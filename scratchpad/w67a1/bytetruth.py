#!/usr/bin/env python3
"""W67-A1 BYTE-TRUTH ENGINE.

Parses PsyQ SN-LNK .OBJ members (primary: C:/Temp/nfs4-clean/psyq43/extracted/<LIB>/obj/*.obj,
cross-check: SpongeBob drop LIBs), extracts per-function spans + SYMBOLS + RELOCS
(patches, with decoded expressions), and byte-matches every function against the
RETAIL bytes of nfs4-f.exe at the VA given by configs/symbol_addrs.txt.

Comparison rule (w62 RELOP anti-vacuity): a word carrying a vendor relocation may
differ ONLY inside its relocated bit-field; any difference outside that field (or
in a word with no reloc) is REAL DRIFT.

Verdicts per fn: identical / reloc-only / drifted(N real words) / absent(no retail VA).

Outputs:
  scratchpad/w67a1/truth/<LIB>/<fn>.txt   annotated vendor disasm (symbols+relocs+retail diff)
  scratchpad/w67a1/BYTETRUTH.md           per-lib/TU/fn verdict table (appended per lib)
  scratchpad/w67a1/PROGRESS.md            one line per lib as it lands
"""
import os, re, struct, subprocess, sys, glob, json

REPO      = r'C:/Temp/nfs4-decomp'
EXTRACTED = r'C:/Temp/nfs4-clean/psyq43/extracted'
ROM       = os.path.join(REPO, 'rom', 'nfs4-f.exe')
SYMADDRS  = os.path.join(REPO, 'configs', 'symbol_addrs.txt')
OUT       = os.path.join(REPO, 'scratchpad', 'w67a1')
OBJD      = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
LOAD_VA   = 0x80010000
HDR       = 0x800

# ---------------- retail ----------------
ROMDATA = open(ROM, 'rb').read()
def retail_words(va, nwords):
    off = va - LOAD_VA + HDR
    if off < HDR or off + nwords*4 > len(ROMDATA):
        return None
    return list(struct.unpack('<%dI' % nwords, ROMDATA[off:off+nwords*4]))

def load_symaddrs():
    m = {}
    for L in open(SYMADDRS):
        mm = re.match(r'(\w+)\s*=\s*0x([0-9A-Fa-f]+);', L)
        if mm:
            m.setdefault(mm.group(1), int(mm.group(2), 16))
    return m
SYMVA = load_symaddrs()
VA2NAME = {}
for _n, _v in SYMVA.items():
    VA2NAME.setdefault(_v, []).append(_n)

# ---------------- SN-LNK object parser (NFS3 precedent + full expr/patch decode) ----------------
class Desync(Exception): pass

def parse_expr(d, p):
    """-> (tree, newp). tree = ('const',v) | ('sym',idx) | ('sect',idx)
       | ('sectstart',idx)|('sectend',idx)|('op36',idx) | (op, a, b)"""
    op = d[p]; p += 1
    if op == 0x00:
        return ('const', struct.unpack('<I', d[p:p+4])[0]), p + 4
    if op == 0x02:
        return ('sym', struct.unpack('<H', d[p:p+2])[0]), p + 2
    if op == 0x04:
        return ('sect', struct.unpack('<H', d[p:p+2])[0]), p + 2
    if op == 0x0C:
        return ('sectstart', struct.unpack('<H', d[p:p+2])[0]), p + 2
    if op == 0x16:
        return ('sectend', struct.unpack('<H', d[p:p+2])[0]), p + 2
    if op == 0x36:
        return ('op36', struct.unpack('<H', d[p:p+2])[0]), p + 2
    if op in (0x2C, 0x2E, 0x30, 0x32):
        a, p = parse_expr(d, p)
        b, p = parse_expr(d, p)
        return ({0x2C:'+', 0x2E:'-', 0x30:'/', 0x32:'*'}[op], a, b), p
    raise Desync("expr op 0x%02x @%d" % (op, p - 1))

def parse_obj(d):
    if d[:4] != b'LNK\x02':
        raise Desync("bad magic")
    p, cur = 4, None
    sections, xdefs, xrefs, locs, patches = {}, [], {}, [], []
    code, fname = {}, None
    chunk_base = 0
    n = len(d)
    while p < n:
        op = d[p]; p += 1
        if op == 0x00:
            break
        elif op == 0x02:
            ln = struct.unpack('<H', d[p:p+2])[0]; p += 2
            chunk_base = len(code.get(cur, b''))
            code[cur] = code.get(cur, b'') + d[p:p+ln]; p += ln
        elif op == 0x06:
            cur = struct.unpack('<H', d[p:p+2])[0]; p += 2
        elif op == 0x08:
            sz = struct.unpack('<I', d[p:p+4])[0]; p += 4
            code[cur] = code.get(cur, b'') + b'\x00' * sz
        elif op == 0x0A:
            ptype = d[p]; p += 1
            poff = struct.unpack('<H', d[p:p+2])[0]; p += 2
            expr, p = parse_expr(d, p)
            patches.append(dict(sect=cur, off=chunk_base + poff, type=ptype, expr=expr))
        elif op == 0x0C:
            sym, sect = struct.unpack('<HH', d[p:p+4]); p += 4
            off = struct.unpack('<I', d[p:p+4])[0]; p += 4
            ln = d[p]; p += 1
            nm = d[p:p+ln].decode('ascii', 'replace'); p += ln
            xdefs.append(dict(sym=sym, sect=sect, off=off, name=nm))
            xrefs[sym] = nm
        elif op == 0x0E:
            sym = struct.unpack('<H', d[p:p+2])[0]; p += 2
            ln = d[p]; p += 1
            xrefs[sym] = d[p:p+ln].decode('ascii', 'replace'); p += ln
        elif op == 0x10:
            sect, grp = struct.unpack('<HH', d[p:p+4]); p += 4
            al = d[p]; p += 1
            ln = d[p]; p += 1
            sections[sect] = d[p:p+ln].decode('ascii', 'replace'); p += ln
        elif op == 0x12:
            sect = struct.unpack('<H', d[p:p+2])[0]; p += 2
            val = struct.unpack('<I', d[p:p+4])[0]; p += 4
            ln = d[p]; p += 1
            locs.append(dict(sect=sect, off=val, name=d[p:p+ln].decode('ascii', 'replace'))); p += ln
        elif op in (0x14, 0x30):
            sym, sect = struct.unpack('<HH', d[p:p+4]); p += 4
            sz = struct.unpack('<I', d[p:p+4])[0]; p += 4
            ln = d[p]; p += 1
            nm = d[p:p+ln].decode('ascii', 'replace'); p += ln
            xdefs.append(dict(sym=sym, sect=sect, off=0, name=nm, bss=sz))
            xrefs[sym] = nm
        elif op == 0x1C:
            p += 2
            ln = d[p]; p += 1
            nm = d[p:p+ln].decode('ascii', 'replace'); p += ln
            if fname is None: fname = nm
        elif op == 0x2E:
            p += 1
        elif op == 0x32: p += 2
        elif op == 0x34:
            p += 2; ln = d[p]; p += 1; p += ln
        elif op == 0x36: p += 4
        elif op == 0x38:
            p += 2 + 4 + 2 + 2 + 4 + 4
            ln = d[p]; p += 1; p += ln
        elif op == 0x3A: p += 2 + 4 + 4
        elif op == 0x3C: p += 2 + 4 + 4
        elif op == 0x3E: p += 2 + 4 + 4
        elif op == 0x40:
            p += 2 + 4 + 2 + 2 + 4
            ln = d[p]; p += 1; p += ln
        elif op == 0x42:
            p += 2 + 4 + 2 + 2 + 4
            nd = struct.unpack('<H', d[p:p+2])[0]; p += 2 + nd * 4
            ln = d[p]; p += 1; p += ln
        elif op == 0x44:
            p += 2; ln = d[p]; p += 1; p += ln
        elif op == 0x46: p += 2 + 4
        elif op == 0x48: p += 1
        elif op == 0x4C: p += 2 + 1
        else:
            raise Desync("op 0x%02x @%d" % (op, p - 1))
    if any(d[p:]):
        raise Desync("TRAILING NON-ZERO bytes after END (consumed %d of %d)" % (p, n))
    return dict(sections=sections, xdefs=xdefs, xrefs=xrefs, locals=locs,
                patches=patches, code=code, filename=fname)

# reloc field masks by SN patch type
PMASK = {16: 0xFFFFFFFF, 74: 0x03FFFFFF, 82: 0x0000FFFF, 84: 0x0000FFFF, 100: 0x0000FFFF}
PNAME = {16: 'REL32', 74: 'REL26', 82: 'HI16', 84: 'LO16', 100: 'GPREL16'}

def render_expr(e, o):
    k = e[0]
    if k == 'const':    return '0x%X' % e[1]
    if k == 'sym':      return o['xrefs'].get(e[1], 'sym#%d' % e[1])
    if k == 'sect':     return '%s(base)' % o['sections'].get(e[1], 'sect#%d' % e[1])
    if k == 'sectstart':return '%s(start)' % o['sections'].get(e[1], 'sect#%d' % e[1])
    if k == 'sectend':  return '%s(end)' % o['sections'].get(e[1], 'sect#%d' % e[1])
    if k == 'op36':     return 'op36(%d)' % e[1]
    return '(%s %s %s)' % (render_expr(e[1], o), k, render_expr(e[2], o))

def disasm_words(words):
    """objdump a list of LE words -> list of disasm strings."""
    import tempfile
    blob = b''.join(struct.pack('<I', w) for w in words)
    tf = os.path.join(OUT, '_dis.bin')
    open(tf, 'wb').write(blob)
    r = subprocess.run([OBJD, '-D', '-b', 'binary', '-m', 'mips:3000', '-EL', '-z', tf],
                       capture_output=True, text=True)
    out = {}
    for L in r.stdout.splitlines():
        m = re.match(r'\s+([0-9a-f]+):\s+[0-9a-f]{8}\s+(.*)', L)
        if m:
            out[int(m.group(1), 16)] = m.group(2).strip()
    return [out.get(i*4, '?') for i in range(len(words))]

def is_text(nm): return nm is not None and nm.startswith('.text')

def carve(o):
    """-> list of (name, sect, off, size, linkage) fn spans in text sections."""
    marks = {}
    for x in o['xdefs']:
        if 'bss' not in x:
            marks.setdefault(x['sect'], []).append((x['off'], x['name'], 'export'))
    for x in o['locals']:
        marks.setdefault(x['sect'], []).append((x['off'], x['name'], 'static'))
    fns = []
    for sect, lst in marks.items():
        snm = o['sections'].get(sect)
        body = o['code'].get(sect, b'')
        if not is_text(snm) or not body:
            continue
        lst = sorted(set(lst))
        for i, (off, nm, kind) in enumerate(lst):
            end = lst[i+1][0] if i + 1 < len(lst) else len(body)
            if end > off:
                fns.append((nm, sect, off, end - off, kind))
    return fns

def get_ids(blob):
    return sorted(set(m.group(0).decode('ascii', 'replace')
                      for m in re.finditer(rb'\$Id: [^$]{0,120}\$', blob)))

def match_fn(o, name, sect, off, size, member, lib, kind, idstr):
    nwords = size // 4
    body = o['code'][sect]
    vwords = list(struct.unpack('<%dI' % nwords, body[off:off+nwords*4]))
    va = SYMVA.get(name)
    relocs = {}   # word-idx -> (type, expr)
    for pch in o['patches']:
        if pch['sect'] == sect and off <= pch['off'] < off + size:
            relocs[(pch['off'] - off) // 4] = (pch['type'], pch['expr'])
    res = dict(lib=lib, member=member, fn=name, kind=kind, size=size, nwords=nwords,
               va=va, nrelocs=len(relocs))
    if va is None:
        res['verdict'] = 'absent'
        return res, vwords, relocs, None
    rwords = retail_words(va, nwords)
    if rwords is None:
        res['verdict'] = 'absent(va-out-of-image)'
        return res, vwords, relocs, None
    drift, ronly, ident = [], 0, 0
    for i, (v, r) in enumerate(zip(vwords, rwords)):
        if v == r:
            ident += 1
            continue
        if i in relocs:
            t = relocs[i][0]
            mask = PMASK.get(t, 0)
            if (v ^ r) & ~mask:
                drift.append(i)
            else:
                ronly += 1
        else:
            drift.append(i)
    res['drift_words'] = drift
    res['reloc_diff'] = ronly
    if drift:
        res['verdict'] = 'drifted(%d)' % len(drift)
    elif ronly:
        res['verdict'] = 'reloc-only'
    else:
        res['verdict'] = 'identical'
    return res, vwords, relocs, rwords

def truth_file(path, res, vwords, relocs, rwords, o, idstr):
    dis = disasm_words(vwords)
    with open(path, 'w', encoding='ascii', errors='replace', newline='\n') as fh:
        fh.write("W67-A1 VENDOR GROUND TRUTH  %s / %s / %s\n" % (res['lib'], res['member'], res['fn']))
        fh.write("linkage=%s  section-size=%d bytes (%d words)  vendor-relocs=%d\n"
                 % (res['kind'], res['size'], res['nwords'], res['nrelocs']))
        fh.write("retail VA=%s  VERDICT=%s\n" %
                 ('0x%08X' % res['va'] if res['va'] else 'NONE', res['verdict']))
        if idstr:
            fh.write("member $Id: %s\n" % '; '.join(idstr))
        fh.write("columns: off | vendor-word | retail-word | flag | disasm | reloc\n")
        fh.write("flags: '='same  'R'differs-in-reloc-field-only(expected, unlinked)  '!'REAL DRIFT\n\n")
        for i, v in enumerate(vwords):
            if res['va'] is not None and (res['va'] + i*4) in VA2NAME and i > 0:
                fh.write("        >> retail symbol here: %s (0x%08X)\n"
                         % (','.join(VA2NAME[res['va'] + i*4]), res['va'] + i*4))
            r = rwords[i] if rwords else None
            if r is None:
                flag = ' '
            elif v == r:
                flag = '='
            elif i in res.get('drift_words', []):
                flag = '!'
            else:
                flag = 'R'
            rl = ''
            if i in relocs:
                t, e = relocs[i]
                rl = '  <%s %s>' % (PNAME.get(t, 'P%d' % t), render_expr(e, o))
            fh.write("%04x  %08x  %s  %s  %-34s%s\n"
                     % (i*4, v, ('%08x' % r) if r is not None else '--------', flag, dis[i], rl))

def process_lib(lib, only_objs=None):
    objdir = os.path.join(EXTRACTED, lib, 'obj')
    rows, id_inv = [], {}
    os.makedirs(os.path.join(OUT, 'truth', lib), exist_ok=True)
    for objf in sorted(glob.glob(os.path.join(objdir, '*.obj'))):
        member = os.path.splitext(os.path.basename(objf))[0]
        if only_objs and member not in only_objs:
            continue
        blob = open(objf, 'rb').read()
        idstr = get_ids(blob)
        if idstr:
            id_inv[member] = idstr
        try:
            o = parse_obj(blob)
        except Desync as e:
            rows.append(dict(lib=lib, member=member, fn='(PARSE-FAIL: %s)' % e, verdict='parse-fail'))
            continue
        for name, sect, off, size, kind in carve(o):
            res, vwords, relocs, rwords = match_fn(o, name, sect, off, size, member, lib, kind, idstr)
            rows.append(res)
            if rwords is not None or res['verdict'].startswith('absent'):
                tp = os.path.join(OUT, 'truth', lib,
                                  re.sub(r'[^A-Za-z0-9_.$-]', '_', name) + '.txt')
                truth_file(tp, res, vwords, relocs, rwords, o, idstr)
    return rows, id_inv

def emit_lib_report(lib, rows, id_inv, fh):
    fh.write("\n## %s (psyq43 vendor objects)\n\n" % lib)
    if id_inv:
        fh.write("$Id inventory:\n")
        for m, ids in sorted(id_inv.items()):
            for s in ids:
                fh.write("- %s: `%s`\n" % (m, s))
        fh.write("\n")
    fh.write("| member | fn | linkage | words | relocs | retail VA | verdict |\n")
    fh.write("|---|---|---|---|---|---|---|\n")
    for r in rows:
        fh.write("| %s | %s | %s | %s | %s | %s | **%s** |\n" % (
            r.get('member',''), r.get('fn',''), r.get('kind',''),
            r.get('nwords',''), r.get('nrelocs',''),
            ('0x%08X' % r['va']) if r.get('va') else '-', r.get('verdict','')))
        if r.get('drift_words'):
            dw = r['drift_words']
            fh.write("|  |  |  |  |  |  | drift @words %s |\n"
                     % (','.join(str(i) for i in dw[:12]) + ('...' if len(dw) > 12 else '')))

if __name__ == '__main__':
    libs = sys.argv[1:] or ['LIBETC']
    os.makedirs(OUT, exist_ok=True)
    md = os.path.join(OUT, 'BYTETRUTH.md')
    mode = 'a' if os.path.exists(md) else 'w'
    with open(md, mode, encoding='ascii', errors='replace', newline='\n') as fh:
        if mode == 'w':
            fh.write("# W67-A1 BYTETRUTH -- vendor(psyq43) vs retail nfs4-f.exe\n")
            fh.write("comparison: reloc-masked word compare (w62 RELOP); '-'=vendor unlinked field\n")
        for lib in libs:
            rows, id_inv = process_lib(lib)
            emit_lib_report(lib, rows, id_inv, fh)
            counts = {}
            for r in rows:
                v = r.get('verdict', '?').split('(')[0]
                counts[v] = counts.get(v, 0) + 1
            with open(os.path.join(OUT, 'PROGRESS.md'), 'a', encoding='ascii', newline='\n') as pf:
                pf.write("%s: %s\n" % (lib, ' '.join('%s=%d' % kv for kv in sorted(counts.items()))))
            print(lib, counts)

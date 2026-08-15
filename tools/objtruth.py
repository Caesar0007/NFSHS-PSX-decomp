#!/usr/bin/env python3
"""W67-A2 byte-truth tool: parse a PsyQ 4.3 SN-LNK .obj member (psyq43/extracted layout),
decode symbols (XDEF + local) and relocation patches WITH their expressions, slice a
function's word span, and diff it against our splat oracle .s (asm/nonmatchings/main/<fn>.s),
masking exactly the reloc-patched bit-fields on both sides.

Usage:
  python objtruth.py syms  <obj>                      # dump symbol map (.text)
  python objtruth.py diff  <obj> <symname> <oracle.s> [--end <nextsym>]  # verdict
  python objtruth.py dump  <obj> <symname> [--end <nextsym>]             # annotated listing
Patch types (empirical, from usage below): masks derived per type.
"""
import struct, sys, re, os

def parse_obj(path):
    d = open(path, 'rb').read()
    assert d[:4] == b'LNK\x02', 'bad magic'
    p, cur = 4, None
    sections, xdefs, locs, patches = {}, [], [], []
    xrefs = {}          # sym index -> name (XDEF also registers its index)
    code = {}
    chunk_base = 0
    n = len(d)
    while p < n:
        op = d[p]; p += 1
        if op == 0x00: break
        elif op == 0x02:
            ln = struct.unpack('<H', d[p:p+2])[0]; p += 2
            chunk_base = len(code.get(cur, b''))
            code[cur] = code.get(cur, b'') + d[p:p+ln]; p += ln
        elif op == 0x06:
            cur = struct.unpack('<H', d[p:p+2])[0]; p += 2
        elif op == 0x08:
            sz = struct.unpack('<I', d[p:p+4])[0]; p += 4
            code[cur] = code.get(cur, b'') + b'\x00'*sz
        elif op == 0x0A:
            ptype = d[p]; p += 1
            poff = struct.unpack('<H', d[p:p+2])[0]; p += 2
            expr, p = parse_expr(d, p)
            patches.append(dict(sect=cur, off=chunk_base+poff, type=ptype, expr=expr))
        elif op == 0x0C:
            sym, sect = struct.unpack('<HH', d[p:p+4]); p += 4
            off = struct.unpack('<I', d[p:p+4])[0]; p += 4
            ln = d[p]; p += 1
            nm = d[p:p+ln].decode('ascii','replace'); p += ln
            xdefs.append(dict(sym=sym, sect=sect, off=off, name=nm))
            xrefs[sym] = nm
        elif op == 0x0E:
            sym = struct.unpack('<H', d[p:p+2])[0]; p += 2
            ln = d[p]; p += 1
            xrefs[sym] = d[p:p+ln].decode('ascii','replace'); p += ln
        elif op == 0x10:
            sect, grp = struct.unpack('<HH', d[p:p+4]); p += 4
            al = d[p]; p += 1; ln = d[p]; p += 1
            sections[sect] = d[p:p+ln].decode('ascii','replace'); p += ln
        elif op == 0x12:
            sect = struct.unpack('<H', d[p:p+2])[0]; p += 2
            val = struct.unpack('<I', d[p:p+4])[0]; p += 4
            ln = d[p]; p += 1
            locs.append(dict(sect=sect, off=val, name=d[p:p+ln].decode('ascii','replace'))); p += ln
        elif op in (0x14, 0x30):
            sym, sect = struct.unpack('<HH', d[p:p+4]); p += 4
            sz = struct.unpack('<I', d[p:p+4])[0]; p += 4
            ln = d[p]; p += 1
            nm = d[p:p+ln].decode('ascii','replace'); p += ln
            xdefs.append(dict(sym=sym, sect=sect, off=0, name=nm, bss=sz))
            xrefs[sym] = nm
        elif op == 0x1C:
            p += 2; ln = d[p]; p += 1; p += ln
        elif op == 0x2E: p += 1
        elif op == 0x32: p += 2
        elif op == 0x34:
            p += 2; ln = d[p]; p += 1; p += ln
        elif op == 0x36: p += 4
        elif op == 0x38:
            p += 2+4+2+2+4+4; ln = d[p]; p += 1; p += ln
        elif op == 0x3A: p += 2+4+4
        elif op == 0x3C: p += 2+4+4
        elif op == 0x3E: p += 2+4+4
        elif op == 0x40:
            p += 2+4+2+2+4; ln = d[p]; p += 1; p += ln
        elif op == 0x42:
            p += 2+4+2+2+4
            nd = struct.unpack('<H', d[p:p+2])[0]; p += 2+nd*4
            ln = d[p]; p += 1; p += ln
        elif op == 0x44:
            p += 2; ln = d[p]; p += 1; p += ln
        elif op == 0x46: p += 2+4
        elif op == 0x48: p += 1
        elif op == 0x4C: p += 2+1
        else:
            raise SystemExit('op 0x%02x @%d' % (op, p-1))
    return dict(sections=sections, xdefs=xdefs, locals=locs, patches=patches,
                code=code, xrefs=xrefs)

def parse_expr(d, p):
    op = d[p]; p += 1
    if op == 0x00:
        v = struct.unpack('<I', d[p:p+4])[0]; return ('const', v), p+4
    if op == 0x02:
        v = struct.unpack('<H', d[p:p+2])[0]; return ('sym', v), p+2
    if op == 0x04:
        v = struct.unpack('<H', d[p:p+2])[0]; return ('sectbase', v), p+2
    if op in (0x0C, 0x16):
        v = struct.unpack('<H', d[p:p+2])[0]; return ('ref%02x' % op, v), p+2
    if op in (0x2C, 0x2E, 0x30, 0x32):
        a, p = parse_expr(d, p)
        b, p = parse_expr(d, p)
        name = {0x2C:'add', 0x2E:'sub', 0x30:'div', 0x32:'mul'}[op]
        return (name, a, b), p
    raise SystemExit('expr op 0x%02x @%d' % (op, p-1))

def render_expr(e, obj):
    t = e[0]
    if t == 'const': return '0x%X' % e[1]
    if t == 'sym':   return obj['xrefs'].get(e[1], 'sym%d' % e[1])
    if t == 'sectbase': return 'SECT(%s)' % obj['sections'].get(e[1], str(e[1]))
    if t in ('add','sub','div','mul'):
        return '(%s %s %s)' % (render_expr(e[1],obj), {'add':'+','sub':'-','div':'/','mul':'*'}[t], render_expr(e[2],obj))
    return repr(e)

# patch-type -> bitmask of the field the linker writes (mask OUT of the compare)
# determined empirically; unknown types default to full-word mask + a warning.
PATCH_MASKS = {
    0x10: 0xFFFFFFFF,  # full 32-bit word (data/pointer)
    0x4A: 0x03FFFFFF,  # jal/j 26-bit target
    0x52: 0x0000FFFF,  # lo16 immediate
    0x54: 0x0000FFFF,  # hi16 immediate
    0x64: 0x0000FFFF,
    0x66: 0x0000FFFF,
    0x28: 0xFFFFFFFF,
    0x1E: 0xFFFFFFFF,
}

def text_sect(obj):
    for k, v in obj['sections'].items():
        if v == '.text': return k
    for k, v in obj['sections'].items():
        if v.startswith('.text'): return k
    raise SystemExit('no .text')

def sym_map(obj):
    ts = text_sect(obj)
    syms = [dict(off=x['off'], name=x['name'], kind='XDEF') for x in obj['xdefs']
            if x.get('sect') == ts and 'bss' not in x]
    syms += [dict(off=x['off'], name=x['name'], kind='local') for x in obj['locals'] if x['sect'] == ts]
    syms.sort(key=lambda s: s['off'])
    return ts, syms

def fn_span(obj, name, end_name=None):
    ts, syms = sym_map(obj)
    tl = len(obj['code'][ts])
    start = None
    for i, s in enumerate(syms):
        if s['name'] == name:
            start = s['off']
            end = tl
            if end_name:
                for s2 in syms:
                    if s2['name'] == end_name: end = s2['off']
            else:
                for s2 in syms[i+1:]:
                    if s2['off'] > start: end = s2['off']; break
            return ts, start, end
    raise SystemExit('symbol %s not found' % name)

def oracle_words(path):
    out = []
    rx = re.compile(r'/\*\s*[0-9A-Fa-f]+\s+([0-9A-Fa-f]{8})\s+([0-9A-Fa-f]{8})\s*\*/\s*(.*)')
    for line in open(path, encoding='utf-8', errors='replace'):
        m = rx.search(line)
        if m:
            # spimdisasm prints the 4 bytes in FILE order; true LE word = byteswap
            w = struct.unpack('<I', bytes.fromhex(m.group(2)))[0]
            out.append((w, m.group(3).rstrip(), int(m.group(1), 16)))
    return out  # (word, text, va)

def cmd_syms(objpath):
    obj = parse_obj(objpath)
    ts, syms = sym_map(obj)
    tl = len(obj['code'][ts])
    print('.text size %d (%d words)' % (tl, tl//4))
    for i, s in enumerate(syms):
        end = syms[i+1]['off'] if i+1 < len(syms) else tl
        print('  %-6s %5d..%5d (%4d w)  %s' % (s['kind'], s['off'], end, (end-s['off'])//4, s['name']))

def patch_index(obj, ts):
    idx = {}
    for pa in obj['patches']:
        if pa['sect'] == ts:
            idx.setdefault(pa['off'], []).append(pa)
    return idx

def cmd_diff(objpath, name, oraclepath, end_name=None, show_all=False):
    obj = parse_obj(objpath)
    ts, start, end = fn_span(obj, name, end_name)
    code = obj['code'][ts][start:end]
    vw = [struct.unpack('<I', code[i:i+4])[0] for i in range(0, len(code), 4)]
    ow = oracle_words(oraclepath)
    pidx = patch_index(obj, ts)
    print('%s: vendor %d words [%d..%d), oracle %d words' % (name, len(vw), start, end, len(ow)))
    if len(vw) != len(ow):
        print('  LENGTH MISMATCH')
    nmatch, ndrift, nreloc = 0, 0, 0
    unknown_types = set()
    for i in range(min(len(vw), len(ow))):
        w_off = start + i*4
        pas = pidx.get(w_off, [])
        mask = 0xFFFFFFFF
        for pa in pas:
            m = PATCH_MASKS.get(pa['type'])
            if m is None:
                unknown_types.add(pa['type']); m = 0xFFFFFFFF
            mask &= ~m
        o_word, o_text, o_va = ow[i]
        if pas: nreloc += 1
        if (vw[i] & mask) == (o_word & mask):
            nmatch += 1
            if show_all and pas:
                print('  [reloc-ok] w%-4d %08X vs %08X  %s  | %s' % (
                    i, vw[i], o_word, o_text,
                    '; '.join('t%02X %s' % (pa['type'], render_expr(pa['expr'], obj)) for pa in pas)))
        else:
            ndrift += 1
            print('  DRIFT w%-4d off+%#x vendor %08X oracle %08X  %s%s' % (
                i, i*4, vw[i], o_word, o_text,
                ('  | ' + '; '.join('t%02X %s' % (pa['type'], render_expr(pa['expr'], obj)) for pa in pas)) if pas else ''))
    print('  verdict: %d/%d non-reloc-masked words match, %d drift, %d reloc words' %
          (nmatch, min(len(vw), len(ow)), ndrift, nreloc))
    if unknown_types:
        print('  WARNING unknown patch types (masked full-word):', ['0x%02X' % t for t in sorted(unknown_types)])

def cmd_dump(objpath, name, end_name=None):
    obj = parse_obj(objpath)
    ts, start, end = fn_span(obj, name, end_name)
    code = obj['code'][ts][start:end]
    pidx = patch_index(obj, ts)
    for i in range(0, len(code), 4):
        w = struct.unpack('<I', code[i:i+4])[0]
        pas = pidx.get(start+i, [])
        ann = ('  | ' + '; '.join('t%02X %s' % (pa['type'], render_expr(pa['expr'], obj)) for pa in pas)) if pas else ''
        print('  +%04X %08X%s' % (i, w, ann))

def cmd_relocs(objpath, byteoff, nwords, oraclepath=None):
    """Annotated reloc listing for an arbitrary span (for local/static fns)."""
    obj = parse_obj(objpath)
    ts = text_sect(obj)
    code = obj['code'][ts]
    pidx = patch_index(obj, ts)
    ow = oracle_words(oraclepath) if oraclepath else None
    for i in range(nwords):
        off = byteoff + i*4
        w = struct.unpack('<I', code[off:off+4])[0]
        pas = pidx.get(off, [])
        if pas:
            txt = ow[i][1] if ow else ''
            print('  w%-4d +%04X %08X  %-52s | %s' % (
                i, i*4, w, txt,
                '; '.join('t%02X %s' % (pa['type'], render_expr(pa['expr'], obj)) for pa in pas)))

def cmd_find(objpath, oraclepath):
    """Scan whole vendor .text for the best word-alignment of the oracle sequence."""
    obj = parse_obj(objpath)
    ts = text_sect(obj)
    code = obj['code'][ts]
    vw = [struct.unpack('<I', code[i:i+4])[0] for i in range(0, len(code), 4)]
    ow = oracle_words(oraclepath)
    pidx = patch_index(obj, ts)
    n = len(ow)
    best = []
    for base in range(0, len(vw)-n+1):
        score = 0
        for i in range(n):
            mask = 0xFFFFFFFF
            for pa in pidx.get((base+i)*4, []):
                m = PATCH_MASKS.get(pa['type'], 0xFFFFFFFF)
                mask &= ~m
            if (vw[base+i] & mask) == (ow[i][0] & mask):
                score += 1
        best.append((score, base))
    best.sort(reverse=True)
    for score, base in best[:5]:
        print('  base word %4d (byte +%#x): %d/%d words match' % (base, base*4, score, n))

if __name__ == '__main__':
    a = sys.argv[1:]
    if not a: raise SystemExit(__doc__)
    cmd = a[0]
    if cmd == 'syms': cmd_syms(a[1])
    elif cmd == 'find': cmd_find(a[1], a[2])
    elif cmd == 'relocs':
        cmd_relocs(a[1], int(a[2], 0), int(a[3], 0), a[4] if len(a) > 4 else None)
    elif cmd == 'diff':
        end = None; show = '--show' in a
        if '--end' in a: end = a[a.index('--end')+1]
        cmd_diff(a[1], a[2], a[3], end, show)
    elif cmd == 'dump':
        end = None
        if '--end' in a: end = a[a.index('--end')+1]
        cmd_dump(a[1], a[2], end)

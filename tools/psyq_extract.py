#!/usr/bin/env python3
"""Extract PsyQ PSX libraries (*.LIB / *.OBJ) -> per-library folders of original-named .OBJ members,
plus per-function code blobs named by their ORIGINAL exported symbol.

Containers (both SN Systems, verified byte-exact against every file in psyq400/PSX/LIB):
  *.LIB = 'LIB\\x01' archive: repeating records of
          name[8] (space-padded) | date u32 | objOffset u32 | recordSize u32
          | length-prefixed exported-symbol list | 0x00 | LNK object
          (4.x archives PREFIX each BSS-class/XBSS export name with a 0x00 type byte --
           psyq400: 159/248 data exports, psyq43: 135/250, all .bss/.sbss size>0; NONE in
           any 3.x archive. lib_members() strips it. The carve keys off object XDEFs,
           so INDEX never depended on this list; proven by an export-completeness check.)
          (record start + objOffset lands on 'LNK\\x02'; next record = start + recordSize.
           Validated: all 20 libs walk to EXACTLY their file length.)
  *.OBJ = 'LNK\\x02' object: opcode stream
          0x00 end · 0x02 code(u16 len,data) · 0x06 switch section(u16) · 0x08 bss(u32)
          0x0A patch(u8 type,u16 off,expr) · 0x0C XDEF(u16 sym,u16 sect,u32 off,name)
          0x0E XREF(u16 sym,name) · 0x10 section(u16 sect,u16 grp,u8 align,name)
          0x12 local(u16 sect,u32 val,name) · 0x14 XBSS(u16 sym,u16 sect,u32 size,name)
          0x1C filename(u16,name) · 0x2E processor(u8) · 0x32/0x34/... debug (SLD)

Function bytes: an XDEF into a code section marks a function start; its end is the next
XDEF/local in the same section (or section end). Only symbols in CODE sections are emitted
as functions -- data symbols are indexed but not written as .bin.

usage: python tools/psyq_extract.py [LIBDIR [OUTDIR]]
In this repository the output tree is what tools/link_stripped_check.py, tools/objtruth.py and the
tools/psyq_pipe/strip_*.py / sdkfn.py / sdk_bss.py tools read: `<OUTDIR>/INDEX.tsv`,
`<OUTDIR>/<LIB>/obj/<MEMBER>.obj`, `<OUTDIR>/<LIB>/functions/<symbol>.bin`.  The PsyQ SDK itself is Sony's and is
not in the repository; the defaults below are the PsyQ 4.3 copy this project is matched against.
(Same tool as nfs3-clean/tools_psyq_extract.py, where the format notes above were worked out on PsyQ 3.0-4.0.)
"""
import os, re, struct, sys, glob, json

LIBDIR = sys.argv[1] if len(sys.argv) > 1 else "C:/Temp/nfs4-clean/psyq43/PSX/LIB"
OUTDIR = sys.argv[2] if len(sys.argv) > 2 else "C:/Temp/nfs4-clean/psyq43/extracted"

# ---------------- LIB archive ----------------
def lib_members(data):
    assert data[:4] == b'LIB\x01', "not a LIB\\x01 archive"
    pos, out = 4, []
    while pos + 20 <= len(data):
        name = data[pos:pos+8].decode('ascii', 'replace').rstrip()
        date, objoff, recsize = struct.unpack('<III', data[pos+8:pos+20])
        if recsize == 0:
            break
        obj_at = pos + objoff
        if data[obj_at:obj_at+4] != b'LNK\x02':
            raise ValueError("member %s: no LNK\\x02 at +%d" % (name, objoff))
        syms, p = [], pos + 20
        while p < obj_at - 1:
            n = data[p]
            if n == 0:
                break
            syms.append(data[p+1:p+1+n].lstrip(b'\x00').decode('ascii', 'replace'))
            p += 1 + n
        out.append(dict(name=name, off=obj_at, size=recsize - objoff, exports=syms,
                        data=data[obj_at:pos+recsize]))
        pos += recsize
    return out, pos

# ---------------- LNK object ----------------
class Desync(Exception): pass

def _expr(d, p, alt_debug=False):
    """Skip one patch expression; returns new offset.
    Grammar derived empirically (LIBAPI/PATCH `0a 52 0000 | 2c 00 08000000 04 02f0`
    = patch(type 0x52, off 0) expr ADD(const 0x8, sectbase 0xf002)):
      0x00 u32 constant · 0x02 u16 symbol · 0x04 u16 section-base
      0x2C/0x2E/0x30/0x32 binary op followed by TWO sub-expressions.
    alt_debug (PsyQ 3.x): 0x36 is a BINARY op too -- LIBSN/CACHE.OBJ has
      `36 (const 0xA0000000) (2C (sectbase) (const 0x20))` = OR(KSEG1, sect+0x20),
      SNFlushCache building an uncached address. The 4.0-empirical u16-node
      reading desynced it (guarded by the trailing-bytes check below)."""
    op = d[p]; p += 1
    if op == 0x00:  return p + 4      # constant (u32)  <- NOT a terminator
    if op == 0x02:  return p + 2      # symbol index
    if op == 0x04:  return p + 2      # section base
    if op == 0x36 and alt_debug:      # 3.x: binary OR
        p = _expr(d, p, alt_debug); return _expr(d, p, alt_debug)
    if op in (0x0C, 0x16, 0x36): return p + 2   # further u16-operand ref nodes (empirical)
    if op in (0x2C, 0x2E, 0x30, 0x32):   # binary: add/sub/div/mul
        p = _expr(d, p, alt_debug); return _expr(d, p, alt_debug)
    raise Desync("expr op 0x%02x @%d" % (op, p - 1))

def parse_obj(d, alt_debug=False, pad_even=False):
    """-> dict(sections, xdefs, xrefs, locals, code{sect:bytes}, filename, clean)
    alt_debug: PsyQ 3.x-era format deltas (psyq360, 1995 objects), used ONLY as a
    Desync/truncation retry -- never for objects the 4.0-proven map parses clean:
      0x4A = FUNCTION-START (sect u16, off u32, file u16, line u32, frameReg u16,
             frameSize u32, retnPcReg u16, mask u32, maskOff u32, len8 name)  [CARD.OBJ]
      0x4C = FUNCTION-END (sect u16, off u32, line u32)                      [CARD.OBJ]
      expr 0x36 = binary OR (two sub-exprs)                                  [LIBSN/CACHE]
    pad_even (SEPARATE flag, per-object): ODD-LENGTH 0x02 code records carry one
      0x00 pad byte to EVEN [psyq360 MOUSE.OBJ] -- but NOT in every 3.x object:
      psyq300 MOUSE.OBJ has an odd record (NUL included in the length) with NO pad,
      and padding it there desyncs. So the driver ladder tries (4.0) -> (3.x, no pad)
      -> (3.x + pad). The pad is part of the section stream -- keep it in code[] so
      offsets match the linker layout; without it the pad reads as a bogus END op."""
    if d[:4] != b'LNK\x02':
        raise Desync("bad magic")
    p, cur = 4, None
    sections, xdefs, xrefs, locs, patches = {}, [], [], [], []
    code, bss, fname = {}, {}, None
    chunk_base = 0
    n = len(d)
    while p < n:
        op = d[p]; p += 1
        if op == 0x00:
            break
        elif op == 0x02:                                   # code
            ln = struct.unpack('<H', d[p:p+2])[0]; p += 2
            if pad_even:
                ln += ln & 1                                # 3.x (some objs): odd records even-padded
            chunk_base = len(code.get(cur, b''))            # patches below are CHUNK-relative
            code[cur] = code.get(cur, b'') + d[p:p+ln]; p += ln
        elif op == 0x06:                                   # switch section
            cur = struct.unpack('<H', d[p:p+2])[0]; p += 2
        elif op == 0x08:                                   # uninitialized
            sz = struct.unpack('<I', d[p:p+4])[0]; p += 4
            bss[cur] = bss.get(cur, 0) + sz
            code[cur] = code.get(cur, b'') + b'\x00' * sz
        elif op == 0x0A:                                   # patch (RELOCATION)
            ptype = d[p]; p += 1
            poff = struct.unpack('<H', d[p:p+2])[0]; p += 2
            p = _expr(d, p, alt_debug)
            # PROVEN chunk-relative: section-relative put only 67% of LIBETC/INTR patches on a
            # relocatable insn, chunk-relative puts 132/132 = 100%.
            patches.append(dict(sect=cur, off=chunk_base + poff, type=ptype))
        elif op == 0x0C:                                   # XDEF
            sym, sect = struct.unpack('<HH', d[p:p+4]); p += 4
            off = struct.unpack('<I', d[p:p+4])[0]; p += 4
            ln = d[p]; p += 1
            nm = d[p:p+ln].decode('ascii', 'replace'); p += ln
            xdefs.append(dict(sym=sym, sect=sect, off=off, name=nm))
        elif op == 0x0E:                                   # XREF
            sym = struct.unpack('<H', d[p:p+2])[0]; p += 2
            ln = d[p]; p += 1
            xrefs.append(d[p:p+ln].decode('ascii', 'replace')); p += ln
        elif op == 0x10:                                   # section def
            sect, grp = struct.unpack('<HH', d[p:p+4]); p += 4
            al = d[p]; p += 1
            ln = d[p]; p += 1
            nm = d[p:p+ln].decode('ascii', 'replace'); p += ln
            sections[sect] = nm
        elif op == 0x12:                                   # local symbol
            sect = struct.unpack('<H', d[p:p+2])[0]; p += 2
            val = struct.unpack('<I', d[p:p+4])[0]; p += 4
            ln = d[p]; p += 1
            nm = d[p:p+ln].decode('ascii', 'replace'); p += ln
            locs.append(dict(sect=sect, off=val, name=nm))
        elif op in (0x14, 0x30):                           # XBSS / local-BSS (0x30 same shape:
                                                           # `30 sym16 sect16 size32 len8 name`)
            sym, sect = struct.unpack('<HH', d[p:p+4]); p += 4
            sz = struct.unpack('<I', d[p:p+4])[0]; p += 4
            ln = d[p]; p += 1
            nm = d[p:p+ln].decode('ascii', 'replace'); p += ln
            xdefs.append(dict(sym=sym, sect=sect, off=0, name=nm, bss=sz))
        elif op == 0x1C:                                   # source file name
            p += 2
            ln = d[p]; p += 1
            nm = d[p:p+ln].decode('ascii', 'replace'); p += ln
            if fname is None: fname = nm
        elif op == 0x2E:                                   # processor
            p += 1
        elif op == 0x32:                                   # SLD: set line
            p += 2
        elif op == 0x34:                                   # SLD: line+file
            p += 2
            ln = d[p]; p += 1; p += ln
        elif op == 0x36:
            p += 4
        elif op == 0x38:                                   # func start
            p += 2 + 4 + 2 + 2 + 4 + 4
            ln = d[p]; p += 1; p += ln
        elif op == 0x3A:                                   # func end
            p += 2 + 4 + 4
        elif op == 0x3C:                                   # block start
            p += 2 + 4 + 4
        elif op == 0x3E:                                   # block end
            p += 2 + 4 + 4
        elif op == 0x40:                                   # def
            p += 2 + 4 + 2 + 2 + 4
            ln = d[p]; p += 1; p += ln
        elif op == 0x42:                                   # def2
            p += 2 + 4 + 2 + 2 + 4
            nd = struct.unpack('<H', d[p:p+2])[0]; p += 2 + nd * 4
            ln = d[p]; p += 1; p += ln
        elif op == 0x44:                                   # section symbol
            p += 2
            ln = d[p]; p += 1; p += ln
        elif op == 0x46:
            p += 2 + 4
        elif op == 0x48:                                   # inc SLD by byte
            p += 1
        elif op == 0x4A:                                   # inc SLD | 3.x FUNCTION-START
            if alt_debug:
                p += 2 + 4 + 2 + 4 + 2 + 4 + 2 + 4 + 4
                ln = d[p]; p += 1; p += ln
        elif op == 0x4C:                                   # (4.0 shape) | 3.x FUNCTION-END
            if alt_debug:
                p += 2 + 4 + 4
            else:
                p += 2 + 1
        else:
            raise Desync("op 0x%02x @%d" % (op, p - 1))
    return dict(sections=sections, xdefs=xdefs, xrefs=xrefs, locals=locs, patches=patches,
                code=code, bss=bss, filename=fname, consumed=p, total=n)

def safe(s):
    return re.sub(r'[^A-Za-z0-9_.+@$-]', '_', s)[:120]

def is_code_section(nm):
    return nm is not None and nm.startswith('.text')

# ---------------- driver ----------------
def main():
    os.makedirs(OUTDIR, exist_ok=True)
    # A STALE failures file from an earlier run must never survive into a clean run
    # (it was only ever written `if desyncs`, so a fixed corpus kept reporting old ones).
    _pf = os.path.join(OUTDIR, 'PARSE_FAILURES.txt')
    if os.path.exists(_pf):
        os.remove(_pf)
    index, stats = [], dict(libs=0, members=0, objs=0, funcs=0, clean=0, desync=0, dsyms=0)
    desyncs = []

    units = []   # (libname, membername, bytes, exports_from_lib)
    written = {} # (lib, filename) -> (member, bytes): same-name collisions across members
    for lf in sorted(glob.glob(os.path.join(LIBDIR, '*.[Ll][Ii][Bb]'))):
        data = open(lf, 'rb').read()
        members, end = lib_members(data)
        assert end == len(data), "%s walk %d != %d" % (lf, end, len(data))
        stats['libs'] += 1; stats['members'] += len(members)
        base = os.path.splitext(os.path.basename(lf))[0]
        for m in members:
            units.append((base, m['name'], m['data'], m['exports']))
    for of in sorted(glob.glob(os.path.join(LIBDIR, '*.[Oo][Bb][Jj]'))):
        base = os.path.splitext(os.path.basename(of))[0]
        units.append(('_standalone', base, open(of, 'rb').read(), []))
        stats['objs'] += 1

    for lib, member, blob, lib_exports in units:
        libdir = os.path.join(OUTDIR, lib)
        objdir = os.path.join(libdir, 'obj')
        fndir  = os.path.join(libdir, 'functions')
        os.makedirs(objdir, exist_ok=True); os.makedirs(fndir, exist_ok=True)
        # Try the 4.0-proven map first; on Desync OR silent truncation (anti-vacuity:
        # non-zero bytes after the END op mean the parse stopped at a stray 0x00 and
        # must NOT count clean), retry with the PsyQ 3.x shapes, then 3.x + even-pad.
        o, clean, errs = None, False, []
        for alt, pad in ((False, False), (True, False), (True, True)):
            label = '4.0' if not alt else ('3.x' if not pad else '3.x+pad')
            try:
                cand = parse_obj(blob, alt_debug=alt, pad_even=pad)
            except Desync as e:
                errs.append("%s-map: %s" % (label, e))
                continue
            if any(blob[cand['consumed']:]):
                errs.append("%s-map: TRAILING NON-ZERO bytes after END op (consumed %d of %d)"
                            % (label, cand['consumed'], len(blob)))
                continue
            o, clean = cand, True
            stats['clean'] += 1
            if alt:
                stats[label] = stats.get(label, 0) + 1
            break
        if not clean:
            stats['desync'] += 1
            desyncs.append("%s/%s: %s" % (lib, member, " | ".join(errs)))
        # original member name; prefer the OBJ's own recorded source filename when present
        orig = (o or {}).get('filename') or member
        stem = safe(os.path.splitext(os.path.basename(orig.replace('\\', '/')))[0]) or safe(member)
        open(os.path.join(objdir, stem + '.obj'), 'wb').write(blob)
        if not clean:
            index.append(dict(lib=lib, member=member, obj=stem + '.obj', ok=False))
            continue
        # ---- carve functions: XDEFs in code sections, sorted, bounded by the next symbol ----
        marks = {}
        for x in o['xdefs'] + o['locals']:
            marks.setdefault(x['sect'], []).append((x['off'], x['name'], 'xdef' if x in o['xdefs'] else 'local'))
        # 2026-07-25 FIX: also emit LOCAL/static symbols (op 0x12). A library static has no XDEF,
        # but the object DOES carry a named local record for it (PAD.OBJ: SetPatchPad/RemovePatchPad/
        # _Pad1/_IsVSync at +0x1c0/+0x240/+0x278/+0x2e0). They were previously used only as carve
        # BOUNDARIES and never written -- 371 named functions across the libs were being dropped.
        exported = set(x['name'] for x in o['xdefs']) | set(x['name'] for x in o['locals'])
        localnames = set(x['name'] for x in o['locals'])
        for sect, lst in marks.items():
            snm = o['sections'].get(sect)
            body = o['code'].get(sect, b'')
            if not is_code_section(snm) or not body:
                continue
            lst = sorted(set(lst))
            # ALIAS FIX (psyq300 LIBSN/SNMAIN `__SN_ENTRY_POINT` == `stup2` @.text+8):
            # two symbols at the SAME offset must each get the body up to the next
            # DISTINCT offset -- 'next mark' gave the first alias an empty body and
            # silently dropped it (found by the archive-export completeness check).
            offs = sorted(set(o_ for o_, _, _ in lst))
            nxt = {o_: (offs[j+1] if j + 1 < len(offs) else len(body)) for j, o_ in enumerate(offs)}
            for i, (off, nm, kind) in enumerate(lst):
                if nm not in exported:      # only emit real exported functions
                    continue
                end = nxt[off]
                fb = body[off:end]
                if not fb:
                    continue
                # SAME NAME from several members of one lib (psyq300: PadInit..PadVersion in
                # MOUSE.OBJ vs PAD.OBJ; stup0/1/2 + __SN_ENTRY_POINT across 2MBYTE/8MBYTE/NONE/
                # NONE2) -- the plain '<name>.bin' used to keep only the LAST writer, silently
                # losing byte-different variants (9 of 12 colliding names in 3.0 differ).
                # First writer keeps the plain name (compat); a byte-DIFFERENT later writer is
                # written as '<name>@<member>.bin'; identical bytes share the one file.
                # Keys are CASE-FOLDED: NTFS is case-insensitive, so distinct symbols that
                # differ only by case (psyq300 LIBCD CD_cw/cd_cw + CD_read/cd_read; LIBGUN
                # StartGUN/StartGun + StopGUN/StopGun in 3.6/4.0/4.3 -- same member, other
                # offsets) would otherwise overwrite each other on disk. Ladder: plain ->
                # name@member -> name@member@off; a file is reused only for IDENTICAL bytes.
                cands = [safe(nm) + '.bin',
                         safe(nm) + '@' + safe(member) + '.bin',
                         safe(nm) + '@' + safe(member) + '@%x.bin' % off]
                for ci, fname in enumerate(cands):
                    prev = written.get((lib, fname.lower()))
                    if prev is None:
                        written[(lib, fname.lower())] = (member, fb)
                        if ci: stats['variants'] = stats.get('variants', 0) + 1
                        break
                    if prev[1] == fb:
                        stats['dupes'] = stats.get('dupes', 0) + 1
                        break
                else:
                    raise RuntimeError('unresolvable file collision %s/%s/%s' % (lib, member, nm))
                open(os.path.join(fndir, fname), 'wb').write(fb)
                stats['funcs'] += 1
                if nm in localnames: stats['statics'] = stats.get('statics', 0) + 1
                index.append(dict(lib=lib, member=member, obj=stem + '.obj', ok=True,
                                  func=nm, section=snm, off=off, size=len(fb),
                                  insns=len(fb)//4, src=orig, file=fname,
                                  linkage='static' if nm in localnames else 'export'))
        for x in o['xdefs']:
            if not is_code_section(o['sections'].get(x['sect'])):
                stats['dsyms'] += 1
                index.append(dict(lib=lib, member=member, obj=stem + '.obj', ok=True,
                                  data_sym=x['name'], section=o['sections'].get(x['sect']),
                                  off=x.get('off', 0), size=x.get('bss', 0), src=orig))

    with open(os.path.join(OUTDIR, 'INDEX.tsv'), 'w', encoding='utf-8') as fh:
        fh.write("lib\tmember\tobj\tkind\tname\tsection\toffset\tsize\tinsns\tsource\tfile\n")
        for e in index:
            kind = 'func' if 'func' in e else ('data' if 'data_sym' in e else 'PARSE-FAIL')
            fh.write("%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" % (
                e['lib'], e['member'], e['obj'], kind,
                e.get('func') or e.get('data_sym', ''), e.get('section', ''),
                e.get('off', ''), e.get('size', ''), e.get('insns', ''), e.get('src', ''),
                e.get('file', '')))
    if desyncs:
        with open(os.path.join(OUTDIR, 'PARSE_FAILURES.txt'), 'w', encoding='utf-8') as fh:
            fh.write("\n".join(desyncs) + "\n")
    print("libs=%(libs)d members=%(members)d standalone_objs=%(objs)d" % stats)
    print("objects parsed clean=%(clean)d  desync=%(desync)d" % stats)
    print("FUNCTIONS extracted=%(funcs)d   data symbols indexed=%(dsyms)d" % stats)
    print("   ...of which file-STATIC (named local symbols): %d" % stats.get('statics', 0))
    print("   same-name variants written as name@member.bin: %d   identical-byte dupes sharing a file: %d"
          % (stats.get('variants', 0), stats.get('dupes', 0)))
    print("out:", OUTDIR)

if __name__ == '__main__':
    main()

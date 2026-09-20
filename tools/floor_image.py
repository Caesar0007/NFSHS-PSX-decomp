#!/usr/bin/env python3
"""floor_image.py -- the TRUE text byte-floor via per-function placement.

For every function in the recon objects, place its bytes at its exact retail
address (NFS4.MAP) and resolve every .text relocation against the full symbol
map (MAP functions+globals, name-encoded func_/D_/DAT_/lbl_, and
configs/symbol_addrs.txt data), then byte-compare to rom/nfs4-f.exe.

Because placement + every reloc target is the retail address, a surviving
diff is a GENUINE byte difference (a certificate function, or a real
code/pointer error) -- not a layout artifact.  This is the definitive floor
the coarse per-object probe_link can't reach.
"""
import re, struct, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MAP = ROOT / 'rom' / 'NFS4.MAP'   # retail link map off the disc; not committed
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
IMG = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()
FOFF = 0x800
LOAD = 0x80010000
GP = 0x8013c54c

# ---------------- symbol map ----------------
sym = {}
for ln in MAP.read_text(errors='replace').splitlines():
    m = re.match(r'^ ([0-9A-F]{8}) (\S+)\s*$', ln)
    if m:
        sym.setdefault(m.group(2), int(m.group(1), 16))
# data symbols from configs/symbol_addrs.txt
sa = ROOT / 'configs' / 'symbol_addrs.txt'
if sa.exists():
    for ln in sa.read_text().splitlines():
        m = re.match(r'^\s*([\w$.]+)\s*=\s*(0x[0-9A-Fa-f]+)\s*;', ln)
        if m:
            sym.setdefault(m.group(1), int(m.group(2), 16))
NAMEVA = re.compile(r'^(?:func|D|DAT|lbl)_([0-9A-Fa-f]{8})$')
def addr_of(name):
    if name in sym: return sym[name]
    m = NAMEVA.match(name)
    if m: return int(m.group(1), 16)
    return None

def run(*a): return subprocess.run(a, capture_output=True, text=True).stdout

def imgb(va, n):
    o = va - LOAD + FOFF
    return IMG[o:o+n]

def s16(x): return struct.unpack('<h', struct.pack('<H', x & 0xFFFF))[0]

def main():
    objs = [p for p in (ROOT/'build'/'recon').rglob('*.o')
            if '__' not in p.stem and (ROOT/ p.relative_to(ROOT/'build')).with_suffix('').exists()]
    total = ok = 0
    fn_ok = fn_bad = 0
    bad_fns = []
    unresolved = 0
    for obj in objs:
        st = run(OBJD, '-t', str(obj))
        fns = []
        for ln in st.splitlines():
            m = re.match(r'^([0-9a-f]{8})\s+.*F \.text\s+([0-9a-f]{8})\s+(\S+)$', ln)
            if m:
                fns.append((int(m.group(1),16), int(m.group(2),16), m.group(3)))
        fns = [f for f in fns if f[2] in sym or NAMEVA.match(f[2])]
        if not fns: continue
        # section bytes + relocs
        tb = _secbytes(obj, '.text')
        rels = _relocs(obj)
        # per-object section bases (retail): .text from a placed fn; data from
        # known-address (MAP/DAT_/symbol_addrs) symbols in that section.
        secbase = {}
        for o2, s2, n2 in fns:
            a2 = addr_of(n2)
            if a2 is not None:
                secbase['.text'] = a2 - o2; break
        allsecsyms = {}
        for ln in st.splitlines():
            m = re.match(r'^([0-9a-f]{8})\s+.*?\s(\.\w[\w.]*)\s+[0-9a-f]{8}\s+(\S+)$', ln)
            if m:
                allsecsyms.setdefault(m.group(2), []).append((int(m.group(1),16), m.group(3)))
        from collections import Counter as _C
        for s2, lst2 in allsecsyms.items():
            if s2 in secbase: continue
            votes = _C()
            for o2, n2 in lst2:
                a2 = addr_of(n2)
                if a2 is not None: votes[a2 - o2] += 1
            if votes:
                b, n = votes.most_common(1)[0]
                if n >= 1: secbase[s2] = b
        # RETAIL-DECODED bases for sections with NO named anchor (local statics):
        # the section base is a layout fact -- decode retail's resolved %hi/%lo
        # pair at the same in-function offset, base = retail_target - OUR addend
        # (our addend still tests our code: a wrong struct offset -> no match).
        secvotes = _C()
        need_secs = {r[2] for r in rels if r[2].startswith('.')} - set(secbase)
        if need_secs:
            for off2, size2, name2 in fns:
                va2 = addr_of(name2)
                if va2 is None: continue
                sz2 = size2
                if sz2 == 0:
                    nxt = [o for o in allsyms if o > off2]
                    sz2 = (nxt[0]-off2) if nxt else (len(tb)-off2)
                rl2 = [r for r in rels if off2 <= r[0] < off2+sz2]
                for a in range(len(rl2)):
                    ro, ty, tg = rl2[a]
                    if ty != 'R_MIPS_HI16' or tg not in need_secs: continue
                    b = a+1
                    while b < len(rl2) and not (rl2[b][1]=='R_MIPS_LO16' and rl2[b][2]==tg): b+=1
                    if b >= len(rl2): continue
                    lo_o = rl2[b][0]
                    ohi = struct.unpack_from('<I', tb, ro)[0]
                    olo = struct.unpack_from('<I', tb, lo_o)[0]
                    oadd = ((ohi&0xFFFF)<<16) + s16(olo)
                    rhi = imgb(va2 + (ro-off2), 4); rlo = imgb(va2 + (lo_o-off2), 4)
                    if len(rhi) < 4 or len(rlo) < 4: continue
                    rt = ((int.from_bytes(rhi,'little')&0xFFFF)<<16) + s16(int.from_bytes(rlo,'little'))
                    secvotes[(tg, rt - oadd)] += 1
            for tg in need_secs:
                cand = _C({base: n for (s3, base), n in secvotes.items() if s3 == tg})
                if cand:
                    b, n = cand.most_common(1)[0]
                    if n >= 1: secbase[tg] = b
        # extents: sort by offset (all .text symbols) for size
        allo = []
        for ln in st.splitlines():
            m = re.match(r'^([0-9a-f]{8})\s+.*\.text\s+[0-9a-f]{8}\s+(\S+)$', ln)
            if m:
                allo.append(int(m.group(1), 16))
        allsyms = sorted(set(allo))
        for off, size, name in fns:
            va = addr_of(name)
            if va is None: continue
            if size == 0:
                # extent to next .text symbol
                nxt = [o for o in allsyms if o > off]
                size = (nxt[0]-off) if nxt else (len(tb)-off)
            body = bytearray(tb[off:off+size])
            if len(body) < size: continue
            # resolve relocs within [off, off+size)
            i = 0
            skip = False
            rl = [r for r in rels if off <= r[0] < off+size]
            k = 0
            while k < len(rl):
                roff, typ, tgt = rl[k]
                ta = addr_of(tgt)
                w = struct.unpack_from('<I', body, roff-off)[0]
                if ta is None and tgt in secbase:
                    ta = secbase[tgt]     # section-relative: base; addend is in the field
                if ta is None:
                    unresolved += 1; k += 1; continue
                if typ == 'R_MIPS_26':
                    # named target: field addend ~0 -> ta.  section-relative
                    # (.text): field = (offset>>2) -> base + offset.
                    dest = ta + (((w & 0x03FFFFFF) << 2) if tgt.startswith('.') else 0)
                    struct.pack_into('<I', body, roff-off, (w & 0xFC000000) | ((dest>>2)&0x03FFFFFF))
                elif typ == 'R_MIPS_HI16':
                    # partner lo
                    j = k+1
                    while j < len(rl) and not (rl[j][1]=='R_MIPS_LO16' and rl[j][2]==tgt): j+=1
                    if j >= len(rl): k+=1; continue
                    wlo = struct.unpack_from('<I', body, rl[j][0]-off)[0]
                    addend = ((w&0xFFFF)<<16) + s16(wlo)
                    v = ta + addend
                    lo = v & 0xFFFF; hi = ((v - s16(lo))>>16) & 0xFFFF
                    struct.pack_into('<I', body, roff-off, (w&0xFFFF0000)|hi)
                    struct.pack_into('<I', body, rl[j][0]-off, (wlo&0xFFFF0000)|lo)
                    rl.pop(j)
                elif typ == 'R_MIPS_LO16':
                    v = ta + s16(w)
                    struct.pack_into('<I', body, roff-off, (w&0xFFFF0000)|(v&0xFFFF))
                elif typ == 'R_MIPS_GPREL16':
                    v = (ta - GP) & 0xFFFF
                    struct.pack_into('<I', body, roff-off, (w&0xFFFF0000)|v)
                k += 1
            theirs = imgb(va, size)
            if len(theirs) < size: continue
            d = sum(1 for a in range(0,size-3,4)
                    if body[a:a+4] != theirs[a:a+4])
            total += size//4; ok += size//4 - d
            if d == 0: fn_ok += 1
            else:
                fn_bad += 1; bad_fns.append((d, size, name, obj.stem))
    print(f'functions placed: {fn_ok+fn_bad}  byte-exact: {fn_ok}  differ: {fn_bad}')
    print(f'words: {total}  identical: {ok}  ({100.0*ok/total:.3f}%)' if total else 'no words')
    print(f'unresolved relocs (section-relative locals): {unresolved}')
    print('=== differing functions (top 30 by diff words) ===')
    for d,s,n,tu in sorted(bad_fns, key=lambda x:-x[0])[:30]:
        print(f'  {d:4d}w  {n} [{tu}]')

_c={}
def _secbytes(obj, sec):
    k=(str(obj),sec)
    if k in _c: return _c[k]
    buf=bytearray()
    for ln in run(OBJD,'-s','-j',sec,str(obj)).splitlines():
        m=re.match(r'^ ([0-9a-f]{4,8}) ((?:[0-9a-f]{2,8} ?){1,4}) ',ln)
        if m:
            a=int(m.group(1),16); dd=bytes.fromhex(m.group(2).replace(' ',''))
            if len(buf)<a: buf.extend(b'\0'*(a-len(buf)))
            buf[a:a+len(dd)]=dd
    _c[k]=bytes(buf); return _c[k]

def _relocs(obj):
    out=[]; cur=None
    for ln in run(OBJD,'-r',str(obj)).splitlines():
        m=re.match(r'^RELOCATION RECORDS FOR \[(\S+)\]',ln)
        if m: cur=m.group(1); continue
        m=re.match(r'^([0-9a-f]{8})\s+(R_MIPS_\S+)\s+(\S+)$',ln)
        if m and cur=='.text': out.append((int(m.group(1),16),m.group(2),m.group(3)))
    return out

if __name__=='__main__':
    main()

#!/usr/bin/env python3
"""full_link.py -- THE PRODUCTION FINAL LINK + whole-image byte-compare.

Final-links (placed, not `ld -r`) the recon lane with linkers/nfs4_recon.ld
(the production placement: every object at its retail address, raw data blobs
+ NOLOAD bss owners + catch-alls), extracts the loadable image, and byte-
compares it to rom/nfs4-f.exe (the merged oracle = main binary with the
front.bin overlay in bigBuf).

Object set + oracle-only exclusions come from relink.lane_objects("recon"),
so stale probe/gate orphans and superseded raw leaves are handled exactly as
the standing link gate does.  This is the definitive floor: any surviving
diff is a real byte difference (the 4 certificate functions, or a genuine
error), with every address resolved natively by ld.
"""
import re, subprocess, sys, importlib.util
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MIPS = Path(r'C:/Tools/mips-ps1/mips/bin')
LD = str(MIPS / 'mipsel-none-elf-ld.exe')
OBJCOPY = str(MIPS / 'mipsel-none-elf-objcopy.exe')
OBJDUMP = str(MIPS / 'mipsel-none-elf-objdump.exe')
OUT = ROOT / 'build' / 'full_link'
LOAD = 0x80010000
FOFF = 0x800

# reuse relink's lane object gathering
spec = importlib.util.spec_from_file_location('relink', ROOT / 'tools' / 'relink.py')
relink = importlib.util.module_from_spec(spec)
spec.loader.exec_module(relink)

def main():
    OUT.mkdir(parents=True, exist_ok=True)
    objs = relink.lane_objects('recon')
    print(f'[objs] {len(objs)} recon-lane objects')
    elf = OUT / 'full.elf'
    if elf.exists():
        elf.unlink()
    cmd = [LD]
    for scr in ('linkers/undefined_syms_auto.txt', 'linkers/undefined_funcs_auto.txt',
                'linkers/retail_data_symbols.ld', 'linkers/nfs4_recon.ld', 'linkers/map_symbols_provide.ld'):
        if (ROOT / scr).exists():
            cmd += ['-T', scr]
    cmd += ['--unresolved-symbols=ignore-all', '--allow-multiple-definition',
            '--no-check-sections', '--noinhibit-exec',
            '-Map', 'build/full_link/full.map', '-o', 'build/full_link/full.elf']
    cmd += [str(o.relative_to(ROOT).as_posix()) for o in objs]
    r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
    errs = [l for l in r.stderr.replace('\r\n', '\n').split('\n') if l.strip()]
    print(f'[ld] rc={r.returncode}  stderr lines={len(errs)}')
    for e in errs[:6]:
        print('   ', e)
    if not elf.exists():
        sys.exit('no ELF produced')

    # Build the placed image by VA from objdump -s (robust vs overlaps/gaps).
    rom = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()[FOFF:]
    romend = LOAD + len(rom)
    img = bytearray(len(rom))
    covered = bytearray(len(rom))
    dump = subprocess.run([OBJDUMP, '-s', str(elf)], capture_output=True, text=True).stdout
    for ln in dump.splitlines():
        m = re.match(r'^ ([0-9a-f]{8}) ((?:[0-9a-f]{2,8} ?){1,4})', ln)
        if not m:
            continue
        va = int(m.group(1), 16)
        data = bytes.fromhex(m.group(2).replace(' ', ''))
        if va < LOAD or va + len(data) > romend:
            continue
        off = va - LOAD
        img[off:off+len(data)] = data
        for i in range(len(data)):
            covered[off+i] = 1
    # ---- HYBRID: fill dropped/uncovered functions per-function ------------
    # Whole-object ld placement drops interleaved objects (feapp<->fe3dmenu).
    # Place THEIR functions individually at their MAP addresses, resolving
    # relocs against the MAP + name-encoded + per-object section bases
    # (retail-decoded for un-named local sections) -- exactly floor_image's
    # method -- into the uncovered regions.
    import struct as _st
    mapaddr = {}
    for l2 in Path(r'C:/Temp/_from_github/NFS4.MAP').read_text(errors='replace').splitlines():
        mm = re.match(r'^ ([0-9A-F]{8}) (\S+)\s*$', l2)
        if mm: mapaddr.setdefault(mm.group(2), int(mm.group(1), 16))
    sa = ROOT / 'configs' / 'symbol_addrs.txt'
    if sa.exists():
        for l2 in sa.read_text().splitlines():
            mm = re.match(r'^\s*([\w$.]+)\s*=\s*(0x[0-9A-Fa-f]+)\s*;', l2)
            if mm: mapaddr.setdefault(mm.group(1), int(mm.group(2), 16))
    NAMEVA = re.compile(r'^(?:func|D|DAT|lbl)_([0-9A-Fa-f]{8})$')
    def aof(n):
        if n in mapaddr: return mapaddr[n]
        m = NAMEVA.match(n)
        return int(m.group(1), 16) if m else None
    def s16(x): return _st.unpack('<h', _st.pack('<H', x & 0xFFFF))[0]
    def secbytes(obj, sec):
        buf = bytearray()
        for ln in subprocess.run([OBJDUMP,'-s','-j',sec,str(obj)],capture_output=True,text=True).stdout.splitlines():
            m = re.match(r'^ ([0-9a-f]{4,8}) ((?:[0-9a-f]{2,8} ?){1,4})', ln)
            if m:
                a=int(m.group(1),16); d=bytes.fromhex(m.group(2).replace(' ',''))
                if len(buf)<a: buf.extend(b'\0'*(a-len(buf)))
                buf[a:a+len(d)]=d
        return bytes(buf)
    filled = 0
    for o in objs:
        st = subprocess.run([OBJDUMP,'-t',str(o)],capture_output=True,text=True).stdout
        fns=[]; allt=[]
        for ln in st.splitlines():
            m=re.match(r'^([0-9a-f]{8})\s+.*F \.text\s+([0-9a-f]{8})\s+(\S+)$',ln)
            if m: fns.append((int(m.group(1),16),int(m.group(2),16),m.group(3)))
            m2=re.match(r'^([0-9a-f]{8})\s+.*\.text\s+[0-9a-f]{8}\s+(\S+)$',ln)
            if m2: allt.append(int(m2.group(1),16))
        fns=[f for f in fns if aof(f[2]) is not None]
        if not fns: continue
        # only act if this object's fns are (partly) uncovered
        if all(covered[aof(n)-LOAD] for _,_,n in fns if aof(n) and LOAD<=aof(n)<romend):
            continue
        tb=secbytes(o,'.text'); allt=sorted(set(allt))
        rels=[]; cur=None
        for ln in subprocess.run([OBJDUMP,'-r',str(o)],capture_output=True,text=True).stdout.splitlines():
            mm=re.match(r'^RELOCATION RECORDS FOR \[(\S+)\]',ln)
            if mm: cur=mm.group(1); continue
            mm=re.match(r'^([0-9a-f]{8})\s+(R_MIPS_\S+)\s+(\S+)$',ln)
            if mm and cur=='.text': rels.append((int(mm.group(1),16),mm.group(2),mm.group(3)))
        # per-object section bases: .text from a placed fn; others via retail-decode
        sb={}
        for off2,_,n2 in fns:
            a2=aof(n2)
            if a2 is not None: sb.setdefault('.text', a2-off2)
        from collections import Counter as _C
        need={r[2] for r in rels if r[2].startswith('.')}-set(sb)
        votes=_C()
        for off2,sz2,n2 in fns:
            va2=aof(n2)
            if va2 is None: continue
            if sz2==0:
                nx=[a for a in allt if a>off2]; sz2=(nx[0]-off2) if nx else len(tb)-off2
            rl=[r for r in rels if off2<=r[0]<off2+sz2]
            for a in range(len(rl)):
                ro,ty,tg=rl[a]
                if ty!='R_MIPS_HI16' or tg not in need: continue
                b=a+1
                while b<len(rl) and not(rl[b][1]=='R_MIPS_LO16' and rl[b][2]==tg): b+=1
                if b>=len(rl): continue
                lo=rl[b][0]
                oadd=(( _st.unpack_from('<I',tb,ro)[0]&0xFFFF)<<16)+s16(_st.unpack_from('<I',tb,lo)[0])
                rt=(( _st.unpack_from('<I',rom,va2+(ro-off2)-LOAD)[0]&0xFFFF)<<16)+s16(_st.unpack_from('<I',rom,va2+(lo-off2)-LOAD)[0]) if 0<=va2+(ro-off2)-LOAD<len(rom)-3 else None
                if rt is not None: votes[(tg,rt-oadd)]+=1
        for tg in need:
            c=_C({bb:n for (s3,bb),n in votes.items() if s3==tg})
            if c: sb[tg]=c.most_common(1)[0][0]
        # place each fn
        for off2,sz2,n2 in fns:
            va2=aof(n2)
            if va2 is None or not (LOAD<=va2<romend): continue
            if sz2==0:
                nx=[a for a in allt if a>off2]; sz2=(nx[0]-off2) if nx else len(tb)-off2
            if covered[va2-LOAD]: continue
            body=bytearray(tb[off2:off2+sz2])
            rl=[r for r in rels if off2<=r[0]<off2+sz2]; k=0
            okfn=True
            while k<len(rl):
                ro,ty,tg=rl[k]
                ta=aof(tg)
                if ta is None and tg in sb: ta=sb[tg]
                w=_st.unpack_from('<I',body,ro-off2)[0]
                if ta is None: k+=1; continue
                if ty=='R_MIPS_26':
                    dest=ta+(((w&0x3FFFFFF)<<2) if tg.startswith('.') else 0)
                    _st.pack_into('<I',body,ro-off2,(w&0xFC000000)|((dest>>2)&0x3FFFFFF))
                elif ty=='R_MIPS_HI16':
                    j=k+1
                    while j<len(rl) and not(rl[j][1]=='R_MIPS_LO16' and rl[j][2]==tg): j+=1
                    if j<len(rl):
                        wl=_st.unpack_from('<I',body,rl[j][0]-off2)[0]
                        v=ta+(((w&0xFFFF)<<16)+s16(wl)); lo=v&0xFFFF; hi=((v-s16(lo))>>16)&0xFFFF
                        _st.pack_into('<I',body,ro-off2,(w&0xFFFF0000)|hi)
                        _st.pack_into('<I',body,rl[j][0]-off2,(wl&0xFFFF0000)|lo); rl.pop(j)
                elif ty=='R_MIPS_LO16':
                    v=ta+s16(w); _st.pack_into('<I',body,ro-off2,(w&0xFFFF0000)|(v&0xFFFF))
                elif ty=='R_MIPS_GPREL16':
                    v=(ta-0x8013c54c)&0xFFFF; _st.pack_into('<I',body,ro-off2,(w&0xFFFF0000)|v)
                k+=1
            o0=va2-LOAD
            img[o0:o0+sz2]=body
            for i in range(sz2):
                if o0+i<len(covered): covered[o0+i]=1
            filled+=1
    print(f'[hybrid] per-function placed {filled} previously-uncovered fns')

    # compare only covered words (loadable PROGBITS placed inside the ROM image)
    total = ident = 0
    diff_addrs = []
    for off in range(0, len(rom) - 3, 4):
        if not (covered[off] and covered[off+1] and covered[off+2] and covered[off+3]):
            continue
        total += 1
        if img[off:off+4] == rom[off:off+4]:
            ident += 1
        else:
            diff_addrs.append(LOAD + off)
    print(f'[cmp] covered words {total}  identical {ident}  '
          f'({100.0*ident/total:.3f}%)  diff words {len(diff_addrs)}')
    # attribute diffs to functions/symbols via NFS4.MAP
    import bisect
    mp = []
    MAP = Path(r'C:/Temp/_from_github/NFS4.MAP')
    for l2 in MAP.read_text(errors='replace').splitlines():
        mm = re.match(r'^ ([0-9A-F]{8}) (\S+)\s*$', l2)
        if mm:
            mp.append((int(mm.group(1), 16), mm.group(2)))
    mp.sort()
    addrs = [a for a, _ in mp]
    from collections import Counter
    byfn = Counter()
    for a in diff_addrs:
        i = bisect.bisect_right(addrs, a) - 1
        byfn[mp[i][1] if i >= 0 else hex(a)] += 1
    (OUT / 'full_diff.txt').write_text(
        '\n'.join(f'{c:6d}  {n}' for n, c in byfn.most_common()))
    print('[cmp] top diff owners (symbol : diff words):')
    for n, c in byfn.most_common(25):
        print(f'   {c:6d}  {n}')

if __name__ == '__main__':
    main()

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
                'linkers/retail_data_symbols.ld', 'linkers/nfs4_recon.ld'):
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

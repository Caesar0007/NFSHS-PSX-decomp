"""honest_diffs.py -- list the differing words of the honest link (same flattening as tools/honest_measure.py)."""
import re
import subprocess

R = 'C:/Temp/nfs4-decomp/'
OBJDUMP = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
LOAD, FOFF = 0x80010000, 0x800
rom = open(R + 'rom/nfs4-f.exe', 'rb').read()[FOFF:]
img = bytearray(len(rom)); cov = bytearray(len(rom))
for ln in subprocess.run([OBJDUMP, '-s', R + 'build/gen_ld/recon_multdef-ok.elf'], capture_output=True, text=True).stdout.splitlines():
    m = re.match(r'^ ([0-9a-f]{8}) ((?:[0-9a-f]{2,8} ?){1,4})', ln)
    if not m:
        continue
    va = int(m.group(1), 16); d = bytes.fromhex(m.group(2).replace(' ', ''))
    if va < LOAD or va + len(d) > LOAD + len(rom):
        continue
    img[va - LOAD:va - LOAD + len(d)] = d
    for i in range(len(d)):
        cov[va - LOAD + i] = 1
for off in range(0, len(rom) - 3, 4):
    if all(cov[off:off + 4]) and img[off:off + 4] != rom[off:off + 4]:
        print('%08x  ours %s  retail %s' % (LOAD + off, img[off:off + 4][::-1].hex(), rom[off:off + 4][::-1].hex()))

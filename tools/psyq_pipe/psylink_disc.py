"""psylink_disc.py -- the two DISC FILES straight from the original SN tools (run psylink_lane.py first).

  PSYLINK 2.73:  the lane's link script + two lines --
        regs    pc=__SN_ENTRY_POINT
        front   group   over(text),file("front.bin")
      `file()` makes the linker write the overlay group to its own raw file (front.rdata .. front.bss, zeros included) and
      leave it OUT of the CPE, so the CPE holds the main groups only -- with bigbuf.obj's zero reservation in the hole.
  CPE2X 1.5 (Sony, 16-bit DOS, run under tools/msdos-player/msdos.exe): NFS4.CPE -> NFS4.EXE (/CA = North America).

Outputs build/psyq/disc/{NFS4.EXE,FRONT.BIN} and compares them with the retail disc files (cut from rom/nfs4-f.exe exactly
like tools/elf_to_exe.py --split: FRONT.BIN = 0x80010000..0x80054548, NFS4.EXE = the same exe with that range zeroed)."""
import os
import shutil
import struct
import subprocess
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
OUT = ROOT / 'build' / 'psyq'
DISC = OUT / 'disc'
PSYLINK = 'C:/Temp/psq43/PSSN/PSYLINK.EXE'
CPE2X = 'C:/Temp/psq43/PSX/BIN/CPE2X.EXE'
MSDOS = str(ROOT / 'tools' / 'msdos-player' / 'msdos.exe')   # vendored DOS runner (GPL v2, see its README); CPE2X itself is Sony's, not vendored
ENV = dict(os.environ, MSYS2_ARG_CONV_EXCL='*', MSYS_NO_PATHCONV='1')
FRONT_SIZE = 0x44548

lnk = (OUT / 'nfs4.lnk').read_bytes()
nl = b'\r\n' if b'\r\n' in lnk else b'\n'
a = b'\torg\t$80010000' + nl
b = b'front\tgroup\tover(text)' + nl
assert lnk.count(a) == 1 and lnk.count(b) == 1
lnk = lnk.replace(a, a + b'\tregs\tpc=__SN_ENTRY_POINT' + nl).replace(b, b'front\tgroup\tover(text),file("front.bin")' + nl)
(OUT / 'nfs4disc.lnk').write_bytes(lnk)
for f in ('front.bin', 'NFS4.CPE', 'NFS4.EXE', 'nfs4disc.cpe'):
    if (OUT / f).exists():
        (OUT / f).unlink()
r = subprocess.run([PSYLINK, '/c', '/m', '@nfs4disc.lnk,nfs4disc.cpe,nfs4disc.sym,nfs4disc.map'], cwd=OUT, capture_output=True, text=True, timeout=600, env=ENV)
print('PSYLINK:', (r.stdout + r.stderr).strip().splitlines()[-1])
shutil.copy(OUT / 'nfs4disc.cpe', OUT / 'NFS4.CPE')
shutil.copy(CPE2X, OUT / 'CPE2X.EXE')
r = subprocess.run([MSDOS, 'CPE2X.EXE', '/CA', 'NFS4.CPE'], cwd=OUT, capture_output=True, text=True, timeout=600, env=ENV)
print('CPE2X  :', (r.stdout + r.stderr).strip().splitlines()[-1])
DISC.mkdir(exist_ok=True)
shutil.copy(OUT / 'NFS4.EXE', DISC / 'NFS4.EXE')
shutil.copy(OUT / 'front.bin', DISC / 'FRONT.BIN')

rom = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()
retail = {'FRONT.BIN': rom[0x800:0x800 + FRONT_SIZE], 'NFS4.EXE': rom[:0x800] + bytes(FRONT_SIZE) + rom[0x800 + FRONT_SIZE:]}
for n in ('NFS4.EXE', 'FRONT.BIN'):
    o, t = (DISC / n).read_bytes(), retail[n]
    m = min(len(o), len(t))
    same = sum(1 for i in range(m) if o[i] == t[i])
    first = next((i for i in range(m) if o[i] != t[i]), None)
    print('%-9s ours %7d B  retail %7d B  identical %7d  first difference @%s' % (n, len(o), len(t), same, hex(first) if first is not None else '-'))
o, t = (DISC / 'NFS4.EXE').read_bytes(), retail['NFS4.EXE']
for off, name in ((0x10, 'pc0'), (0x18, 't_addr'), (0x1c, 't_size'), (0x30, 's_addr')):
    print('   header %-6s ours %08x  retail %08x' % (name, struct.unpack_from('<I', o, off)[0], struct.unpack_from('<I', t, off)[0]))
print('   bigBuf hole (282000 B) all zero in ours:', not any(o[0x800:0x800 + 282000]))

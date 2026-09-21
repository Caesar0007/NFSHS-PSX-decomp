#!/usr/bin/env python3
"""slink_disc.py -- the two DISC FILES from Route C (run slink_lane.py first).

slink_lane.py leaves build/psyq_off/off.cpe (the main program, with bigbuf.obj's zero reservation where the overlay goes)
and off_front.bin (the `front` overlay group, written raw by slink's file() attribute).  Sony's CPE2X /CA turns the CPE
into NFS4.EXE (16-bit DOS program, run under the vendored tools/msdos-player/msdos.exe).  Both files are then compared
with the retail disc files, cut from rom/nfs4-f.exe exactly like tools/elf_to_exe.py --split does."""
import hashlib
import os
import shutil
import struct
import subprocess
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
DISC = OUT / 'disc'
CPE2X = 'C:/Temp/psq43/PSX/BIN/CPE2X.EXE'
MSDOS = str(ROOT / 'tools' / 'msdos-player' / 'msdos.exe')
ENV = dict(os.environ, MSYS2_ARG_CONV_EXCL='*', MSYS_NO_PATHCONV='1')
FRONT_SIZE = 0x44548

for f in ('NFS4.CPE', 'NFS4.EXE'):
    if (OUT / f).exists():
        (OUT / f).unlink()
shutil.copy(OUT / 'off.cpe', OUT / 'NFS4.CPE')
shutil.copy(CPE2X, OUT / 'CPE2X.EXE')
r = subprocess.run([MSDOS, 'CPE2X.EXE', '/CA', 'NFS4.CPE'], cwd=OUT, capture_output=True, text=True, timeout=600, env=ENV)
print('CPE2X  :', ((r.stdout + r.stderr).strip().splitlines() or ['?'])[-1])
DISC.mkdir(exist_ok=True)
shutil.copy(OUT / 'NFS4.EXE', DISC / 'NFS4.EXE')
shutil.copy(OUT / 'off_front.bin', DISC / 'FRONT.BIN')
rom = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()
retail = {'FRONT.BIN': rom[0x800:0x800 + FRONT_SIZE], 'NFS4.EXE': rom[:0x800] + bytes(FRONT_SIZE) + rom[0x800 + FRONT_SIZE:]}
for n in ('NFS4.EXE', 'FRONT.BIN'):
    o, t = (DISC / n).read_bytes(), retail[n]
    m = min(len(o), len(t))
    diff = [i for i in range(m) if o[i] != t[i]]
    print('%-9s ours %7d B  retail %7d B  differing bytes %d%s   sha1 %s / %s' % (
        n, len(o), len(t), len(diff) + abs(len(o) - len(t)), '' if not diff else '  first @%#x' % diff[0],
        hashlib.sha1(o).hexdigest()[:12], hashlib.sha1(t).hexdigest()[:12]))
    if o == t:
        print('          BYTE-IDENTICAL to the retail disc file')

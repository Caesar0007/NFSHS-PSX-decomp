"""strip_worddiff.py OBJ FUNCTION LIB/NAME [SLICE_OFF SLICE_LEN] -- word-by-word diff of one LINK_STRIPPED function against
its SDK blob (relocated fields masked like the gate); prints ours vs SDK disassembly for the differing words."""
import re
import struct
import subprocess
import sys
from pathlib import Path

R = Path(__file__).resolve().parents[2].as_posix() + '/'
B = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-'
obj, fn, sdk = sys.argv[1:4]
lib, name = sdk.split('/')
blob = open('C:/Temp/nfs4-clean/psyq43/extracted/%s/functions/%s.bin' % (lib, name), 'rb').read()
if len(sys.argv) > 5:
    blob = blob[int(sys.argv[4]):int(sys.argv[4]) + int(sys.argv[5])]
o = R + obj
t = subprocess.run([B + 'objdump.exe', '-t', o], capture_output=True, text=True).stdout
off = [int(l.split()[0], 16) for l in t.splitlines() if l.split()[-1:] == [fn] and '.text.strip' in l][0]
subprocess.run([B + 'objcopy.exe', '-O', 'binary', '-j', '.text.strip', o, R + 'build/tmp/wd.bin'])
sec = open(R + 'build/tmp/wd.bin', 'rb').read()
rel = {}
for ln in subprocess.run([B + 'objdump.exe', '-r', '-j', '.text.strip', o], capture_output=True, text=True).stdout.splitlines():
    m = re.match(r'^([0-9a-f]{8})\s+(R_MIPS_\w+)', ln)
    if m:
        rel[int(m.group(1), 16)] = m.group(2)


def dis(words):
    open(R + 'build/tmp/wd2.bin', 'wb').write(b''.join(struct.pack('<I', w) for w in words))
    out = subprocess.run([B + 'objdump.exe', '-D', '-b', 'binary', '-m', 'mips:3000', '-EL', '-M', 'no-aliases', R + 'build/tmp/wd2.bin'],
                         capture_output=True, text=True).stdout
    return [re.sub(r'\s+', ' ', m.group(1)) for m in re.finditer(r'^\s*[0-9a-f]+:\s+[0-9a-f]{8}\s+(.*)$', out, re.M)]


n = len(blob) // 4
ours = [struct.unpack_from('<I', sec, off + 4 * i)[0] for i in range(n)]
theirs = [struct.unpack_from('<I', blob, 4 * i)[0] for i in range(n)]
do, dt = dis(ours), dis(theirs)
for i in range(n):
    k = rel.get(off + 4 * i, '')
    mask = 0xFC000000 if k == 'R_MIPS_26' else 0xFFFF0000 if k in ('R_MIPS_HI16', 'R_MIPS_LO16') else 0xFFFFFFFF
    if (ours[i] & mask) != (theirs[i] & mask):
        print('%04x  ours %-30s sdk %-30s' % (4 * i, do[i][:30], dt[i][:30]))

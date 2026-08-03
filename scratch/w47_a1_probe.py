"""w47-a1 probe harness: swap a snippet in nfile.c against a saved base, gate, report.
usage: python scratch/w47_a1_probe.py <old_file> <new_file> <fn[,fn...]>
old/new files are read as text; LF is normalised to CRLF to match the TU."""
import sys, subprocess

P = 'recon/eaclib/psx/eacpsxz/nfile.c'
BASE = open('scratch/w47_a1_base.c', 'rb').read().decode('utf-8')


def rd(path):
    t = open(path, 'rb').read().decode('utf-8')
    return t.replace('\r\n', '\n').replace('\n', '\r\n')


old, new = rd(sys.argv[1]), rd(sys.argv[2])
assert BASE.count(old) == 1, 'anchor count %d' % BASE.count(old)
open(P, 'wb').write(BASE.replace(old, new).encode('utf-8'))
r = subprocess.run([sys.executable, 'tools/verify_asm.py', P, sys.argv[3]],
                   capture_output=True, text=True)
for line in r.stdout.splitlines():
    if 'PASS' in line or 'FAIL' in line or 'ORACLE' in line:
        print(line)
if not r.stdout.strip():
    print(r.stderr[-1200:])

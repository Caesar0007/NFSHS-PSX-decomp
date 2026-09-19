"""textsize_check.py [substr...] -- compare every recon object's built .text size with its retail slot
(distance to the next spine base in linkers/nfs4_recon.ld).  Prints only mismatches (or objects matching a substr)."""
import re
import subprocess
import sys

ROOT = 'C:/Temp/nfs4-decomp/'
OD = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
ld = open(ROOT + 'linkers/nfs4_recon.ld').read()
spine = [(int(a, 16), o) for a, o in re.findall(r'(0x[0-9a-f]+) : SUBALIGN\(4\) \{ (build/recon/\S+?)\(\.text\)', ld)]
spine.sort()
want = sys.argv[1:]
for i, (a, o) in enumerate(spine[:-1]):
    nxt = spine[i + 1][0]
    if want and not any(w in o for w in want):
        continue
    out = subprocess.run([OD, '-h', ROOT + o], capture_output=True, text=True).stdout
    m = re.search(r'^\s*\d+\s+\.text\s+([0-9a-f]{8})', out, re.M)
    sz = int(m.group(1), 16) if m else -1
    slot = nxt - a
    if want or not (sz <= slot and slot - sz < 8) :
        print('%#010x  built %#7x  slot %#7x  %+5d  %s' % (a, sz, slot, sz - slot, o.replace('build/recon/', '')))

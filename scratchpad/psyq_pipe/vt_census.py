"""vt_census.py -- which front-end object emits which vtables (R/D = global, r/d = local copy), and for each class the
retail owner by table address (rodata placement rows).  Local copies in the wrong object mean an owner surface sees an
ALL-INLINE version of the class (no key function visible)."""
import glob
import re
import subprocess

R = 'C:/Temp/nfs4-decomp/'
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
objs = glob.glob(R + 'build/recon/frontend/common/*.cpp.o') + glob.glob(R + 'build/recon/frontend/psx/*.cpp.o')
import os
objs = [o.replace(chr(92), '/') for o in objs if os.path.exists(o.replace(chr(92), '/').replace('/build/recon/', '/recon/')[:-2])]
rel = [o.replace(R, '') for o in objs]
out = ''
for k in range(0, len(rel), 20):
    out += subprocess.run([NM, '-A'] + rel[k:k + 20], capture_output=True, text=True, cwd=R).stdout
per = {}
for ln in out.splitlines():
    m = re.match(r'(.*?\.o):\S+ ([RrDd]) _vt\.\d+(\w+)$', ln)
    if m:
        per.setdefault(m.group(1).replace('\\', '/').split('/')[-1].replace('.cpp.o', ''), []).append(m.group(2) + ':' + m.group(3))
for o in sorted(per):
    print('%-22s %s' % (o, ' '.join(sorted(per[o]))))

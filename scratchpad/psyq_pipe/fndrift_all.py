"""fndrift_all.py [substr] -- for every front-end recon object: compare the built function layout with retail, using the
object's FIRST retail-known function as the anchor (gen_ld's implied spine base is unreliable once objects are dropped).
Prints one line per object that drifts: total size delta, the first culprit function, and symbols retail does not have."""
import glob
import os
import re
import subprocess
import sys

R = 'C:/Temp/nfs4-decomp/'
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
want = sys.argv[1] if len(sys.argv) > 1 else ''
sym = {}
for ln in open(R + 'configs/symbol_addrs.txt', errors='replace'):
    m = re.match(r'(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);', ln)
    if m:
        sym.setdefault(m.group(1), int(m.group(2), 16))
objs = sorted(glob.glob(R + 'build/recon/frontend/common/*.cpp.o') + glob.glob(R + 'build/recon/frontend/psx/*.cpp.o') +
              glob.glob(R + 'build/recon/game/psx/fe3dmenu.cpp.o'))
for o in objs:
    o = o.replace('\\', '/')
    if want not in o or not os.path.exists(o.replace('/build/recon/', '/recon/')[:-2]):
        continue
    out = subprocess.run([NM, '-n', o.replace(R, '')], capture_output=True, text=True, cwd=R).stdout
    fns = []
    for ln in out.splitlines():
        p = ln.split()
        if len(p) == 3 and p[1] in 'Tt' and not p[2].startswith(('gcc2_', '__gnu_compiled')):
            fns.append((int(p[0], 16), p[2]))
    base, prev, last, culprits, unknown = None, None, '', [], []
    for off, name in fns:
        r = sym.get(name) or sym.get(name.replace('_._', '___')) or sym.get(name.replace('___', '_._'))
        if r is None:
            unknown.append(name)
            last = name
            continue
        if base is None:
            base = r - off
        d = off + base - r
        if prev is not None and d != prev:
            culprits.append('%+d after %s' % (d - prev, last[:48]))
        prev, last = d, name
    if culprits or unknown:
        print('%-22s %s%s' % (o.split('/')[-1].replace('.cpp.o', ''), '; '.join(culprits[:3]),
                              ('   NOT-IN-RETAIL: ' + ', '.join(u[:40] for u in unknown[:3])) if unknown else ''))

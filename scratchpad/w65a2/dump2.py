#!/usr/bin/env python3
"""dump2.py CPP FN LO HI -- print ours+oracle instruction list in index range."""
import re, subprocess, sys
from pathlib import Path
ROOT = Path(r'C:\Temp\nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
src = (ROOT / 'tools' / 'verify_asm.py').read_text()
head = src.split('allpass=True')[0]
g = {'__name__': '__vsrc__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}
cpp, fn = sys.argv[1], sys.argv[2]
lo = int(sys.argv[3]); hi = int(sys.argv[4])
sys.argv = ['verify_asm.py', cpp, '__none__']
exec(compile(head, 'verify_asm_head', 'exec'), g)
obj = g['obj']
dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)], capture_output=True, text=True).stdout
lab = g['_resolve'](fn)
body, on = [], False
for ln in dis.splitlines():
    m = re.match(r'^([0-9a-f]{8}) <(.+)>:', ln)
    if m:
        on = (m.group(2) == lab); continue
    if not on: continue
    m = re.match(r'^\s*([0-9a-f]+):\t[0-9a-f ]+\t(.*)$', ln)
    if m: body.append((int(m.group(1),16), m.group(2).split(';')[0].strip()))
    elif ln.strip() == '': on = False
p = g['_find_oracle_path'](fn)
o_idx, o_body = 0, []
for ln in p.read_text().splitlines():
    s = re.sub(r'/\*.*?\*/','',ln).strip()
    if s.startswith('endlabel'): break
    if s.endswith(':') and s.startswith('.L'):
        o_body.append((o_idx, s, True)); continue
    if s.startswith('.word'):
        o_body.append((o_idx, s, False)); o_idx += 1; continue
    if not s or s.startswith(('.','glabel','nonmatching','dlabel','jlabel','alabel')) or s.endswith(':'):
        continue
    o_body.append((o_idx, s, False)); o_idx += 1
print('=== OURS %d..%d ===' % (lo,hi))
for k in range(max(0,lo), min(len(body), hi+1)):
    print('%4d %08x %s' % (k, body[k][0], body[k][1]))
print('=== ORACLE %d..%d ===' % (lo,hi))
for (a,s,isl) in o_body:
    if lo <= a <= hi: print('%4d %s %s' % (a, 'L' if isl else ' ', s))

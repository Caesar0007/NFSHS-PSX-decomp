#!/usr/bin/env python3
"""brshow.py CPP FN [idx] -- print ours (objdump) and oracle (.s) around a branch index."""
import re, subprocess, sys
from pathlib import Path
ROOT = Path(r'C:\Temp\nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
BR = re.compile(r'^\s*(b\w*|j)\b')
src = (ROOT / 'tools' / 'verify_asm.py').read_text()
head = src.split('allpass=True')[0]
g = {'__name__': '__vsrc__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}
cpp = sys.argv[1]; fn = sys.argv[2]
idx = int(sys.argv[3]) if len(sys.argv) > 3 else None
win = int(sys.argv[4]) if len(sys.argv) > 4 else 8
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
ours_br = [i for i,(a,t) in enumerate(body) if BR.match(t)]
# oracle
p = g['_find_oracle_path'](fn)
o_idx, labels, o_body = 0, {}, []
for ln in p.read_text().splitlines():
    s = re.sub(r'/\*.*?\*/','',ln).strip()
    if s.startswith('endlabel'): break
    if s.endswith(':') and s.startswith('.L'):
        labels.setdefault(s[:-1], o_idx); o_body.append((o_idx, s, True)); continue
    if s.startswith('.word'):
        o_body.append((o_idx, s, False)); o_idx += 1; continue
    if not s or s.startswith(('.','glabel','nonmatching','dlabel','jlabel','alabel')) or s.endswith(':'):
        continue
    o_body.append((o_idx, s, False)); o_idx += 1
o_br = [i for i, x in enumerate(o_body) if (not x[2]) and BR.match(x[1])]
def show(title, items, center, lo, hi):
    print('---- %s ----' % title)
    for it in items:
        if lo <= it[0] <= hi:
            print(it)
if idx is None:
    print('ours branches:', [(k, body[i][0], body[i][1]) for k,i in enumerate(ours_br)])
else:
    i = ours_br[idx]
    print('=== OURS (insn index %d) ===' % i)
    for k in range(max(0,i-win), min(len(body), i+win+1)):
        print('%4d %08x %s' % (k, body[k][0], body[k][1]))
    j = o_br[idx]
    oi = o_body[j][0]
    print('=== ORACLE (insn index %d) ===' % oi)
    for (a, s, isl) in o_body:
        if oi-win <= a <= oi+win+1:
            print('%4d %s %s' % (a, 'L' if isl else ' ', s))

#!/usr/bin/env python3
"""tgt.py CPP FN IDX [WIN] -- for branch #IDX of FN, print the BRANCH site and both
TARGET sites (ours + oracle) so the +-1 shift's mechanism is readable at a glance."""
import re, subprocess, sys
from pathlib import Path
ROOT = Path(r'C:\Temp\nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
BR = re.compile(r'^\s*(b\w*|j)\b')
src = (ROOT / 'tools' / 'verify_asm.py').read_text()
head = src.split('allpass=True')[0]
g = {'__name__': '__vsrc__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}
cpp, fn = sys.argv[1], sys.argv[2]
idx = int(sys.argv[3])
win = int(sys.argv[4]) if len(sys.argv) > 4 else 3
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
    if m: body.append((int(m.group(1), 16), m.group(2).split(';')[0].strip()))
    elif ln.strip() == '': on = False
ours_br = [i for i, (a, t) in enumerate(body) if BR.match(t)]
p = g['_find_oracle_path'](fn)
o_idx, o_body = 0, []
for ln in p.read_text().splitlines():
    s = re.sub(r'/\*.*?\*/', '', ln).strip()
    if s.startswith('endlabel'): break
    if s.endswith(':') and s.startswith('.L'):
        o_body.append((o_idx, s, True)); continue
    if s.startswith('.word'):
        o_body.append((o_idx, s, False)); o_idx += 1; continue
    if not s or s.startswith(('.', 'glabel', 'nonmatching', 'dlabel', 'jlabel', 'alabel')) or s.endswith(':'):
        continue
    o_body.append((o_idx, s, False)); o_idx += 1
o_br = [i for i, x in enumerate(o_body) if (not x[2]) and BR.match(x[1])]
bi = ours_br[idx]
ta = body[bi][0]
m = re.search(r'\b([0-9a-f]+)\b\s*<', body[bi][1]) or re.search(r',([0-9a-f]+)$', body[bi][1])
otgt = bi + (int(m.group(1), 16) - ta) // 4
oj = o_br[idx]
om = re.search(r'(\.L\w+)\s*$', o_body[oj][1])
olab = om.group(1)
otgt_o = next(a for (a, s, isl) in o_body if isl and s[:-1] == olab)
def show_o(lo, hi):
    for (a, s, isl) in o_body:
        if lo <= a <= hi: print('%4d %s %s' % (a, 'L' if isl else ' ', s))
def show_u(lo, hi):
    for k in range(max(0, lo), min(len(body), hi + 1)):
        print('%4d %08x %s' % (k, body[k][0], body[k][1]))
print('### BRANCH #%d  ours idx %d -> %d   oracle idx %d -> %d (%s)' %
      (idx, bi, otgt, o_body[oj][0], otgt_o, olab))
print('--- ours branch site'); show_u(bi - win, bi + win)
print('--- oracle branch site'); show_o(o_body[oj][0] - win, o_body[oj][0] + win)
print('--- ours target'); show_u(otgt - win, otgt + win)
print('--- oracle target'); show_o(otgt_o - win, otgt_o + win)

#!/usr/bin/env python3
"""Print the gcc-2.8 allocno table (-dg/-dl) for ONE function of a C++ TU.
Run tools/rtl_dump.py first (produces <tu>.i.greg/.lreg), then:
    python tools/prio.py <greg-file> <lreg-file> "void Hud_BuildNumbers(int)"
Shows per-pseudo: allocation order, disposition (hard reg), refs, live length,
and the allocno_compare priority floor_log2(refs)*refs/live  (w41-a1)."""
import math
import re
import sys

NAME = {16:'s0',17:'s1',18:'s2',19:'s3',20:'s4',21:'s5',22:'s6',23:'s7',30:'fp',
        2:'v0',3:'v1',4:'a0',5:'a1',6:'a2',7:'a3',8:'t0',9:'t1',10:'t2',11:'t3',
        12:'t4',13:'t5',14:'t6',15:'t7',24:'t8',25:'t9',29:'sp',31:'ra'}

greg, lreg, fn = sys.argv[1], sys.argv[2], sys.argv[3]
g = open(greg, errors='replace').read()
l = open(lreg, errors='replace').read()
sec = lambda t: next((s.split('(note', 1)[0]
                      for s in re.split(r'\n;; Function ', t)
                      if s.startswith(fn)), '')
gh, lh = sec(g), sec(l)
order = re.search(r'regs to allocate: ([\d ]+)', gh).group(1).split()
disp = {m.group(1): int(m.group(2)) for m in
        re.finditer(r'(\d+) in (\d+)', gh[gh.find('Register dispositions'):])}
for i, r in enumerate(order):
    m = re.search(r'Register %s used (\d+) times across (\d+) insns' % r, lh)
    refs, ll = (int(m.group(1)), int(m.group(2))) if m else (0, 1)
    pri = (int(math.log(refs, 2)) if refs else 0) * refs / ll
    hard = disp.get(r)
    print(f'{i:2d}: p{r:>4} -> {NAME.get(hard, hard)!s:>4} '
          f'refs={refs:3d} live={ll:4d} pri={pri:.4f}')

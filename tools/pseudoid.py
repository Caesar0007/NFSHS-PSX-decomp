#!/usr/bin/env python3
"""pseudoid.py -- print the DEFINING RTL insn of given pseudos, so an allocno
number from a -dg/-dl table can be tied back to a source variable.
Usage: python tools/pseudoid.py <tu.lreg> "<fn sig>" [p1 p2 ...]   (no list = all)
"""
import re
import sys

sys.path.insert(0, 'tools')
import allocsim as A

lreg, fn = sys.argv[1], sys.argv[2]
want = {int(x.lstrip('pP')) for x in sys.argv[3:]}
sec = A._section(open(lreg, errors='replace').read(), fn)
body = sec[sec.find('\n(note'):] if '\n(note' in sec else sec
insns = re.split(r'\n\n(?=\((?:insn|jump_insn|call_insn|note|code_label))', body)
seen = set()
for ins in insns:
    m = re.search(r'\(set \(reg[/\w]*:\w+ (\d+)\)', ins)
    if not m:
        continue
    p = int(m.group(1))
    if p < A.FIRST_PSEUDO or (want and p not in want) or p in seen:
        continue
    seen.add(p)
    txt = ' '.join(ins.split())
    print('p%-5d  %s' % (p, txt[:230]))
missing = (want - seen)
if missing:
    print('\n(no top-level SET found for: %s -- probably set inside a PARALLEL '
          'or only via a clobber)' % ' '.join('p%d' % x for x in sorted(missing)))

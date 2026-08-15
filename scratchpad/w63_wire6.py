#!/usr/bin/env python3
"""Wire W63-A17's DrawGouraudShape row (psxfront.cpp, 14->11 probe-verified 2x)."""
import ast

src = open('tools/build.py', encoding='utf-8', newline='').read()
tm = src.find('PER_FN_TEXT_MOVES = {')
tm_end = src.find('\n}', tm)
anchor = '    # w60-a3 (orchestrator-wired, probe-verified REAL=0 in scratchpad/w60a3):'
assert src.count(anchor) == 1
rel = 'recon/frontend/psx/psxfront.cpp'
key = '"%s": {' % rel
i = src.find(key, tm, tm_end)
row = ('            {"take": r"\\tsh\\t\\$23,10\\(\\$16\\)\\n",'
       ' "after": r"\\tsh\\t\\$2,8\\(\\$16\\)\\n"},\n')
comment = ("        # w63-a17 (probe-verified 2x): DrawGouraudShape 14->11 @246/245.\n"
           "        # Retail leaves the lhu load-delay slot as a nop and emits\n"
           "        # sh s7,10(s0) after sh v0,8(s0); moving pre-maspsx lets maspsx\n"
           "        # insert the nop. The +1 = a pre-existing read-back copy the old\n"
           "        # order cancelled numerically.\n")
if i > 0:
    entry_end = src.find('\n    },', i)
    assert '"DrawGouraudShape' not in src[i:entry_end]
    j = src.find('\n', i) + 1
    block = (comment +
             '        "DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii": [\n' +
             row + '        ],\n')
    src = src[:j] + block + src[j:]
else:
    block = ('    "%s": {\n' % rel + comment +
             '        "DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii": [\n' +
             row + '        ],\n    },\n')
    src = src.replace(anchor, block + anchor)
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired + parses (entry existed: %s)' % (i > 0))

#!/usr/bin/env python3
"""Wire W63-A3's FntPrint row into the EXISTING FONT.c TEXT_MOVES entry."""
import ast

src = open('tools/build.py', encoding='utf-8', newline='').read()
tm = src.find('PER_FN_TEXT_MOVES = {')
tm_end = src.find('\n}', tm)
key = '"recon/syslib/psx/libgpu/FONT.c": {'
i = src.find(key, tm, tm_end)
assert i > 0, 'FONT.c entry not found in PER_FN_TEXT_MOVES span'
entry_end = src.find('\n    },', i)
assert '"FntPrint"' not in src[i:entry_end], 'row already present'
j = src.find('\n', i) + 1
block = (
    "        # w63-a3 (probe-verified 2x): FntPrint 3 -> PASS 240/240. cse\n"
    "        # constant-sharing breaker: the fresh li lands at the DEF position\n"
    "        # (one-line relocation); anchors region-unique, label-agnostic.\n"
    '        "FntPrint": [\n'
    '            {"take": r"\\tli\\t\\$6,-1[^\\n]*\\n", "after": r"\\tbeq\\t\\$5,\\$2,\\$L\\d+\\n"},\n'
    "        ],\n"
)
src = src[:j] + block + src[j:]
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired + parses')

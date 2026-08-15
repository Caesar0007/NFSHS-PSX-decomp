#!/usr/bin/env python3
"""Append W64-A7's label-move row to the EXISTING MCXMAIN _padIntRecvHdr list
(AFTER the w62 copy+slot row -- anchors match the post-row region)."""
import ast
import json

s = json.load(open('scratchpad/w64a7/SPEC_text_moves_padIntRecvHdr_label.json'))
row = s['row']


def lit(x):
    return '"' + x.encode('unicode_escape').decode().replace('"', '\\"') + '"'


src = open('tools/build.py', encoding='utf-8', newline='').read()
tm = src.find('PER_FN_TEXT_MOVES = {')
i = src.find('"recon/syslib/psx/libpad/MCXMAIN.c"', tm)
assert i > 0
j = src.find('"_padIntRecvHdr"', i)
assert 0 < j < src.find('\n    },', i)
lst_open = src.find('[', j)
depth = 0
k = lst_open
while True:
    c = src[k]
    if c == '[':
        depth += 1
    elif c == ']':
        depth -= 1
        if depth == 0:
            break
    k += 1
ins = src.rfind('\n', 0, k) + 1
parts = ', '.join('"%s": %s' % (kk, lit(v)) for kk, v in row.items())
block = ('            # w64-a7 (probed 2x + brdist proof): LABEL MOVE past the\n'
         '            # merge copy -- fixes 2 wrong branch WORDS behind a green\n'
         '            # gate (04Q pure form); brdist 2 -> 0, TU 5/5.\n'
         '            {%s},\n' % parts)
src = src[:ins] + block + src[ins:]
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('appended + parses')

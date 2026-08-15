#!/usr/bin/env python3
"""Wire W63-A4's MemCardExist_cb 2-site spec (scratchpad/w63a4/text_moves_spec.json).
Supersedes the never-fired w62a8 row (ABI-name anchors vs numeric-register .s)."""
import ast
import json


def lit(s):
    return '"' + s.encode('unicode_escape').decode().replace('"', '\\"') + '"'


spec = json.load(open('scratchpad/w63a4/text_moves_spec.json'))[0]
assert spec['fn'] == 'MemCardExist_cb' and spec['rel'].endswith('LIBMCRD.c')

src = open('tools/build.py', encoding='utf-8', newline='').read()
tm = src.find('PER_FN_TEXT_MOVES = {')
assert tm > 0
# scope the search to this table's span (14F: identical rel keys exist in MULTIPLE tables)
tm_end = src.find('\n}', tm)
key = '"recon/syslib/psx/libmcrd/LIBMCRD.c": {'
i = src.find(key, tm, tm_end)
assert i > 0, 'LIBMCRD entry not found in PER_FN_TEXT_MOVES span'
entry_end = src.find('\n    },', i)
assert '"MemCardExist_cb"' not in src[i:entry_end], 'row already present'
j = src.find('\n', i) + 1
rows = ''
for mv in spec['move']:
    rows += ('            {"take": ' + lit(mv['take']) +
             ', "after": ' + lit(mv['after']) + '},\n')
block = (
    "        # w63-a4 (probe-verified 2x, PASS 117/117; whole-TU 23/26, 0\n"
    "        # PASS->FAIL): Exist_cb sched2 emission order, two li-$2,1 sites\n"
    "        # each one line earlier in retail. Supersedes the w62a8 row whose\n"
    "        # ABI-name anchors could never match cc1's numeric registers.\n"
    '        "MemCardExist_cb": [\n' + rows + '        ],\n'
)
src = src[:j] + block + src[j:]
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired + parses')

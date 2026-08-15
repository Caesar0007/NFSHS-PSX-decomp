#!/usr/bin/env python3
"""Append W64-A6's CdRead slot row to the EXISTING cdread.c/CdRead list
(probed 2x with the FINAL list incl the live w62 row; objdump-proven:
store executes in the slot, one real word diff left = the known 11B zero)."""
import ast
import json

spec = json.load(open('scratchpad/w64a6/tm_cdread.json'))
rows = spec['recon/syslib/psx/libcd/cdread.c']['CdRead']
new = rows[-1]
assert new.get('slot') is True and '\\$20,0\\(\\$16\\)' in new['take']


def lit(s):
    return '"' + s.encode('unicode_escape').decode().replace('"', '\\"') + '"'


src = open('tools/build.py', encoding='utf-8', newline='').read()
tm = src.find('PER_FN_TEXT_MOVES = {')
key = '"recon/syslib/psx/libcd/cdread.c"'
i = src.find(key, tm)
assert i > 0
j = src.find('"CdRead"', i)
assert 0 < j < src.find('\n    },', i)
lst_open = src.find('[', j)
# find the matching close bracket of this list
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
parts = ', '.join('"%s": %s' % (kk, lit(v)) if isinstance(v, str)
                  else '"%s": %s' % (kk, v) for kk, v in new.items())
block = ('            # w64-a6 (probed 2x FINAL-LIST, objdump-proven: slot word\n'
         '            # 0xAE140000 @insn 67 both streams; after-pin load-bearing\n'
         '            # vs the watchdog-arm jal): w00 store into the sync slot,\n'
         '            # CdRead 5 -> 2 COUNT-EXACT 103/103.\n'
         '            {%s},\n' % parts)
src = src[:ins] + block + src[ins:]
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('appended + parses')

#!/usr/bin/env python3
"""Wire W63-A7's _dirCheck row (new PADSEQD.c key; proven 2x, objdump-verified
retail 11 words; the take/after/drop_after trio undoes make_return_insns)."""
import ast
import json


def lit(s):
    return '"' + s.encode('unicode_escape').decode().replace('"', '\\"') + '"'


spec = json.load(open('scratchpad/w63a7/SPEC_text_moves_dirCheck.json'))
rows = spec['PER_FN_TEXT_MOVES']['recon/syslib/psx/libpad/PADSEQD.c']['_dirCheck']

src = open('tools/build.py', encoding='utf-8', newline='').read()
NL = '\r\n' if '\r\n' in src[:2000] else '\n'
tm = src.find('PER_FN_TEXT_MOVES = {')
tm_end = src.find(NL + '}', tm)
assert src.find('"recon/syslib/psx/libpad/PADSEQD.c"', tm, tm_end) < 0
anchor = '    # w60-a3 (orchestrator-wired, probe-verified REAL=0 in scratchpad/w60a3):'
assert src.count(anchor) == 1
block = ('    # w63-a7 (proven 2x; spliced object OBJDUMP-VERIFIED = retail 11 words,' + NL +
         '    # both branch targets exact): _dirCheck 1 -> PASS 11/11. Undoes' + NL +
         '    # make_return_insns (reorg.c:4289) duplicating the return; li rejoins' + NL +
         '    # the fall-through block. NOTE: the analogous _padInitDirSeq splice is' + NL +
         '    # a GATE-BLIND DEAD-CODE BUG (store past the return) -- never wire it.' + NL +
         '    "recon/syslib/psx/libpad/PADSEQD.c": {' + NL +
         '        "_dirCheck": [' + NL)
for mv in rows:
    parts = ', '.join('"%s": %s' % (k, lit(v)) for k, v in mv.items())
    block += '            {%s},' % parts + NL
block += '        ],' + NL + '    },' + NL
src = src.replace(anchor, block + anchor)
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired + parses')

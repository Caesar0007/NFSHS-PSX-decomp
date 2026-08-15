#!/usr/bin/env python3
"""Wire W66-A2's nop_before_label per-TU maspsx flag (spec's 3 edits)."""
import ast

src = open('tools/build.py', encoding='utf-8', newline='').read()

a = '#   "jtbl_at_fusion"     -> pass --jtbl-at-fusion to maspsx for this TU only'
assert src.count(a) == 1
src = src.replace(a, a + (
    '\n#   "nop_before_label"   -> pass --nop-before-label to maspsx for this TU\n'
    '#                           only (inserted load-delay nop BEFORE a following\n'
    '#                           label = retail/aspsx placement; closes FntPrint\'s\n'
    '#                           class-d word. PER-TU ONLY: breaks fememcard/fescreen).'))

old = ('    if JTBL_AT_FUSION or tu_flags.get("jtbl_at_fusion"):\n'
       '        maspsx_cmd.append("--jtbl-at-fusion")')
n = src.count(old)
assert n == 2, n
new = old + ('\n    if tu_flags.get("nop_before_label"):\n'
             '        maspsx_cmd.append("--nop-before-label")')
src = src.replace(old, new)

a = '"recon/syslib/psx/libgpu/FONT.c":       {"jtbl_at_fusion": True,   # FntPrint'
assert src.count(a) == 1
src = src.replace(a, (
    '"recon/syslib/psx/libgpu/FONT.c":       {"jtbl_at_fusion": True,   # FntPrint\n'
    '                                             "nop_before_label": True,  # w66-a2: brdist (10,8,9)->0'))

ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired + parses')

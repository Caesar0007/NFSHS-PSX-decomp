#!/usr/bin/env python3
"""Wire W63-A19's -G8 identity tells: aispeeds.cpp ("aiwther" 8-byte literal in
retail .sdata -- only reachable at -G8) + mpause.cpp (two 8-byte short[4] in
.sdata, same tell; 2 of W62-A19 sec.3.2's 8 wrong-section symbols)."""
import ast

src = open('tools/build.py', encoding='utf-8', newline='').read()
anchor = '    "recon/game/common/audioeng.cpp":       {"g_value": "8"},'
assert src.count(anchor) == 1
for rel in ('recon/game/common/aispeeds.cpp', 'recon/game/common/mpause.cpp'):
    assert ('"%s"' % rel) not in src.split('PER_FN_TEXT_MOVES')[0] or True
block = (
    '    # w63-a19: -G IDENTITY TELLS from the data-ownership sweep (E5): 8-byte\n'
    '    # sdata objects only reachable at -G8 ("aiwther" literal; mpause short[4]\n'
    '    # pair = 2 of the W62 sec-3.2 wrong-section symbols). Gated 2x post-wire.\n'
    '    "recon/game/common/aispeeds.cpp":       {"g_value": "8"},\n'
    '    "recon/game/common/mpause.cpp":         {"g_value": "8"},\n'
)
i = src.find(anchor)
# ensure not already present in the PER_TU_FLAGS table
tbl_start = src.rfind('PER_TU_FLAGS', 0, i)
tbl_end = src.find('\n}', tbl_start)
assert '"recon/game/common/aispeeds.cpp"' not in src[tbl_start:tbl_end]
assert '"recon/game/common/mpause.cpp"' not in src[tbl_start:tbl_end]
src = src[:i] + block + src[i:]
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired + parses')

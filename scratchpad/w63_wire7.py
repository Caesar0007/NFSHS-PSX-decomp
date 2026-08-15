#!/usr/bin/env python3
"""W63-A14 spec: drop the mis-attributed jtbl_at_fusion from r3dcar.cpp
(keep g_value 8). Same class as w38-a5's sfx.cpp: neither InsertCarFacet nor
InsertCarFacetMenu has an $at jtbl macro in its oracle. Coupled with A14's
source landing => InsertCarFacet PASS 1144/1144, REAL=0 already = dual-lane.
build.py is CRLF on disk -- use \\r\\n in literals."""
import ast

src = open('tools/build.py', encoding='utf-8', newline='').read()
NL = '\r\n' if '\r\n' in src[:2000] else '\n'
old = ('    "recon/game/common/r3dcar.cpp":         {"jtbl_at_fusion": True,   # R3DCar_InsertCarFacet' + NL +
       '                                             "g_value": "8"},          # 2026-08-04G -G8 queue')
assert src.count(old) == 1
new = ('    # w63-a14: jtbl_at_fusion DROPPED (w38-a5 sfx.cpp mis-attribution class --' + NL +
       '    # neither InsertCarFacet nor InsertCarFacetMenu has an $at jtbl macro in' + NL +
       '    # its oracle); with the A14 source landing => InsertCarFacet PASS 1144/1144.' + NL +
       '    "recon/game/common/r3dcar.cpp":         {"g_value": "8"},          # 2026-08-04G -G8 queue')
src = src.replace(old, new)
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired + parses')

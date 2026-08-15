#!/usr/bin/env python3
"""Wire W63-A8's _padSetActAlign_rcv into PADCMD.c's EXISTING
PER_FN_CC1_VER_SPLICE_272 2.7.2 set (merge, never a second dict entry)."""
import ast

src = open('tools/build.py', encoding='utf-8', newline='').read()
old = '"recon/syslib/psx/libpad/PADCMD.c": {"2.7.2": {"_padLoadActInfo"}},'
new = ('"recon/syslib/psx/libpad/PADCMD.c": {"2.7.2": {"_padLoadActInfo",\n'
       '        # w63-a8: 27->2 count-exact via source landing @2a3a0587, then\n'
       '        # PASS 50/50 on 2.7.2 (cse no-copy-prop identity is a version\n'
       '        # property; 970404 control = 2). Whole-TU 18/19, 0 regressions.\n'
       '        "_padSetActAlign_rcv"}},')
assert src.count(old) == 1
src = src.replace(old, new)
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired + parses')

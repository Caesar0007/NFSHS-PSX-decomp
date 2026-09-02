#!/usr/bin/env python
"""W85-M2 diagnostic gate: verbatim tools/verify_asm.py, but with the per-fn
`-fno-delayed-branch` splice for recon/syslib/psx/libmcrd/LIBMCRD.c REMOVED
from the in-memory build tables (dbr-ON lane).  Nothing under tools/ is
modified; the change lives only in this process.

Usage: python scratchpad/w85/M2_verify_dbron.py <cfile> <fn[,fn...]>
"""
import sys, pathlib, runpy

ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))

import build as bld

KEY = 'recon/syslib/psx/libmcrd/LIBMCRD.c'
for name in ('PER_FN_FLAG_SPLICE_272', 'PER_FN_NO_DELAYED_BRANCH'):
    tbl = getattr(bld, name, None)
    if isinstance(tbl, dict) and KEY in tbl:
        tbl.pop(KEY)
        print('[dbr-on gate] dropped %s[%s]' % (name, KEY))

sys.argv = ['verify_asm.py'] + sys.argv[1:]
runpy.run_path(str(ROOT / 'tools' / 'verify_asm.py'), run_name='__main__')

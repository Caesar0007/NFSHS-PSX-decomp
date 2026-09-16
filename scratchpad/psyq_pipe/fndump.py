#!/usr/bin/env python3
"""fndump.py CPP FN OUTSTEM -- write verify_asm's normalized oracle/ours listings to OUTSTEM.oracle/.ours (numbered)."""
import sys, importlib.util
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]; sys.path.insert(0, str(ROOT/'tools'))
cpp, fn, out = sys.argv[1], sys.argv[2], sys.argv[3]
sys.argv = [sys.argv[0], cpp, '__none__']
sp = importlib.util.spec_from_file_location('va', ROOT/'tools'/'verify_asm.py'); V = importlib.util.module_from_spec(sp)
try: sp.loader.exec_module(V)
except SystemExit: pass
for tag, L in (('oracle', V.oracle(fn)), ('ours', V.ours(fn))):
    Path(out + '.' + tag).write_text('\n'.join(f'{i:4d} {l}' for i, l in enumerate(L)) + '\n')
    print(tag, len(L))

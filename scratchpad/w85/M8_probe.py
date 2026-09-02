#!/usr/bin/env python3
"""M8 probe: apply variant patch file(s) to the baseline candidate, gate it.

Usage: python scratchpad/w85/M8_probe.py <variant.py> [<variant2.py> ...]
Each variant file defines PAIRS = [(old, new), ...]; every `old` must occur
exactly once in the (progressively patched) text.
Env: KEEP=1 leaves M8_try.cpp; OUT=<path> writes elsewhere.
"""
import os, runpy, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = ROOT / 'scratchpad' / 'w85'
BASE = HERE / 'M8_base_cand.cpp'
sys.path.insert(0, str(HERE / 'variants'))
FN   = 'CarIO_ReadInCarTextureData__FPcP8Car_tObjii'
LANE = 'recon/game/psx/cario.cpp'

def apply(txt, pairs, tag):
    for old, new in pairs:
        n = txt.count(old)
        if n != 1:
            sys.exit('[%s] anchor count %d (need 1) for:\n%s' % (tag, n, old[:300]))
        txt = txt.replace(old, new, 1)
    return txt

def gate(path):
    r = subprocess.run([sys.executable, 'regiondiff/tools/verify_region.py', 'JPN',
                        str(Path(path).relative_to(ROOT).as_posix()), FN,
                        '--lane-as=' + LANE], capture_output=True, text=True, cwd=str(ROOT))
    out = (r.stdout + r.stderr).strip()
    return out.splitlines()[0].strip() if out else 'NO OUTPUT'

if __name__ == '__main__':
    names = sys.argv[1:]
    txt = BASE.read_text()
    for n in names:
        p = HERE / 'variants' / n if not os.path.sep in n else Path(n)
        if not p.suffix:
            p = p.with_suffix('.py')
        mod = runpy.run_path(str(p))
        txt = apply(txt, mod['PAIRS'], p.stem)
    out = Path(os.environ.get('OUT') or (HERE / 'M8_try.cpp'))
    out.write_text(txt)
    print('%-46s %s' % ('+'.join(x.replace('.py','') for x in names) or 'base', gate(out)))

#!/usr/bin/env python3
"""w64a21_gate.py SRC [SRC...] -- whole-TU gate census, JSON lines to stdout.

Anti-drift (catalog 12H): drives tools/verify_asm.py's OWN module (same compile,
same normalizers, same dead-%hi collapse as tugate) -- only the reporting differs.
One line per TU:  {"src":..., "ok":true, "fns":{name:[ndiff, nours, noracle]}}
"""
import difflib
import importlib.util
import json
import re
import sys
import time
from pathlib import Path

ROOT = Path(r'C:\Temp\nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))   # build.py does a bare `import fix_symsizes`


def gate_tu(src):
    argv = sys.argv
    sys.argv = ['verify_asm.py', src, '__none__']
    spec = importlib.util.spec_from_file_location('va_' + str(time.time()),
                                                  ROOT / 'tools' / 'verify_asm.py')
    V = importlib.util.module_from_spec(spec)
    try:
        spec.loader.exec_module(V)
    except SystemExit as e:
        if not hasattr(V, '_name2addr'):
            sys.argv = argv
            return {'src': src, 'ok': False,
                    'err': f'verify_asm aborted (exit {e.code}) -- compile failure',
                    'fns': {}}
    finally:
        sys.argv = argv

    fns = {}
    for n in sorted({n for n in V._name2addr if n and not n.startswith('.')}):
        try:
            b = V.oracle(n)
            if not b:
                continue
            a = V.ours(n)
            if not a:
                continue
        except Exception:
            continue
        if len(a) == len(b):
            for i in range(len(a)):
                mo = re.match(r'lui (\w+),0$', a[i])
                me = re.match(r'lui (\w+),\d+$', b[i])
                if mo and me and mo.group(1) == me.group(1):
                    b[i] = a[i]
        d = [l for l in difflib.unified_diff(a, b, lineterm='')
             if l[0] in '+-' and not l.startswith(('+++', '---'))]
        fns[n] = [len(d), len(a), len(b)]
    return {'src': src, 'ok': True, 'fns': fns}


if __name__ == '__main__':
    for s in sys.argv[1:]:
        t0 = time.time()
        r = gate_tu(s)
        r['secs'] = round(time.time() - t0, 1)
        print(json.dumps(r), flush=True)

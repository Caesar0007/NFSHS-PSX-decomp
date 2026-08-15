#!/usr/bin/env python3
"""w64a7: probe an EXTRA PER_FN_TEXT_MOVES row without editing tools/build.py.

Loads build.py, appends rows from a JSON spec into its in-memory
PER_FN_TEXT_MOVES table, then runs verify_asm.py's OWN source (12H anti-drift).

usage: W64A7_TM='<json>' python scratchpad/w64a7/tmprobe.py <rel> <Fn>
  json = {"<rel>": {"<Fn>": [ {take:..., after:..., slot:true, copy:true}, ... ]}}
  rows are APPENDED after any already-wired rows for that fn.
"""
import importlib.util, json, os, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bld)

extra = json.loads(os.environ.get('W64A7_TM', '{}'))
for rel, fns in extra.items():
    tab = bld.PER_FN_TEXT_MOVES.setdefault(rel, {})
    for fn, rows in fns.items():
        tab.setdefault(fn, [])
        tab[fn] = list(tab[fn]) + list(rows)

sys.modules['bld'] = bld
va_src = (ROOT / 'tools' / 'verify_asm.py').read_text()
va_src = va_src.replace(
    "spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')\n"
    "bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)",
    "import sys as _s; bld = _s.modules['bld']")
assert 'bld = _s.modules' in va_src, 'verify_asm build.py loader shape changed'
sys.argv = ['verify_asm.py'] + sys.argv[1:]
exec(compile(va_src, str(ROOT / 'tools' / 'verify_asm.py'), 'exec'),
     {'__name__': '__main__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')})

import importlib.util, json, os, sys, subprocess, re
from pathlib import Path
ROOT = Path(r'C:\Temp\nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
extra = json.loads(os.environ.get('W64A7_TM', '{}'))
for rel, fns in extra.items():
    tab = bld.PER_FN_TEXT_MOVES.setdefault(rel, {})
    for fn, rows in fns.items():
        tab[fn] = list(tab.get(fn, [])) + list(rows)
sys.modules['bld'] = bld
src = (ROOT / 'tools' / 'brdist.py').read_text()
src = src.replace("sys.path.insert(0, str(ROOT / 'tools'))",
                  "sys.path.insert(0, str(ROOT / 'tools'))\nimport sys as _s; _s.modules['bld']=_s.modules['bld']")
va = (ROOT / 'tools' / 'verify_asm.py').read_text()
va = va.replace("spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')\nbld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)",
                "import sys as _s; bld = _s.modules['bld']")
(ROOT/'scratchpad'/'w64a7'/'_va_patched.py').write_text(va)
src = src.replace("src = (ROOT / 'tools' / 'verify_asm.py').read_text()",
                  "src = (ROOT / 'scratchpad' / 'w64a7' / '_va_patched.py').read_text()")
src = src.replace("g = {'__name__': '__vsrc__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}",
                  "g = {'__name__': '__vsrc__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}")
sys.argv = ['brdist.py'] + sys.argv[1:]
exec(compile(src, 'brdist_patched', 'exec'), {'__name__': '__main__'})

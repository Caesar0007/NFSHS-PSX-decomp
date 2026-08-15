#!/usr/bin/env python3
"""br.py MODE ARGS...  -- run the repo's own gate/tugate/brdist against a
build.py that carries the w66-a1 PER_FN_BRANCH_RETARGET mechanism, patched
IN MEMORY.  tools/build.py is never written.

MODE = gate <TU> <Fn[,Fn...]>   (tools/verify_asm.py)
     | tu   <TU>                (tools/tugate.py)
     | brd  <TU>                (tools/brdist.py)
     | dump <TU> <Fn>           (print the post-mechanism .s region)

Spec comes from $W66_SPEC (a JSON file path or inline JSON):
  {"branch_retarget": {"<rel>": {"<Fn>": [{"branch":..., "after":...}, ...]}},
   "text_moves":         {"<rel>": {"<Fn>": [ ...rows... ]}},   # APPENDED
   "text_moves_replace": {"<rel>": {"<Fn>": [ ...rows... ]}}}   # FINAL list
The FINAL-list form is the one to use when a fn already carries wired rows
(w65 brief: probe files carry the FINAL list, not the delta).
"""
import importlib.util, json, os, sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
sys.path.insert(0, str(HERE))
from mech import patched_source

spec_mod = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec_mod)
code = compile(patched_source(), str(ROOT / 'tools' / 'build.py'), 'exec')
exec(code, bld.__dict__)
assert hasattr(bld, '_apply_branch_retarget'), 'mechanism not installed'

raw = os.environ.get('W66_SPEC', '{}')
if raw and not raw.lstrip().startswith('{'):
    raw = Path(raw).read_text()
spec = json.loads(raw or '{}')

for rel, fns in spec.get('branch_retarget', {}).items():
    tab = bld.PER_FN_BRANCH_RETARGET.setdefault(rel, {})
    for fn, rows in fns.items():
        tab[fn] = list(rows)
for rel, fns in spec.get('text_moves', {}).items():
    tab = bld.PER_FN_TEXT_MOVES.setdefault(rel, {})
    for fn, rows in fns.items():
        tab[fn] = list(tab.get(fn, [])) + list(rows)
for rel, fns in spec.get('text_moves_replace', {}).items():
    tab = bld.PER_FN_TEXT_MOVES.setdefault(rel, {})
    for fn, rows in fns.items():
        tab[fn] = list(rows)
sys.modules['bld'] = bld

va = (ROOT / 'tools' / 'verify_asm.py').read_text()
va = va.replace(
    "spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')\n"
    "bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)",
    "import sys as _s; bld = _s.modules['bld']")
assert 'bld = _s.modules' in va, 'verify_asm build.py loader shape changed'
va = va.replace("ROOT = Path(__file__).resolve().parent.parent", "ROOT = Path(r'%s')" % ROOT)
assert "ROOT = Path(r'" in va, 'verify_asm ROOT line shape changed'
PVA = HERE / '_va_patched.py'
PVA.write_text(va)

mode, rest = sys.argv[1], sys.argv[2:]
if mode == 'gate':
    sys.argv = ['verify_asm.py'] + rest
    exec(compile(va, str(ROOT / 'tools' / 'verify_asm.py'), 'exec'),
         {'__name__': '__main__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')})
elif mode == 'tu':
    tg = (ROOT / 'tools' / 'tugate.py').read_text()
    tg = tg.replace("ROOT/'tools'/'verify_asm.py'", "ROOT/'scratchpad'/'w66a1'/'_va_patched.py'")
    assert '_va_patched' in tg, 'tugate verify_asm path shape changed'
    sys.argv = ['tugate.py'] + rest
    exec(compile(tg, str(ROOT / 'tools' / 'tugate.py'), 'exec'),
         {'__name__': '__main__', '__file__': str(ROOT / 'tools' / 'tugate.py')})
elif mode == 'brd':
    bd = (ROOT / 'tools' / 'brdist.py').read_text()
    bd = bd.replace("src = (ROOT / 'tools' / 'verify_asm.py').read_text()",
                    "src = (ROOT / 'scratchpad' / 'w66a1' / '_va_patched.py').read_text()")
    assert '_va_patched' in bd, 'brdist verify_asm path shape changed'
    sys.argv = ['brdist.py'] + rest
    exec(compile(bd, str(ROOT / 'tools' / 'brdist.py'), 'exec'), {'__name__': '__main__'})
elif mode == 'dump':
    import re
    tu, fn = rest[0], rest[1]
    src = ROOT / tu
    obj = bld.compile_c(src, skip_asm=False) if src.suffix == '.c' else bld.compile_cpp(src)
    s = Path(str(obj).replace('.o', '.s')).read_text(errors='replace')
    m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(fn), s, re.M)
    m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(fn), s[m.end():], re.M)
    for i, ln in enumerate(s[m.start():m.end() + m2.start()].split('\n')):
        print(i, repr(ln))
else:
    sys.exit('mode must be gate|tu|brd|dump')

#!/usr/bin/env python3
"""pr.py MODE ARGS...  -- run the repo's own gate/tugate/brdist with EXTRA per-fn
build.py table rows injected IN MEMORY (tools/build.py is never edited).

MODE = gate <TU> <Fn[,Fn...]>   (tools/verify_asm.py)
     | tu   <TU>                (tools/tugate.py)
     | brd  <TU>                (tools/brdist.py)

Spec comes from $W65_SPEC (a JSON file path or inline JSON):
  {"text_moves":   {"<rel>": {"<Fn>": [ {take,after,slot,copy,drop_after,drop_nop}, ...]}},
   "no_thread_jumps": {"<rel>": ["<Fn>", ...]},
   "force_addr":      {"<rel>": ["<Fn>", ...]},
   "no_delayed_branch": {"<rel>": ["<Fn>", ...]},
   "epilogue_unfill":   {"<rel>": ["<Fn>", ...]}}
text_moves rows are APPENDED after any already-wired rows for that fn.
"""
import importlib.util, json, os, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
spec_mod = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec_mod)
spec_mod.loader.exec_module(bld)

raw = os.environ.get('W65_SPEC', '{}')
if raw and not raw.lstrip().startswith('{'):
    raw = Path(raw).read_text()
spec = json.loads(raw or '{}')

for rel, fns in spec.get('text_moves', {}).items():
    tab = bld.PER_FN_TEXT_MOVES.setdefault(rel, {})
    for fn, rows in fns.items():
        tab[fn] = list(tab.get(fn, [])) + list(rows)
for rel, fns in spec.get('text_moves_replace', {}).items():
    tab = bld.PER_FN_TEXT_MOVES.setdefault(rel, {})
    for fn, rows in fns.items():
        tab[fn] = list(rows)          # FINAL list, not a delta
for key, table in (('no_thread_jumps', 'PER_FN_NO_THREAD_JUMPS'),
                   ('force_addr', 'PER_FN_FORCE_ADDR'),
                   ('no_delayed_branch', 'PER_FN_NO_DELAYED_BRANCH'),
                   ('epilogue_unfill', 'PER_FN_EPILOGUE_UNFILL'),
                   ('g8', 'PER_FN_G8'),
                   ('no_split_addresses', 'PER_FN_NO_SPLIT_ADDRESSES')):
    t = getattr(bld, table, None)
    if t is None:
        continue
    for rel, fns in spec.get(key, {}).items():
        cur = t.get(rel)
        if isinstance(cur, set) or cur is None:
            t[rel] = set(cur or ()) | set(fns)
        else:
            t[rel] = list(cur) + list(fns)
for rel, flags in spec.get('flag_splice_272', {}).items():
    tab = bld.PER_FN_FLAG_SPLICE_272.setdefault(rel, {})
    for flag, fns in flags.items():
        tab[flag] = set(tab.get(flag, set())) | set(fns)
for rel, vers in spec.get('cc1_ver_splice_272', {}).items():
    tab = bld.PER_FN_CC1_VER_SPLICE_272.setdefault(rel, {})
    for ver, fns in vers.items():
        tab[ver] = set(tab.get(ver, set())) | set(fns)
sys.modules['bld'] = bld

va = (ROOT / 'tools' / 'verify_asm.py').read_text()
va = va.replace(
    "spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')\n"
    "bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)",
    "import sys as _s; bld = _s.modules['bld']")
assert 'bld = _s.modules' in va, 'verify_asm build.py loader shape changed'
va = va.replace("ROOT = Path(__file__).resolve().parent.parent", "ROOT = Path(r'%s')" % ROOT)
assert "ROOT = Path(r'" in va, 'verify_asm ROOT line shape changed'
PVA = ROOT / 'scratchpad' / 'w65a2' / '_va_patched.py'
PVA.write_text(va)

mode, rest = sys.argv[1], sys.argv[2:]
if mode == 'gate':
    sys.argv = ['verify_asm.py'] + rest
    exec(compile(va, str(ROOT / 'tools' / 'verify_asm.py'), 'exec'),
         {'__name__': '__main__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')})
elif mode == 'tu':
    tg = (ROOT / 'tools' / 'tugate.py').read_text()
    tg = tg.replace("ROOT/'tools'/'verify_asm.py'", "ROOT/'scratchpad'/'w65a2'/'_va_patched.py'")
    assert '_va_patched' in tg, 'tugate verify_asm path shape changed'
    sys.argv = ['tugate.py'] + rest
    exec(compile(tg, str(ROOT / 'tools' / 'tugate.py'), 'exec'),
         {'__name__': '__main__', '__file__': str(ROOT / 'tools' / 'tugate.py')})
elif mode == 'brd':
    bd = (ROOT / 'tools' / 'brdist.py').read_text()
    bd = bd.replace("src = (ROOT / 'tools' / 'verify_asm.py').read_text()",
                    "src = (ROOT / 'scratchpad' / 'w65a2' / '_va_patched.py').read_text()")
    assert '_va_patched' in bd, 'brdist verify_asm path shape changed'
    sys.argv = ['brdist.py'] + rest
    exec(compile(bd, str(ROOT / 'tools' / 'brdist.py'), 'exec'), {'__name__': '__main__'})
else:
    sys.exit('mode must be gate|tu|brd')

#!/usr/bin/env python3
"""pq.py TU FN -- tools/psyqproof.py run against a build.py that carries the
w66-a1 PER_FN_BRANCH_RETARGET mechanism, and with $W66_SPEC's rows applied to
the PRODUCTION lane's cc1 .s at exactly the point psyqproof already applies
PER_FN_TEXT_MOVES.

Anti-drift (12H): psyqproof.py's SOURCE is loaded and only its build.py loader
and the probe-move applier are substituted; every measurement path is the
shipped tool's.  tools/*.py is never written.

This is the harness the named psyqproof upgrade would replace: the shipped
prover has a W64_PQ_TEXT_MOVES_FILE hook but no BRANCH_RETARGET one, so the
two production REAL=1 rows this belt fixes are otherwise unprovable there.
"""
import importlib.util, json, os, sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
sys.path.insert(0, str(HERE))
from mech import patched_source

spec = importlib.util.spec_from_file_location('nfs4build', ROOT / 'tools' / 'build.py')
bp = importlib.util.module_from_spec(spec)
exec(compile(patched_source(), str(ROOT / 'tools' / 'build.py'), 'exec'), bp.__dict__)
sys.modules['nfs4build'] = bp

raw = os.environ.get('W66_SPEC', '{}')
if raw and not raw.lstrip().startswith('{'):
    raw = Path(raw).read_text()
sp = json.loads(raw or '{}')
for rel, fns in sp.get('branch_retarget', {}).items():
    bp.PER_FN_BRANCH_RETARGET.setdefault(rel, {}).update(fns)
for rel, fns in sp.get('text_moves_replace', {}).items():
    bp.PER_FN_TEXT_MOVES.setdefault(rel, {}).update(fns)
for rel, fns in sp.get('text_moves', {}).items():
    t = bp.PER_FN_TEXT_MOVES.setdefault(rel, {})
    for fn, rows in fns.items():
        t[fn] = list(t.get(fn, [])) + list(rows)

src = (ROOT / 'tools' / 'psyqproof.py').read_text()
LOAD_OLD = ('        spec = importlib.util.spec_from_file_location("nfs4build", ROOT / "tools" / "build.py")\n'
            '        bp = importlib.util.module_from_spec(spec)\n'
            '        sys.modules["nfs4build"] = bp\n'
            '        spec.loader.exec_module(bp)\n')
assert src.count(LOAD_OLD) == 1, 'psyqproof build_module shape changed'
src = src.replace(LOAD_OLD, '        bp = sys.modules["nfs4build"]\n')
OLD = ('    bp = build_module()\n'
       '    table = json.loads(Path(path).read_text()) if path else {}\n'
       '    for tu, fns in table.items():\n'
       '        bp.PER_FN_TEXT_MOVES.setdefault(tu, {}).update(fns)\n'
       '    bp._apply_text_moves(rel_posix, s_file)\n')
NEW = ('    bp = build_module()\n'
       '    table = json.loads(Path(path).read_text()) if path else {}\n'
       '    for tu, fns in table.items():\n'
       '        bp.PER_FN_TEXT_MOVES.setdefault(tu, {}).update(fns)\n'
       '    bp._apply_text_moves(rel_posix, s_file)\n'
       '    bp._apply_branch_retarget(rel_posix, s_file)\n')
assert src.count(OLD) == 1, 'psyqproof _apply_probe_moves body shape changed'
src = src.replace(OLD, NEW)
# force the hook on (it is gated on the env var / --with-text-moves)
os.environ.setdefault('W64_PQ_TEXT_MOVES_FILE', str(HERE / '_empty_moves.json'))
(HERE / '_empty_moves.json').write_text('{}')
src = src.replace('ROOT = Path(r"C:\\Temp\\nfs4-decomp")',
                  'ROOT = Path(r"%s")' % ROOT)
exec(compile(src, str(ROOT / 'tools' / 'psyqproof.py'), 'exec'),
     {'__name__': '__main__', '__file__': str(ROOT / 'tools' / 'psyqproof.py')})

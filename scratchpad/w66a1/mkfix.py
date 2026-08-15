#!/usr/bin/env python3
"""mkfix.py -- emit sim_text_moves.patch: the ONE missing wiring hunk.

The orchestrator's landing carried all 5 PER_FN_BRANCH_RETARGET rows byte-exact
but never merged the `_MERGE_INTO_PER_FN_TEXT_MOVES` block, so
PER_FN_TEXT_MOVES has no `recon/game/common/sim.cpp` key at all.  That is why
the 4 sim moves "do not fire" (they are absent) and why the sim retarget row
reports `after x0` (its anchor is written against POST-move text).

Rows are rendered FROM SPEC_w66a1_ALL.json -- no regex is ever re-typed.
tools/build.py is not written by this script; the diff is taken between two
copies in a temp tree.
"""
import ast, json, subprocess, sys, tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BUILD = ROOT / 'tools' / 'build.py'
spec = json.loads((HERE / 'SPEC_w66a1_ALL.json').read_text())
rows = spec['text_moves_replace']['recon/game/common/sim.cpp']['Sim_MainGameLoop__Fv']

HDR = '''    # w66-a1 (probe-verified 2x, objdump 15D word proof): Sim_MainGameLoop__Fv
    # FAIL 6 (ours 319 / oracle 321) -> PASS 321/321, production REAL 50 -> 0,
    # calltarget_audit 2 -> 0.  Pure BASIC-BLOCK PLACEMENT: with A = the shared
    # Sim_ProcessSimSchedules block, B = the speed==3 arm, C = the
    # InBetween/Camera_Update arm, retail lays them [B][C][A] (B pays a `j` to A)
    # and cc1 lays them [B][A][C] (B falls straight THROUGH into A, so the
    # `j`+`nop` never exists).  Six source forms falsified across W61/W62 -- every
    # goto form lets jump.c's jump-around-jump inversion fire and gcc folds B's
    # own call away; the unexplored axis was the LAYOUT pass.
    # ROW ORDER IS LOAD-BEARING (each anchor is written against the text the
    # previous row produced), and these four MUST land together with this fn's
    # PER_FN_BRANCH_RETARGET row: the moves ALONE gate PASS 321/321 while the
    # speed==3 arm calls Sim_ProcessSimSchedules ONCE instead of twice (the
    # w63-a11/w65-a2 Camera_UpdateHeliCam hazard -- verify_asm normalises branch
    # targets, so only brdist / a word proof can see it).
'''

L = [HDR + '    "recon/game/common/sim.cpp": {',
     '        "Sim_MainGameLoop__Fv": [']
for r in rows:
    parts = ['"take": %s' % json.dumps(r['take']), '"after": %s' % json.dumps(r['after'])]
    if r.get('copy'):
        parts.append('"copy": True')
    L.append('            {%s},' % ', '.join(parts))
L += ['        ],', '    },']
ENTRY = '\r\n'.join('\r\n'.join(x.split('\n')) for x in L) + '\r\n'

ANCHOR = 'PER_FN_TEXT_MOVES = {\r\n'
src = BUILD.read_text(newline='')
assert src.count(ANCHOR) == 1, 'PER_FN_TEXT_MOVES anchor count != 1'
assert '"recon/game/common/sim.cpp"' not in src.split('PER_FN_BRANCH_RETARGET')[0], \
    'sim.cpp already present in PER_FN_TEXT_MOVES -- do not double-add'
out = src.replace(ANCHOR, ANCHOR + ENTRY, 1)
ast.parse(out)

# the rendered rows must round-trip to exactly the spec's regexes
ns = {'__file__': str(BUILD), '__name__': 'simfix_probe'}
exec(compile(out, str(BUILD), 'exec'), ns)
got = ns['PER_FN_TEXT_MOVES']['recon/game/common/sim.cpp']['Sim_MainGameLoop__Fv']
for i, r in enumerate(rows):
    for k in ('take', 'after'):
        assert got[i][k] == r[k], 'row %d key %s does not round-trip' % (i, k)
    assert bool(got[i].get('copy')) == bool(r.get('copy'))
print('rendered 4 rows; round-trip == SPEC: True')

with tempfile.TemporaryDirectory() as td:
    td = Path(td)
    for side, text in (('a', src), ('b', out)):
        p = td / side / 'tools'
        p.mkdir(parents=True)
        (p / 'build.py').write_bytes(text.encode())
    r = subprocess.run(['git', '-c', 'core.autocrlf=false', 'diff', '--no-index',
                        '--no-color', '--src-prefix=a/', '--dst-prefix=b/',
                        'a/tools/build.py', 'b/tools/build.py'],
                       cwd=td, capture_output=True)
    diff = r.stdout.decode()
assert diff
diff = diff.replace('a/a/tools/build.py', 'a/tools/build.py').replace('b/b/tools/build.py', 'b/tools/build.py')
(HERE / 'sim_text_moves.patch').write_bytes(diff.encode())
print('wrote sim_text_moves.patch (%d bytes)' % len(diff))

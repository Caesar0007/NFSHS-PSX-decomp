"""symfix_order_drive.py -- apply symfix_order.py file by file under the byte gate (symloop.py).  A file whose object bytes
move is retried function by function; a function whose reorder moves the code is left alone and listed."""
import json
import re
import time
import subprocess
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
PY = sys.executable
FIX = str(ROOT / 'scratchpad/psyq_pipe' / (sys.argv[1] if len(sys.argv) > 1 else 'symfix_order.py'))   # any fixer with the same CLI / report lines
LOOP = str(ROOT / 'scratchpad/psyq_pipe/symloop.py')


def revert(rel):
    for _ in range(5):
        subprocess.run(['git', 'checkout', '--', rel], cwd=ROOT, capture_output=True)
        if subprocess.run(['git', 'diff', '--quiet', '--', rel], cwd=ROOT).returncode == 0:
            return
        time.sleep(1)
    raise SystemExit('could not revert ' + rel)


def run(*a):
    return subprocess.run([PY, *a], capture_output=True, text=True, cwd=ROOT).stdout


SKIPF = ROOT / 'scratchpad/psyq_pipe/symfix_skip.json'
skip = json.load(open(SKIPF)) if SKIPF.exists() else {}
fixname = Path(FIX).name
plan = {}
for ln in run(FIX).splitlines():
    m = re.match(r'^(\S+)\s+\[(\S+)\]\s+(.*)$', ln)
    if m:
        fns = [x.rsplit(':', 1)[0] for x in m.group(3).split() if x.rsplit(':', 1)[1] != '0']
        fns = [f for f in fns if f not in skip.get(fixname, [])]
        if fns:
            plan[m.group(2)] = fns
print('files', len(plan), 'functions', sum(len(v) for v in plan.values()), flush=True)
good_total, bad = 0, []
for rel, fns in sorted(plan.items()):
    run(FIX, '--apply', '--fn', ','.join(fns))
    out = run(LOOP, rel, '--quiet')
    if 'BYTES: UNCHANGED' in out:
        good_total += len(fns)
        print('OK    %-44s %2d fns | %s' % (rel[-44:], len(fns), out.strip().splitlines()[-1]), flush=True)
        continue
    revert(rel)
    good = []
    for fn in fns:
        run(FIX, '--apply', '--fn', ','.join(good + [fn]))
        o2 = run(LOOP, rel, '--quiet')
        if 'BYTES: UNCHANGED' in o2:
            good.append(fn)
        else:
            bad.append((rel, fn))
        revert(rel)
    if good:
        run(FIX, '--apply', '--fn', ','.join(good))
    out = run(LOOP, rel, '--quiet')
    assert 'BYTES: UNCHANGED' in out, rel
    good_total += len(good)
    print('PART  %-44s %2d of %2d fns | %s' % (rel[-44:], len(good), len(fns), out.strip().splitlines()[-1]), flush=True)
skip.setdefault(fixname, []).extend(fn for _, fn in bad)
SKIPF.write_text(json.dumps(skip, indent=1))
print('reordered under the byte gate:', good_total, '| code moved (left alone):', len(bad))
for rel, fn in bad:
    print('   MOVES', rel, fn)

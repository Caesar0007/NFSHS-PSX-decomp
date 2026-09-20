"""symfix_order_drive.py -- apply symfix_order.py file by file under the byte gate (symloop.py).  A file whose object bytes
move is retried function by function; a function whose reorder moves the code is left alone and listed."""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
PY = sys.executable
FIX = str(ROOT / 'scratchpad/psyq_pipe' / (sys.argv[1] if len(sys.argv) > 1 else 'symfix_order.py'))   # any fixer with the same CLI / report lines
LOOP = str(ROOT / 'scratchpad/psyq_pipe/symloop.py')


def run(*a):
    return subprocess.run([PY, *a], capture_output=True, text=True, cwd=ROOT).stdout


plan = {}
for ln in run(FIX).splitlines():
    m = re.match(r'^(\S+)\s+\[(\S+)\]\s+(.*)$', ln)
    if m:
        fns = [x.rsplit(':', 1)[0] for x in m.group(3).split() if x.rsplit(':', 1)[1] != '0']
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
    subprocess.run(['git', 'checkout', '--', rel], cwd=ROOT)
    good = []
    for fn in fns:
        run(FIX, '--apply', '--fn', ','.join(good + [fn]))
        o2 = run(LOOP, rel, '--quiet')
        if 'BYTES: UNCHANGED' in o2:
            good.append(fn)
        else:
            bad.append((rel, fn))
        subprocess.run(['git', 'checkout', '--', rel], cwd=ROOT)
    if good:
        run(FIX, '--apply', '--fn', ','.join(good))
    out = run(LOOP, rel, '--quiet')
    assert 'BYTES: UNCHANGED' in out, rel
    good_total += len(good)
    print('PART  %-44s %2d of %2d fns | %s' % (rel[-44:], len(good), len(fns), out.strip().splitlines()[-1]), flush=True)
print('reordered under the byte gate:', good_total, '| code moved (left alone):', len(bad))
for rel, fn in bad:
    print('   MOVES', rel, fn)

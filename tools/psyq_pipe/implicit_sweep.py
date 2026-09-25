"""implicit_sweep.py [fragment ...] -- which game/frontend translation units call functions with NO visible declaration?

CC1PLPSX 2.8.0 accepts an undeclared call (an implicit `int f(...)`), but every such call wraps its statement in nested
debug scopes that retail's SYM does not have (AI_CalcMeritsBasedOnSpeed: 30 scopes vs retail 1, all gone with one real
prototype).  Compiles each TU exactly as tools/build.py does (into a scratch dir) and lists the compiler's
"implicit declaration of function" warnings per file.  Writes scratchpad/psyq_pipe/implicit_sweep.json."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
import build  # noqa: E402

build.OUT = ROOT / 'build' / 'tmp' / 'implicit_sweep_out'
warnings = {}
_run = build.run


def run(cmd, *a, **k):
    r = _run(cmd, *a, **k)
    exe = Path(str(cmd[0])).name.upper()
    if exe.startswith('CC1'):
        for m in re.finditer(r"implicit declaration of function `([^']+)'", (r.stderr or '') + (r.stdout or '')):
            warnings.setdefault(cur, []).append(m.group(1))
    return r


build.run = run
want = sys.argv[1:]
srcs = sorted([*(ROOT / 'recon' / 'game').rglob('*.c*'), *(ROOT / 'recon' / 'frontend').rglob('*.c*')])
srcs = [s for s in srcs if s.suffix in ('.c', '.cpp') and (not want or any(w in s.as_posix() for w in want))]
report = {}
for s in srcs:
    cur = s.relative_to(ROOT).as_posix()
    try:
        if s.suffix == '.cpp':
            build.compile_cpp(s)
        else:
            build.compile_c(s, True)
    except SystemExit:
        pass
    names = sorted(set(warnings.get(cur, [])))
    if names:
        report[cur] = names
        print('%-52s %s' % (cur, ' '.join(names)), flush=True)
out = ROOT / 'scratchpad' / 'psyq_pipe' / 'implicit_sweep.json'
out.parent.mkdir(parents=True, exist_ok=True)
out.write_text(json.dumps(report, indent=1) + '\n')
print('%d of %d TUs have implicit declarations -> %s' % (len(report), len(srcs), out))

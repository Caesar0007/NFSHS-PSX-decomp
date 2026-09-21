"""gdebug_compile.py [name-fragment ...] -- compile the GAME translation units (recon/game, recon/frontend) with FULL debug
info (`-g`, as retail did; the normal build uses -g1 for C and nothing for C++) into build/gdebug/, through tools/build.py's
own per-TU flag logic (imported, not edited).  Only the compiler's .s output is wanted -- psylink_lane.py assembles it with
ASPSX -g; the GNU assembler step of build.py cannot digest SN's .begin/.bend debug directives, so its failure is ignored.
Writes scratchpad/psyq_pipe/gdebug_report.json: per TU, whether -g left the instruction stream unchanged."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
(ROOT / 'scratchpad' / 'psyq_pipe').mkdir(parents=True, exist_ok=True)   # local, git-ignored work area
sys.path.insert(0, str(ROOT / 'tools'))
import build  # noqa: E402

GOUT = ROOT / 'build' / 'gdebug'
build.OUT = GOUT
build.CC1_FLAGS = ['-g' if f == '-g1' else f for f in build.CC1_FLAGS]
_run = build.run


def run(cmd, *a, **k):
    exe = Path(str(cmd[0])).name.upper()
    if exe.startswith('CC1PL') and '-g' not in [str(c) for c in cmd]:
        cmd = [cmd[0], '-g', *cmd[1:]]
    return _run(cmd, *a, **k)


build.run = run


def ins(p):
    out = []
    for l in open(p, errors='replace'):
        l = l.split('#')[0].rstrip()
        if re.match(r'^\t[a-z]', l) and not l.startswith('\t.'):
            out.append(re.sub(r'\$L\w+', '$L', re.sub(r'\s+', ' ', l.strip())))
    return out


want = sys.argv[1:]
srcs = sorted([*(ROOT / 'recon' / 'game').rglob('*.c*'), *(ROOT / 'recon' / 'frontend').rglob('*.c*')])
srcs = [s for s in srcs if s.suffix in ('.c', '.cpp') and (not want or any(w in s.as_posix() for w in want))]
report = {}
for s in srcs:
    rel = s.relative_to(ROOT).as_posix()
    try:
        if s.suffix == '.cpp':
            build.compile_cpp(s)
        else:
            build.compile_c(s, True)
        note = 'assembled'
    except SystemExit as e:
        note = 'cc1 ok, gnu-as refused' if '[maspsx/as]' in str(e) or 'maspsx' in str(e) else 'FAILED: ' + str(e)[:160]
    g = GOUT / (rel + '.s')
    n = ROOT / 'build' / (rel + '.s')
    same = None
    if g.is_file() and n.is_file():
        a, b = ins(g), ins(n)
        same = (a == b)
        if not same:
            note += ' | CODE DIFFERS %d vs %d insns' % (len(a), len(b))
    report[rel] = {'s': g.is_file(), 'same_code': same, 'note': note}
    print('%-52s %s %s' % (rel[-52:], 'same' if same else ('DIFF' if same is False else '----'), note[:90]))
(ROOT / 'scratchpad' / 'psyq_pipe' / 'gdebug_report.json').write_text(json.dumps(report, indent=1))
print('TUs %d | .s produced %d | code identical %d | differs %d' % (len(report), sum(r['s'] for r in report.values()),
      sum(r['same_code'] is True for r in report.values()), sum(r['same_code'] is False for r in report.values())))

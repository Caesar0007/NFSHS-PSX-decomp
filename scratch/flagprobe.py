"""MEASURE-ONLY per-TU flag probe.  Patches tools/build.py's PER_TU_FLAGS,
gates the TU, then ALWAYS restores build.py byte-for-byte (report-only: the
briefing marks tools/build.py off-limits for landing this wave)."""
import io, os, sys, subprocess

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BUILD = os.path.join(ROOT, 'tools', 'build.py')


def read(p):
    with io.open(p, 'r', encoding='utf-8', newline='') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='') as f:
        f.write(s)


tu, fns, key = sys.argv[1], sys.argv[2], sys.argv[3]
orig = read(BUILD)
anchor = 'PER_TU_FLAGS = {'
assert orig.count(anchor) == 1
new = orig.replace(anchor, anchor + '\n    "%s": {"%s": True},' % (tu, key))
try:
    write(BUILD, new)
    for f in os.listdir(os.path.join(ROOT, 'tools', '__pycache__')) \
            if os.path.isdir(os.path.join(ROOT, 'tools', '__pycache__')) else []:
        if f.startswith('build.'):
            os.remove(os.path.join(ROOT, 'tools', '__pycache__', f))
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', tu, fns],
                       cwd=ROOT, capture_output=True, text=True)
    for l in ((r.stdout or '') + (r.stderr or '')).splitlines():
        if 'PASS' in l or 'FAIL' in l or 'rror' in l:
            print('   ' + l.strip())
finally:
    write(BUILD, orig)
    print('   [build.py restored:', read(BUILD) == orig, ']')

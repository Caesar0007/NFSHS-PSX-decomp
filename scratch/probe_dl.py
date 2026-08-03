"""apply patch -> rtl_dump -dL -> print the SetRamp loop line + verdicts + gate."""
import io, os, sys, subprocess, importlib.util, re

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def read(p):
    with io.open(p, 'r', encoding='utf-8', newline='') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='') as f:
        f.write(s)


tu, fns, patchpath = sys.argv[1], sys.argv[2], sys.argv[3]
path = os.path.join(ROOT, tu)
orig = read(path)
spec = importlib.util.spec_from_file_location('patch', patchpath)
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
try:
    write(path, m.apply(orig))
    subprocess.run([sys.executable, 'tools/rtl_dump.py', tu, '-dL'],
                   cwd=ROOT, capture_output=True, text=True)
    dump = os.path.join(ROOT, 'scratch', 'rtl',
                        os.path.basename(tu).replace('.cpp', '.i.loop'))
    txt = read(dump) if os.path.exists(dump) else ''
    loops = re.findall(r'Loop from \d+ to \d+: (\d+) real insns\.', txt)
    moved = len(re.findall(r'savings 2  moved', txt))
    print('   loops=%s  savings2-moved=%d' % (loops, moved))
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', tu, fns],
                       cwd=ROOT, capture_output=True, text=True)
    for l in ((r.stdout or '') + (r.stderr or '')).splitlines():
        if 'PASS' in l or 'FAIL' in l or 'rror' in l:
            print('   ' + l.strip())
finally:
    write(path, orig)

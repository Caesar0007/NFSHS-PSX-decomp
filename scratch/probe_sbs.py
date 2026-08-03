"""apply patch, print side_by_side for ONE fn, restore."""
import io, os, sys, subprocess, importlib.util

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def read(p):
    with io.open(p, 'r', encoding='utf-8', newline='') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='') as f:
        f.write(s)


tu, fn, patchpath = sys.argv[1], sys.argv[2], sys.argv[3]
path = os.path.join(ROOT, tu)
orig = read(path)
spec = importlib.util.spec_from_file_location('patch', patchpath)
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
try:
    write(path, m.apply(orig))
    r = subprocess.run([sys.executable, 'tools/side_by_side.py', tu, fn],
                       cwd=ROOT, capture_output=True, text=True)
    print(r.stdout or r.stderr)
finally:
    write(path, orig)

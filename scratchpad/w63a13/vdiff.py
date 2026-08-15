"""vdiff.py <probe-module> <variant> -- apply one variant from a probe module and
print the positional side-by-side mismatches, then restore."""
import sys, os, subprocess, importlib.util
ROOT = r'C:/Temp/nfs4-decomp'
sys.path.insert(0, ROOT + '/tools')

mod_path = sys.argv[1]
tag = sys.argv[2]
spec = importlib.util.spec_from_file_location('probemod', mod_path)
m = importlib.util.module_from_spec(spec)
sys.argv = [mod_path, '__none__']
spec.loader.exec_module(m)

SRC, FN = m.SRC, m.FN
full = os.path.join(ROOT, SRC)
orig = open(full, 'rb').read()
crlf = orig.count(b'\r\n') > orig.count(b'\n') // 2


def fix(b):
    return b.replace(b'\n', b'\r\n') if (crlf and b'\r\n' not in b) else b


try:
    data = orig
    for old, new in m.VARIANTS[tag]:
        old, new = fix(old), fix(new)
        assert old in data, 'MISS %r' % old[:60]
        data = data.replace(old, new)
    open(full + '.vtmp', 'wb').write(data)
    os.replace(full + '.vtmp', full)
    r = subprocess.run([sys.executable, ROOT + '/scratchpad/w62a13/dump.py', SRC, FN],
                       capture_output=True, text=True, cwd=ROOT)
    for ln in r.stdout.splitlines():
        if '|' in ln:
            print(ln)
    print(r.stderr[-400:] if r.returncode else '')
finally:
    open(full + '.vtmp', 'wb').write(orig)
    os.replace(full + '.vtmp', full)
    assert open(full, 'rb').read() == orig
    print('(restored)')

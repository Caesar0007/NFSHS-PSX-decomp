"""Patch a variant into the REAL path, run tools/sbs.py, restore."""
import os, subprocess, sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


def main():
    rel, fn, vfile, idx = sys.argv[1], sys.argv[2], sys.argv[3], int(sys.argv[4])
    path = os.path.join(ROOT, rel.replace('/', os.sep))
    ns = {}
    with open(vfile, 'r', encoding='utf-8') as f:
        exec(f.read(), ns)
    anchor, variants = ns['ANCHOR'], ns['VARIANTS']
    with open(path, 'rb') as f:
        orig = f.read()
    crlf = orig.count(b'\r\n') > 0

    def enc(s):
        s = s.replace('\r\n', '\n')
        if crlf:
            s = s.replace('\n', '\r\n')
        return s.encode('ascii')

    a = enc(anchor)
    assert orig.count(a) == 1
    name, rep = variants[idx]
    new = orig.replace(a, enc(rep))
    out = ''
    try:
        with open(path, 'wb') as f:
            f.write(new)
        r = subprocess.run([sys.executable, 'tools/sbs.py', rel, fn],
                           cwd=ROOT, capture_output=True, text=True)
        out = r.stdout + r.stderr
    finally:
        with open(path, 'wb') as f:
            f.write(orig)
    with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'sbs_out.txt'), 'w') as f:
        f.write('=== %s\n%s' % (name, out))
    print('=== %s' % name)
    print(out)


if __name__ == '__main__':
    main()

"""a8 probe harness: apply a patch to a TU, gate one/many fns, restore.

usage:  python scratch/probe.py <tu> <fns-comma> <patchfile.py>
The patch file must define  apply(src) -> newsrc   (str in/out, CRLF preserved).
Always restores the original file, even on exception.
"""
import io, os, sys, subprocess, importlib.util, shutil

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def read(p):
    with io.open(p, 'r', encoding='utf-8', newline='') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='') as f:
        f.write(s)


def gate(tu, fns):
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', tu, fns],
                       cwd=ROOT, capture_output=True, text=True)
    out = (r.stdout or '') + (r.stderr or '')
    lines = [l.rstrip() for l in out.splitlines()
             if ('PASS' in l or 'FAIL' in l or 'ORACLE' in l or 'rror' in l)]
    return '\n'.join(lines) if lines else out[-800:]


def run(tu, fns, patchpath):
    path = os.path.join(ROOT, tu)
    orig = read(path)
    spec = importlib.util.spec_from_file_location('patch', patchpath)
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    try:
        new = m.apply(orig)
        if new == orig:
            print('!! PATCH WAS A NO-OP')
            return
        write(path, new)
        print(gate(tu, fns))
    finally:
        write(path, orig)


if __name__ == '__main__':
    run(sys.argv[1], sys.argv[2], sys.argv[3])

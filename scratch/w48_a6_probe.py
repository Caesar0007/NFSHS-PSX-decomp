"""w48-a6 fast variant probe: patch one function body in-place, gate, restore.

Usage:  python scratch/w48_a6_probe.py <file> <FN> <variants.py>
The variants module must define ANCHOR (exact original body text, unique in the file)
and VARIANTS = [(name, replacement_text), ...].
Always restores the original file in a finally block.
"""
import sys, os, io, importlib.util, subprocess, re

def gate(path, fn):
    r = subprocess.run([sys.executable, "tools/verify_asm.py", path, fn],
                       capture_output=True, text=True, timeout=300)
    out = r.stdout + r.stderr
    m = re.search(r':\s+(PASS|FAIL (\d+))', out)
    if not m:
        return None, out
    if m.group(1) == 'PASS':
        return 0, out
    return int(m.group(2)), out

def main():
    path, fn, vmod = sys.argv[1], sys.argv[2], sys.argv[3]
    spec = importlib.util.spec_from_file_location("vmod", vmod)
    v = importlib.util.module_from_spec(spec); spec.loader.exec_module(v)
    with io.open(path, 'r', newline='') as f:
        orig = f.read()
    nl = '\r\n' if orig.count('\r\n') > orig.count('\n') // 2 else '\n'
    def conv(s):
        return s.replace('\r\n', '\n').replace('\n', nl)
    v.ANCHOR = conv(v.ANCHOR)
    v.VARIANTS = [(n, conv(t)) for n, t in v.VARIANTS]
    assert orig.count(v.ANCHOR) == 1, "anchor not unique (%d hits)" % orig.count(v.ANCHOR)
    try:
        base, _ = gate(path, fn)
        print("BASE %s" % base)
        for name, repl in v.VARIANTS:
            with io.open(path, 'w', newline='') as f:
                f.write(orig.replace(v.ANCHOR, repl))
            n, out = gate(path, fn)
            print("%-40s %s" % (name, "COMPILE-FAIL" if n is None else n))
            if n is None:
                print(out[-600:])
    finally:
        with io.open(path, 'w', newline='') as f:
            f.write(orig)
        print("restored (%d bytes)" % len(orig))

main()

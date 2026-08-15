"""w63a1 probe driver -- byte-mode variant probe on ONE TU, always restores.

usage:  python scratchpad/w63a1/probe.py <variantfile.py>

The variant file must define:
    TU    = "recon/game/psx/hud.cpp"
    FN    = "Hud_Init__Fv"
    VARIANTS = [ (name, [(old, new, count), ...]), ... ]   # bytes-in-str, LF-normalised
A variant with an empty edit list is the CONTROL.
Every replace asserts its expected match count (12K: no fake 'inert' readings).
"""
import importlib.util
import os
import subprocess
import sys

ROOT = r"C:/Temp/nfs4-decomp"


def read_bytes(p):
    with open(p, "rb") as f:
        return f.read()


def write_bytes(p, data):
    tmp = p + ".w63a1tmp"
    with open(tmp, "wb") as f:
        f.write(data)
    assert os.path.getsize(tmp) > 0
    os.replace(tmp, p)


def gate(tu, fn):
    r = subprocess.run([sys.executable, "tools/verify_asm.py", tu, fn],
                       capture_output=True, text=True, cwd=ROOT)
    for line in r.stdout.splitlines():
        s = line.strip()
        if s.startswith(fn + ":"):
            return s
    return "ERR " + (r.stdout + r.stderr).strip()[-300:]


def main():
    spec = importlib.util.spec_from_file_location("variants", sys.argv[1])
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    tu = os.path.join(ROOT, mod.TU)
    fn = mod.FN
    orig = read_bytes(tu)
    # detect line-ending regime once (12K)
    crlf = orig.count(b"\r\n") > orig.count(b"\n") // 2
    print("line endings:", "CRLF" if crlf else "LF")
    try:
        for name, edits in mod.VARIANTS:
            cur = orig
            ok = True
            for old, new, cnt in edits:
                o = old.encode()
                n = new.encode()
                if crlf:
                    o = o.replace(b"\n", b"\r\n")
                    n = n.replace(b"\n", b"\r\n")
                got = cur.count(o)
                if got != cnt:
                    print("%-38s ANCHOR-FAIL expected %d got %d for %r"
                          % (name, cnt, got, old[:60]))
                    ok = False
                    break
                cur = cur.replace(o, n)
            if not ok:
                continue
            write_bytes(tu, cur)
            print("%-38s %s" % (name, gate(mod.TU, fn)))
            sys.stdout.flush()
    finally:
        write_bytes(tu, orig)
        print("restored:", len(orig), "bytes")


main()

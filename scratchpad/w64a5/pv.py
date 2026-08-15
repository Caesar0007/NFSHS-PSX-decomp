"""w64a5 generic variant prober.

Patches the REAL source path (PER_TU_FLAGS is path-keyed), runs tools/verify_asm.py,
restores in `finally`.  Variants are supplied as a python module exposing
  TU      : repo-relative source path
  FUNC    : symbol to gate
  BASE    : exact byte-string that must appear EXACTLY ONCE in the file
  VARIANTS: dict name -> replacement byte-string

Usage:  python scratchpad/w64a5/pv.py <spec-module.py> [name ...]
Line endings of the file are auto-detected and applied to the replacement text
(all replacement text is written with plain \n and translated).
"""
import importlib.util
import os
import subprocess
import sys

ROOT = r"C:\Temp\nfs4-decomp"


def load(path):
    spec = importlib.util.spec_from_file_location("spec", path)
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


def main():
    spec = load(sys.argv[1])
    names = sys.argv[2:] or list(spec.VARIANTS)
    tu = os.path.join(ROOT, spec.TU.replace("/", os.sep))
    orig = open(tu, "rb").read()
    crlf = orig.count(b"\r\n") > 0

    def enc(s):
        b = s.encode("ascii")
        b = b.replace(b"\r\n", b"\n")
        if crlf:
            b = b.replace(b"\n", b"\r\n")
        return b

    base = enc(spec.BASE)
    n = orig.count(base)
    assert n == 1, "BASE matched %d times (need exactly 1)" % n
    log = os.path.join(ROOT, "scratchpad", "w64a5", "pv_last.log")
    try:
        for name in names:
            new = orig.replace(base, enc(spec.VARIANTS[name]))
            assert new != orig or spec.VARIANTS[name] == spec.BASE
            with open(tu + ".tmp", "wb") as fh:
                fh.write(new)
            os.replace(tu + ".tmp", tu)
            r = subprocess.run(
                [sys.executable, "tools/verify_asm.py", spec.TU, spec.FUNC],
                cwd=ROOT, capture_output=True, text=True, timeout=900)
            out = [l.strip() for l in (r.stdout + r.stderr).splitlines()
                   if "PASS" in l or "FAIL" in l or "Error" in l or "error" in l]
            with open(log, "a") as fh:
                fh.write("%-28s %s\n" % (name, " | ".join(out[:3])))
            print("%-28s %s" % (name, " | ".join(out[:3])), flush=True)
    finally:
        with open(tu + ".tmp", "wb") as fh:
            fh.write(orig)
        os.replace(tu + ".tmp", tu)
        print("[restored]", flush=True)


if __name__ == "__main__":
    main()

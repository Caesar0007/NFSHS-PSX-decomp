"""w64a5 multi-edit variant prober.

Spec module exposes:
  TU, FUNC
  VARIANTS: name -> list of (base_str, repl_str) pairs; each base must match EXACTLY once.
Optional: EXTRA_FUNCS (list) gated too;  DIFF=1 env prints the full diff for a single name.
Usage: python pv2.py <spec.py> [name ...]
"""
import importlib.util
import os
import subprocess
import sys

ROOT = r"C:\Temp\nfs4-decomp"


def main():
    _s = importlib.util.spec_from_file_location("spec", sys.argv[1])
    spec = importlib.util.module_from_spec(_s)
    _s.loader.exec_module(spec)
    names = sys.argv[2:] or list(spec.VARIANTS)
    tu = os.path.join(ROOT, spec.TU.replace("/", os.sep))
    orig = open(tu, "rb").read()
    crlf = orig.count(b"\r\n") > 0

    def enc(s):
        b = s.encode("utf-8").replace(b"\r\n", b"\n")
        return b.replace(b"\n", b"\r\n") if crlf else b

    funcs = [spec.FUNC] + list(getattr(spec, "EXTRA_FUNCS", []))
    env = dict(os.environ)
    if os.environ.get("DIFF"):
        env["VA_MAX"] = "400"
    try:
        for name in names:
            data = orig
            for b, r in spec.VARIANTS[name]:
                eb = enc(b)
                n = data.count(eb)
                assert n == 1, "%s: base matched %d times:\n%r" % (name, n, b[:120])
                data = data.replace(eb, enc(r))
            with open(tu + ".tmp", "wb") as fh:
                fh.write(data)
            os.replace(tu + ".tmp", tu)
            res = []
            for f in funcs:
                r = subprocess.run([sys.executable, "tools/verify_asm.py", spec.TU, f],
                                   cwd=ROOT, capture_output=True, text=True, timeout=1200,
                                   env=env)
                txt = r.stdout + r.stderr
                if os.environ.get("DIFF"):
                    print(txt)
                res += [l.strip() for l in txt.splitlines()
                        if "PASS" in l or "FAIL" in l or "rror" in l]
            print("%-26s %s" % (name, " | ".join(res[:6])), flush=True)
    finally:
        with open(tu + ".tmp", "wb") as fh:
            fh.write(orig)
        os.replace(tu + ".tmp", tu)
        print("[restored]", flush=True)


if __name__ == "__main__":
    main()

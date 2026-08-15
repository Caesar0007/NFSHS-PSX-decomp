"""w64a12 probe: apply (old,new) text substitutions to a recon TU, gate one fn,
restore ALWAYS.  Byte-mode; line-ending agnostic (caller supplies exact text).

usage:  python scratchpad/w64a12/w64a12_probe.py <tu> <fn> <variants.json>

variants.json = [ {"name": "...", "subs": [[old, new], ...]}, ... ]
Each `old` must match EXACTLY ONCE (asserted) or the variant is reported SKIP.
"""
import json
import os
import subprocess
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))


def gate(tu, fn):
    r = subprocess.run([sys.executable, "tools/verify_asm.py", tu, fn],
                       capture_output=True, text=True, cwd=ROOT)
    for l in r.stdout.splitlines():
        if l.strip().startswith(fn + ":"):
            return l.strip()
    return "ERR " + (r.stderr.strip()[-200:] or r.stdout.strip()[-200:])


def main():
    tu, fn, vfile = sys.argv[1], sys.argv[2], sys.argv[3]
    path = os.path.join(ROOT, tu)
    with open(path, "rb") as f:
        orig = f.read()
    variants = json.load(open(vfile, encoding="utf-8"))
    log = []
    try:
        for v in variants:
            data = orig
            ok = True
            for old, new in v["subs"]:
                ob = old.encode("utf-8")
                nb = new.encode("utf-8")
                n = data.count(ob)
                if n != 1:
                    log.append("%-28s SKIP (match count %d for %r)"
                               % (v["name"], n, old[:60]))
                    ok = False
                    break
                data = data.replace(ob, nb)
            if not ok:
                continue
            assert len(data) > 0
            tmp = path + ".w64a12tmp"
            with open(tmp, "wb") as f:
                f.write(data)
            os.replace(tmp, path)
            log.append("%-28s %s" % (v["name"], gate(tu, fn)))
            print(log[-1], flush=True)
    finally:
        with open(path, "wb") as f:
            f.write(orig)
        with open(os.path.join(os.path.dirname(__file__), "probe.log"), "a") as f:
            f.write("\n".join(log) + "\n")
    print("--- restored ---")


main()

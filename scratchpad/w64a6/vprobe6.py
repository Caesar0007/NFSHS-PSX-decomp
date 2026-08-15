"""w64a6 generic VARIANT prober.

Applies a list of (old,new) byte substitutions to a TU (in place, PER_TU_FLAGS is path
keyed so a renamed copy measures the wrong lane), gates one or more functions, restores
in `finally`.  Variants are described in a JSON file:

  [{"name":"...", "edits":[["old","new"], ...], "fns":["A","B"]}, ...]

Usage: python scratchpad/w64a6/vprobe6.py <tu-rel> <variants.json> [fn ...]
"""
import json, os, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"


def gate(turel, fn):
    p = subprocess.run([sys.executable, "tools/verify_asm.py", turel, fn],
                       cwd=ROOT, capture_output=True, text=True, timeout=1800)
    out = p.stdout + p.stderr
    for line in out.splitlines():
        if line.strip().startswith(fn + ":"):
            return line.strip()[len(fn) + 1:].strip()
    return (out.strip().splitlines() or ["NO OUTPUT"])[-1]


def main():
    turel, vfile = sys.argv[1], sys.argv[2]
    defaults = sys.argv[3:]
    tu = os.path.join(ROOT, turel.replace("/", os.sep))
    base = open(tu, "rb").read()
    variants = json.load(open(vfile, "r", encoding="utf-8"))
    allfns = []
    for v in variants:
        for f in v.get("fns", defaults):
            if f not in allfns:
                allfns.append(f)
    print("BASELINE   " + " | ".join("%s %s" % (f, gate(turel, f)) for f in allfns), flush=True)
    try:
        for v in variants:
            cur = base
            ok = True
            for old, new in v["edits"]:
                ob, nb = old.encode("utf-8"), new.encode("utf-8")
                n = cur.count(ob)
                if n != 1:
                    print("%-28s SKIP (anchor count %d): %s" % (v["name"], n, old[:60]), flush=True)
                    ok = False
                    break
                cur = cur.replace(ob, nb, 1)
            if not ok:
                continue
            tmp = tu + ".tmp"
            open(tmp, "wb").write(cur)
            assert os.path.getsize(tmp) > 100
            os.replace(tmp, tu)
            fns = v.get("fns", defaults)
            print("%-28s %s" % (v["name"], " | ".join("%s %s" % (f, gate(turel, f)) for f in fns)), flush=True)
    finally:
        open(tu, "wb").write(base)
        print("restored", os.path.getsize(tu))


main()

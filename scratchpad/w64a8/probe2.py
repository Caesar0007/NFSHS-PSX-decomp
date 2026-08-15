"""probe2.py -- variant runner that reports BOTH lanes (gate + psyqproof).

usage: python scratchpad/w64a8/probe2.py <json-spec>
spec = {"src": <path>, "fn": <name>, "variants": {tag: [[old,new],...]}}
Restores the file in finally:; asserts each anchor matches exactly once.
"""
import json
import os
import subprocess
import sys
import pathlib

ROOT = str(pathlib.Path(__file__).resolve().parents[2])


def gate(src, fn):
    r = subprocess.run([sys.executable, "tools/verify_asm.py", src, fn],
                       capture_output=True, text=True, cwd=ROOT)
    hit = [l.strip() for l in r.stdout.splitlines() if l.strip().startswith(fn + ":")]
    return hit[0] if hit else (r.stdout.strip()[-120:] + " ERR " + r.stderr.strip()[-120:])


def proof(src, fn):
    r = subprocess.run([sys.executable, "tools/psyqproof.py", src, fn],
                       capture_output=True, text=True, cwd=ROOT)
    hit = [l.strip() for l in r.stdout.splitlines() if l.strip().startswith(fn + ":")]
    extra = [l.strip() for l in r.stdout.splitlines() if l.strip().startswith("word")]
    return (hit[0] if hit else r.stdout.strip()[-160:]) + (" || " + "; ".join(extra[:3]) if extra else "")


def main():
    spec = json.load(open(sys.argv[1]))
    src, fn = spec["src"], spec["fn"]
    do_proof = spec.get("proof", True)
    full = os.path.join(ROOT, src)
    orig = open(full, "rb").read()
    crlf = orig.count(b"\r\n") > orig.count(b"\n") // 2

    def fix(s):
        b = s.encode()
        if crlf and b"\r\n" not in b:
            b = b.replace(b"\n", b"\r\n")
        return b
    try:
        for tag, pairs in spec["variants"].items():
            data, ok = orig, True
            for old, new in pairs:
                o, n = fix(old), fix(new)
                c = data.count(o)
                if c != 1:
                    print("=== %-34s ANCHOR count=%d %r" % (tag, c, old[:60]))
                    ok = False
                    break
                data = data.replace(o, n)
            if not ok:
                continue
            tmp = full + ".p2tmp"
            open(tmp, "wb").write(data)
            os.replace(tmp, full)
            g = gate(src, fn)
            p = proof(src, fn) if do_proof else ""
            print("=== %-34s %s\n        %s" % (tag, g, p))
    finally:
        tmp = full + ".p2tmp"
        open(tmp, "wb").write(orig)
        os.replace(tmp, full)
        assert open(full, "rb").read() == orig
        print("(restored)")


main()

#!/usr/bin/env python3
"""w64a17 probe harness: byte-mode patch a recon TU, gate one fn, restore.

usage: python scratchpad/w64a17/probe.py <spec.json>

spec.json = {"file": "recon/...", "fn": "Mangled", "variants": [
   {"name": "...", "edits": [[old, new], ...]}, ...]}
All strings are matched with LF newlines normalised; the harness re-applies the
file's original newline convention.  Every edit asserts count==1.
"""
import json, os, subprocess, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]


def gate(rel, fn):
    r = subprocess.run([sys.executable, "tools/verify_asm.py", rel, fn],
                       capture_output=True, text=True, cwd=str(ROOT))
    for ln in r.stdout.splitlines():
        s = ln.strip()
        if s.startswith(fn + ":"):
            return s[len(fn) + 1:].strip()
    return "ERR " + (r.stdout.strip()[-200:] + " " + r.stderr.strip()[-200:])


def main():
    spec = json.loads(pathlib.Path(sys.argv[1]).read_text())
    rel = spec["file"]
    fn = spec["fn"]
    p = ROOT / rel
    orig = p.read_bytes()
    crlf = b"\r\n" in orig
    text = orig.decode("latin-1").replace("\r\n", "\n")
    log = []
    try:
        print("BASE:", gate(rel, fn))
        for v in spec["variants"]:
            body = text
            ok = True
            for old, new in v["edits"]:
                n = body.count(old)
                if n != 1:
                    log.append((v["name"], "ANCHOR count=%d" % n))
                    print("%-40s ANCHOR count=%d" % (v["name"], n))
                    ok = False
                    break
                body = body.replace(old, new)
            if not ok:
                continue
            out = body.replace("\n", "\r\n") if crlf else body
            tmp = p.with_suffix(p.suffix + ".tmp")
            tmp.write_bytes(out.encode("latin-1"))
            os.replace(str(tmp), str(p))
            res = gate(rel, fn)
            log.append((v["name"], res))
            print("%-40s %s" % (v["name"], res))
    finally:
        p.write_bytes(orig)
        print("RESTORED:", gate(rel, fn))
    json.dump(log, open(str(ROOT / "scratchpad/w64a17/last_probe.json"), "w"), indent=1)


main()

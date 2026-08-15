#!/usr/bin/env python3
"""w65a1 probe harness: byte-mode patch a recon TU, gate one fn AND read its
branch-routing row (brdist), restore.

usage: python scratchpad/w65a1/probe.py <spec.json>

spec.json = {"file": "recon/...", "fn": "Mangled", "variants": [
   {"name": "...", "edits": [[old, new], ...]}, ...]}
Every edit asserts count==1.  The file's own newline convention is re-applied.
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


def brd(rel, fn):
    r = subprocess.run([sys.executable, "tools/brdist.py", rel],
                       capture_output=True, text=True, cwd=str(ROOT))
    for ln in r.stdout.splitlines():
        if ln.startswith(fn + " ") or ln.startswith(fn + "\t"):
            return ln[len(fn):].strip()
    return "br-CLEAN"


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
        print("BASE: %-24s | %s" % (gate(rel, fn), brd(rel, fn)))
        for v in spec["variants"]:
            body = text
            ok = True
            for old, new in v["edits"]:
                n = body.count(old)
                if n != 1:
                    log.append((v["name"], "ANCHOR count=%d" % n, ""))
                    print("%-34s ANCHOR count=%d" % (v["name"], n))
                    ok = False
                    break
                body = body.replace(old, new)
            if not ok:
                continue
            out = body.replace("\n", "\r\n") if crlf else body
            tmp = p.with_suffix(p.suffix + ".tmp")
            tmp.write_bytes(out.encode("latin-1"))
            os.replace(str(tmp), str(p))
            gr, br = gate(rel, fn), brd(rel, fn)
            log.append((v["name"], gr, br))
            print("%-34s %-24s | %s" % (v["name"], gr, br))
    finally:
        p.write_bytes(orig)
        print("RESTORED: %-20s | %s" % (gate(rel, fn), brd(rel, fn)))
    out = pathlib.Path(sys.argv[2] if len(sys.argv) > 2
                       else str(ROOT / "scratchpad/w65a1/last_probe.json"))
    out.write_text(json.dumps(log, indent=1))


main()

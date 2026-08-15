#!/usr/bin/env python3
"""Apply ONE variant from a spec, dump the FULL (VA_MAX) diff, restore.
usage: python scratchpad/w67a8/show.py <spec.json> <variant-name>
"""
import json, os, subprocess, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]


def main():
    spec = json.loads(pathlib.Path(sys.argv[1]).read_text())
    want = sys.argv[2]
    rel, fn = spec["file"], spec["fn"]
    p = ROOT / rel
    orig = p.read_bytes()
    crlf = b"\r\n" in orig
    text = orig.decode("latin-1").replace("\r\n", "\n")
    v = [v for v in spec["variants"] if v["name"] == want][0]
    body = text
    for old, new in v["edits"]:
        assert body.count(old) == 1, "anchor count != 1"
        body = body.replace(old, new)
    out = body.replace("\n", "\r\n") if crlf else body
    tmp = p.with_suffix(p.suffix + ".tmp")
    tmp.write_bytes(out.encode("latin-1"))
    os.replace(str(tmp), str(p))
    try:
        env = dict(os.environ, VA_MAX="400")
        r = subprocess.run([sys.executable, "tools/verify_asm.py", rel, fn],
                           capture_output=True, text=True, cwd=str(ROOT), env=env)
        print(r.stdout)
        if r.stderr.strip():
            print("STDERR:", r.stderr[-500:])
    finally:
        p.write_bytes(orig)


main()

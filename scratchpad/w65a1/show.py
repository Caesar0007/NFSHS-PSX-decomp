#!/usr/bin/env python3
"""show.py <spec.json> <variant-index> [route|gate] -- apply ONE variant, print the
gate diff or the routing view, then restore."""
import json, os, subprocess, sys, pathlib
ROOT = pathlib.Path(r'C:\Temp\nfs4-decomp')
spec = json.loads(pathlib.Path(sys.argv[1]).read_text())
idx = int(sys.argv[2])
mode = sys.argv[3] if len(sys.argv) > 3 else "gate"
rel, fn = spec["file"], spec["fn"]
p = ROOT / rel
orig = p.read_bytes()
crlf = b"\r\n" in orig
text = orig.decode("latin-1").replace("\r\n", "\n")
v = spec["variants"][idx]
try:
    body = text
    for old, new in v["edits"]:
        assert body.count(old) == 1, "anchor %d" % body.count(old)
        body = body.replace(old, new)
    out = body.replace("\n", "\r\n") if crlf else body
    tmp = p.with_suffix(p.suffix + ".tmp")
    tmp.write_bytes(out.encode("latin-1"))
    os.replace(str(tmp), str(p))
    cmd = ([sys.executable, "scratchpad/w65a1/route.py", rel, fn] if mode == "route"
           else [sys.executable, "tools/verify_asm.py", rel, fn])
    r = subprocess.run(cmd, capture_output=True, text=True, cwd=str(ROOT))
    print("=== %s (%s)" % (v["name"], mode))
    print(r.stdout)
    print(r.stderr[-500:] if r.returncode and r.stderr else "")
finally:
    p.write_bytes(orig)

#!/usr/bin/env python3
"""show.py <spec.json> <variant-index> -- apply ONE variant, print the full gate
diff (and optionally the side-by-side), then restore."""
import json, os, subprocess, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[2]
spec = json.loads(pathlib.Path(sys.argv[1]).read_text())
idx = int(sys.argv[2])
sbs = len(sys.argv) > 3 and sys.argv[3] == "sbs"
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
    tool = "tools/side_by_side.py" if sbs else "tools/verify_asm.py"
    r = subprocess.run([sys.executable, tool, rel, fn], capture_output=True,
                       text=True, cwd=str(ROOT))
    print("=== %s (%s)" % (v["name"], "sbs" if sbs else "gate"))
    print(r.stdout)
finally:
    p.write_bytes(orig)

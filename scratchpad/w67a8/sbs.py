#!/usr/bin/env python3
"""Apply ONE variant, dump ours-vs-oracle side by side (normalized), restore.
usage: python scratchpad/w67a8/sbs.py <spec.json> <variant-name|BASE>
"""
import json, os, subprocess, sys, pathlib, importlib.util

ROOT = pathlib.Path(__file__).resolve().parents[2]


def main():
    spec = json.loads(pathlib.Path(sys.argv[1]).read_text())
    want = sys.argv[2]
    rel, fn = spec["file"], spec["fn"]
    p = ROOT / rel
    orig = p.read_bytes()
    crlf = b"\r\n" in orig
    text = orig.decode("latin-1").replace("\r\n", "\n")
    if want != "BASE":
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
        sys.argv = ["side_by_side.py", rel, fn]
        sys.path.insert(0, str(ROOT / "tools"))
        spec2 = importlib.util.spec_from_file_location(
            "side_by_side", str(ROOT / "tools/side_by_side.py"))
        m = importlib.util.module_from_spec(spec2)
        os.chdir(str(ROOT))
        try:
            spec2.loader.exec_module(m)
        except SystemExit:
            pass
    finally:
        p.write_bytes(orig)


main()

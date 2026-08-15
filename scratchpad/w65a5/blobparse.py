#!/usr/bin/env python3
"""W63-A19  blob parser: turn a spimdisasm data blob .s into (name, va, size,
line_start, line_end) records, VA-ordered, with a byte-exact re-emit check.

Usage:  python blobparse.py asm/data/sdata_8013C54C.sdata.s
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

VA_RE = re.compile(r"/\*\s*([0-9A-Fa-f]+)\s+([0-9A-Fa-f]{8})\s")


def parse(path):
    """Return (header_lines, records). record = dict(name, va, end, lines)."""
    txt = Path(path).read_text(errors="replace")
    nl = "\r\n" if "\r\n" in txt else "\n"
    lines = txt.split(nl)
    recs = []
    header = []
    i = 0
    # header = everything before the first `nonmatching`/`dlabel`
    while i < len(lines) and not lines[i].startswith(("nonmatching", "dlabel")):
        header.append(lines[i])
        i += 1
    cur = None
    while i < len(lines):
        ln = lines[i]
        if ln.startswith("nonmatching "):
            if cur:
                recs.append(cur)
            cur = {"name": ln.split(None, 1)[1].strip(), "lines": [ln],
                   "va": None, "end": None}
        elif cur is not None:
            cur["lines"].append(ln)
            m = VA_RE.search(ln)
            if m and cur["va"] is None:
                cur["va"] = int(m.group(2), 16)
        i += 1
    if cur:
        recs.append(cur)
    return nl, header, recs


def main():
    path = ROOT / sys.argv[1] if len(sys.argv) > 1 else \
        ROOT / "asm/data/sdata_8013C54C.sdata.s"
    nl, header, recs = parse(path)
    print(f"{path.name}: {len(recs)} labels, header {len(header)} lines, "
          f"newline={'CRLF' if nl == chr(13)+chr(10) else 'LF'}")
    # anti-vacuity: re-emit must equal the original byte for byte
    out = nl.join(header + [l for r in recs for l in r["lines"]])
    orig = path.read_text(errors="replace")
    assert out == orig, "re-emit mismatch -- parser is lossy, DO NOT edit with it"
    print("re-emit check: BYTE-IDENTICAL")
    nova = [r["name"] for r in recs if r["va"] is None]
    print(f"labels with no VA comment: {len(nova)} {nova[:5]}")
    recs = [r for r in recs if r["va"] is not None]
    order_ok = all(a["va"] < b["va"] for a, b in zip(recs, recs[1:]))
    print(f"emission order == VA order: {order_ok}")
    end = int(sys.argv[2], 16) if len(sys.argv) > 2 else None
    if end:
        for a, b in zip(recs, recs[1:]):
            a["end"] = b["va"]
        recs[-1]["end"] = end
        print(f"VA span {recs[0]['va']:#x}..{end:#x} "
              f"({end - recs[0]['va']} bytes)")
        for r in recs:
            assert r["end"] > r["va"], r["name"]


def load(path, end_va):
    """Public entry: (newline, header, VA-ordered records with .end filled)."""
    nl, header, recs = parse(path)
    recs = [r for r in recs if r["va"] is not None]
    assert all(a["va"] < b["va"] for a, b in zip(recs, recs[1:])), "not VA-ordered"
    for a, b in zip(recs, recs[1:]):
        a["end"] = b["va"]
    recs[-1]["end"] = end_va
    return nl, header, recs


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""lit.py -- W67-A4: per-TU retail-vs-ours .sdata layout differ, LITERAL-aware.

Prints two columns of records:
  RETAIL: every blob record in the TU's retail span (name, size, decoded bytes)
  OURS:   our object's section carved at symbol boundaries; unnamed space
          between/before symbols is shown as anonymous runs with decoded bytes
          (this is where -G8 string literals live).

  python scratchpad/w67a4/lit.py --blob <ctl> --end 0xVA --obj <path.o> [--sec .sdata]
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
import blobparse  # noqa: E402

OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
FBASE = 0x8000F800
SYMLINE = re.compile(r"^([0-9a-f]{8}) (.{7}) (\S+)\s+([0-9a-f]{8}) (.*)$")


def classify(b):
    if not any(b):
        return "zero[%d]" % len(b)
    txt = b.split(b"\x00", 1)[0]
    if txt and all(32 <= c < 127 for c in txt) and not any(b[len(txt):]):
        return 'STR %r' % txt.decode()
    return "hex " + b.hex()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--blob", required=True)
    ap.add_argument("--end", required=True)
    ap.add_argument("--obj", required=True)
    ap.add_argument("--sec", default=".sdata")
    a = ap.parse_args()

    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    _, _, recs = blobparse.load(ROOT / a.blob, int(a.end, 16))
    by_name = {r["name"]: r for r in recs}

    r = subprocess.run([OBJDUMP, "-t", "-h", "-s", a.obj],
                       capture_output=True, text=True, cwd=ROOT)
    syms, size, by = [], 0, bytearray()
    mode = None
    for ln in r.stdout.splitlines():
        if ln.startswith("Contents of section "):
            mode = ln.split("Contents of section ", 1)[1].rstrip(":")
            continue
        m = re.match(r"^\s*\d+\s+(\S+)\s+([0-9a-f]+)\s", ln)
        if m and m.group(1) == a.sec:
            size = int(m.group(2), 16)
        m = SYMLINE.match(ln)
        if m and m.group(3) == a.sec and m.group(5).strip():
            syms.append((int(m.group(1), 16), int(m.group(4), 16),
                         m.group(5).strip()))
        if mode == a.sec:
            m = re.match(r"^\s([0-9a-f]{4,8}) ((?:[0-9a-f]{2,8} ?){1,4})", ln)
            if m:
                by += bytes.fromhex(m.group(2).replace(" ", ""))
    syms.sort()
    mine = {n for _, _, n in syms if n in by_name}
    if not mine:
        print("no blob-named symbol in", a.obj, a.sec)
        return
    vas = sorted(by_name[n]["va"] for n in mine)
    lo = vas[0]
    hi = max(by_name[n]["end"] for n in mine)
    # implied bases per anchor
    bases = {}
    for off, sz, n in syms:
        if n in by_name:
            bases.setdefault(by_name[n]["va"] - off, []).append(n)
    print("== implied bases:")
    for b, ns in sorted(bases.items()):
        print("   base %#010x  x%d  e.g. %s" % (b, len(ns), ns[:4]))

    print("== RETAIL run %#x..%#x (%d B)" % (lo, hi, hi - lo))
    for rec in recs:
        if lo <= rec["va"] < hi:
            b = rom[rec["va"] - FBASE:rec["end"] - FBASE]
            own = "*" if rec["name"] in mine else " "
            print("  %s %#010x %3d B %-24s %s"
                  % (own, rec["va"], len(b), rec["name"], classify(b)))

    print("== OURS %s size %d" % (a.sec, size))
    marks = sorted({0, size}
                   | {off for off, _, _ in syms}
                   | {off + sz for off, sz, _ in syms if sz})
    symat = {off: (n, sz) for off, sz, n in syms}
    for i, off in enumerate(marks[:-1]):
        nxt = marks[i + 1]
        b = bytes(by[off:nxt])
        n, sz = symat.get(off, ("(anon)", 0))
        print("    +%#06x %3d B %-24s %s" % (off, nxt - off, n, classify(b)))


main()

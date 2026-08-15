#!/usr/bin/env python3
"""Classify the multiple-definition pairs in a src-lane ld stderr dump."""
import re
import sys
from collections import Counter
from pathlib import Path

HERE = Path(__file__).resolve().parent
path = Path(sys.argv[1]) if len(sys.argv) > 1 else HERE / "base_head.err"
lines = path.read_text(errors="replace").replace("\r\n", "\n").split("\n")

pairs = []
cur = None
for l in lines:
    m = re.search(r"ld\.exe: (\S+): in function", l)
    if m:
        cur = m.group(1)
        continue
    m = re.search(r"multiple definition of [`'](.+?)'; (\S+):", l)
    if m:
        head = re.search(r"ld\.exe: (\S+):\(", l)
        pairs.append((head.group(1) if head else cur, m.group(2), m.group(1)))


def lane(p):
    if not p:
        return "None"
    p = p.replace(chr(92), "/")
    if "/build/asm/" in p or p.startswith("build/asm"):
        return "asm"
    if "/build/src/" in p or p.startswith("build/src"):
        return "src"
    if "/build/recon/" in p:
        return "recon"
    return "other"


def short(p):
    return p.replace(chr(92), "/").split("/build/")[-1] if p else str(p)


print("pairs parsed:", len(pairs))
print(Counter((lane(a), lane(b)) for a, b, _ in pairs))
c2 = Counter((short(a), short(b)) for a, b, _ in pairs)
print("top duplicate object pairs:")
for (a, b), n in c2.most_common(15):
    print(f"  {n:5d}  {a}  <->  {b}")
names = sorted({n for _, _, n in pairs})
(HERE / (path.stem + ".dupnames.txt")).write_text("\n".join(names))
print("distinct duplicated symbol names:", len(names))

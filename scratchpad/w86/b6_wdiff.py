"""W86-B6 helper: word-by-word diff of a base oracle .s vs a regional oracle .s.

Both listings are count-exact for the rows in this assignment, so index i in one
corresponds to index i in the other.  The base (splat) listing prints the word
byte-reversed; the regional (regionrecon) listing prints it big-endian.
Prints every differing index with both words decoded as an addiu/ori immediate
when that is what they are.
"""
import re
import sys

BASE_RE = re.compile(r"/\* [0-9A-Fa-f]+ ([0-9A-Fa-f]{8}) ([0-9A-Fa-f]{8}) \*/\s+(.*)")
REG_RE = re.compile(r"/\* ([0-9A-Fa-f]{8}) ([0-9A-Fa-f]{8}) \*/\s+(.*)")


def read_base(path):
    out = []
    for line in open(path):
        m = BASE_RE.search(line)
        if m:
            le = m.group(2)
            w = int(le[6:8] + le[4:6] + le[2:4] + le[0:2], 16)
            out.append((w, m.group(3).strip()))
    return out


def read_region(path):
    out = []
    for line in open(path):
        if "glabel" in line:
            continue
        m = REG_RE.search(line)
        if m:
            out.append((int(m.group(2), 16), m.group(3).strip()))
    return out


b = read_base(sys.argv[1])
r = read_region(sys.argv[2])
print("base %d insns / region %d insns" % (len(b), len(r)))
n = 0
for i in range(min(len(b), len(r))):
    if b[i][0] != r[i][0]:
        n += 1
        print("insn %-4d  base %08x  %-40s  region %08x  %s"
              % (i, b[i][0], b[i][1], r[i][0], r[i][1]))
print("differing words: %d" % n)

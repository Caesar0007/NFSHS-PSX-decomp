"""W64-A22 MISSION A/1e -- the LOCAL-ALLOC (qty) layer at an EXACT tie.

1d proved the decl dial reaches the GLOBAL allocno layer at an exact tie
(global.c allocno_compare -> `return v1 - v2`, allocno number == pseudo number
== declaration order).  This probe isolates the OTHER layer: a SINGLE basic block
(every pseudo is block-local => local-alloc qty, reg_basic_block >= 0) with the
same exact-tie construction.  local-alloc.c:281-285 mints the qty number in the
INSN SCAN (alloc_qty is called from block_alloc as it walks the block), so the
prediction is: DECL order inert, FIRST-USE order decisive.

Two axes are swept independently:
  * decl   : permute the declaration list, hold first-use order fixed
  * firstuse: permute the definition statements, hold declaration order fixed
"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from declab import compile_dump  # noqa: E402

LANES = [("cpp", "CC1PLPSX 2.8.0 C++"), ("c272", "CC1PSX 2.7.2 C"),
         ("c280", "CC1PSX 2.8.0 C"),
         ("c281", "FSF gcc-2.8.1-psx cc1"),
         ("c272b", "FSF gcc-2.7.2-970404-psx cc1")]
LOADG = re.compile(r"lw\t\$(\w+),%lo\(G(\d)\)|lw\t\$(\w+),G(\d)")
RX = re.compile(r"Register (\d+) used (\d+) times across (\d+) insns"
                r"(?: in block (\d+))?;")


def gen(decl_order, use_order, V):
    L = ["int G0,G1,G2,G3,G4,G5;", "", "int f(int p) {"]
    for v in decl_order:
        L.append("  int %s;" % v)
    for v in use_order:                       # births in use_order
        L.append("  %s = G%d;" % (v, V.index(v)))
    for v in use_order:
        L.append("  p ^= %s;" % v)
    for v in use_order:
        L.append("  p += %s;" % v)
    L.append("  return p;")
    L.append("}")
    return "\n".join(L) + "\n"


def main():
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 4
    V = [chr(ord('a') + i) for i in range(n)]
    rev, rot = list(reversed(V)), V[1:] + V[:1]
    cases = [
        ("BASE            ", V, V),
        ("decl=rev use=id ", rev, V),
        ("decl=rot use=id ", rot, V),
        ("decl=id  use=rev", V, rev),
        ("decl=id  use=rot", V, rot),
    ]
    for lane, desc in LANES:
        print("=" * 78)
        print("LANE %s : %s   (single basic block, n=%d)" % (lane, desc, n))
        base = None
        for i, (tag, d, u) in enumerate(cases):
            src = gen(d, u, V)
            s, lreg, greg, err = compile_dump(src, lane, "loc%d_%s_%d"
                                              % (n, lane, i))
            if not s:
                print("  %-18s COMPILE FAILED %s" % (tag, err[-160:]))
                continue
            body = "\n".join(l for l in s.splitlines()
                             if not l.startswith("\t.file"))
            if base is None:
                base = body
            vr = {}
            for mm in LOADG.finditer(s):
                reg = mm.group(1) or mm.group(3)
                idx = int(mm.group(2) or mm.group(4))
                vr.setdefault(V[idx], reg)
            info = ["p%s(r%s/l%s/blk%s)" % mm.groups()[:4] for mm in RX.finditer(lreg)]
            print("  %-18s %-14s %s" %
                  (tag, "SAME-CODE" if body == base else "CODE-DIFFERS <==",
                   " ".join("%s=$%s" % (v, vr.get(v, "?")) for v in V)))
            print("        %s" % " ".join(info))


main()

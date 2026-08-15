"""W64-A22 MISSION A/1d -- the EXACT-TIE global-allocno decl probe.

1c showed multi-block locals become global allocnos but their live lengths were
staggered by the birth order, so allocno_compare never reached its tie-break.
Here the DEATH stagger is made to match the BIRTH stagger (same use order in the
last block as the definition order), which makes REG_LIVE_LENGTH *identical* for
every local -- an exact allocno_compare tie, where global.c's last line
`return v1 - v2` (ALLOCNO NUMBER == pseudo number == declaration order) is the
only thing left to decide the serving order.
"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from declab import compile_dump, NAME  # noqa: E402

LANES = [("cpp", "CC1PLPSX 2.8.0 C++"), ("c272", "CC1PSX 2.7.2 C"),
         ("c280", "CC1PSX 2.8.0 C"),
         ("c281", "FSF gcc-2.8.1-psx cc1"),
         ("c272b", "FSF gcc-2.7.2-970404-psx cc1")]
RX = re.compile(r"Register (\d+) used (\d+) times across (\d+) insns"
                r"(?: in block (\d+))?;([^\n]*)")
LOADG = re.compile(r"lw\t\$(\w+),%lo\(G(\d)\)|lw\t\$(\w+),G(\d)")


FLAT = os.environ.get("W64A22_FLAT")


def _use(v, ind):
    """FLAT: a 1-insn use (equal birth/death stagger -> EXACT live-length tie)."""
    return ("%sp ^= %s;" % (ind, v)) if FLAT else ("%sp += sink(%s);" % (ind, v))


def gen(order, n, nuse):
    V = [chr(ord('a') + i) for i in range(n)]
    L = ["int G0,G1,G2,G3,G4,G5;", "int sink(int);", "", "int f(int p,int q) {"]
    for v in order:
        L.append("  int %s;" % v)
    for i, v in enumerate(V):                       # births: a,b,c...
        L.append("  %s = G%d;" % (v, i))
    L.append("  if (q) {")
    for k in range(nuse):
        for v in V:
            L.append(_use(v, "    "))
    L.append("  }")
    for v in V:                                     # deaths: a,b,c... (same stagger)
        L.append(_use(v, "  "))
    L.append("  return p;")
    L.append("}")
    return "\n".join(L) + "\n"


def main():
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 4
    nuse = int(sys.argv[2]) if len(sys.argv) > 2 else 1
    V = [chr(ord('a') + i) for i in range(n)]
    perms = [("id", list(V)), ("rev", list(reversed(V)))]
    if n >= 3:
        perms.append(("rot", V[1:] + V[:1]))
    for lane, desc in LANES:
        print("=" * 78)
        print("LANE %s : %s  (n=%d, %d in-arm use rounds)" % (lane, desc, n, nuse))
        base = None
        for tag, order in perms:
            src = gen(order, n, nuse)
            s, lreg, greg, err = compile_dump(src, lane,
                                              "tie%d_%s_%s" % (n, lane, tag))
            if not s:
                print("  %-5s COMPILE FAILED %s" % (tag, err[-200:]))
                continue
            body = "\n".join(l for l in s.splitlines()
                             if not l.startswith("\t.file"))
            if base is None:
                base = body
            glob = []
            for mm in RX.finditer(lreg):
                p, refs, live, blk = (int(mm.group(1)), int(mm.group(2)),
                                      int(mm.group(3)), mm.group(4))
                if blk is None:
                    glob.append("p%d(r%d/l%d)" % (p, refs, live))
            m = re.search(r";; (\d+) regs to allocate: ([^\n]*)", greg)
            vr = {}
            for mm in LOADG.finditer(s):
                reg = mm.group(1) or mm.group(3)
                idx = int(mm.group(2) or mm.group(4))
                vr.setdefault(V[idx], reg)
            print("  %-5s %s" % (tag, "SAME-CODE" if body == base
                                 else "CODE-DIFFERS  <=="))
            print("        globals   : %s" % " ".join(glob))
            print("        greg order: %s" % (m.group(2).strip() if m else "-"))
            print("        var->reg  : %s"
                  % " ".join("%s=$%s" % (v, vr.get(v, "?")) for v in V))


main()

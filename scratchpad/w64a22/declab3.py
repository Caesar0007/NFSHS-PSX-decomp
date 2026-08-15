"""W64-A22 MISSION A/1c -- the GLOBAL-ALLOCNO decl-order tie-break probe.

1a proved pseudo NUMBER == declaration order; 1b proved that for BLOCK-LOCAL
pseudos (local-alloc qtys) the decl permutation is code-inert even at equal refs.
1c targets the other layer: pseudos live in MORE THAN ONE basic block become
global allocnos (global.c:385-398 numbers them by ASCENDING PSEUDO NUMBER), and
allocno_compare's last line is `return v1 - v2` -- an ALLOCNO-NUMBER tie-break.
So a decl permutation should move the code IFF two global allocnos tie exactly.

The symmetric-arm construction below gives two locals identical REG_N_REFS and
identical REG_LIVE_LENGTH (each is used first in one arm and second in the other).
"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from declab import compile_dump, NAME  # noqa: E402

LANES = [("cpp", "CC1PLPSX 2.8.0 C++"), ("c272", "CC1PSX 2.7.2 C"),
         ("c280", "CC1PSX 2.8.0 C")]


def gen_sym(order, n):
    """n symmetric locals: each used first in one arm, in rotation."""
    V = [chr(ord('a') + i) for i in range(n)]
    L = ["int G0,G1,G2,G3,G4,G5;", "int sink(int);", "", "int f(int p,int q) {"]
    for v in order:
        L.append("  int %s;" % v)
    for i, v in enumerate(V):
        L.append("  %s = G%d;" % (v, i))
    for k in range(n):                 # n arms, each a rotation of the use order
        L.append("  %s (q == %d) {" % ("if" if k == 0 else "else if", k))
        for j in range(n):
            L.append("    p += sink(%s);" % V[(k + j) % n])
        L.append("  }")
    L.append("  return p;")
    L.append("}")
    return "\n".join(L) + "\n"


def floor_log2(x):
    r = -1
    while x:
        x >>= 1
        r += 1
    return r


RX = re.compile(r"Register (\d+) used (\d+) times across (\d+) insns"
                r"(?: in block (\d+))?;([^\n]*)")


def main():
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 3
    V = [chr(ord('a') + i) for i in range(n)]
    perms = [("id", list(V)), ("rev", list(reversed(V)))]
    if n >= 3:
        perms.append(("rot", V[1:] + V[:1]))
    for lane, desc in LANES:
        print("=" * 78)
        print("LANE %s : %s   (n=%d symmetric locals)" % (lane, desc, n))
        base = None
        for tag, order in perms:
            src = gen_sym(order, n)
            s, lreg, greg, err = compile_dump(src, lane, "sym%d_%s_%s"
                                              % (n, lane, tag))
            if not s:
                print("  %-6s COMPILE FAILED %s" % (tag, err[-200:]))
                continue
            body = "\n".join(l for l in s.splitlines()
                             if not l.startswith("\t.file"))
            if base is None:
                base = body
            m = re.search(r";; (\d+) regs to allocate: ([^\n]*)", greg)
            pri = []
            for mm in RX.finditer(lreg):
                p, refs, live = int(mm.group(1)), int(mm.group(2)), int(mm.group(3))
                blk = mm.group(4)
                if blk is not None:      # block-local => local-alloc qty
                    continue
                pri.append("p%d(r%d/l%d=%d)" % (p, refs, live,
                                                int(floor_log2(refs) * refs
                                                    / float(live) * 10000)))
            disp = {}
            if "Register dispositions" in greg:
                for mm in re.finditer(r"(\d+) in (\d+)",
                                      greg.split("Register dispositions:")[-1]):
                    disp[int(mm.group(1))] = int(mm.group(2))
            dtxt = " ".join("p%d->%s" % (k, NAME[v] if v < 32 else v)
                            for k, v in sorted(disp.items()))
            print("  %-5s %s" % (tag, "SAME-CODE" if body == base
                                 else "CODE-DIFFERS  <=="))
            print("        greg order: %s" % (m.group(2).strip() if m else "-"))
            print("        globals   : %s" % " ".join(pri))
            print("        disp      : %s" % dtxt)


main()

"""W64-A22 MISSION A/1f -- the MEMORY-LOCAL half of the 13A claim.

stmt.c:3592-3617's register arm is gated on `! TREE_ADDRESSABLE (decl)` and
`! TREE_THIS_VOLATILE (decl)` and `DECL_MODE != BLKmode`; anything failing those
falls to the `assign_stack_local`/`assign_stack_temp` arms further down, i.e. a
FRAME SLOT handed out at the declaration.  Probe: permute the declarations of
(1) address-taken scalars, (2) arrays (BLKmode), and read each object's sp offset
out of the emitted .s.
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
# `sinkp(&x)` argument setup: addiu $4,$sp,<off>  (calls appear in V order)
SPARG = re.compile(r"add[iu]+\t\$4,\$sp,(-?\d+)")


def gen(kind, order, V):
    L = ["int sinkp(int*);", "", "int f(int p) {"]
    for v in order:
        if kind == "addr":
            L.append("  int %s;" % v)
        else:                       # BLKmode: arrays
            L.append("  int %s[2];" % v)
    for i, v in enumerate(V):
        L.append("  %s%s = p + %d;" % (v, "" if kind == "addr" else "[0]", i))
    for v in V:
        L.append("  sinkp(%s%s);" % ("&" if kind == "addr" else "", v))
    L.append("  return p;")
    L.append("}")
    return "\n".join(L) + "\n"


def main():
    n = 4
    V = [chr(ord('a') + i) for i in range(n)]
    perms = [("decl=id ", V), ("decl=rev", list(reversed(V))),
             ("decl=rot", V[1:] + V[:1])]
    for kind in ("addr", "array"):
        for lane, desc in LANES:
            print("=" * 78)
            print("LANE %s : %s   kind=%s" % (lane, desc, kind))
            for tag, order in perms:
                src = gen(kind, order, V)
                s, lreg, greg, err = compile_dump(src, lane,
                                                  "mem_%s_%s_%s"
                                                  % (kind, lane, tag[-3:].strip()))
                if not s:
                    print("  %-9s COMPILE FAILED %s" % (tag, err[-160:]))
                    continue
                offs = [int(m.group(1)) for m in SPARG.finditer(s)]
                print("  %-9s  frame slots: %s"
                      % (tag, " ".join("%s=sp+%d" % (v, o)
                                       for v, o in zip(V, offs))))


main()

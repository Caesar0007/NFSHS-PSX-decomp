"""W64-A22 MISSION A/1b -- the EQUAL-PRIORITY decl-order tie-break probe.

run_declab.py (probe 1a) gave every local a DISTINCT ref count so it could be
identified in the .lreg dump -- which also removed the very tie the 13A claim is
about ("BOTH allocator layers TIE-BREAK BY NUMBER").  1b restores the tie:
all five scalars get IDENTICAL ref counts and near-identical live ranges, and the
variable->register map is read straight out of the .s (each var is loaded from its
own global G0..G4, so `lw $r,%lo(Gn)` names it).

Probes:
  eqglob : call-crossing  -> global allocnos (global.c allocno_compare tie)
  eqloc  : straight line  -> local-alloc qtys (local-alloc.c QTY_CMP_PRI tie)
  addr   : &x escapes     -> memory locals (reload1.c frame-slot order)
"""
import os
import re
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from declab import compile_dump, parse, NAME  # noqa: E402

VARS = ["a", "b", "c", "d", "e"]
PERMS = [
    ("decl_abcde", ["a", "b", "c", "d", "e"]),
    ("decl_edcba", ["e", "d", "c", "b", "a"]),
    ("decl_cadbe", ["c", "a", "d", "b", "e"]),
    ("decl_bcdea", ["b", "c", "d", "e", "a"]),
]
LANES = [("cpp", "CC1PLPSX 2.8.0 C++ (-fno-exceptions -fno-rtti -G4)"),
         ("c272", "CC1PSX 2.7.2 C (-G0 -mgas)"),
         ("c280", "CC1PSX 2.8.0 C (-G4)")]
N_USE = 3            # SAME for every variable  -> equal REG_N_REFS


def gen(kind, order):
    L = ["int G0,G1,G2,G3,G4;", "int sink(int);", "int sinkp(int*);", "",
         "int f(int p) {"]
    for v in order:
        L.append("  int %s;" % v)
    for i, v in enumerate(VARS):                 # first-use order FIXED
        L.append("  %s = G%d;" % (v, i))
    if kind == "addr":
        for v in VARS:
            L.append("  sinkp(&%s);" % v)
    for _ in range(N_USE):                       # equal refs, symmetric uses
        for v in VARS:
            if kind == "eqloc":
                L.append("  p += %s;" % v)
            else:
                L.append("  p += sink(%s);" % v)
    L.append("  return p;")
    L.append("}")
    return "\n".join(L) + "\n"


LOADG = re.compile(r"lw\t\$(\w+),%lo\(G(\d)\)|lw\t\$(\w+),G(\d)")
SPADDR = re.compile(r"addiu\t\$4,\$sp,(-?\d+)")


def var_regs(s):
    """var -> hard reg, read from `lw $r,%lo(Gn)` (first-use order is fixed)."""
    out = {}
    for m in LOADG.finditer(s):
        reg = m.group(1) or m.group(3)
        idx = int(m.group(2) or m.group(4))
        out.setdefault(VARS[idx], reg)
    return out


def var_slots(s):
    """var -> sp offset, read from the sinkp(&x) argument setup (call order)."""
    offs = [int(m.group(1)) for m in SPADDR.finditer(s)]
    return dict(zip(VARS, offs))


def strip(s):
    return "\n".join(l for l in s.splitlines() if not l.startswith("\t.file"))


def main():
    for lane, desc in LANES:
        print("=" * 78)
        print("LANE %s : %s" % (lane, desc))
        for kind in ("eqglob", "eqloc", "addr"):
            print("-" * 78)
            print("  PROBE kind=%s  (equal refs=%d for every local)" % (kind, N_USE))
            base = None
            for tag, order in PERMS:
                src = gen(kind, order)
                s, lreg, greg, err = compile_dump(src, lane,
                                                  "eq_%s_%s_%s" % (lane, kind, tag))
                if not s:
                    print("    %-12s COMPILE FAILED %s" % (tag, err[-150:]))
                    continue
                body = strip(s)
                if base is None:
                    base = body
                same = "SAME-CODE " if body == base else "CODE-DIFFERS"
                m = re.search(r";; (\d+) regs to allocate: ([^\n]*)", greg)
                order_line = m.group(2).strip() if m else "-"
                info = var_regs(s)
                if kind == "addr":
                    info = var_slots(s)
                print("    %-12s %s  %s" %
                      (tag, same,
                       " ".join("%s=%s" % (v, info.get(v, "?")) for v in VARS)))
                print("                 greg priority order: %s" % order_line)


main()

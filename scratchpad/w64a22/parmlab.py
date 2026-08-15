"""W64-A22 MISSION A/2 -- the W46 PROLOGUE PARAM-COPY SINK boundary lab.

W46 parked: "assign_parms emits before any statement -- no source position or
fence reaches it; only sched dependence-chain depth can."
W47-a1 partially retired it (a fence on the param pins the copy at retail's
prologue position -- FILE_callbackop).
tenchu cookbook 3.13 (FUN_80057b80) claims a FENCE-FREE cure: introduce ordinary
local copies of the formals and use the LOCALS throughout -- "`param_2 = arg_2;
param_1 = arg_1;` coalesces to the same bare `move s1,a1` / `move s0,a0` while
RETAINING LOCAL-ASSIGNMENT ORDER".
W64-A2 FALSIFIED that cure on BuildCustomObjectFacets (4 forms; the copies were
copy-propagated away, only the coloring rotated).

This lab reproduces the minimal situation and asks the narrow question:
  WHAT does the local-copy device actually move, and when is it inert?
Measured per variant: every callee-saved <- arg-reg copy, IN EMISSION ORDER,
with the instruction index so a delay-slot sink is visible.
"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from declab import compile_dump  # noqa: E402

LANES = [("cpp", "CC1PLPSX 2.8.0 C++"), ("c272", "CC1PSX 2.7.2 C"),
         ("c280", "CC1PSX 2.8.0 C"),
         ("c281", "FSF gcc-2.8.1-psx cc1 (tenchu's lane)"),
         ("c272b", "FSF gcc-2.7.2-970404-psx cc1 (LoM's lane)")]
MOVE = re.compile(r"^\t(?:move|addu|or)\t\$(\d+),\$([4-7])(?:,\$0)?$")

H = "int h(int);\nint k(int,int);\n\n"
TAIL = ("  r = 0;\n"
        "  r += h(*x);\n"
        "  r += h(*y);\n"
        "  r += k(*x, *y);\n"
        "  return r;\n}\n")

VARIANTS = {
    # (a) natural: formals used directly
    "a_direct": H + "int f(int *x,int *y) {\n  int r;\n" + TAIL,
    # (b) tenchu's device, local copies assigned x then y
    "b_locals_xy": H + "int f(int *x0,int *y0) {\n  int r;\n"
                       "  int *x;\n  int *y;\n  x = x0;\n  y = y0;\n" + TAIL,
    # (c) tenchu's device with the ASSIGNMENT ORDER REVERSED (the claimed dial)
    "c_locals_yx": H + "int f(int *x0,int *y0) {\n  int r;\n"
                       "  int *x;\n  int *y;\n  y = y0;\n  x = x0;\n" + TAIL,
    # (d) as (c) but the DECLARATIONS are reversed too
    "d_decl_yx": H + "int f(int *x0,int *y0) {\n  int r;\n"
                     "  int *y;\n  int *x;\n  y = y0;\n  x = x0;\n" + TAIL,
    # (e) decl-with-init form of (b)
    "e_init_xy": H + "int f(int *x0,int *y0) {\n  int r;\n"
                     "  int *x = x0;\n  int *y = y0;\n" + TAIL,
    # (f) decl-with-init form of (c)
    "f_init_yx": H + "int f(int *x0,int *y0) {\n  int r;\n"
                     "  int *y = y0;\n  int *x = x0;\n" + TAIL,
    # (g) BODY first-use flipped (the use-order dial, no local copies)
    "g_useflip": H + "int f(int *x,int *y) {\n  int r;\n"
                     "  r = 0;\n  r += h(*y);\n  r += h(*x);\n"
                     "  r += k(*x, *y);\n  return r;\n}\n",
    # (h) read-only fence on the SECOND formal, before any statement
    "h_fence_y": H + "int f(int *x,int *y) {\n  int r;\n"
                     "  __asm__(\"\" : : \"r\"(y));\n" + TAIL,
    # (i) read-only fence on the FIRST formal, before any statement
    "i_fence_x": H + "int f(int *x,int *y) {\n  int r;\n"
                     "  __asm__(\"\" : : \"r\"(x));\n" + TAIL,
    # (j) fence on BOTH, y first (order-of-operands dial)
    "j_fence_yx": H + "int f(int *x,int *y) {\n  int r;\n"
                      "  __asm__(\"\" : : \"r\"(y), \"r\"(x));\n" + TAIL,
    # (k)/(l) MULTI-SET locals: a second SET defeats copy propagation, so the
    # first assignment survives as a real RTL copy (13B/15B "the copy IS the
    # mechanism").  The honest boundary test for tenchu's fence-free device.
    "k_multiset_xy": H + "int f(int *x0,int *y0) {\n  int r;\n"
                         "  int *x;\n  int *y;\n  x = x0;\n  y = y0;\n"
                         "  r = 0;\n  r += h(*x);\n  r += h(*y);\n"
                         "  x = x0 + 1;\n  y = y0 + 1;\n"
                         "  r += k(*x, *y);\n  return r;\n}\n",
    "l_multiset_yx": H + "int f(int *x0,int *y0) {\n  int r;\n"
                         "  int *x;\n  int *y;\n  y = y0;\n  x = x0;\n"
                         "  r = 0;\n  r += h(*x);\n  r += h(*y);\n"
                         "  x = x0 + 1;\n  y = y0 + 1;\n"
                         "  r += k(*x, *y);\n  return r;\n}\n",
    # (m)/(n) identity-LAUNDERED local copies (13B), both orders
    "m_laund_xy": H + "int f(int *x0,int *y0) {\n  int r;\n"
                      "  int *x = x0;\n  int *y = y0;\n"
                      "  __asm__(\"\" : \"=r\"(x) : \"0\"(x));\n"
                      "  __asm__(\"\" : \"=r\"(y) : \"0\"(y));\n" + TAIL,
    "n_laund_yx": H + "int f(int *x0,int *y0) {\n  int r;\n"
                      "  int *y = y0;\n  int *x = x0;\n"
                      "  __asm__(\"\" : \"=r\"(y) : \"0\"(y));\n"
                      "  __asm__(\"\" : \"=r\"(x) : \"0\"(x));\n" + TAIL,
}


def moves(s):
    out, idx = [], 0
    started = False
    for ln in s.splitlines():
        if ln.startswith("f__F") or ln == "f:":
            started = True
            continue
        if not started:
            continue
        if ln.startswith("\t.end"):
            break
        if ln.startswith("\t") and not ln.startswith("\t."):
            idx += 1
            m = MOVE.match(ln)
            if m:
                out.append("#%d $%s<-$%s" % (idx, m.group(1), m.group(2)))
    return out


def main():
    for lane, desc in LANES:
        print("=" * 78)
        print("LANE %s : %s" % (lane, desc))
        base = None
        for tag in sorted(VARIANTS):
            s, lreg, greg, err = compile_dump(VARIANTS[tag], lane,
                                              "parm2_%s_%s" % (lane, tag))
            if not s or "\t.end" not in s:
                print("  %-12s COMPILE FAILED %s" % (tag, err.strip()[-200:]))
                continue
            body = "\n".join(l for l in s.splitlines()
                             if not l.startswith("\t.file"))
            if base is None:
                base = body
            print("  %-12s %-10s copies: %s"
                  % (tag, "SAME" if body == base else "DIFFERS",
                     " ; ".join(moves(s)) or "(none)"))


main()

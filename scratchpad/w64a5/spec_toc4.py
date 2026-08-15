import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from spec_toc import TU, FUNC, BASE, M
from spec_toc2 import HEAD, DO, P0, CALL, ST, INC, END, mk

F = lambda *ops: '__asm__("" : : %s);' % ", ".join('"r"(%s)' % o for o in ops)
FL = F("loc")


def mk2(before_i=(), pre=(), a=(), after=()):
    """before_i: statements emitted before `i = 1;` (loop depth 0)."""
    s = ""
    for l in before_i:
        s += "    " + l + "\n"
    s += HEAD
    for l in pre:
        s += "        " + l + "\n"
    s += DO
    for l in a:
        s += "            " + l + "\n"
    s += P0 + CALL + ST + INC + END
    for l in after:
        s += "    " + l + "\n"
    return s


G = [F("magic", "track_first"), M]

VARIANTS = {
    "ctl":        BASE,
    "T1_pre":     mk2(pre=[FL], a=G),
    "T2_beforei": mk2(before_i=[FL], a=G),
    "T3_after":   mk2(a=G, after=[FL]),
    "T4_pre2":    mk2(pre=[FL, FL], a=G),
    # semantically-clean twin: magic also initialised in the preheader
    "U1_pre":     mk2(pre=[M, FL], a=G),
    "U2_pre":     mk2(pre=[FL, M], a=G),
}

import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from spec_toc import TU, FUNC, BASE, M
from spec_toc2 import HEAD, DO, P0, CALL, ST, INC

F = lambda *ops: '__asm__("" : : %s);' % ", ".join('"r"(%s)' % o for o in ops)
TF = "track_first"


def mk4(a=(), post=(), after=()):
    """post = statements after the do-while but INSIDE the guard."""
    s = HEAD + DO
    for l in a:
        s += "            " + l + "\n"
    s += P0 + CALL + ST + INC
    s += "        } while (track_first <= track_last);\n"
    for l in post:
        s += "        " + l + "\n"
    s += "    }\n"
    for l in after:
        s += "    " + l + "\n"
    return s


VARIANTS = {
    "ctl":  BASE,
    "W2b":  mk4(a=[M, F(TF)], post=[F("magic", TF)]),
    "W3b":  mk4(a=[M, F(TF, TF)], post=[F("magic")]),
    "W2c":  mk4(a=[M, F(TF)], post=[F(TF, "magic")]),
}

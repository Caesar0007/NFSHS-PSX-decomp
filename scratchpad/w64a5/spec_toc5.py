import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from spec_toc import TU, FUNC, BASE, M
from spec_toc2 import HEAD, DO, P0, CALL, ST, INC, END

F = lambda *ops: '__asm__("" : : %s);' % ", ".join('"r"(%s)' % o for o in ops)


def mk3(before_i=(), pre=(), a=(), b=(), after=()):
    s = ""
    for l in before_i:
        s += "    " + l + "\n"
    s += HEAD
    for l in pre:
        s += "        " + l + "\n"
    s += DO
    for l in a:
        s += "            " + l + "\n"
    s += P0
    for l in b:
        s += "            " + l + "\n"
    s += CALL + ST + INC + END
    for l in after:
        s += "    " + l + "\n"
    return s


TF = "track_first"
VARIANTS = {
    "ctl":       BASE,
    "W1":        mk3(a=[M, F(TF)], after=[F("magic")]),
    "W2":        mk3(a=[M, F(TF)], after=[F("magic", TF)]),
    "W3":        mk3(a=[M, F(TF, TF)], after=[F("magic")]),
    "W4":        mk3(a=[M], b=[F(TF)], after=[F("magic")]),
    "W5":        mk3(pre=[F("loc")], a=[M, F(TF)], after=[F("magic")]),
    "W6":        mk3(a=[M, F(TF)], after=[F("magic"), F("loc")]),
    "W7":        mk3(a=[M, F(TF)], after=[F("magic", "loc")]),
    "W8":        mk3(a=[M, F(TF)], after=[F("magic", "magic")]),
}

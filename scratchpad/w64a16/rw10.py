"""Round 10: X1 basin -- fence POSITION x OPERAND sweep (06B: placement != choice)."""
import sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "..", "tools"))
import fast
import rw4

SRC, FN = rw4.SRC, rw4.FN
IF0 = b"    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {\n"
DRAWT = b"      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);\n"
SET = b"      pc = (u_char **)0x1f800004;\n"
RDJ = b"    daprim = (DR_AREA *)*pc;\n"
ARMS_NOFENCE = IF0 + DRAWT + SET + b"    }\n    else {\n" + SET + b"    }\n" + RDJ
RX = b"    r.x = 0;\n"
RY = b"    r.y = *(short *)((char *)drenv + 2) + this->fYOffset;\n"
RH = b"    r.h = height;\n"
TAIL_END = b"""    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    *pc = (u_char *)daprim + 0xc;
"""
TAIL_OLD = b"""    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    Render_gPacketPtr = (u_char *)daprim + 0xc;
"""

OPS = {"d": b"\"r\" (daprim)", "dp": b"\"r\" (daprim), \"r\" (pc)",
       "ddd": b"\"r\" (daprim), \"r\" (daprim), \"r\" (daprim)"}
V = {}
for ok, ops in OPS.items():
    f = b"    __asm__ (\"\" : : " + ops + b");\n"
    V["P-read  " + ok] = [rw4.FNDECL, (rw4.ARMS, ARMS_NOFENCE + f), (TAIL_OLD, TAIL_END)]
    V["P-afterX " + ok] = [rw4.FNDECL, (rw4.ARMS, ARMS_NOFENCE), (RX, RX + f), (TAIL_OLD, TAIL_END)]
    V["P-afterY " + ok] = [rw4.FNDECL, (rw4.ARMS, ARMS_NOFENCE), (RY, RY + f), (TAIL_OLD, TAIL_END)]
    V["P-afterH " + ok] = [rw4.FNDECL, (rw4.ARMS, ARMS_NOFENCE), (RH, RH + f), (TAIL_OLD, TAIL_END)]

if __name__ == "__main__":
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    sel = {k: v for k, v in V.items() if not only or any(o in k for o in only)}
    fast.run(SRC, FN, "tFEApplication::Redraw", sel, gval="0", dump=False)

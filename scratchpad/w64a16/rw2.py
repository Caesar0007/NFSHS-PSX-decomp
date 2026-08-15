"""W64-A16 Redraw ladder round 2: struct-view cell BASED AT 0x1F800004."""
import sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "..", "tools"))
import fast

SRC = "recon/frontend/common/feapp.cpp"
FN = "Redraw__14tFEApplication"

ARMS = b"""    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {
      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);
      daprim = (DR_AREA *)Render_gPacketPtr;
    }
    else {
      daprim = (DR_AREA *)Render_gPacketPtr;
    }
"""
STORE = b"    Render_gPacketPtr = (u_char *)daprim + 0xc;\n"
IF0 = b"    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {\n"
DRAWT = b"      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);\n"
TD = (b"typedef struct tPktCell { u_char *pkt; } tPktCell;\n"
      b"typedef struct tPsyQPrimTag {")
TDA = b"typedef struct tPsyQPrimTag {"
SET = b"      pc = (tPktCell *)0x1f800004;\n"
RDJ = b"    daprim = (DR_AREA *)pc->pkt;\n"
STJ = b"    pc->pkt = (u_char *)daprim + 0xc;\n"

V = {}

# P1 armdup set, join read, block decl before the if
V["P1 armdup blockdecl"] = [
    (TDA, TD),
    (ARMS, b"    tPktCell *pc;\n" + IF0 + DRAWT + SET + b"    }\n    else {\n" + SET + b"    }\n" + RDJ),
    (STORE, STJ)]

# P2 armdup set + read inside both arms
V["P2 armdup set+read"] = [
    (TDA, TD),
    (ARMS, b"    tPktCell *pc;\n" + IF0 + DRAWT + SET + b"  " + RDJ +
     b"    }\n    else {\n" + SET + b"  " + RDJ + b"    }\n"),
    (STORE, STJ)]

# P3 single join set + identity fence AFTER the read
V["P3 joinset fence-after-read"] = [
    (TDA, TD),
    (ARMS, IF0 + DRAWT + b"    }\n    tPktCell *pc = (tPktCell *)0x1f800004;\n" + RDJ +
     b"    __asm__ (\"\" : \"=r\" (pc) : \"0\" (pc));\n"),
    (STORE, STJ)]

# P4 single join set, NO device (control: does loop.c hoist it?)
V["P4 joinset plain"] = [
    (TDA, TD),
    (ARMS, IF0 + DRAWT + b"    }\n    tPktCell *pc = (tPktCell *)0x1f800004;\n" + RDJ),
    (STORE, STJ)]

# P5 armdup, decl at the TOP of the loop body variables (fn scope decl list)
V["P5 armdup fnscope-decl"] = [
    (TDA, TD),
    (b"  DR_AREA *daprim;\n", b"  DR_AREA *daprim;\n  tPktCell *pc;\n"),
    (ARMS, IF0 + DRAWT + SET + b"    }\n    else {\n" + SET + b"    }\n" + RDJ),
    (STORE, STJ)]

# P6 armdup, store spelled through a SECOND struct pointer set in the same arms
V["P6 armdup + arm-read"] = [
    (TDA, TD),
    (ARMS, b"    tPktCell *pc;\n" + IF0 + DRAWT + SET + b"    }\n    else {\n" + SET + b"    }\n"
     + b"    daprim = (DR_AREA *)pc->pkt;\n"),
    (STORE, b"    pc->pkt = (u_char *)daprim + 0xc;\n")]

if __name__ == "__main__":
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    sel = {k: v for k, v in V.items() if not only or any(o in k for o in only)}
    fast.run(SRC, FN, "tFEApplication::Redraw", sel, gval="0", dump=False)

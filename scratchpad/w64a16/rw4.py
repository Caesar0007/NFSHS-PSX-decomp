"""W64-A16 Redraw round 4: ONE fn-scope cell shared by BOTH packet blocks
(no net new pseudo vs base) + arm-duplicated set in the loop (no LICM movable)."""
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
SET = b"      pc = (u_char **)0x1f800004;\n"
RDJ = b"    daprim = (DR_AREA *)*pc;\n"
STJ = b"    *pc = (u_char *)daprim + 0xc;\n"

B1_DECL = b"  u_char **packetCell = (u_char **)0x1f800004;\n"
B1_RD = b"  daprim = (DR_AREA *)*packetCell;\n"
B1_ST = b"  *packetCell = (u_char *)daprim + 0xc;\n"

LOOP = [(ARMS, IF0 + DRAWT + SET + b"    }\n    else {\n" + SET + b"    }\n" + RDJ), (STORE, STJ)]
FNDECL = (b"  RECT r;\n", b"  RECT r;\n  u_char **pc;\n")
B1_USE_PC = [(B1_DECL, b"  pc = (u_char **)0x1f800004;\n"),
             (B1_RD, b"  daprim = (DR_AREA *)*pc;\n"),
             (B1_ST, b"  *pc = (u_char *)daprim + 0xc;\n")]

V = {}
V["W1 shared fn-scope cell"] = [FNDECL] + B1_USE_PC + LOOP
# W2: same, but drop block1's now-empty braces (removes a NOTE_INSN_BLOCK)
V["W2 shared, b1 braces dropped"] = [FNDECL] + B1_USE_PC + LOOP + [
    (b"  {\n  pc = (u_char **)0x1f800004;\n", b"  pc = (u_char **)0x1f800004;\n  {\n")]
# W3: block1 keeps its OWN block-local cell; loop uses fn-scope pc (= R d3, control)
V["W3 separate cells (control)"] = [FNDECL] + LOOP
# W4: shared cell, and the loop's read stays in BOTH arms
V["W4 shared + arm reads"] = [FNDECL] + B1_USE_PC + [
    (ARMS, IF0 + DRAWT + SET + b"  " + RDJ + b"    }\n    else {\n" + SET + b"  " + RDJ + b"    }\n"),
    (STORE, STJ)]

if __name__ == "__main__":
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    sel = {k: v for k, v in V.items() if not only or any(o in k for o in only)}
    fast.run(SRC, FN, "tFEApplication::Redraw", sel, gval="0", dump=False)

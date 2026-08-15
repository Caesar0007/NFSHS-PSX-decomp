"""Round 6: NO cell variable at all -- just move the macro READ to the JOIN so the
read and the store land in ONE basic block (block-1's shape) and cse commons the
constant address into a register."""
import sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "..", "tools"))
import fast
import rw4

SRC, FN = rw4.SRC, rw4.FN
IF0 = b"    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {\n"
DRAWT = b"      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);\n"
RDJ = b"    daprim = (DR_AREA *)Render_gPacketPtr;\n"

V = {
    # J1: bare if (no else), macro read at the join
    "J1 join macro read": [(rw4.ARMS, IF0 + DRAWT + b"    }\n" + RDJ)],
    # J2: keep the else (empty) for shape parity
    "J2 join read, else kept": [(rw4.ARMS, IF0 + DRAWT + b"    }\n    else {\n    }\n" + RDJ)],
}
if __name__ == "__main__":
    fast.run(SRC, FN, "tFEApplication::Redraw", V, gval="0", dump=False)

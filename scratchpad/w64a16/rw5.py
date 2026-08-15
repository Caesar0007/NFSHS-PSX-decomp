"""Round 5: keep pseudo COUNT at base -- block1 back to the literal macro,
fn-scope cell used only in the loop (arm-duplicated set)."""
import sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "..", "tools"))
import fast
import rw4

SRC, FN = rw4.SRC, rw4.FN
B1_MACRO = [(rw4.B1_DECL, b""),
            (rw4.B1_RD, b"  daprim = (DR_AREA *)Render_gPacketPtr;\n"),
            (rw4.B1_ST, b"  Render_gPacketPtr = (u_char *)daprim + 0xc;\n")]
V = {
    "W5 b1 macro + loop cell": [rw4.FNDECL] + B1_MACRO + rw4.LOOP,
    "W6 b1 macro only (control)": B1_MACRO,
}
if __name__ == "__main__":
    fast.run(SRC, FN, "tFEApplication::Redraw", V, gval="0", dump=False)

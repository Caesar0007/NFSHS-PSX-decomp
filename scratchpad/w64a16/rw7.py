"""Round 7: R-d3 basin (arm-dup fn-scope cell, address window CORRECT) +
dials aimed at the ONE remaining cause -- daprim losing $a0 to the extra pseudo."""
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
STJ = b"    *pc = (u_char *)daprim + 0xc;\n"
BASE = [rw4.FNDECL,
        (rw4.ARMS, IF0 + DRAWT + SET + b"    }\n    else {\n" + SET + b"    }\n" + RDJ),
        (rw4.STORE, STJ)]


def var(extra_read, tag):
    pairs = [rw4.FNDECL,
             (rw4.ARMS, IF0 + DRAWT + SET + b"    }\n    else {\n" + SET + b"    }\n" + RDJ + extra_read),
             (rw4.STORE, STJ)]
    return tag, pairs


V = dict([
    var(b"", "X0 control (R d3)"),
    var(b"    __asm__ (\"\" : : \"r\" (daprim));\n", "X1 ro-fence on daprim"),
    var(b"    __asm__ (\"\" : : \"r\" (daprim), \"r\" (daprim));\n", "X1b ro-fence x2"),
    var(b"    __asm__ (\"\" : \"=r\" (daprim) : \"0\" (daprim));\n", "X2 identity fence daprim"),
    var(b"    __asm__ (\"\" : : \"r\" (pc));\n", "X3 ro-fence on pc"),
])
# X4: read spelled through a subscript
V["X4 pc[0] subscript"] = [rw4.FNDECL,
                           (rw4.ARMS, IF0 + DRAWT + SET + b"    }\n    else {\n" + SET + b"    }\n"
                            + b"    daprim = (DR_AREA *)pc[0];\n"),
                           (rw4.STORE, b"    pc[0] = (u_char *)daprim + 0xc;\n")]

if __name__ == "__main__":
    fast.run(SRC, FN, "tFEApplication::Redraw", V, gval="0", dump=False)

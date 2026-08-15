"""W64-A16 tUserNameMenuItem::Draw -- the 156-constant residual.
Hypothesis: retail's `li t0,156` is a RELOAD REMATERIALIZATION of a REG_EQUIV-const
pseudo (emitted immediately before its use, in a spill/reload register), not an
allocated allocno.  Our identity fence kills the REG_EQUIV and forces a real
allocation ($v1).  Probe spellings that keep the const equivalence."""
import sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "..", "tools"))
import fast

SRC = "recon/frontend/common/femenuoptions.cpp"
FN = "Draw__17tUserNameMenuItemb"

B1 = b"""  {
    int boxRight = 0x9c;
    __asm__("" : "=r"(boxRight) : "0"(boxRight));
    PSXDrawSquare(0,x,y + -3,boxRight - shape->width,(int)shape->height);
  }
"""
B2 = b"""  {
    int boxRight = 0x9c;
    __asm__("" : "=r"(boxRight) : "0"(boxRight));
    PSXDrawSquare(0,x,y + 0xc,boxRight - shape->width,(int)shape->height);
  }
"""
P1 = b"  PSXDrawSquare(0,x,y + -3,0x9c - shape->width,(int)shape->height);\n"
P2 = b"  PSXDrawSquare(0,x,y + 0xc,0x9c - shape->width,(int)shape->height);\n"
N1 = b"""  {
    int boxRight = 0x9c;
    PSXDrawSquare(0,x,y + -3,boxRight - shape->width,(int)shape->height);
  }
"""
N2 = b"""  {
    int boxRight = 0x9c;
    PSXDrawSquare(0,x,y + 0xc,boxRight - shape->width,(int)shape->height);
  }
"""

V = {
    "U1 literal both blocks": [(B1, P1), (B2, P2)],
    "U2 unfenced local both": [(B1, N1), (B2, N2)],
    "U3 literal 1st only": [(B1, P1)],
    "U4 literal 2nd only": [(B2, P2)],
    # U5: keep the fence but declare+assign (not decl-with-init) -- 12D decl-with-init demote
    "U5 assign-not-init": [(B1, B1.replace(b"int boxRight = 0x9c;", b"int boxRight;\n    boxRight = 0x9c;")),
                           (B2, B2.replace(b"int boxRight = 0x9c;", b"int boxRight;\n    boxRight = 0x9c;"))],
    # U6: foreign-operand fence (15A) to DEMOTE the constant's serving order
    "U6 foreign fence on shape": [
        (B1, B1.replace(b"__asm__(\"\" : \"=r\"(boxRight) : \"0\"(boxRight));",
                        b"__asm__(\"\" : \"=r\"(boxRight) : \"0\"(boxRight));\n    __asm__(\"\" : : \"r\"(shape));")),
        (B2, B2.replace(b"__asm__(\"\" : \"=r\"(boxRight) : \"0\"(boxRight));",
                        b"__asm__(\"\" : \"=r\"(boxRight) : \"0\"(boxRight));\n    __asm__(\"\" : : \"r\"(shape));"))],
}

if __name__ == "__main__":
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    sel = {k: v for k, v in V.items() if not only or any(o in k for o in only)}
    fast.run(SRC, FN, "tUserNameMenuItem::Draw", sel, gval="0", dump=False)

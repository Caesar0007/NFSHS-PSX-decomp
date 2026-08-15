"""Round 8: X1 basin (14@393, address window PERFECT) -- attack the two residuals:
  (1) fYOffset in $a1 (ours) vs $a2 (retail) + late `addiu a1,sp,56`
  (2) packet store scheduled last (lands in the jal slot) vs retail's early position."""
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
FENCE = b"    __asm__ (\"\" : : \"r\" (daprim));\n"
ARMSNEW = IF0 + DRAWT + SET + b"    }\n    else {\n" + SET + b"    }\n" + RDJ + FENCE

TAIL_OLD = b"""    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    Render_gPacketPtr = (u_char *)daprim + 0xc;
"""
# packet store BETWEEN the two prim-tag statements (retail's asm order)
TAIL_MID = b"""    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr;
    *pc = (u_char *)daprim + 0xc;
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
"""
TAIL_END = b"""    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
    *pc = (u_char *)daprim + 0xc;
"""
BASE = [rw4.FNDECL, (rw4.ARMS, ARMSNEW), (TAIL_OLD, TAIL_END)]

V = {}
V["Y0 control (X1)"] = BASE
V["Y1 packet store between prim stmts"] = [rw4.FNDECL, (rw4.ARMS, ARMSNEW), (TAIL_OLD, TAIL_MID)]
# Y2: also name fYOffset in its own local so it gets its own allocno
V["Y2 mid + yoff local"] = [rw4.FNDECL, (rw4.ARMS, ARMSNEW), (TAIL_OLD, TAIL_MID),
                            (b"    r.y = *(short *)((char *)drenv + 2) + this->fYOffset;\n",
                             b"    { u_char yo = this->fYOffset;\n"
                             b"      r.y = *(short *)((char *)drenv + 2) + yo; }\n")]
# Y3: fence operand = daprim twice (more refs)
V["Y3 mid + fence x2"] = [rw4.FNDECL,
                          (rw4.ARMS, ARMSNEW.replace(b"\"r\" (daprim));", b"\"r\" (daprim), \"r\" (daprim));")),
                          (TAIL_OLD, TAIL_MID)]
# Y4: mid order, fence moved AFTER the r.x=0 statement
V["Y4 mid + fence after r.x"] = [rw4.FNDECL,
                                 (rw4.ARMS, ARMSNEW.replace(FENCE, b"")),
                                 (b"    r.x = 0;\n    r.y = *(short *)((char *)drenv + 2) + this->fYOffset;\n",
                                  b"    r.x = 0;\n" + FENCE +
                                  b"    r.y = *(short *)((char *)drenv + 2) + this->fYOffset;\n"),
                                 (TAIL_OLD, TAIL_MID)]

if __name__ == "__main__":
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    sel = {k: v for k, v in V.items() if not only or any(o in k for o in only)}
    fast.run(SRC, FN, "tFEApplication::Redraw", sel, gval="0", dump=False)

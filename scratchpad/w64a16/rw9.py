"""Round 9: X1 basin -- packet store INSIDE the comma expression (keeps the shared
palette load) + the struct-view alias dial."""
import sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "..", "tools"))
import fast
import rw4
import rw8

SRC, FN = rw4.SRC, rw4.FN
V = {}
V["Z0 control (X1)"] = rw8.BASE

TAIL_C3 = b"""    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    *pc = (u_char *)daprim + 0xc,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
"""
V["Z1 3-way comma, store in middle"] = [rw4.FNDECL, (rw4.ARMS, rw8.ARMSNEW), (rw8.TAIL_OLD, TAIL_C3)]

TAIL_C3B = b"""    *pc = (u_char *)daprim + 0xc,
    ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr,
    ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
"""
V["Z2 3-way comma, store first"] = [rw4.FNDECL, (rw4.ARMS, rw8.ARMSNEW), (rw8.TAIL_OLD, TAIL_C3B)]

# Z3: struct-view alias dial on the packet cell (MEM_IN_STRUCT_P flip) in the X1 basin
TD = (b"typedef struct tPktCell { u_char *pkt; } tPktCell;\n"
      b"typedef struct tPsyQPrimTag {")
ARMS_S = rw8.ARMSNEW.replace(b"pc = (u_char **)0x1f800004;", b"pc = (tPktCell *)0x1f800004;") \
                    .replace(b"daprim = (DR_AREA *)*pc;", b"daprim = (DR_AREA *)pc->pkt;")
V["Z3 struct-view cell (alias dial)"] = [
    (b"typedef struct tPsyQPrimTag {", TD),
    (b"  RECT r;\n", b"  RECT r;\n  tPktCell *pc;\n"),
    (rw4.ARMS, ARMS_S),
    (rw8.TAIL_OLD, rw8.TAIL_END.replace(b"*pc =", b"pc->pkt =")),
]
V["Z4 struct-view + 3-way comma"] = [
    (b"typedef struct tPsyQPrimTag {", TD),
    (b"  RECT r;\n", b"  RECT r;\n  tPktCell *pc;\n"),
    (rw4.ARMS, ARMS_S),
    (rw8.TAIL_OLD, TAIL_C3.replace(b"*pc =", b"pc->pkt =")),
]

if __name__ == "__main__":
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    sel = {k: v for k, v in V.items() if not only or any(o in k for o in only)}
    fast.run(SRC, FN, "tFEApplication::Redraw", sel, gval="0", dump=False)

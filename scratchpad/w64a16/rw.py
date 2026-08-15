"""W64-A16 Redraw variant ladder (gate-only, restores on finally)."""
import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "tools"))
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

DECL = b"    u_char **cell2;\n"
SET = b"      cell2 = (u_char **)0x1f800004;\n"
RD = b"    daprim = (DR_AREA *)*cell2;\n"
ST = b"    *cell2 = (u_char *)daprim + 0xc;\n"

IF0 = b"    if (this->fCurrentScreen[(u_char)this->fPlayer] != (tScreen *)0x0) {\n"
DRAWT = b"      (this->fCurrentScreen[(u_char)this->fPlayer])->Draw(true);\n"

V = {}

# S2: cell set in BOTH arms (2 sets => no movable), read at the JOIN, cell store
V["S2 armdup-set join-read"] = [
    (ARMS, DECL + IF0 + DRAWT + SET + b"    }\n    else {\n" + SET + b"    }\n" + RD),
    (STORE, ST)]

# S3: cell set + read in BOTH arms
V["S3 armdup set+read"] = [
    (ARMS, DECL + IF0 + DRAWT + SET + RD.replace(b"    d", b"      d") +
     b"    }\n    else {\n" + SET + RD.replace(b"    d", b"      d") + b"    }\n"),
    (STORE, ST)]

# F1: single set at the JOIN + identity fence AFTER the read (blocks the movable via 2nd SET)
V["F1 join-set + fence after read"] = [
    (ARMS, IF0 + DRAWT + b"    }\n" + DECL.replace(b"cell2;", b"cell2 = (u_char **)0x1f800004;") + RD +
     b"    __asm__ (\"\" : \"=r\" (cell2) : \"0\" (cell2));\n"),
    (STORE, ST)]

# F2: same, fence BEFORE the read
V["F2 join-set + fence before read"] = [
    (ARMS, IF0 + DRAWT + b"    }\n" + DECL.replace(b"cell2;", b"cell2 = (u_char **)0x1f800004;") +
     b"    __asm__ (\"\" : \"=r\" (cell2) : \"0\" (cell2));\n" + RD),
    (STORE, ST)]

# T1: TWO short-lived cells (read cell / store cell) -- each life ~2
V["T1 two cells"] = [
    (ARMS, IF0 + DRAWT + b"    }\n" +
     b"    { u_char **cellR = (u_char **)0x1f800004; daprim = (DR_AREA *)*cellR; }\n"),
    (STORE, b"    { u_char **cellW = (u_char **)0x1f800004; *cellW = (u_char *)daprim + 0xc; }\n")]

# T2: two cells, each identity-fenced
V["T2 two cells fenced"] = [
    (ARMS, IF0 + DRAWT + b"    }\n" +
     b"    { u_char **cellR = (u_char **)0x1f800004; __asm__ (\"\" : \"=r\" (cellR) : \"0\" (cellR)); daprim = (DR_AREA *)*cellR; }\n"),
    (STORE, b"    { u_char **cellW = (u_char **)0x1f800004; __asm__ (\"\" : \"=r\" (cellW) : \"0\" (cellW)); *cellW = (u_char *)daprim + 0xc; }\n")]

# ST1: STRUCT VIEW of the scratchpad pair (MEM_IN_STRUCT_P flip, alias dial)
SDEF = b"typedef struct tScratchPtrs { u_char *pal; u_char *pkt; } tScratchPtrs;\n"
V["ST1 struct view both uses"] = [
    (b"typedef struct tPsyQPrimTag {", SDEF + b"typedef struct tPsyQPrimTag {"),
    (ARMS, IF0 + DRAWT + b"    }\n" +
     b"    tScratchPtrs *scr = (tScratchPtrs *)0x1f800000;\n"
     b"    daprim = (DR_AREA *)scr->pkt;\n"),
    (STORE, b"    scr->pkt = (u_char *)daprim + 0xc;\n")]

# ST2: struct view, set duplicated in both arms (no movable)
V["ST2 struct view armdup"] = [
    (b"typedef struct tPsyQPrimTag {", SDEF + b"typedef struct tPsyQPrimTag {"),
    (ARMS, b"    tScratchPtrs *scr;\n" + IF0 + DRAWT +
     b"      scr = (tScratchPtrs *)0x1f800000;\n    }\n    else {\n"
     b"      scr = (tScratchPtrs *)0x1f800000;\n    }\n"
     b"    daprim = (DR_AREA *)scr->pkt;\n"),
    (STORE, b"    scr->pkt = (u_char *)daprim + 0xc;\n")]

if __name__ == "__main__":
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    sel = {k: v for k, v in V.items() if not only or any(o in k for o in only)}
    fast.run(SRC, FN, "tFEApplication::Redraw", sel, gval="0", dump=False)

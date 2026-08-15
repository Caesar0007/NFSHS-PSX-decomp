"""W64-A16 Redraw ladder round 3: fn-scope cell, DECL POSITION sweep (13A)."""
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

DECLS = {
    "d0 after-short-i":     (b"  short i;\n", b"  short i;\n  %s\n"),
    "d1 after-drenv":       (b"  DRAWENV *drenv;\n", b"  DRAWENV *drenv;\n  %s\n"),
    "d2 after-daprim":      (b"  DR_AREA *daprim;\n", b"  DR_AREA *daprim;\n  %s\n"),
    "d3 after-RECT":        (b"  RECT r;\n", b"  RECT r;\n  %s\n"),
    "d4 before-short-i":    (b"  short i;\n", b"  %s\n  short i;\n"),
}

V = {}
for kind, (typ, setx, rdx, stx) in {
    "S": (b"tPktCell *pc;", b"      pc = (tPktCell *)0x1f800004;\n",
          b"    daprim = (DR_AREA *)pc->pkt;\n", b"    pc->pkt = (u_char *)daprim + 0xc;\n"),
    "R": (b"u_char **pc;", b"      pc = (u_char **)0x1f800004;\n",
          b"    daprim = (DR_AREA *)*pc;\n", b"    *pc = (u_char *)daprim + 0xc;\n"),
}.items():
    for dk, (danch, dfmt) in DECLS.items():
        pairs = []
        if kind == "S":
            pairs.append((TDA, TD))
        pairs.append((danch, dfmt.replace(b"%s", typ)))
        pairs.append((ARMS, IF0 + DRAWT + setx + b"    }\n    else {\n" + setx + b"    }\n" + rdx))
        pairs.append((STORE, stx))
        V["%s %s" % (kind, dk)] = pairs

if __name__ == "__main__":
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    sel = {k: v for k, v in V.items() if not only or any(o in k for o in only)}
    fast.run(SRC, FN, "tFEApplication::Redraw", sel, gval="0", dump=False)

"""W64-A16 FeAudio_InitViv -- the certificate's missing instrument, second route.

local-alloc.c:471-477 makes a pseudo local-allocatable iff
    REG_BASIC_BLOCK(i) >= 0   AND   REG_N_DEATHS(i) == 1
Four waves of receipts only ever attacked the REG_N_DEATHS half (identity fence =>
2 deaths => GLOBAL => $a3, at the price of one carrier copy).  The OTHER half --
REG_BASIC_BLOCK < 0, i.e. the pseudo is referenced from more than one basic block --
reaches GLOBAL with NO copy insn at all (05D promotion).  InitViv has a second,
structurally identical byte-swap block after the `if (bigfileHeader == 0) return 0;`
and the second async wait, so ONE shared source-word variable spans two blocks for
free.  NOTE: feaudio.cpp is CRLF (w63a16 hazard) -- fast.run() fixes the anchors.
"""
import sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "..", "tools"))
import fast

SRC = "recon/frontend/common/feaudio.cpp"
FN = "FeAudio_InitViv__FPc"

DECL = b"  char *lumpyName;\n"
DECL2 = b"  char *lumpyName;\n  u_int swappedType;\n"
B1DECL = b"    u_int swappedType = lumpHead.type;\n"
B1DECL2 = b"    swappedType = lumpHead.type;\n"
FENCE = b"    __asm__(\"\" : \"+r\"(swappedType));\n"
B2 = (b"    u_int headerType = bigfileHeader->type;\n"
      b"    __asm__(\"\" : : \"r\"(headerType), \"r\"(byteMask));\n")
B2N = (b"    swappedType = bigfileHeader->type;\n"
       b"    __asm__(\"\" : : \"r\"(swappedType), \"r\"(byteMask));\n")
B2X = (b"    header->type = headerType << 0x18 | (headerType & 0xff00) << 8 |\n"
       b"                   (headerType & byteMask) >> 8 | headerType >> 0x18;\n")
B2XN = (b"    header->type = swappedType << 0x18 | (swappedType & 0xff00) << 8 |\n"
        b"                   (swappedType & byteMask) >> 8 | swappedType >> 0x18;\n")

SHARE = [(DECL, DECL2), (B1DECL, B1DECL2), (B2, B2N), (B2X, B2XN)]

V = {
    "G1 shared 2-block pseudo + fence": SHARE,
    "G2 shared 2-block pseudo, NO fence": SHARE + [(FENCE, b"")],
    "G3 no fence only (control)": [(FENCE, b"")],
    # G4: share only the SECOND block's write direction (block2 writes it first)
    "G4 shared, fence, decl last": [(b"  LUMPYHEAD *bigfileHeader;\n",
                                     b"  LUMPYHEAD *bigfileHeader;\n  u_int swappedType;\n"),
                                    (B1DECL, B1DECL2), (B2, B2N), (B2X, B2XN)],
}

if __name__ == "__main__":
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    sel = {k: v for k, v in V.items() if not only or any(o in k for o in only)}
    fast.run(SRC, FN, "FeAudio_InitViv", sel, gval="0", dump=False)

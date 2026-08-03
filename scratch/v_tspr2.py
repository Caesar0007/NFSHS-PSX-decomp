TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_BuildTimeSprites__FP4SPRTPcii'

DECL = """  char minSep [6] = {':', ':', '\\'', '\\'', '\\'', '.'} /* @0x8013d8dc */;
"""

LOOPM = "    if (c == 0x4d) {\n"
LOOPS = "    if (c == 0x53) {\n"

VARIANTS = [
    # V1: the S code as a named local declared FIRST (born before the aggregate copies)
    ('V1 named sc local first', [
        (DECL, "  int sc;\n  sc = 0x53;\n" + DECL),
        (LOOPS, "    if (c == sc) {\n")]),
    # V2: both codes as named locals, S declared first
    ('V2 named sc+mc locals', [
        (DECL, "  int sc;\n  int mc;\n  sc = 0x53;\n  mc = 0x4d;\n" + DECL),
        (LOOPM, "    if (c == mc) {\n"),
        (LOOPS, "    if (c == sc) {\n")]),
    # V3: sc named+early, mc left as a literal (hoisted)
    ('V3 sc early, mc literal, S-test first', [
        (DECL, "  int sc;\n  sc = 0x53;\n" + DECL),
        ("""    if (c == 0x4d) {
      c = langMin;
    }
    if (c == 0x53) {
      c = langSec;
    }
""", """    if (c == 0x4d) {
      c = langMin;
    }
    if (c == sc) {
      c = langSec;
    }
""")]),
]

TU = "recon/game/psx/hud.cpp"
FN = "Hud_Draw321Num__Fiiiiii"

# --- anchors (LF-normalised; probe.py converts to CRLF) ---
SEED = "    byw = y;\n"
COPY = "      by = byw;\n"
BUMP = "      byw = byw + 9;\n"
FENCE = '  __asm__ volatile("" : : "r"(by));\n'
BTB = "  Hud_BlackThinBox(x - 3,y - 2,0x38,0x31);\n"
TAIL = "  Hud_GoTpage(1);\n"

GIV = [(SEED, "", 1), (COPY, "      by = y + i * 9;\n", 1), (BUMP, "", 1)]

VARIANTS = [
    ("control", []),
    ("giv-plain", GIV),
    ("giv+2fenceops", GIV + [(FENCE, '  __asm__ volatile("" : : "r"(by), "r"(by));\n', 1)]),
    ("giv+3fenceops", GIV + [(FENCE, '  __asm__ volatile("" : : "r"(by), "r"(by), "r"(by));\n', 1)]),
    ("giv+fence-at-tail", GIV + [(FENCE, "", 1), (TAIL, FENCE + TAIL, 1)]),
    ("giv+fence-before-btb", GIV + [(FENCE, "", 1), (BTB, FENCE + BTB, 1)]),
    ("giv+2fences-spread", GIV + [(TAIL, FENCE + TAIL, 1)]),
]

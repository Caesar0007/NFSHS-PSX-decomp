TU = "recon/game/psx/hud.cpp"
FN = "Hud_Draw321Num__Fiiiiii"

SEED = "    byw = y;\n"
COPY = "      by = byw;\n"
BUMP = "      byw = byw + 9;\n"
CALL = "          Flare_2DHalo(x + j * 10 + 4,by + 4,flare_intensity,flare_intensity,6);\n"


def giv(expr):
    return [(SEED, "", 1), (COPY, "      by = %s;\n" % expr, 1), (BUMP, "", 1)]


VARIANTS = [
    ("control", []),
    ("giv y+i*9", giv("y + i * 9")),
    ("giv y+i*8+i", giv("y + i * 8 + i")),
    ("giv y+(i*3)*3", giv("y + (i * 3) * 3")),
    ("giv y+i*4+i*5", giv("y + i * 4 + i * 5")),
    ("giv y+i+i*8", giv("y + i + i * 8")),
    ("consec by=i*9;by+=y",
     [(SEED, "", 1), (COPY, "      by = i * 9;\n      by = by + y;\n", 1), (BUMP, "", 1)]),
    ("consec by=y;by+=i*9",
     [(SEED, "", 1), (COPY, "      by = y;\n      by = by + i * 9;\n", 1), (BUMP, "", 1)]),
    ("giv y+i*9+1 / arg by+3",
     giv("y + i * 9 + 1") + [(CALL, CALL.replace("by + 4", "by + 3"), 1)]),
]

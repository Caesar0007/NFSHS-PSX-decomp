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
    ("y+i*5+i*4", giv("y + i * 5 + i * 4")),
    ("y+4*i+5*i", giv("y + 4 * i + 5 * i")),
    ("(y+i*4)+(i*5)", giv("(y + i * 4) + (i * 5)")),
    ("y+i*3+i*6", giv("y + i * 3 + i * 6")),
    ("y+i*1+i*8", giv("y + i * 1 + i * 8")),
    ("y+i*9+j*0", giv("y + i * 9 + j * 0")),
    ("y+i*9+k*0", giv("y + i * 9 + k * 0")),
    ("y+i*10-i", giv("y + i * 10 - i")),
    ("y+i*9+i-i", giv("y + i * 9 + i - i")),
    # third-op via the halo offset carried in `by` and removed at the call
    ("y+i*9+4 / arg by", giv("y + i * 9 + 4") + [(CALL, CALL.replace("by + 4", "by"), 1)]),
]

TU = "recon/game/psx/hud.cpp"
FN = "Hud_Draw321Num__Fiiiiii"

SEED = "    byw = y;\n"
COPY = "      by = byw;\n"
BUMP = "      byw = byw + 9;\n"
DECL = "  int by2;\n"

LOOP2 = (
    "  k = 0;\n"
    "  i = 0;\n"
    "  do {\n"
    "    j = 0;\n"
    "    by2 = y + i * 9 + 1;\n"
    "    do {\n"
    "      index = (Hud_Character[num] & 1 << k) != 0;\n"
    "      Hud_FBuildSprite(index | 0x3c,x + j * 10 + 1,by2,0x808080,0);\n"
    "      j = j + 1;\n"
    "      k = k + 1;\n"
    "    } while (j < 5);\n"
    "    i = i + 1;\n"
    "  } while (i < 5);\n"
)


def loop2_renamed(iname, jname, kname):
    t = LOOP2
    t = t.replace("  i = 0;\n", "  %s = 0;\n" % iname)
    t = t.replace("    i = i + 1;\n", "    %s = %s + 1;\n" % (iname, iname))
    t = t.replace("  } while (i < 5);\n", "  } while (%s < 5);\n" % iname)
    t = t.replace("i * 9", "%s * 9" % iname)
    t = t.replace("    j = 0;\n", "    %s = 0;\n" % jname)
    t = t.replace("      j = j + 1;\n", "      %s = %s + 1;\n" % (jname, jname))
    t = t.replace("    } while (j < 5);\n", "    } while (%s < 5);\n" % jname)
    t = t.replace("x + j * 10 + 1", "x + %s * 10 + 1" % jname)
    t = t.replace("  k = 0;\n", "  %s = 0;\n" % kname)
    t = t.replace("      k = k + 1;\n", "      %s = %s + 1;\n" % (kname, kname))
    t = t.replace("1 << k", "1 << %s" % kname)
    return t


GIV = [(SEED, "", 1), (COPY, "      by = y + i * 9;\n", 1), (BUMP, "", 1)]

SPLIT_I = [(DECL, DECL + "  int i2;\n", 1), (LOOP2, loop2_renamed("i2", "j", "k"), 1)]
SPLIT_IJK = [(DECL, DECL + "  int i2;\n  int j2;\n  int k2;\n", 1),
             (LOOP2, loop2_renamed("i2", "j2", "k2"), 1)]

VARIANTS = [
    ("control", []),
    ("split-i2 only (walker basin)", SPLIT_I),
    ("giv + split-i2", GIV + SPLIT_I),
    ("giv + split-i2/j2/k2", GIV + SPLIT_IJK),
    ("giv only", GIV),
]

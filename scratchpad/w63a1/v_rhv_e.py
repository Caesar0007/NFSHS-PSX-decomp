TU = "recon/game/psx/hud.cpp"
FN = "Hud_RenderHudView__Fv"

S1 = "        *tagp = *tagp & 0xff000000 | *(u_int *)pal & otmask;\n"
S2 = "        *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tagp & otmask;\n"

# A2's foreign-operand fence: operand is a DIFFERENT live value, so it extends the
# live length of every pseudo crossing it without adding refs to them.
FT = '        __asm__ ("" : : "r"(tagp));\n'
FP = '        __asm__ ("" : : "r"(pal));\n'
FJ = '        __asm__ ("" : : "r"(j));\n'
FO = '        __asm__ ("" : : "r"(otmask));\n'

VARIANTS = [
    ("control", []),
    ("foreign(j) between S1/S2", [(S2, FJ + S2, 1)]),
    ("foreign(otmask) between S1/S2", [(S2, FO + S2, 1)]),
    ("foreign(tagp) between S1/S2", [(S2, FT + S2, 1)]),
    ("foreign(pal) between S1/S2", [(S2, FP + S2, 1)]),
    ("foreign(j) after S2", [(S2, S2 + FJ, 1)]),
    ("foreign(otmask) after S2", [(S2, S2 + FO, 1)]),
    ("foreign(j) before S1", [(S1, FJ + S1, 1)]),
]

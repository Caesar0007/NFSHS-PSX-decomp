NL = chr(13) + chr(10)
ENV = {}

SUBOT = ("  u_long **subOtRow = subOtStart[gFlip];" + NL +
         "  iVar11 = ((carObj->N).objID & 0xfU) * 0x200;" + NL +
         "  (carObj->render).sub_ot =" + NL +
         "       subOtRow[iVar9] + iVar11;" + NL)

HEAD = "  iVar11 = ((carObj->N).objID & 0xfU) * 0x200;" + NL + "  (carObj->render).sub_ot =" + NL


def sub(expr):
    return [(SUBOT, HEAD + "       " + expr + " + iVar11;" + NL)]


PATCHES = [
    ("s4_gflipfirst", sub("*(u_long **)(gFlip * 8 + iVar9 * 4 + (int)R3DCar_subOtStart)")),
    ("s5_local2d", sub("subOtStart[gFlip][iVar9]")),
    ("s6_local_gflipfirst", sub("*(u_long **)(gFlip * 8 + iVar9 * 4 + (int)subOtStart)")),
    ("s7_idxfirst_parens", sub("*(u_long **)((iVar9 * 4 + gFlip * 8) + (int)R3DCar_subOtStart)")),
    ("s8_shifts", sub("*(u_long **)((iVar9 << 2) + (gFlip << 3) + (int)R3DCar_subOtStart)")),
]

NL = chr(13) + chr(10)
ENV = {}

SUBOT = ("  u_long **subOtRow = subOtStart[gFlip];" + NL +
         "  iVar11 = ((carObj->N).objID & 0xfU) * 0x200;" + NL +
         "  (carObj->render).sub_ot =" + NL +
         "       subOtRow[iVar9] + iVar11;" + NL)

TAIL = ("  iVar11 = ((carObj->N).objID & 0xfU) * 0x200;" + NL +
        "  (carObj->render).sub_ot =" + NL)


def sub(pre, expr):
    return [(SUBOT, pre + TAIL + "       " + expr + " + iVar11;" + NL)]


F = "  int flipIdx = gFlip;" + NL
FO = "  int flipOff = gFlip * 8;" + NL

PATCHES = [
    ("t1_flipval_idxfirst", sub(F, "*(u_long **)(iVar9 * 4 + flipIdx * 8 + (int)R3DCar_subOtStart)")),
    ("t2_flipval_flipfirst", sub(F, "*(u_long **)(flipIdx * 8 + iVar9 * 4 + (int)R3DCar_subOtStart)")),
    ("t3_flipoff_idxfirst", sub(FO, "*(u_long **)(iVar9 * 4 + flipOff + (int)R3DCar_subOtStart)")),
    ("t4_flipval_2d", sub(F, "R3DCar_subOtStart[flipIdx][iVar9]")),
    ("t5_flipval_local2d", sub(F, "subOtStart[flipIdx][iVar9]")),
]

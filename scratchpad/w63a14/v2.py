NL = chr(13) + chr(10)
ENV = {}

SUBOT = ("  u_long **subOtRow = subOtStart[gFlip];" + NL +
         "  iVar11 = ((carObj->N).objID & 0xfU) * 0x200;" + NL +
         "  (carObj->render).sub_ot =" + NL +
         "       subOtRow[iVar9] + iVar11;" + NL)

SCENE = ("    Transformer_zScene **loadedSceneBase = &R3DCar_LoadedScenePointer[0][0];" + NL +
         "    ppTVar21 = loadedSceneBase + countryFlag * 50;" + NL +
         "    ppTVar21 = ppTVar21 + carType;" + NL)

PATCHES = [
    ("ctl", [(SUBOT, SUBOT)]),
    # ---- cluster 1: sub_ot address, index-terms-first byte math
    ("s1_idxfirst", [(SUBOT,
        "  iVar11 = ((carObj->N).objID & 0xfU) * 0x200;" + NL +
        "  (carObj->render).sub_ot =" + NL +
        "       *(u_long **)(iVar9 * 4 + gFlip * 8 + (int)R3DCar_subOtStart) + iVar11;" + NL)]),
    ("s2_idxfirst_keeplocal", [(SUBOT,
        "  iVar11 = ((carObj->N).objID & 0xfU) * 0x200;" + NL +
        "  (carObj->render).sub_ot =" + NL +
        "       *(u_long **)(iVar9 * 4 + gFlip * 8 + (int)subOtStart) + iVar11;" + NL)]),
    ("s3_natural2d", [(SUBOT,
        "  iVar11 = ((carObj->N).objID & 0xfU) * 0x200;" + NL +
        "  (carObj->render).sub_ot =" + NL +
        "       R3DCar_subOtStart[gFlip][iVar9] + iVar11;" + NL)]),
    # ---- cluster 2: LoadedScenePointer slot address
    ("m1_natural2d", [(SCENE,
        "    ppTVar21 = &R3DCar_LoadedScenePointer[countryFlag][carType];" + NL)]),
    ("m2_idxfirst", [(SCENE,
        "    ppTVar21 = (Transformer_zScene **)" + NL +
        "        (carType * 4 + countryFlag * 200 + (int)R3DCar_LoadedScenePointer);" + NL)]),
]

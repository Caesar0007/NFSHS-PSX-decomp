import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "tools"))
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi"

MUL_OLD = b"""            iVar3 = fixedmult(matrix.m[0],blend_x);
            iVar11_emit = fixedmult(matrix.m[3],blend_x);
            matrix.m[0] = iVar3;
            matrix.m[3] = iVar11_emit;
            matrix.m[6] = fixedmult(matrix.m[6],blend_x);
            iVar3 = fixedmult(matrix.m[1],blend_y);
            iVar4 = fixedmult(matrix.m[4],blend_y);
            matrix.m[1] = iVar3;
            matrix.m[4] = iVar4;
            matrix.m[7] = fixedmult(matrix.m[7],blend_y);
            iVar3 = fixedmult(matrix.m[2],blend_z);
            iVar4 = fixedmult(matrix.m[5],blend_z);
            matrix.m[2] = iVar3;
            matrix.m[5] = iVar4;
            matrix.m[8] = fixedmult(matrix.m[8],blend_z);
"""

MUL_NEW = b"""            iVar3 = fixedmult(matrix.m[0],blend_x);
            iVar4 = fixedmult(matrix.m[3],blend_x);
            iVar11_emit = fixedmult(matrix.m[6],blend_x);
            matrix.m[0] = iVar3;
            matrix.m[3] = iVar4;
            matrix.m[6] = iVar11_emit;
            iVar3 = fixedmult(matrix.m[1],blend_y);
            iVar4 = fixedmult(matrix.m[4],blend_y);
            iVar11_emit = fixedmult(matrix.m[7],blend_y);
            matrix.m[1] = iVar3;
            matrix.m[4] = iVar4;
            matrix.m[7] = iVar11_emit;
            iVar3 = fixedmult(matrix.m[2],blend_z);
            iVar4 = fixedmult(matrix.m[5],blend_z);
            iVar11_emit = fixedmult(matrix.m[8],blend_z);
            matrix.m[2] = iVar3;
            matrix.m[5] = iVar4;
            matrix.m[8] = iVar11_emit;
"""

CBI_OLD = b"           (objMat_p = (int)simObjs,"
CBI_NEW = b"           (objCollideBoomInstance = (Trk_CollideBoomInst *)groupBase_p,"

Q_OLD = b"*(struct Pack8 *)(groupBase_p + 0x14);"
Q_NEW = b"*(struct Pack8 *)((int)objCollideBoomInstance + 0x14);"

B_OLD = b"""            blend_x = (int)*(short *)(groupBase_p + 0x1c) << 8;
            blend_y = (int)*(short *)(groupBase_p + 0x1e) << 8;
            blend_z = (int)*(short *)(groupBase_p + 0x20) << 8;
"""
B_NEW = b"""            blend_x = (int)*(short *)((int)objCollideBoomInstance + 0x1c) << 8;
            blend_y = (int)*(short *)((int)objCollideBoomInstance + 0x1e) << 8;
            blend_z = (int)*(short *)((int)objCollideBoomInstance + 0x20) << 8;
"""
B_NEW_CR = b"""            blend_x = (int)objCollideBoomInstance->sx << 8;
            blend_y = (int)objCollideBoomInstance->sy << 8;
            blend_z = (int)objCollideBoomInstance->sz << 8;
"""

CBI = [(CBI_OLD, CBI_NEW), (Q_OLD, Q_NEW), (B_OLD, B_NEW)]
CBI_CR = [(CBI_OLD, CBI_NEW), (Q_OLD, Q_NEW), (B_OLD, B_NEW_CR)]

variants = {
    "A_mul3then3": [(MUL_OLD, MUL_NEW)],
    "B_cbi_cast": CBI,
    "B_cbi_compref": CBI_CR,
    "C_both_cast": [(MUL_OLD, MUL_NEW)] + CBI,
    "C_both_compref": [(MUL_OLD, MUL_NEW)] + CBI_CR,
}

fast.run(SRC, FN, "DrawW_BuildCustomObjectFacets", variants, gval="4", minrefs=3, dump=False)

VARIANTS = variants

"""w63-a2 -- FIRST APPLICATION OF THE FOREIGN-OPERAND FENCE.

DrawW_BuildChunkObjectFacets residual cluster (A) (w46/w62 named angle):
  "buy objDef's +4 live somewhere that is NOT an emission-order change" --
  a READ-ONLY fence on objDef was falsified because it costs an insn AND puts
  the +1 ref on objDef itself (wrong direction: refs RAISE the priority).
The foreign-operand fence puts the ref on a NEIGHBOUR and the +1 live on
everything live across it, objDef included.
"""
import sys
sys.path.insert(0, r"C:/Temp/nfs4-decomp/tools")
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo"
DUMPFN = "DrawW_BuildChunkObjectFacets(struct"

C1 = (b"        case 1:\n"
      b"          objDef = Track_gObjDefs[objInstance->pad];\n")
F = b"          __asm__(\"\" : : \"r\"(objInstance));\n"

C2OLD = (b"          t2 = fixedmult(matrix.m[5],sz);\n"
         b"          objDef = Track_gObjDefs[objInstance->pad];\n"
         b"          t3 = fixedmult(matrix.m[8],sz);\n"
         b"          matrix.m[2] = t1;\n"
         b"          matrix.m[5] = t2;\n"
         b"          matrix.m[8] = t3;\n")
C2NEW = (b"          t2 = fixedmult(matrix.m[5],sz);\n"
         b"          t3 = fixedmult(matrix.m[8],sz);\n"
         b"          matrix.m[2] = t1;\n"
         b"          matrix.m[5] = t2;\n"
         b"          matrix.m[8] = t3;\n"
         b"          objDef = Track_gObjDefs[objInstance->pad];\n")

V = {
    "0_ctl":        (C1, C1),
    "1_f1":         (C1, C1 + F),
    "2_f4":         (C1, C1 + F * 4),
    "3_c2move":     (C2OLD, C2NEW),
    "4_f4+c2move":  [(C1, C1 + F * 4), (C2OLD, C2NEW)],
    "5_f8+c2move":  [(C1, C1 + F * 8), (C2OLD, C2NEW)],
}

fast.run(SRC, FN, DUMPFN, V, gval="4", minrefs=4)

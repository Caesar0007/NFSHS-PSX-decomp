"""w63-a2 lab6 -- tune the foreign-fence count on BuildChunkObjectFacets
(c2move + N fences; N=4 measured 8 diffs @434/434 from a 19 @433 base)."""
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

V = {("%d_f%d" % (n, n)): [(C1, C1 + F * n), (C2OLD, C2NEW)] for n in (2, 3, 5, 6)}
V["7_f4_objDefop"] = [(C1, C1 + b"          __asm__(\"\" : : \"r\"(objDef));\n" * 4),
                      (C2OLD, C2NEW)]

fast.run(SRC, FN, DUMPFN, V, gval="4", minrefs=4, dump=False)

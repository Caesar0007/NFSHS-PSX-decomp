import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "tools"))
import fast

SRC = "recon/game/psx/draww.cpp"
FN = "DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo"
OLD = b"          objectOffset = (int)goffsets[objInstance->zoffset];\r\n"

VAR = {
 "A_index_first": b"          objectOffset = *(signed char *)((int)objInstance->zoffset + (int)goffsets);\r\n",
 "B_named_index": b"          { int zo = objInstance->zoffset; objectOffset = (int)goffsets[zo]; }\r\n",
 "C_base_first_cast": b"          objectOffset = *(signed char *)((int)goffsets + (int)objInstance->zoffset);\r\n",
 "D_ptr_add": b"          objectOffset = (int)*(goffsets + objInstance->zoffset);\r\n",
 "E_extra_qty": b"          { int zo = objInstance->zoffset; int zq = zo; objectOffset = (int)goffsets[zq]; }\r\n",
}
variants = {k: [(OLD, v)] for k, v in VAR.items()}
VARIANTS = variants

if __name__ == "__main__":
    fast.run(SRC, FN, "DrawW_BuildObjectFacets", variants, gval="4", minrefs=4, dump=False)

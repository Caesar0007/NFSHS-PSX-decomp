import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast
SRC='recon/game/psx/night.cpp'; FN='Night_AdditiveNightCalc__FP6VECTORP7CVECTOR'
BASE=(b'    x = v->vx;\n')
V={'base':[],
 'block_local_vp':[(BASE, b'    VECTOR *vp = v;\n    x = vp->vx;\n')],
 'block_local_vp_launder':[(BASE, b'    VECTOR *vp = v;\n    __asm__("" : "=r"(vp) : "0"(vp));\n    x = vp->vx;\n')],
}
fast.run(SRC,FN,FN,V,gval="8",dump=False)

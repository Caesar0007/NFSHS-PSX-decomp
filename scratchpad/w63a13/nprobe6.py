import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast
SRC='recon/game/psx/night.cpp'; FN='Night_SetEnviroment__FP13DRender_tView'
BASE=(b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
      b'    int zn2 = 0x80;\n'
      b'    __asm__("" : : "r"(tgt), "r"(zn2));\n'
      b'    Night_gZNear = zn2;\n'
      b'    if ((tgt[0x447] & 4) != 0) {\n')
V={'base':[],
 'no_tgt_local':[(BASE,
   b'    int zn2 = 0x80;\n'
   b'    __asm__("" : : "r"(zn2));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((*((u_char *)Camera_gInfo[Vi->player].target + 0x447) & 4) != 0) {\n')],
 'zn_only_fence':[(BASE,
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    int zn2 = 0x80;\n'
   b'    __asm__("" : : "r"(zn2));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n')],
}
fast.run(SRC,FN,FN,V,gval="8",dump=False)

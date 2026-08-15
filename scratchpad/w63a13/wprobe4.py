import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast
SRC='recon/game/psx/weather.cpp'; FN='Weather_DoWeather__FP13DRender_tView'
HEAD=b'  if ((GameSetup_gData.commMode != 1) && (0x20 < simGlobal.gameTicks - timechange)) {\n'
F=b'  __asm__("" : : "r"(player));\n'
G=(b'  if ((GameSetup_gData.commMode != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n')
V={'base':[],
 'one_after_reads_nofence':[(F, b'  int one = 1;\n'+F),(HEAD,G)],
 'one_fence_only':[(F, b'  int one = 1;\n  __asm__("" : : "r"(one));\n'),(HEAD,G)],
 'one_after_reads_fenced_ctl':[(F, b'  int one = 1;\n  __asm__("" : : "r"(player), "r"(one));\n'),(HEAD,G)],
 'one_shared_all':[(F, b'  int one = 1;\n  __asm__("" : : "r"(player), "r"(one));\n'),(HEAD,G),
   (b'      clean_up = ab == 1;\n', b'      clean_up = ab == one;\n'),
   (b'      clean_up = 1;\n', b'      clean_up = one;\n')],
}
fast.run(SRC,FN,FN,V,gval="0",dump=False)

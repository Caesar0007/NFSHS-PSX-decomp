import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast
SRC='recon/game/psx/weather.cpp'; FN='Weather_DoWeather__FP13DRender_tView'
F=b'  __asm__("" : : "r"(player));\n'
HEAD=b'  if ((GameSetup_gData.commMode != 1) && (0x20 < simGlobal.gameTicks - timechange)) {\n'
G1=b'  if ((cm != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n'
G2=b'  if ((cm != 1) && (0x20 < simGlobal.gameTicks - timechange)) {\n'
V={'base':[],
 'cm_before_fence_one_after':[(F, b'  int cm = GameSetup_gData.commMode;\n  int one = 1;\n'+F),(HEAD,G1)],
 'cm_and_one_before_fence':[(F, b'  int one = 1;\n  int cm = GameSetup_gData.commMode;\n'+F),(HEAD,G1)],
 'cm_before_fence_no_one':[(F, b'  int cm = GameSetup_gData.commMode;\n'+F),(HEAD,G2)],
 'one_before_fence_cm_inline':[(F, b'  int one = 1;\n'+F),(HEAD,
   b'  if ((GameSetup_gData.commMode != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
 'cm_first_then_one_then_fence':[(F, b'  int cm = GameSetup_gData.commMode;\n'+F+b'  int one = 1;\n'),(HEAD,G1)],
}
fast.run(SRC,FN,FN,V,gval="0",dump=False)

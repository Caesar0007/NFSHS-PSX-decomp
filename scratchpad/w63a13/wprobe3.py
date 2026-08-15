import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast
SRC='recon/game/psx/weather.cpp'; FN='Weather_DoWeather__FP13DRender_tView'
P=b'  player = Vi->player;\n'
HEAD=b'  if ((GameSetup_gData.commMode != 1) && (0x20 < simGlobal.gameTicks - timechange)) {\n'
F=b'  __asm__("" : : "r"(player));\n'
V={'base':[],
 'one_before_player':[(P, b'  int one = 1;\n'+P),(HEAD,
   b'  if ((GameSetup_gData.commMode != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
 'one_before_player_fenced':[(P, b'  int one = 1;\n'+P),(F, b'  __asm__("" : : "r"(player), "r"(one));\n'),(HEAD,
   b'  if ((GameSetup_gData.commMode != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
 'one_after_reads_fenced':[(F, b'  int one = 1;\n  __asm__("" : : "r"(player), "r"(one));\n'),(HEAD,
   b'  if ((GameSetup_gData.commMode != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
 'one_and_cm_before_player':[(P, b'  int one = 1;\n'+P),(HEAD,
   b'  int cm = GameSetup_gData.commMode;\n'
   b'  if ((cm != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
}
fast.run(SRC,FN,FN,V,gval="0",dump=False)

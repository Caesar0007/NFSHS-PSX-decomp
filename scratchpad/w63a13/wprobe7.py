import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast
SRC='recon/game/psx/weather.cpp'; FN='Weather_DoWeather__FP13DRender_tView'
CM=b'  int cm = GameSetup_gData.commMode;\n'
LPT=(b'    if (1 < simGlobal.gameTicks - Weather_gLastProcessTimeA[player]) {\n'
     b'      Weather_gLastProcessTimeA[player] = simGlobal.gameTicks;\n')
V={'base':[],
 # (A) stop the commMode base lui from joining the early lui group
 'cm_split_decl':[(CM, b'  cm = GameSetup_gData.commMode;\n'),
                  (b'  int ab;\n', b'  int ab;\n  int cm;\n')],
 'cm_volatile_view':[(CM, b'  int cm = *(volatile int *)&GameSetup_gData.commMode;\n')],
 # (B) the sll position at the LastProcessTime guard
 'lpt_index_first':[(LPT,
   b'    if (1 < simGlobal.gameTicks - *(int *)((player << 2) + (int)Weather_gLastProcessTimeA)) {\n'
   b'      *(int *)((player << 2) + (int)Weather_gLastProcessTimeA) = simGlobal.gameTicks;\n')],
 'lpt_ticks_local':[(LPT,
   b'    int gt = simGlobal.gameTicks;\n'
   b'    if (1 < gt - Weather_gLastProcessTimeA[player]) {\n'
   b'      Weather_gLastProcessTimeA[player] = gt;\n')],
}
fast.run(SRC,FN,FN,V,gval="0",dump=False)

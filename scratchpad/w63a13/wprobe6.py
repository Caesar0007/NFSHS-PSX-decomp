import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast
SRC='recon/game/psx/weather.cpp'; FN='Weather_DoWeather__FP13DRender_tView'
R=(b'  wpt = Weather_gPServerA[player];\n'
   b'  wprevpt = Weather_gPrevPServerA[player];\n'
   b'  wd = Weather_gDrawnServerA[player];\n')
F=b'  __asm__("" : : "r"(player));\n'
HEAD=b'  if ((GameSetup_gData.commMode != 1) && (0x20 < simGlobal.gameTicks - timechange)) {\n'
G=b'  if ((cm != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n'
CM=b'  int cm = GameSetup_gData.commMode;\n'
ONE=b'  int one = 1;\n'
def mk(reads, pre):
    return [(R, reads), (F, pre+F), (HEAD, G)]
V={'base':[],
 'cm_between_2_3': mk(R.split(b'\n')[0]+b'\n'+R.split(b'\n')[1]+b'\n'+CM+R.split(b'\n')[2]+b'\n', ONE),
 'cm_between_1_2': mk(R.split(b'\n')[0]+b'\n'+CM+R.split(b'\n')[1]+b'\n'+R.split(b'\n')[2]+b'\n', ONE),
 'cm_before_reads': mk(CM+R, ONE),
 'ctl_cm_after_reads': mk(R, CM+ONE),
}
fast.run(SRC,FN,FN,V,gval="0",dump=False)

import sys
sys.path.insert(0, r'C:\Temp\nfs4-decomp\tools')
import fast

SRC = 'recon/game/common/audiocmn.cpp'
FN = 'AudioCmn_CheckState__FP8Car_tObj'

HEAD = b"""  {
    CopSpeak_tRequest r;
    bool saidplayer;

    CopSpeak_InitRequest(&r);"""
ARM = b"""    else {
      if (bestLapTime[car->carIndex] <= carspeed) goto LAB_800774e0;
      r.phrase = 0;
      bestLapTime[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r);
    }"""
ARMBL = b"""    else {
      if (bl[car->carIndex] <= carspeed) goto LAB_800774e0;
      r.phrase = 0;
      bl[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r);
    }"""
DECL = b"    int *bl = bestLapTime;\n"
L = b'    __asm__("" : "=r"(bl) : "0"(bl));\n'

def blockdecl(extra=b""):
    return (HEAD.replace(b"    bool saidplayer;\n", b"    bool saidplayer;\n" + DECL + extra))

V = {
 'J1_blockdecl_plain': [(HEAD, blockdecl()), (ARM, ARMBL)],
 'J2_blockdecl_laundered': [(HEAD, blockdecl(L)), (ARM, ARMBL)],
 'J3_blockdecl_plain_bothsites': [(HEAD, blockdecl()), (ARM, ARMBL),
      (b"      recordLapTime = bestLapTime[car->carIndex] =",
       b"      recordLapTime = bl[car->carIndex] ="),
      (b"(car->stats).time[(car->stats).lap + -1] < bestLapTime[car->carIndex]))",
       b"(car->stats).time[(car->stats).lap + -1] < bl[car->carIndex]))")],
 'J4_blockdecl_laundered_bothsites': [(HEAD, blockdecl(L)), (ARM, ARMBL),
      (b"      recordLapTime = bestLapTime[car->carIndex] =",
       b"      recordLapTime = bl[car->carIndex] ="),
      (b"(car->stats).time[(car->stats).lap + -1] < bestLapTime[car->carIndex]))",
       b"(car->stats).time[(car->stats).lap + -1] < bl[car->carIndex]))")],
}
fast.run(SRC, FN, FN, V, gval='4', dump=False)

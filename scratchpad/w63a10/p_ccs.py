import sys
sys.path.insert(0, r'C:\Temp\nfs4-decomp\tools')
import fast

SRC = 'recon/game/common/audiocmn.cpp'
FN = 'AudioCmn_CheckState__FP8Car_tObj'

A = b"""    else {
      if (bestLapTime[car->carIndex] <= carspeed) goto LAB_800774e0;
      r.phrase = 0;
      bestLapTime[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r);
    }"""

def arm(body):
    return [(A, b"    else {\n" + body + b"    }")]

L = b'      __asm__("" : "=r"(bl) : "0"(bl));\n'
DECL = b'      int *bl = bestLapTime;\n'

V = {
 'C1_bl_both_laundered': arm(DECL + L + b"""      if (bl[car->carIndex] <= carspeed) goto LAB_800774e0;
      r.phrase = 0;
      bl[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r);
"""),
 'C2_bl_both_plain': arm(DECL + b"""      if (bl[car->carIndex] <= carspeed) goto LAB_800774e0;
      r.phrase = 0;
      bl[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r);
"""),
 'C3_bl_guard_only_laundered': arm(DECL + L + b"""      if (bl[car->carIndex] <= carspeed) goto LAB_800774e0;
      r.phrase = 0;
      bestLapTime[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r);
"""),
 'C4_foreign_fence_carspeed': arm(b'      __asm__("" : : "r"(carspeed));\n' + b"""      if (bestLapTime[car->carIndex] <= carspeed) goto LAB_800774e0;
      r.phrase = 0;
      bestLapTime[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r);
"""),
 'C5_bl_both_laundered_ci': arm(DECL + L + b"""      int ci = car->carIndex;
      if (bl[ci] <= carspeed) goto LAB_800774e0;
      r.phrase = 0;
      bl[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r);
"""),
 'C6_bl_yoda': arm(DECL + L + b"""      if (!(carspeed < bl[car->carIndex])) goto LAB_800774e0;
      r.phrase = 0;
      bl[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r);
"""),
}
fast.run(SRC, FN, FN, V, gval='4', dump=False)

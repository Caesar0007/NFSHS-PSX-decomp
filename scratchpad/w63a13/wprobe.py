"""wprobe.py -- Weather_DoWeather (w63-a13).
(A) head: retail materialises the commMode compare's `1` early in $a2 and self-temps the
    load (`lw v0,0(v0)`); ours does the mirror.  Same shape as Night_SetEnviroment.
(B) tail: the SYM 8c block lists NO `mode` local -- retail carries the Camera_GetMode
    result in $a1, which is `ab`'s register, and `ab` is DEAD by then (12D dead-pseudo
    staging law: reuse the existing variable, do not add one)."""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/weather.cpp'
FN = 'Weather_DoWeather__FP13DRender_tView'

HEAD = b'  if ((GameSetup_gData.commMode != 1) && (0x20 < simGlobal.gameTicks - timechange)) {\n'
TAIL = (b'    mode = Camera_GetMode(player);\n'
        b'    if (mode != prevCameraMode[player]) {\n'
        b'      clean_up = 1;\n'
        b'    }\n'
        b'    prevCameraMode[player] = mode;\n')
AB_TAIL = (b'    ab = Camera_GetMode(player);\n'
           b'    if (ab != prevCameraMode[player]) {\n'
           b'      clean_up = 1;\n'
           b'    }\n'
           b'    prevCameraMode[player] = ab;\n')

VARIANTS = {
 'base': [],
 # (B) the SYM-faithful staging: reuse `ab` (dead after *plb = ab)
 'ab_carries_mode': [(TAIL, AB_TAIL)],
 # (A) named constant + zero-insn read-only fence (the Night_SetEnviroment cure)
 'one_rofence': [(HEAD,
    b'  int one = 1;\n'
    b'  __asm__("" : : "r"(one));\n'
    b'  if ((GameSetup_gData.commMode != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
 'one_launder': [(HEAD,
    b'  int one = 1;\n'
    b'  __asm__("" : "=r"(one) : "0"(one));\n'
    b'  if ((GameSetup_gData.commMode != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
 # (A') name the LOADED value instead (mirror of the night `tgt` local)
 'cm_local': [(HEAD,
    b'  int cm = GameSetup_gData.commMode;\n'
    b'  if ((cm != 1) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
 'cm_local_fence': [(HEAD,
    b'  int cm = GameSetup_gData.commMode;\n'
    b'  __asm__("" : : "r"(cm));\n'
    b'  if ((cm != 1) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
 'both_ab_and_one': [(TAIL, AB_TAIL), (HEAD,
    b'  int one = 1;\n'
    b'  __asm__("" : : "r"(one));\n'
    b'  if ((GameSetup_gData.commMode != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

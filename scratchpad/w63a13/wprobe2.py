"""wprobe2.py -- Weather_DoWeather round 2 from the NEW 12-diff basin (w63-a13)."""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/weather.cpp'
FN = 'Weather_DoWeather__FP13DRender_tView'

HEAD = b'  if ((GameSetup_gData.commMode != 1) && (0x20 < simGlobal.gameTicks - timechange)) {\n'
FENCE = b'  __asm__("" : : "r"(player));\n'

VARIANTS = {
 'base': [],
 'cm_local': [(HEAD,
    b'  int cm = GameSetup_gData.commMode;\n'
    b'  if ((cm != 1) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
 'cm_local_rofence': [(HEAD,
    b'  int cm = GameSetup_gData.commMode;\n'
    b'  __asm__("" : : "r"(cm));\n'
    b'  if ((cm != 1) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
 'cm_launder': [(HEAD,
    b'  int cm = GameSetup_gData.commMode;\n'
    b'  __asm__("" : "=r"(cm) : "0"(cm));\n'
    b'  if ((cm != 1) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
 'one_local': [(HEAD,
    b'  int one = 1;\n'
    b'  if ((GameSetup_gData.commMode != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
 # the player fence carries a 2nd operand = +1 ref on player (basin re-ladder, 04Z)
 'player_fence_x2': [(FENCE, b'  __asm__("" : : "r"(player), "r"(player));\n')],
 # move the player fence before the commMode guard
 'fence_pos_after_guard': [(FENCE, b''),
    (HEAD, HEAD + b'')],
 # cm local + one local together
 'cm_and_one': [(HEAD,
    b'  int cm = GameSetup_gData.commMode;\n'
    b'  int one = 1;\n'
    b'  __asm__("" : : "r"(one));\n'
    b'  if ((cm != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n')],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

"""w64-a13 wprobe -- Weather_DoWeather cluster (A): retail materialises the commMode base
as a SELF-TEMP at the point of use (`lui v0,%hi(GameSetup_gData+12); lw v0,%lo(...)($v0)`)
while ours HOISTS that lui into the prologue lui group, where it must take its own scratch
($a3/$7).  It is the hoist that forces the separate register, so the lever is anything that
keeps the lui adjacent to its load.  (Cluster (B), the `sll s0,s2,2` slot, is separately
solved by a PER_FN_TEXT_MOVES row -- see scratchpad/w64a13/tm_weather.json, 6 -> 4.)
"""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/weather.cpp'
FN = 'Weather_DoWeather__FP13DRender_tView'

HEAD = (b'  player = Vi->player;\n'
        b'  int cm = GameSetup_gData.commMode;\n'
        b'  wpt = Weather_gPServerA[player];\n'
        b'  wprevpt = Weather_gPrevPServerA[player];\n'
        b'  wd = Weather_gDrawnServerA[player];\n'
        b'  int one = 1;\n'
        b'  __asm__("" : : "r"(player));\n')
GUARD = b'  if ((cm != one) && (0x20 < simGlobal.gameTicks - timechange)) {\n'

P = b'  player = Vi->player;\n'
CM = b'  int cm = GameSetup_gData.commMode;\n'
ARR = (b'  wpt = Weather_gPServerA[player];\n'
       b'  wprevpt = Weather_gPrevPServerA[player];\n'
       b'  wd = Weather_gDrawnServerA[player];\n')
ONE = b'  int one = 1;\n'
FE = b'  __asm__("" : : "r"(player));\n'

VARIANTS = {
    'base': [],
    # fence ABOVE the cm read (barrier the lui hoist)
    'fence_first': [(HEAD, P + FE + CM + ARR + ONE)],
    # a second, dedicated fence just above the cm read
    'fence2': [(HEAD, P + FE + CM + ARR + ONE + FE)],
    # RO fence on cm right after the read
    'ro_cm': [(HEAD, P + CM + b'  __asm__("" : : "r"(cm));\n' + ARR + ONE + FE)],
    # cm read moved down, just above the guard
    'cm_last': [(HEAD, P + ARR + ONE + FE + CM)],
    # cm read inline at the guard
    'cm_inline': [(HEAD, P + ARR + ONE + FE),
                  (GUARD, b'  if ((GameSetup_gData.commMode != one) && '
                          b'(0x20 < simGlobal.gameTicks - timechange)) {\n')],
    # cm read via a pointer local to the struct (address materialised as a value)
    'cm_ptr': [(HEAD, P + b'  int cm = ((GameSetup_tData *)&GameSetup_gData)->commMode;\n'
                + ARR + ONE + FE)],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

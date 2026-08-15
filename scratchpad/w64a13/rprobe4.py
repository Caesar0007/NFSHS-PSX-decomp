"""w64-a13 rprobe4 -- from the count-exact `pf_below` basin (102 @475/475), add the w41
`rows` local (retail keeps (numLaps+1)*0xc LIVE: `addiu a0,a0,28` in the ==1 arm where we
const-fold `li t1,52`) and dial the two callee-saved constants (ours 160->s2, 1->s1;
retail 160->s7, 1->s2)."""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/overlays.cpp'
FN = 'RaceStatistics__Fv'

DECL = b'  int halfH;\n  int titleX;\n  int titleY;\n'
HDR = b'  HUD_STATS_SIZE_H = (GameSetup_gData.numLaps + 1) * 0xc + 0x28;\n'
SZW = b'  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * 0x96;\n'
POSX = b'  HUD_STATS_POS_X = 0xa0 - Cars_gNumHumanRaceCars * 0x4b;\n'
TX = (b'  titleX = 0xa0 - (textpixels(TextSys_Word(0x39)) >> 1);\n'
      b'  col1 = HUD_STATS_POS_X + 0xa;\n  col2 = 0xa0;\n')
ARM = b'    HUD_STATS_SIZE_H = (GameSetup_gData.numLaps + 1) * 0xc + 0x1c;\n'
GUARDS = (b'  if (GameSetup_gData.numLaps == 1) {\n'
          b'    HUD_STATS_SIZE_H = (GameSetup_gData.numLaps + 1) * 0xc + 0x1c;\n  }\n'
          b'  if (GameSetup_gData.raceType == 1) {\n'
          b'    HUD_STATS_SIZE_H = HUD_STATS_SIZE_H + 0x1b;\n  }\n')

FENCE = b'  __asm__ volatile("" : : "r"(pitch));\n'
SZW_P = b'  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * pitch;\n'
PD = (DECL, DECL + b'  int pitch;\n')
PF_BELOW = [PD, (HDR, HDR + b'  pitch = 0x96;\n' + FENCE), (SZW, SZW_P)]

# --- rows: keep the (numLaps+1)*0xc product live -------------------------------
ROWS = [(DECL, DECL + b'  int rows;\n'),
        (HDR, b'  rows = (GameSetup_gData.numLaps + 1) * 0xc;\n'
              b'  HUD_STATS_SIZE_H = rows + 0x28;\n'),
        (ARM, b'    HUD_STATS_SIZE_H = rows + 0x1c;\n')]

# --- the in-place titleX (w64 reading) ----------------------------------------
TX_INPLACE = (b'  titleX = titleX - (textpixels(TextSys_Word(0x39)) >> 1);\n'
              b'  col1 = HUD_STATS_POS_X + 0xa;\n  col2 = 0xa0;\n')
POSX_TX = b'  HUD_STATS_POS_X = titleX - Cars_gNumHumanRaceCars * 0x4b;\n'
INPLACE = [(HDR, b'  titleX = 0xa0;\n' + HDR), (POSX, POSX_TX), (TX, TX_INPLACE)]

ONE = [(DECL, DECL + b'  int one;\n'),
       (HDR, b'  one = 1;\n' + HDR),
       (GUARDS, GUARDS.replace(b'== 1) {', b'== one) {'))]

VARIANTS = {
    'pf_below': PF_BELOW,
    'pf_rows': PF_BELOW + ROWS,
    'rows_only': ROWS,
    'pf_rows_ip': INPLACE + PF_BELOW + ROWS,
    'pf_rows_one': ONE + PF_BELOW + ROWS,
    'pf_rows_ip_one': INPLACE + ONE + PF_BELOW + ROWS,
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

"""w64-a13 rprobe2 -- RaceStatistics NEW STRUCTURAL READING.

w63-a13 read retail's prologue as "THREE NAMED CONSTANTS" (0x96/$a1, 0xA0/$s7, 1/$s2)
and probed them as pure constants -> 152 @473.  Re-reading the WHOLE oracle shows two of
the three are not constants at all, they are TWO-ROLE VARIABLES mutated in place:

  $s7:  addiu $s7,$zero,0xA0        (insn 6, interleaved with the saves)
        subu  $s4,$s7,$v1           HUD_STATS_POS_X = titleX - n*0x4b
        subu  $s7,$s7,$v0           titleX = titleX - textw/2      <-- IN PLACE
        (then reused as the j/loop counter much later -- a separate pseudo)
  $s2:  addiu $s2,$zero,0x1         (insn 8)
        bne   $a2,$s2 / bne $v0,$s2  the two `== 1` tests
        sw    $s2,0x10($sp)          the FIRST Hud_FBuildF4's 5th arg
        (then colmid, a separate block-local pseudo)
  $s5:  addiu $s5,$zero,0xA0        SEPARATE materialisation for col2 (w46's "route cx
                                    to all three sites incl. col2" was therefore WRONG)

Because both cross calls they are callee-saved BY CONSTRUCTION -- no fence needed, which
is what makes this different from every "named constant + fence" wave (w45/w46/w50/w63).
"""
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
GUARDS = (b'  if (GameSetup_gData.numLaps == 1) {\n'
          b'    HUD_STATS_SIZE_H = (GameSetup_gData.numLaps + 1) * 0xc + 0x1c;\n  }\n'
          b'  if (GameSetup_gData.raceType == 1) {\n'
          b'    HUD_STATS_SIZE_H = HUD_STATS_SIZE_H + 0x1b;\n  }\n')
FB1 = (b"  Hud_FBuildF4(0,HUD_STATS_POS_X,((titleY + 0x11) * 0x10000 >> 0x10) + 0xb,"
       b"(int)HUD_STATS_SIZE_W,1,0,'\\0','\\0');\n")

# --- the in-place titleX pieces -------------------------------------------------
TX_INPLACE = (b'  titleX = titleX - (textpixels(TextSys_Word(0x39)) >> 1);\n'
              b'  col1 = HUD_STATS_POS_X + 0xa;\n  col2 = 0xa0;\n')
TX_AFTER = (b'  col1 = HUD_STATS_POS_X + 0xa;\n  col2 = 0xa0;\n'
            b'  titleX = titleX - (textpixels(TextSys_Word(0x39)) >> 1);\n')
POSX_TX = b'  HUD_STATS_POS_X = titleX - Cars_gNumHumanRaceCars * 0x4b;\n'

INPLACE = [(HDR, b'  titleX = 0xa0;\n' + HDR), (POSX, POSX_TX), (TX, TX_INPLACE)]
INPLACE_L = [(HDR, b'  titleX = 0xa0;\n' + HDR), (POSX, POSX_TX), (TX, TX_AFTER)]
# titleX init AFTER the SIZE_H statement instead of before it
INPLACE_P2 = [(HDR, HDR + b'  titleX = 0xa0;\n'), (POSX, POSX_TX), (TX, TX_INPLACE)]
# titleX init between SIZE_W and POS_X
INPLACE_P3 = [(SZW, SZW + b'  titleX = 0xa0;\n'), (POSX, POSX_TX), (TX, TX_INPLACE)]

ONE = [(DECL, DECL + b'  int one;\n'),
       (HDR, b'  one = 1;\n' + HDR),
       (GUARDS, GUARDS.replace(b'== 1) {', b'== one) {')),
       (FB1, FB1.replace(b"(int)HUD_STATS_SIZE_W,1,0,", b"(int)HUD_STATS_SIZE_W,one,0,"))]
ONE_NOARG = [(DECL, DECL + b'  int one;\n'),
             (HDR, b'  one = 1;\n' + HDR),
             (GUARDS, GUARDS.replace(b'== 1) {', b'== one) {'))]
PITCH = [(DECL, DECL + b'  int pitch;\n'),
         (HDR, b'  pitch = 0x96;\n' + HDR),
         (SZW, b'  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * pitch;\n')]

VARIANTS = {
    'base': [],
    'inplace': INPLACE,
    'inplace_late': INPLACE_L,
    'inplace_p2': INPLACE_P2,
    'inplace_p3': INPLACE_P3,
    'one': ONE,
    'one_noarg': ONE_NOARG,
    'inplace_one': INPLACE + ONE,
    'inplace_one_noarg': INPLACE + ONE_NOARG,
    'inplace_pitch': INPLACE + PITCH,
    'inplace_one_pitch': INPLACE + ONE + PITCH,
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

"""w64-a13 rprobe3 -- RaceStatistics: the w45 use-fence on `pitch` (which is the ONLY
device known to stop sched1 hoisting the `lw numHuman; mult` chain above the register
saves, i.e. the thing that turns our `mflo $t1; sw 132(sp)` spill into retail's
`mflo $s3`) COMBINED with the w64 in-place-titleX reading.

Read off the side_by_side of `inplace_pitch` (473/475):
  * ours ALREADY emits retail's split base for numLaps (`lui t1; addiu t1; lw a1,4(t1)`)
    -- the 2 missing addiu are NOT an addressing-shape problem at this basin;
  * ours still SPILLS the product (`mflo t1; sw t1,132(sp)` + `lhu` reload);
  * retail reads numLaps FIRST (address at insn 2-3), ours reads Cars_gNumHumanRaceCars
    first because `pitch = 0x96` sits above the SIZE_H statement.
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

TX_INPLACE = (b'  titleX = titleX - (textpixels(TextSys_Word(0x39)) >> 1);\n'
              b'  col1 = HUD_STATS_POS_X + 0xa;\n  col2 = 0xa0;\n')
POSX_TX = b'  HUD_STATS_POS_X = titleX - Cars_gNumHumanRaceCars * 0x4b;\n'
SZW_P = b'  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * pitch;\n'

INPLACE = [(HDR, b'  titleX = 0xa0;\n' + HDR), (POSX, POSX_TX), (TX, TX_INPLACE)]
INPLACE_A = [(HDR, HDR + b'  titleX = 0xa0;\n'), (POSX, POSX_TX), (TX, TX_INPLACE)]

FENCE = b'  __asm__ volatile("" : : "r"(pitch));\n'
PD = (DECL, DECL + b'  int pitch;\n')

# pitch+fence ABOVE the SIZE_H statement (numLaps read second)
PF_ABOVE = [PD, (HDR, b'  pitch = 0x96;\n' + FENCE + HDR), (SZW, SZW_P)]
# pitch+fence BELOW the SIZE_H statement (numLaps read first, like retail)
PF_BELOW = [PD, (HDR, HDR + b'  pitch = 0x96;\n' + FENCE), (SZW, SZW_P)]
# pitch above, fence below SIZE_H
PF_SPLIT = [PD, (HDR, b'  pitch = 0x96;\n' + HDR + FENCE), (SZW, SZW_P)]
# no fence, pitch below SIZE_H
P_BELOW = [PD, (HDR, HDR + b'  pitch = 0x96;\n'), (SZW, SZW_P)]

ONE = [(DECL, DECL + b'  int one;\n'),
       (HDR, b'  one = 1;\n' + HDR),
       (GUARDS, GUARDS.replace(b'== 1) {', b'== one) {'))]

VARIANTS = {
    'base': [],
    'pf_above': PF_ABOVE,
    'pf_below': PF_BELOW,
    'pf_split': PF_SPLIT,
    'p_below': P_BELOW,
    'ip_pf_above': INPLACE + PF_ABOVE,
    'ip_pf_below': INPLACE + PF_BELOW,
    'ip_pf_split': INPLACE + PF_SPLIT,
    'ip_p_below': INPLACE + P_BELOW,
    'ipa_pf_below': INPLACE_A + PF_BELOW,
    'ip_pf_below_one': INPLACE + PF_BELOW + ONE,
    'pf_below_one': PF_BELOW + ONE,
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

"""rprobe.py -- RaceStatistics: retail's PROLOGUE materialises THREE named constants
(`addiu a1,zero,0x96` insn 4, `addiu s7,zero,0xA0` insn 6, `addiu s2,zero,1` insn 8) and
that is what makes 0x96 a real `mult` operand and both `== 1` tests register compares.
Every earlier wave probed `pitch = 0x96` ALONE (w40, w49: mult appears but LCS worse).
13F/04Z: land the SET, not one member.  w63-a13."""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/overlays.cpp'
FN = 'RaceStatistics__Fv'

SZW = b'  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * 0x96;\n'
POSX = b'  HUD_STATS_POS_X = 0xa0 - Cars_gNumHumanRaceCars * 0x4b;\n'
NL1 = b'  if (GameSetup_gData.numLaps == 1) {\n'
RT1 = b'  if (GameSetup_gData.raceType == 1) {\n'
DECL = b'  int titleY;\n'

D3 = b'  int titleY;\n  int pitch;\n  int centre;\n  int one;\n'
INIT3 = (b'  pitch = 0x96;\n  centre = 0xa0;\n  one = 1;\n')
HDR = b'  HUD_STATS_SIZE_H = (GameSetup_gData.numLaps + 1) * 0xc + 0x28;\n'

VARIANTS = {
 'base': [],
 'pitch_only': [(DECL, b'  int titleY;\n  int pitch;\n'),
                (HDR, b'  pitch = 0x96;\n' + HDR),
                (SZW, b'  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * pitch;\n')],
 'pitch_centre': [(DECL, b'  int titleY;\n  int pitch;\n  int centre;\n'),
                (HDR, b'  pitch = 0x96;\n  centre = 0xa0;\n' + HDR),
                (SZW, b'  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * pitch;\n'),
                (POSX, b'  HUD_STATS_POS_X = centre - Cars_gNumHumanRaceCars * 0x4b;\n')],
 'all_three': [(DECL, D3), (HDR, INIT3 + HDR),
                (SZW, b'  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * pitch;\n'),
                (POSX, b'  HUD_STATS_POS_X = centre - Cars_gNumHumanRaceCars * 0x4b;\n'),
                (NL1, b'  if (GameSetup_gData.numLaps == one) {\n'),
                (RT1, b'  if (GameSetup_gData.raceType == one) {\n')],
 'centre_one': [(DECL, b'  int titleY;\n  int centre;\n  int one;\n'),
                (HDR, b'  centre = 0xa0;\n  one = 1;\n' + HDR),
                (POSX, b'  HUD_STATS_POS_X = centre - Cars_gNumHumanRaceCars * 0x4b;\n'),
                (NL1, b'  if (GameSetup_gData.numLaps == one) {\n'),
                (RT1, b'  if (GameSetup_gData.raceType == one) {\n')],
 'pitch_one': [(DECL, b'  int titleY;\n  int pitch;\n  int one;\n'),
                (HDR, b'  pitch = 0x96;\n  one = 1;\n' + HDR),
                (SZW, b'  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * pitch;\n'),
                (NL1, b'  if (GameSetup_gData.numLaps == one) {\n'),
                (RT1, b'  if (GameSetup_gData.raceType == one) {\n')],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

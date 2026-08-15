"""w64-a13 rprobe5 -- micro-dials on the pf_rows_ip basin (475/475, census addiu 69v70 +
nop 24v23 only).  The visible residual at the head is ONE redundant copy:
    OURS   addu v0,s1,zero ; subu s4,v0,v1
    ORACLE subu s4,s7,v1
i.e. gcc copies titleX out before reading it, so 160 never becomes titleX's own register
and the whole s1/s2/s7/fp band stays rotated one slot from retail's."""
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

FENCE = b'  __asm__ volatile("" : : "r"(pitch));\n'
SZW_P = b'  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * pitch;\n'
PD = (DECL, DECL + b'  int pitch;\n')
PF = [PD, (HDR, HDR + b'  pitch = 0x96;\n' + FENCE), (SZW, SZW_P)]
ROWS = [(DECL, DECL + b'  int rows;\n'),
        (HDR, b'  rows = (GameSetup_gData.numLaps + 1) * 0xc;\n'
              b'  HUD_STATS_SIZE_H = rows + 0x28;\n'),
        (ARM, b'    HUD_STATS_SIZE_H = rows + 0x1c;\n')]

TX_INPLACE = (b'  titleX = titleX - (textpixels(TextSys_Word(0x39)) >> 1);\n'
              b'  col1 = HUD_STATS_POS_X + 0xa;\n  col2 = 0xa0;\n')
POSX_TX = b'  HUD_STATS_POS_X = titleX - Cars_gNumHumanRaceCars * 0x4b;\n'
IP = [(HDR, b'  titleX = 0xa0;\n' + HDR), (POSX, POSX_TX), (TX, TX_INPLACE)]
# titleX init early but POS_X keeps the LITERAL (cse shares the 160 anyway)
IP_LIT = [(HDR, b'  titleX = 0xa0;\n' + HDR), (TX, TX_INPLACE)]
# identity launder on titleX right after its init
LAUND = (b'  titleX = 0xa0;\n',
         b'  titleX = 0xa0;\n  __asm__ ("" : "=r"(titleX) : "0"(titleX));\n')
# col1 through an explicit temp (retail: addiu v1,s4,10 ; addu s6,v1,zero)
COL1T = (b'  col1 = HUD_STATS_POS_X + 0xa;\n',
         b'  { int c1 = HUD_STATS_POS_X + 0xa; col1 = c1; }\n')

BASE = IP + PF + ROWS
BASE_L = IP_LIT + PF + ROWS

VARIANTS = {
    'ip': BASE,
    'ip_lit': BASE_L,
    'ip_laund': BASE + [LAUND],
    'ip_lit_laund': BASE_L + [LAUND],
    'ip_col1t': BASE + [COL1T],
    'ip_lit_col1t': BASE_L + [COL1T],
    'ip_laund_col1t': BASE + [LAUND, COL1T],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

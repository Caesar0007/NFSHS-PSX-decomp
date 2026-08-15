"""w64-a13 rprobe6 -- REQDELTA-PRICED dials on the `ip` basin (475/475 count-exact).

allocsim MATCHES 49/49 on this basin.  multidial (--want p95=s7,p123=s2) prices the
titleX half EXACTLY: **p95 (titleX, the /v SI pseudo born as `(const_int 160)`) needs
live 57 -> 61, i.e. +4 RTL insns inside its range, and it then lands in retail's $s7.**
(p123, the anonymous cse constant 1, then falls to $s1 instead of retail's $s2; that half
needs a second, unpriced dial -- p257's $s2 is a pointer at pri 0.3529.)

These variants try to buy the +4 as a BIRTH move (pin the `li 160` early with a barrier,
which is where retail has it: insn 6, interleaved with the saves) or as a DEATH move.
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
ARM = b'    HUD_STATS_SIZE_H = (GameSetup_gData.numLaps + 1) * 0xc + 0x1c;\n'
FTXY = (b'  Font_TextXY(TextSys_Word(0x39),titleX * 0x10000 >> 0x10,titleY);\n')

FENCE = b'  __asm__ volatile("" : : "r"(pitch));\n'
FENCE2 = b'  __asm__ volatile("" : : "r"(pitch), "r"(titleX));\n'
SZW_P = b'  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * pitch;\n'
PD = (DECL, DECL + b'  int pitch;\n')
ROWSTXT = (b'  rows = (GameSetup_gData.numLaps + 1) * 0xc;\n'
           b'  HUD_STATS_SIZE_H = rows + 0x28;\n')
TX_INPLACE = (b'  titleX = titleX - (textpixels(TextSys_Word(0x39)) >> 1);\n'
              b'  col1 = HUD_STATS_POS_X + 0xa;\n  col2 = 0xa0;\n')
TX_AFTER = (b'  col1 = HUD_STATS_POS_X + 0xa;\n  col2 = 0xa0;\n'
            b'  titleX = titleX - (textpixels(TextSys_Word(0x39)) >> 1);\n')
POSX_TX = b'  HUD_STATS_POS_X = titleX - Cars_gNumHumanRaceCars * 0x4b;\n'

# base = IP + PF + ROWS, expressed as one ordered edit list
BASE = [PD,
        (HDR, b'  titleX = 0xa0;\n' + ROWSTXT + b'  pitch = 0x96;\n' + FENCE),
        (SZW, SZW_P), (POSX, POSX_TX), (TX, TX_INPLACE),
        (DECL, DECL + b'  int rows;\n'),
        (ARM, b'    HUD_STATS_SIZE_H = rows + 0x1c;\n')]


def rebase(fence=FENCE, tx=TX_INPLACE, tx_first=True, extra=None):
    hdr = (b'  titleX = 0xa0;\n' + ROWSTXT + b'  pitch = 0x96;\n' + fence
           if tx_first else
           ROWSTXT + b'  pitch = 0x96;\n  titleX = 0xa0;\n' + fence)
    out = [PD, (HDR, hdr), (SZW, SZW_P), (POSX, POSX_TX), (TX, tx),
           (DECL, DECL + b'  int rows;\n'),
           (ARM, b'    HUD_STATS_SIZE_H = rows + 0x1c;\n')]
    if extra:
        out += extra
    return out


F_TX_ONLY = (b'  titleX = 0xa0;\n', b'  titleX = 0xa0;\n'
             b'  __asm__ volatile("" : : "r"(titleX));\n')
F_BEFORE_TXY = (FTXY, b'  __asm__ volatile("" : : "r"(col1));\n' + FTXY)
F_BEFORE_TXY2 = (FTXY, b'  __asm__ volatile("" : : "r"(col1), "r"(col2));\n' + FTXY)

VARIANTS = {
    'ip': rebase(),
    't1_fence2': rebase(fence=FENCE2),
    't2_tx_after_pitch': rebase(tx_first=False),
    't3_own_fence': rebase(extra=[F_TX_ONLY]),
    't4_tx_late': rebase(tx=TX_AFTER),
    't5_fence_txy': rebase(extra=[F_BEFORE_TXY]),
    't6_f2_txy': rebase(fence=FENCE2, extra=[F_BEFORE_TXY]),
    't7_txy2': rebase(extra=[F_BEFORE_TXY2]),
    't8_own_txy': rebase(extra=[F_TX_ONLY, F_BEFORE_TXY]),
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

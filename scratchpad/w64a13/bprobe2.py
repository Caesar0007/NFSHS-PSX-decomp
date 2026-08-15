"""w64-a13 bprobe2 -- Hud_BTCStats cluster (b), read straight off the ORACLE loop body
(w63's census bounds the entire 24 to this one extra `subu`):

    sll v0,s7,16 ; sra s2,v0,16          s2 = (int)SIZE_H     ] hoisted ABOVE the loop
    lhu t0,0x70(sp); sll; sra v0         v0 = (int)POS_Y      ]
    subu s1,s0,v0                        s1 = yoff = (startY+0xf) - POS_Y
  loop:
    beqz t0,.else                        t0 = postgame
      addiu v0,s1,8                        yoff + 8
      j .join
      subu v0,s2,v0                        SIZE_H - (yoff+8)
    .else:
      subu v0,s2,s1                        SIZE_H - yoff
    .join:
    beqz showtimeleft ; addiu v0,v0,-0x10

=> retail's arms are TWO COMPLETE SUBTRACTIONS over a LOOP-INVARIANT yoff/sizeH pair.
w53 measured the bare two-arm ternary (37 @474) and w60 measured a hoisted `yoff` local
(33 @474) but NEVER the two together, and never with the int SIZE_H also hoisted -- the
+1 insn in both single-lever measurements is exactly what a missing hoist looks like.
"""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/overlays.cpp'
FN = 'Hud_BTCStats__Fsb'

DECL = b'  short HUD_STATS_TEXT_START_Y;\n'
LOOP = b'  for (i = 1; i < 4; i = i + 1) {\n'
ARG = (b"    Hud_FBuildF4(0,col[i] - 2,startY + 0xf,1,\n"
       b"                 HUD_STATS_SIZE_H - ((startY + 0xf + (postgame ? 8 : 0)) - HUD_STATS_POS_Y) -\n"
       b"                 (showtimeleft ? 0x10 : 0),0,'\\0','\\0');\n")


def arg(expr):
    return (b"    Hud_FBuildF4(0,col[i] - 2,startY + 0xf,1,\n"
            b"                 " + expr + b",0,'\\0','\\0');\n")


SHOW = b"(showtimeleft ? 0x10 : 0)"
INL = b"((startY + 0xf) - HUD_STATS_POS_Y)"
YD = (DECL, DECL + b'  int yoff;\n')
SD = (DECL, DECL + b'  int sizeH;\n')
HOIST_Y = (LOOP, b'  yoff = (startY + 0xf) - HUD_STATS_POS_Y;\n' + LOOP)
HOIST_S = (LOOP, b'  sizeH = HUD_STATS_SIZE_H;\n' + LOOP)


def tern(sz, yo):
    return (b"(postgame ? " + sz + b" - (" + yo + b" + 8) : " + sz + b" - " + yo + b") - " + SHOW)


VARIANTS = {
    'base': [],
    # two-arm ternary, everything inline (w53's 37 @474 control)
    'tern_inline': [(ARG, arg(tern(b"HUD_STATS_SIZE_H", INL)))],
    # + hoisted yoff local
    'tern_yoff': [YD, HOIST_Y, (ARG, arg(tern(b"HUD_STATS_SIZE_H", b"yoff")))],
    # + hoisted yoff AND int sizeH
    'tern_yoff_sz': [YD, SD, HOIST_Y, HOIST_S, (ARG, arg(tern(b"sizeH", b"yoff")))],
    # hoisted sizeH only
    'tern_sz': [SD, HOIST_S, (ARG, arg(tern(b"sizeH", INL)))],
    # hoists WITHOUT the two-arm ternary (control: does the hoist alone cost?)
    'hoist_only': [YD, SD, HOIST_Y, HOIST_S,
                   (ARG, arg(b"sizeH - ((startY + 0xf + (postgame ? 8 : 0)) - HUD_STATS_POS_Y) - " + SHOW))],
    'hoist_y_only': [YD, HOIST_Y,
                     (ARG, arg(b"HUD_STATS_SIZE_H - (yoff + (postgame ? 8 : 0)) - " + SHOW))],
    # two-arm ternary where only the POSTGAME arm carries the +8, showtimeleft folded in
    'tern_yoff_sz2': [YD, SD, HOIST_Y, HOIST_S,
                      (ARG, arg(b"(postgame ? sizeH - (yoff + 8) : sizeH - yoff) - " + SHOW))],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

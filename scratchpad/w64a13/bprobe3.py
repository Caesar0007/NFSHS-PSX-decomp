"""w64-a13 bprobe3 -- Hud_BTCStats.  The two-arm ternary + hoisted yoff/sizeH (bprobe2
`tern_yoff_sz`, 33 @474) FIXES the census's `subu 12v11` -- the one opcode w63 bounded the
whole 24 to -- and leaves `addiu 52v51 addu 68v67 nop 24v25`.  The side_by_side says the
new +1 addiu/+1 addu are the `startY + 0xf` term: retail computes it ONCE into an int
(`sll s0,s6,16; sra s0; addiu s0,s0,15`) and passes `addu a2,s0,zero` at every call AND
derives yoff from that same s0; ours re-derives it and stages a second copy.
w60 measured a `startY + 0xf` local ALONE at 26 @473 -- never together with the arm fix.
"""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/overlays.cpp'
FN = 'Hud_BTCStats__Fsb'

DECL = b'  short HUD_STATS_TEXT_START_Y;\n'
LOOP = b'  for (i = 1; i < 4; i = i + 1) {\n'
CALL1 = b"  Hud_FBuildF4(0,HUD_STATS_POS_X,startY + 0xf,HUD_STATS_SIZE_W,1,0,'\\0','\\0');\n"
ARG = (b"    Hud_FBuildF4(0,col[i] - 2,startY + 0xf,1,\n"
       b"                 HUD_STATS_SIZE_H - ((startY + 0xf + (postgame ? 8 : 0)) - HUD_STATS_POS_Y) -\n"
       b"                 (showtimeleft ? 0x10 : 0),0,'\\0','\\0');\n")
SHOWCALL = (b"    Hud_FBuildF4(0,HUD_STATS_POS_X,\n"
            b"                 (startY + 0xf + HUD_STATS_SIZE_H - (postgame ? 8 : 0)) -\n"
            b"                 (startY + 0xf - HUD_STATS_POS_Y) - 0x10,HUD_STATS_SIZE_W,1,0,'\\0','\\0');\n")

SHOW = b"(showtimeleft ? 0x10 : 0)"
YD = (DECL, DECL + b'  int yoff;\n')
SD = (DECL, DECL + b'  int sizeH;\n')
PD = (DECL, DECL + b'  int yplus;\n')

# yplus = startY + 0xf, minted at the FIRST call site (retail's s0) and reused everywhere
MINT = (CALL1, b'  yplus = startY + 0xf;\n'
        b"  Hud_FBuildF4(0,HUD_STATS_POS_X,yplus,HUD_STATS_SIZE_W,1,0,'\\0','\\0');\n")
SHOW_Y = (SHOWCALL,
          b"    Hud_FBuildF4(0,HUD_STATS_POS_X,\n"
          b"                 (yplus + HUD_STATS_SIZE_H - (postgame ? 8 : 0)) -\n"
          b"                 (yplus - HUD_STATS_POS_Y) - 0x10,HUD_STATS_SIZE_W,1,0,'\\0','\\0');\n")
HOIST_Y = (LOOP, b'  yoff = yplus - HUD_STATS_POS_Y;\n' + LOOP)
HOIST_S = (LOOP, b'  sizeH = HUD_STATS_SIZE_H;\n' + LOOP)


def arg(expr, y=b'startY + 0xf'):
    return (b"    Hud_FBuildF4(0,col[i] - 2," + y + b",1,\n"
            b"                 " + expr + b",0,'\\0','\\0');\n")


TERN = (b"(postgame ? sizeH - (yoff + 8) : sizeH - yoff) - " + SHOW)
PLAIN = (b"HUD_STATS_SIZE_H - ((yplus + (postgame ? 8 : 0)) - HUD_STATS_POS_Y) - " + SHOW)

VARIANTS = {
    'base': [],
    # w60 control: yplus alone
    'yplus': [PD, MINT, SHOW_Y, (ARG, arg(PLAIN, b'yplus'))],
    # the full stack
    'full': [PD, YD, SD, MINT, SHOW_Y, HOIST_Y, HOIST_S, (ARG, arg(TERN, b'yplus'))],
    # full but showtimeleft call left alone
    'full_nosh': [PD, YD, SD, MINT, HOIST_Y, HOIST_S, (ARG, arg(TERN, b'yplus'))],
    # full without the sizeH hoist
    'full_nosz': [PD, YD, MINT, SHOW_Y, HOIST_Y,
                  (ARG, arg(b"(postgame ? HUD_STATS_SIZE_H - (yoff + 8) : HUD_STATS_SIZE_H - yoff) - "
                            + SHOW, b'yplus'))],
    # yplus + two-arm ternary, yoff/sizeH inline (no extra locals)
    'yplus_tern': [PD, MINT, SHOW_Y,
                   (ARG, arg(b"(postgame ? HUD_STATS_SIZE_H - ((yplus - HUD_STATS_POS_Y) + 8)"
                             b" : HUD_STATS_SIZE_H - (yplus - HUD_STATS_POS_Y)) - " + SHOW, b'yplus'))],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

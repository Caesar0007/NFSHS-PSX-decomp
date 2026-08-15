"""w64-a13 bprobe -- Hud_BTCStats cluster (b), the ONE extra `subu` the w63 census bounds
the whole 24 to.  Target shape (retail): `addiu v0,s1,8 ; subu v0,s2,v0` where s1 is the
SHARED cse temp yoff = (startY+0xf) - POS_Y and s2 = (int)SIZE_H.

w60-a7 proved BOTH natural spellings fold and retail folded NEITHER, so the route is a
fold ESCAPE.  Two documented devices this receipt stack has never tried on the INNER term:
  * catalog 14C EMBEDDED ASSIGNMENT: a MODIFY_EXPR operand blocks fold()'s reassociation
    (`x = (a + (h = b + K)) & m`, creatememclass).  w49 tried it on the OUTER `inset`
    (48 @469, 4 short) but never on `yoff` itself, which is the term retail SHARES.
  * catalog Font-r12 FOLD-REWRITE ESCAPE: split_tree's varsign=-1 branch rewrites
    (CON-VAR)+ARG1 -> (CON+ARG1)-VAR and fold never re-folds its own rewrite output.
"""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/overlays.cpp'
FN = 'Hud_BTCStats__Fsb'

DECL = b'  short HUD_STATS_TEXT_START_Y;\n'
ARG = (b"    Hud_FBuildF4(0,col[i] - 2,startY + 0xf,1,\n"
       b"                 HUD_STATS_SIZE_H - ((startY + 0xf + (postgame ? 8 : 0)) - HUD_STATS_POS_Y) -\n"
       b"                 (showtimeleft ? 0x10 : 0),0,'\\0','\\0');\n")


def arg(expr):
    return (b"    Hud_FBuildF4(0,col[i] - 2,startY + 0xf,1,\n"
            b"                 " + expr + b",0,'\\0','\\0');\n")


SHOW = b"(showtimeleft ? 0x10 : 0)"
YOFF = b"((startY + 0xf) - HUD_STATS_POS_Y)"
YASSIGN = b"(yoff = (startY + 0xf) - HUD_STATS_POS_Y)"
PG = b"(postgame ? 8 : 0)"
YD = (DECL, DECL + b'  int yoff;\n')

V = {
    # control
    'base': [],
    # 1. embedded assignment on the SHARED term, +8 outside it
    'emb_yoff': [YD, (ARG, arg(b"HUD_STATS_SIZE_H - (" + YASSIGN + b" + " + PG + b") - " + SHOW))],
    # 2. same but addend first
    'emb_yoff_addend1': [YD, (ARG, arg(b"HUD_STATS_SIZE_H - (" + PG + b" + " + YASSIGN + b") - " + SHOW))],
    # 3. embedded assignment INSIDE the parenthesised startY term
    'emb_startY': [YD, (ARG, arg(b"HUD_STATS_SIZE_H - (((yoff = startY + 0xf) - HUD_STATS_POS_Y) + "
                                 + PG + b") - " + SHOW))],
    # 4. FOLD-REWRITE ESCAPE (varsign=-1) on the subtrahend
    'split_tree': [(ARG, arg(b"HUD_STATS_SIZE_H - (" + PG + b" - HUD_STATS_POS_Y + (startY + 0xf)) - "
                             + SHOW))],
    # 5. same escape, showtimeleft folded into the same subtrahend
    'split_tree2': [(ARG, arg(b"HUD_STATS_SIZE_H - (" + PG + b" - HUD_STATS_POS_Y + (startY + 0xf) + "
                              + SHOW + b")"))],
    # 6. escape with the const term written as a difference the fold cannot fuse
    'split_tree3': [(ARG, arg(b"HUD_STATS_SIZE_H - (" + PG + b" + (startY + 0xf) - HUD_STATS_POS_Y) - "
                              + SHOW))],
    # 7. embedded assignment + showtimeleft first
    'emb_show1': [YD, (ARG, arg(b"HUD_STATS_SIZE_H - " + SHOW + b" - (" + YASSIGN + b" + " + PG + b")"))],
    # 8. the SECOND (showtimeleft) call site mints yoff instead -- w60 named angle
    'mint_second': [YD,
                    (b"                 (startY + 0xf + HUD_STATS_SIZE_H - (postgame ? 8 : 0)) -\n"
                     b"                 (startY + 0xf - HUD_STATS_POS_Y) - 0x10,HUD_STATS_SIZE_W,1,0,'\\0','\\0');\n",
                     b"                 (startY + 0xf + HUD_STATS_SIZE_H - (postgame ? 8 : 0)) -\n"
                     b"                 (yoff = startY + 0xf - HUD_STATS_POS_Y) - 0x10,HUD_STATS_SIZE_W,1,0,'\\0','\\0');\n")],
    # 9. both: mint at the second site AND consume the same local in the loop
    'mint_and_use': None,
}
del V['mint_and_use']

VARIANTS = V

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

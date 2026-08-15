"""w64-a13 bhprobe2 -- Hrz_BuildHorizon, building on `lit_w` (132 -> 118 @471/473).

Spelling the clipW read as the LITERAL scratchpad address `*(short *)0x1f800010` (instead
of `*(short *)((int)hsd + 0x10)`) re-materialises the base exactly like retail
(`lui v0,8064; lhu v0,16(v0)`) and is worth -14.  But it also flips the LOAD WIDTH:
   ours   lui v1,8064 ; lh  v1,16(v1)                (combine fuses the sign-extend)
   oracle lui v0,8064 ; lhu v0,16(v0) ; sll ; sra    (extend kept separate)
census after lit_w: `lh 27v26  lhu 12v13  lui 27v28  nop 79v78  sll 5v6  sra 1v2`.
=> read it as an UNSIGNED short and cast, which is the catalog's DISTINCT-EXTENSION rule.
"""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/hrzsku.cpp'
FN = 'Hrz_BuildHorizon__FP13DRender_tView'

W = b'*(short *)((int)hsd + 0x10)'
H = b'*(short *)((int)hsd + 0x12)'


def cond(w, h):
    return (b"            if ((mpts[0].vx >= 0 || mpts[1].vx >= 0 || mpts[2].vx >= 0 || mpts[3].vx >= 0) &&\n"
            b"                (" + w + b" >= mpts[0].vx || " + w + b" >= mpts[1].vx ||\n"
            b"                 " + w + b" >= mpts[2].vx || " + w + b" >= mpts[3].vx) &&\n"
            b"                (mpts[0].vy >= 0 || mpts[1].vy >= 0 || mpts[2].vy >= 0 || mpts[3].vy >= 0) &&\n"
            b"                (" + h + b" >= mpts[0].vy || " + h + b" >= mpts[1].vy ||\n"
            b"                 " + h + b" >= mpts[2].vy || " + h + b" >= mpts[3].vy)) {\n")


COND = cond(W, H)
LW = b'*(short *)0x1f800010'
LH = b'*(short *)0x1f800012'
UW = b'(short)*(u_short *)0x1f800010'
UH = b'(short)*(u_short *)0x1f800012'
HW = b'(short)*(u_short *)((int)hsd + 0x10)'
HH = b'(short)*(u_short *)((int)hsd + 0x12)'

VARIANTS = {
    'lit_w': [(COND, cond(LW, H))],
    'uw': [(COND, cond(UW, H))],
    'uw_uh': [(COND, cond(UW, UH))],
    'uw_lh': [(COND, cond(UW, LH))],
    'lit_w_hh': [(COND, cond(LW, HH))],
    'uw_hh': [(COND, cond(UW, HH))],
    'hw_only': [(COND, cond(HW, H))],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

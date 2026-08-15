"""w64-a13 bhprobe -- Hrz_BuildHorizon.  The w63 census says the ENTIRE 2-insn shortfall
is `lui 26 v 28`, and the side_by_side NAMES both of them: they are the two clip reads.

   ORACLE   lui v0,8064 ; lhu v0,16(v0)        (fresh base per clip read)
   OURS     lhu v0,16(s5)                      (off the hoisted hsd base)

So retail did NOT reach clipW/clipH through the `hsd` pointer at these two sites -- it
re-materialised the scratchpad base.  w61 measured the plain literal spelling in a
DIFFERENT basin (207 @470); 04Z says re-measure.  The untried device is the w47/13B
OPACITY LAUNDER on a per-site base local: `int hb = 0x1f800000;
__asm__("" : "=r"(hb) : "0"(hb));` is zero-insn and cse-opaque, so the base cannot be
equated with hsd's and must be materialised fresh = retail's `lui` + displacement pair.
"""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/hrzsku.cpp'
FN = 'Hrz_BuildHorizon__FP13DRender_tView'

W = b'*(short *)((int)hsd + 0x10)'
H = b'*(short *)((int)hsd + 0x12)'
COND = (
    b"            if ((mpts[0].vx >= 0 || mpts[1].vx >= 0 || mpts[2].vx >= 0 || mpts[3].vx >= 0) &&\n"
    b"                (" + W + b" >= mpts[0].vx || " + W + b" >= mpts[1].vx ||\n"
    b"                 " + W + b" >= mpts[2].vx || " + W + b" >= mpts[3].vx) &&\n"
    b"                (mpts[0].vy >= 0 || mpts[1].vy >= 0 || mpts[2].vy >= 0 || mpts[3].vy >= 0) &&\n"
    b"                (" + H + b" >= mpts[0].vy || " + H + b" >= mpts[1].vy ||\n"
    b"                 " + H + b" >= mpts[2].vy || " + H + b" >= mpts[3].vy)) {\n")


def cond(w, h, pre=b''):
    return (pre +
            b"            if ((mpts[0].vx >= 0 || mpts[1].vx >= 0 || mpts[2].vx >= 0 || mpts[3].vx >= 0) &&\n"
            b"                (" + w + b" >= mpts[0].vx || " + w + b" >= mpts[1].vx ||\n"
            b"                 " + w + b" >= mpts[2].vx || " + w + b" >= mpts[3].vx) &&\n"
            b"                (mpts[0].vy >= 0 || mpts[1].vy >= 0 || mpts[2].vy >= 0 || mpts[3].vy >= 0) &&\n"
            b"                (" + h + b" >= mpts[0].vy || " + h + b" >= mpts[1].vy ||\n"
            b"                 " + h + b" >= mpts[2].vy || " + h + b" >= mpts[3].vy)) {\n")


LIT_W = b'*(short *)0x1f800010'
LIT_H = b'*(short *)0x1f800012'
VOL_W = b'*(volatile short *)0x1f800010'
VOL_H = b'*(volatile short *)0x1f800012'

LAUND1 = (b'            int hb;\n'
          b'            hb = 0x1f800000;\n'
          b'            __asm__ ("" : "=r"(hb) : "0"(hb));\n')
LAUND2 = (b'            int hb, hb2;\n'
          b'            hb = 0x1f800000;\n'
          b'            __asm__ ("" : "=r"(hb) : "0"(hb));\n'
          b'            hb2 = 0x1f800000;\n'
          b'            __asm__ ("" : "=r"(hb2) : "0"(hb2));\n')

VARIANTS = {
    'base': [],
    'lit': [(COND, cond(LIT_W, LIT_H))],
    'lit_w': [(COND, cond(LIT_W, H))],
    'lit_h': [(COND, cond(W, LIT_H))],
    'vol': [(COND, cond(VOL_W, VOL_H))],
    'laund1': [(COND, cond(b'*(short *)(hb + 0x10)', b'*(short *)(hb + 0x12)', LAUND1))],
    'laund2': [(COND, cond(b'*(short *)(hb + 0x10)', b'*(short *)(hb2 + 0x12)', LAUND2))],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

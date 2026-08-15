"""w64-a13 bhprobe3 -- Hrz_BuildHorizon: from the new `lit_w` basin (118 @471/473), try to
recover the SECOND missing `lui` (the clipH read, retail `lui v0,8064; lhu v0,18(v0)`,
ours `lhu v0,18(s6)`) without letting cse merge the two scratchpad bases (which is what
makes the both-literal form 1 insn SHORT at 470)."""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/hrzsku.cpp'
FN = 'Hrz_BuildHorizon__FP13DRender_tView'

W = b'*(short *)((int)hsd + 0x10)'
H = b'*(short *)((int)hsd + 0x12)'


def cond(w, h, pre=b''):
    return (pre +
            b"            if ((mpts[0].vx >= 0 || mpts[1].vx >= 0 || mpts[2].vx >= 0 || mpts[3].vx >= 0) &&\n"
            b"                (" + w + b" >= mpts[0].vx || " + w + b" >= mpts[1].vx ||\n"
            b"                 " + w + b" >= mpts[2].vx || " + w + b" >= mpts[3].vx) &&\n"
            b"                (mpts[0].vy >= 0 || mpts[1].vy >= 0 || mpts[2].vy >= 0 || mpts[3].vy >= 0) &&\n"
            b"                (" + h + b" >= mpts[0].vy || " + h + b" >= mpts[1].vy ||\n"
            b"                 " + h + b" >= mpts[2].vy || " + h + b" >= mpts[3].vy)) {\n")


COND = cond(W, H)
LW = b'*(short *)0x1f800010'
LAUND = (b'            int hb;\n'
         b'            hb = 0x1f800000;\n'
         b'            __asm__ ("" : "=r"(hb) : "0"(hb));\n')
FENCE = b'            __asm__ ("" : : "r"(hsd));\n'

VARIANTS = {
    'lit_w': [(COND, cond(LW, H))],
    'lit_w_laundH': [(COND, cond(LW, b'*(short *)(hb + 0x12)', LAUND))],
    'lit_w_lit12': [(COND, cond(LW, b'*(short *)(0x1f800000 + 0x12)'))],
    'lit_w_off': [(COND, cond(LW, b'((short *)0x1f800000)[9]'))],
    'lit_w_fence': [(COND, cond(LW, H, FENCE))],
    'lit_w_h_hsd0': [(COND, cond(LW, b'((Draw_HorizonCache *)0x1f800000)->head.clipH'))],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

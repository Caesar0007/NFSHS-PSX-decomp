"""bhprobe.py -- Hrz_BuildHorizon: the w61 open dial (2) "make the 24-bit mask outrank
the 8-bit one as a LOOP.C MOVABLE".  Both masks currently have exactly 2 in-loop uses and
identical spans, so loop.c hoists the CHEAPER (1-insn lui 0xff000000) and retail hoists
the 2-insn 0xffffff.  Device = the w44 zero-insn semantic no-op RE-MASK (cse folds the
redundant AND, flow/loop.c still see the occurrence) + catalog 13C "LICM TIPS AT N
OCCURRENCES".  w63-a13."""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/hrzsku.cpp'
FN = 'Hrz_BuildHorizon__FP13DRender_tView'

RMW = (b'                *(u_int *)p = *(u_int *)p & 0xff000000 | *pal & 0xffffff;\n'
       b'                *pal = *pal & 0xff000000 | (u_int)p & 0xffffff;\n')

VARIANTS = {
 'base': [],
 # +1 zero-insn occurrence of the 24-bit mask (cse folds the redundant AND)
 'm24_x3': [(RMW,
   b'                *(u_int *)p = *(u_int *)p & 0xff000000 | (*pal & 0xffffff) & 0xffffff;\n'
   b'                *pal = *pal & 0xff000000 | (u_int)p & 0xffffff;\n')],
 'm24_x4': [(RMW,
   b'                *(u_int *)p = *(u_int *)p & 0xff000000 | (*pal & 0xffffff) & 0xffffff;\n'
   b'                *pal = *pal & 0xff000000 | ((u_int)p & 0xffffff) & 0xffffff;\n')],
 # a named pkt24 evaluated first (the Flare_Tri pkt_addr24 idiom, which fixed the sibling
 # Hrz_BuildSky star loop) -- generates the 24-bit mask BEFORE the 8-bit one
 'pkt24_first': [(RMW,
   b'                u_int pkt24 = (u_int)p & 0xffffff;\n'
   b'                *(u_int *)p = *(u_int *)p & 0xff000000 | *pal & 0xffffff;\n'
   b'                *pal = *pal & 0xff000000 | pkt24;\n')],
 'pkt24_first_x3': [(RMW,
   b'                u_int pkt24 = (u_int)p & 0xffffff;\n'
   b'                *(u_int *)p = *(u_int *)p & 0xff000000 | (*pal & 0xffffff) & 0xffffff;\n'
   b'                *pal = *pal & 0xff000000 | pkt24;\n')],
 # NEGATIVE CONTROL: inflate the 8-bit mask instead (should get worse)
 'm8_x3': [(RMW,
   b'                *(u_int *)p = (*(u_int *)p & 0xff000000) & 0xff000000 | *pal & 0xffffff;\n'
   b'                *pal = *pal & 0xff000000 | (u_int)p & 0xffffff;\n')],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

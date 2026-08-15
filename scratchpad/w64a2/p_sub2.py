import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "tools"))
import fast
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from p_sub import stage, SRC, FN, ASMCALL  # noqa

# after the 12D staging landing the ONLY residual is a pure s2<->s3 swap:
# ours p80(sd)=s3 / p91(merged v4+prim)=s2 ; retail sd=s2 / merged=s3.
# allocsim-by-hand: sd pri = 4*25/752 = .1330 ; p91 pri = 3*14/265 = .1585.
# dial = raise sd's refs with a multi-operand read-only fence (each operand
# = +1 ref, ONE barrier).  N=5 is the modelled minimum.

STAGED_ASMCALL = (b'        : : "r"(v4), "r"(sd), "r"(&sd->otz)\r\n'
                  b'        : "$12", "$13", "$14", "memory");\r\n'
                  b'    DrawW_AddSubdividPrimGT4((POLY_GT4 *)v4,v0,v1,v2,v3,sd);')

variants = {}
for n in (1, 2, 3, 4, 5, 6, 7, 8):
    ops = b", ".join([b'"r"(sd)'] * n)
    fence = b'    __asm__("" : : ' + ops + b');\r\n'
    # after the OT-link template, before the GT4 add
    variants["staged+fence_after_%d" % n] = stage(False) + [
        (STAGED_ASMCALL,
         STAGED_ASMCALL.replace(b'    DrawW_AddSubdividPrimGT4',
                                fence + b'    DrawW_AddSubdividPrimGT4'))]
VARIANTS = variants

if __name__ == "__main__":
    fast.run(SRC, FN, "DrawW_SubdividFacet", variants, gval="4", minrefs=3, dump=False)

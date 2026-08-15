"""aprobe2.py -- Night_AdditiveNightCalc round 2: attack `v`'s hard-reg PREFERENCE
(the receipt's own mechanism: find_reg SKIPS $v1/$a0 because the conflicting `v` allocno
prefers them).  Catalog 11A/12E: an asm_operands def makes global.c set_preference
return early, i.e. an identity launder DELETES a parm's copy preference.  w63-a13."""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/night.cpp'
FN = 'Night_AdditiveNightCalc__FP6VECTORP7CVECTOR'

BASE = (b'  __asm__("" : "=r"(color) : "0"(color));\n'
        b'  z = v->vz;\n')

def V(b): return [(BASE, b)]

VARIANTS = {
 'base': [],
 'v_launder_only': V(b'  __asm__("" : "=r"(v) : "0"(v));\n  z = v->vz;\n'),
 'v_then_color': V(b'  __asm__("" : "=r"(v) : "0"(v));\n'
                   b'  __asm__("" : "=r"(color) : "0"(color));\n  z = v->vz;\n'),
 'color_then_v': V(b'  __asm__("" : "=r"(color) : "0"(color));\n'
                   b'  __asm__("" : "=r"(v) : "0"(v));\n  z = v->vz;\n'),
 'both_one_line': V(b'  __asm__("" : "=r"(v), "=r"(color) : "0"(v), "1"(color));\n'
                    b'  z = v->vz;\n'),
 'v_rofence': V(b'  __asm__("" : "=r"(color) : "0"(color));\n'
                b'  __asm__("" : : "r"(v));\n  z = v->vz;\n'),
 'v_launder_after_vz': V(b'  __asm__("" : "=r"(color) : "0"(color));\n'
                         b'  z = v->vz;\n'
                         b'  __asm__("" : "=r"(v) : "0"(v));\n'),
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="8", dump=False)

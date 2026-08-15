"""aprobe.py -- Night_AdditiveNightCalc: DEMOTE x/xdist below z with a LATE read-only
fence (model-derived from the CORRECTED QTY/allocno priority floor_log2(r)*r*SIZE/live).
w63-a13."""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/night.cpp'
FN = 'Night_AdditiveNightCalc__FP6VECTORP7CVECTOR'

TAIL = (b'      color->r = (u_char)newR;\n'
        b'      color->g = (u_char)newG;\n'
        b'      color->b = (u_char)newB;\n')

def V(b): return [(TAIL, b)]

VARIANTS = {
 'base': [],
 # +1 ref AND a long live range on x  -> pri 2*5*4/~25 = 1.6 < z's 2.0
 'x_late_fence': V(TAIL + b'      __asm__("" : : "r"(x));\n'),
 'xdist_late_fence': V(TAIL + b'      __asm__("" : : "r"(xdist));\n'),
 'both_late_fence': V(TAIL + b'      __asm__("" : : "r"(x), "r"(xdist));\n'),
 # same but placed BEFORE the three stores (shorter stretch, still past the index use)
 'x_fence_before_stores': V(b'      __asm__("" : : "r"(x));\n' + TAIL),
 'both_fence_before_stores': V(b'      __asm__("" : : "r"(x), "r"(xdist));\n' + TAIL),
 # PROMOTE z instead: 3 distinct-looking operands on one late fence
 'z_late_fence': V(TAIL + b'      __asm__("" : : "r"(z));\n'),
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="8", dump=False)

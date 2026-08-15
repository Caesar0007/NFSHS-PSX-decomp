"""hprobe.py -- HrzSetPsxMatrix: the w60-a6 "ONE-VALUE-PER-ROW CARRY" hypothesis, the
only remaining source shape that matches retail's staggered per-row register triples
({v1,a0,v0} {a1,v0,v1} {a2,a3,v0}).  Built on BOTH the shipped 3-t-block base (62 @52/56)
and the count-exact single-t-block base (72 @56/56).  w63-a13."""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/hrzsku.cpp'
FN = 'HrzSetPsxMatrix__FP10matrixtdef'

# --- the three shipped t-blocks (anchor) ---
T3 = (b'  {\n    int t1;\n    int t2;\n    int t3;\n\n'
      b'    t1 = m->m[0];\n    t2 = m->m[1];\n    t3 = m->m[2];\n'
      b'    temp.m[0] = t1;\n    temp.m[1] = -t2;\n    temp.m[2] = t3;\n  }\n'
      b'  {\n    int t1, t2, t3;                 /* w40-a8: per-ROW block (see note above) */\n'
      b'    t1 = m->m[3];\n    t2 = m->m[4];\n    t3 = m->m[5];\n'
      b'    temp.m[3] = t1;\n    temp.m[4] = -t2;\n    temp.m[5] = t3;\n  }\n'
      b'  {\n    int t1, t2, t3;\n'
      b'    t1 = m->m[6];\n    t2 = m->m[7];\n    t3 = m->m[8];\n'
      b'    temp.m[6] = t1;\n    temp.m[7] = -t2;\n    temp.m[8] = t3;\n  }\n')

T1 = (b'  {\n    int t1;\n    int t2;\n    int t3;\n\n'
      b'    t1 = m->m[0];\n    t2 = m->m[1];\n    t3 = m->m[2];\n'
      b'    temp.m[0] = t1;\n    temp.m[1] = -t2;\n    temp.m[2] = t3;\n'
      b'    t1 = m->m[3];\n    t2 = m->m[4];\n    t3 = m->m[5];\n'
      b'    temp.m[3] = t1;\n    temp.m[4] = -t2;\n    temp.m[5] = t3;\n'
      b'    t1 = m->m[6];\n    t2 = m->m[7];\n    t3 = m->m[8];\n'
      b'    temp.m[6] = t1;\n    temp.m[7] = -t2;\n    temp.m[8] = t3;\n  }\n')

# --- the three shipped r-blocks (anchor) ---
R3 = (b'  {\n    int r0;\n    int r1;\n    int r2;\n\n'
      b'    r0 = temp.m[0] >> 4;\n    r1 = temp.m[3] >> 4;\n    r2 = temp.m[6] >> 4;\n'
      b'    mpsx.m[0][0] = (short)r0;\n    mpsx.m[0][1] = (short)r1;\n    mpsx.m[0][2] = (short)r2;\n  }\n'
      b'  {\n    int r0;\n    int r1;\n    int r2;\n\n'
      b'    r0 = temp.m[1] >> 4;\n    r1 = temp.m[4] >> 4;\n    r2 = temp.m[7] >> 4;\n'
      b'    mpsx.m[1][0] = (short)r0;\n    mpsx.m[1][1] = (short)r1;\n    mpsx.m[1][2] = (short)r2;\n  }\n'
      b'  {\n    int r0;\n    int r1;\n    int r2;\n\n'
      b'    r0 = temp.m[2] >> 4;\n    r1 = temp.m[5] >> 4;\n    r2 = temp.m[8] >> 4;\n'
      b'    mpsx.m[2][0] = (short)r0;\n    mpsx.m[2][1] = (short)r1;\n    mpsx.m[2][2] = (short)r2;\n  }\n')

def sh(k):   return b'temp.m[%d] >> 4' % k
def st(r, c, v): return b'    mpsx.m[%d][%d] = (short)%s;\n' % (r, c, v)

DECL9 = (b'    int r0, r1, r2;\n    int s0, s1, s2;\n    int u0, u1, u2;\n')

# carry-1: each row's FIRST shift is computed before the previous row's LAST store
CARRY1 = (b'  {\n' + DECL9 +
  b'    r0 = ' + sh(0) + b';\n    r1 = ' + sh(3) + b';\n    r2 = ' + sh(6) + b';\n' +
  st(0,0,b'r0') + st(0,1,b'r1') +
  b'    s0 = ' + sh(1) + b';\n' + st(0,2,b'r2') +
  b'    s1 = ' + sh(4) + b';\n    s2 = ' + sh(7) + b';\n' +
  st(1,0,b's0') + st(1,1,b's1') +
  b'    u0 = ' + sh(2) + b';\n' + st(1,2,b's2') +
  b'    u1 = ' + sh(5) + b';\n    u2 = ' + sh(8) + b';\n' +
  st(2,0,b'u0') + st(2,1,b'u1') + st(2,2,b'u2') + b'  }\n')

# carry-2: two of the next row's shifts precede the previous row's last store
CARRY2 = (b'  {\n' + DECL9 +
  b'    r0 = ' + sh(0) + b';\n    r1 = ' + sh(3) + b';\n    r2 = ' + sh(6) + b';\n' +
  st(0,0,b'r0') +
  b'    s0 = ' + sh(1) + b';\n' + st(0,1,b'r1') +
  b'    s1 = ' + sh(4) + b';\n' + st(0,2,b'r2') +
  b'    s2 = ' + sh(7) + b';\n' + st(1,0,b's0') +
  b'    u0 = ' + sh(2) + b';\n' + st(1,1,b's1') +
  b'    u1 = ' + sh(5) + b';\n' + st(1,2,b's2') +
  b'    u2 = ' + sh(8) + b';\n' +
  st(2,0,b'u0') + st(2,1,b'u1') + st(2,2,b'u2') + b'  }\n')

# carry-1 but the carried value is the row's LAST (r2 computed after the first two stores)
CARRY1B = (b'  {\n' + DECL9 +
  b'    r0 = ' + sh(0) + b';\n    r1 = ' + sh(3) + b';\n' +
  st(0,0,b'r0') +
  b'    r2 = ' + sh(6) + b';\n' + st(0,1,b'r1') +
  b'    s0 = ' + sh(1) + b';\n' + st(0,2,b'r2') +
  b'    s1 = ' + sh(4) + b';\n' + st(1,0,b's0') +
  b'    s2 = ' + sh(7) + b';\n' + st(1,1,b's1') +
  b'    u0 = ' + sh(2) + b';\n' + st(1,2,b's2') +
  b'    u1 = ' + sh(5) + b';\n' + st(2,0,b'u0') +
  b'    u2 = ' + sh(8) + b';\n' + st(2,1,b'u1') + st(2,2,b'u2') + b'  }\n')

VARIANTS = {
 'base_3t_3r': [],
 'seed_1t_3r': [(T3, T1)],
 '3t_carry1': [(R3, CARRY1)],
 '3t_carry2': [(R3, CARRY2)],
 '3t_carry1b': [(R3, CARRY1B)],
 '1t_carry1': [(T3, T1), (R3, CARRY1)],
 '1t_carry2': [(T3, T1), (R3, CARRY2)],
 '1t_carry1b': [(T3, T1), (R3, CARRY1B)],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

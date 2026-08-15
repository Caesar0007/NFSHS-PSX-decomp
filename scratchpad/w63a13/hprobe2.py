"""hprobe2.py -- HrzSetPsxMatrix: FENCED one-value-per-row carry.  hprobe.py proved the
plain source-order carry is canonicalised away by sched1 (all six orderings bit-identical),
so the overlap has to be PINNED with a zero-insn barrier.  w63-a13."""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
sys.path.insert(0, r'C:/Temp/nfs4-decomp/scratchpad/w63a13')
import fast
from hprobe import SRC, FN, T3, T1, R3, DECL9, sh, st


def carry_fenced(nfence):
    b = [b'  {\n' + DECL9]
    b.append(b'    r0 = ' + sh(0) + b';\n    r1 = ' + sh(3) + b';\n    r2 = ' + sh(6) + b';\n')
    b.append(st(0, 0, b'r0') + st(0, 1, b'r1'))
    b.append(b'    s0 = ' + sh(1) + b';\n')
    if nfence >= 1:
        b.append(b'    __asm__("" : : "r"(r2));\n')
    b.append(st(0, 2, b'r2'))
    b.append(b'    s1 = ' + sh(4) + b';\n    s2 = ' + sh(7) + b';\n')
    b.append(st(1, 0, b's0') + st(1, 1, b's1'))
    b.append(b'    u0 = ' + sh(2) + b';\n')
    if nfence >= 2:
        b.append(b'    __asm__("" : : "r"(s2));\n')
    b.append(st(1, 2, b's2'))
    b.append(b'    u1 = ' + sh(5) + b';\n    u2 = ' + sh(8) + b';\n')
    b.append(st(2, 0, b'u0') + st(2, 1, b'u1') + st(2, 2, b'u2') + b'  }\n')
    return b''.join(b)


VARIANTS = {
    'base_3t_3r': [],
    '3t_carryF1': [(R3, carry_fenced(1))],
    '3t_carryF2': [(R3, carry_fenced(2))],
    '1t_carryF1': [(T3, T1), (R3, carry_fenced(1))],
    '1t_carryF2': [(T3, T1), (R3, carry_fenced(2))],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)

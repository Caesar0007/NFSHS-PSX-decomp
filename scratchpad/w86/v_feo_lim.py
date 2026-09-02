F = '          __asm__("" : : "r"(lim), "r"(lim), "r"(lim), "r"(lim));\n'
def andmask(n, decl='          int limM = -1;\n'):
    return decl + ''.join('          lim &= limM;\n' for _ in range(n))
def ormask(n):
    return '          int limZ = 0;\n' + ''.join('          lim |= limZ;\n' for _ in range(n))
VARIANTS = [("drop", [(F, "")])]
for n in range(1, 8):
    VARIANTS.append((f"and{n}", [(F, andmask(n))]))
for n in (1,2,3,4,5,6):
    VARIANTS.append((f"or{n}", [(F, ormask(n))]))

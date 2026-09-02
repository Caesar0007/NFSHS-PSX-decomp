F = '          __asm__("" : : "r"(lim), "r"(lim), "r"(lim), "r"(lim));\n'
def rep(s, n): return ''.join(s for _ in range(n))
VARIANTS = []
for n in (1,2,4):
    VARIANTS.append((f"absorbOR_sel{n}", [(F, rep('          lim |= (lim & (int)selected);\n', n))]))
    VARIANTS.append((f"absorbAND_sel{n}", [(F, rep('          lim &= (lim | (int)selected);\n', n))]))
    VARIANTS.append((f"absorbOR_cur{n}", [(F, rep('          lim |= (lim & cur);\n', n))]))
    VARIANTS.append((f"absorbAND_cur{n}", [(F, rep('          lim &= (lim | cur);\n', n))]))

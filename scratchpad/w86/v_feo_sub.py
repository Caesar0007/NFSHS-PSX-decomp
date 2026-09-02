F = ('  __asm__("" : : "r"(packetCell));\n'
     '  __asm__("" : "=r"(x) : "0"(x));\n'
     '  __asm__("" : "=r"(x) : "0"(x));\n')
def rep(s,n): return ''.join(s for _ in range(n))
VARIANTS=[("drop",[(F,"")])]
for n in (1,2,3,4):
    VARIANTS.append((f"absAND_pc{n}", [(F, rep('  x &= (x | (int)packetCell);\n', n))]))
    VARIANTS.append((f"absOR_pc{n}",  [(F, rep('  x |= (x & (int)packetCell);\n', n))]))
    VARIANTS.append((f"absAND_w{n}",  [(F, rep('  x &= (x | w);\n', n))]))
VARIANTS.append(("keepPC_absx2", [(F, '  __asm__("" : : "r"(packetCell));\n' + rep('  x &= (x | w);\n',2))]))
VARIANTS.append(("keepPC_absx1", [(F, '  __asm__("" : : "r"(packetCell));\n' + rep('  x &= (x | w);\n',1))]))

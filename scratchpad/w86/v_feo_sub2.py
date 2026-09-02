F = ('  __asm__("" : : "r"(packetCell));\n'
     '  __asm__("" : "=r"(x) : "0"(x));\n'
     '  __asm__("" : "=r"(x) : "0"(x));\n')
KEEP = '  __asm__("" : : "r"(packetCell));\n'
COORD = '  (prim->x0 = x,\n'
def rep(s,n): return ''.join(s for _ in range(n))
VARIANTS=[]
for n in (1,2,3,4):
    VARIANTS.append((f"live_absx{n}_keepPC", [(F, KEEP), (COORD, rep('  x &= (x | y);\n', n) + COORD)]))
    VARIANTS.append((f"live_absx{n}_nofence", [(F, ""), (COORD, rep('  x &= (x | y);\n', n) + COORD)]))
for n in (1,2):
    VARIANTS.append((f"live_absx{n}_pcAbs_nofence", [(F, ""), (COORD, rep('  x &= (x | y);\n', n) + rep('  x &= (x | (int)packetCell);\n',1) + COORD)]))

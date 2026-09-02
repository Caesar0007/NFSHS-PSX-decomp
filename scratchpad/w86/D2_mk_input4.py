import pathlib

PROD = ['    __asm__("" : "=r"(addressBlocker%s));\n' % s for s in ('', '2', '3', '4', '5')]
CONS = ['    __asm__("" : : "r"(addressBlocker%s));\n' % s for s in ('', '2', '3', '4', '5')]
DROP = [(x, '') for x in PROD + CONS]

ANCHOR = '    for (; i < 32; i++) {\n'

def A(v, t='int'):
    return '    %s = (%s)((unsigned int)%s | ((unsigned int)%s & 3u));\n' % (v, t, v, v)

cands = [('h', 'int *'), ('left', 'int'), ('menukeys', 'u_long'),
         ('interfaceActive', 'char *'), ('i', 'int'), ('r', 'Input_tResults *'),
         ('acc', 'u_long'), ('right', 'int'), ('j', 'int'), ('k', 'int'),
         ('one', 'u_long')]

variants = []
for v, t in cands:
    variants.append(('drop cluster + abs(%s) pre-loop' % v,
                     DROP + [(ANCHOR, A(v, t) + ANCHOR)]))
pathlib.Path('scratchpad/w86/D2_i4.txt').write_text(repr(variants))
print(len(variants))

import pathlib

PROD = ['    __asm__("" : "=r"(addressBlocker%s));\n' % s for s in ('', '2', '3', '4', '5')]
CONS = ['    __asm__("" : : "r"(addressBlocker%s));\n' % s for s in ('', '2', '3', '4', '5')]
DECL_TAIL = '    int addressBlocker%s;\n'

variants = []
# symmetric ladder: keep only the first N blocker pairs
for n in range(5):
    pairs = []
    for k in range(n, 5):
        pairs.append((PROD[k], ''))
        pairs.append((CONS[k], ''))
    variants.append(('keep %d pairs' % n, pairs))
# producers only / consumers only
variants.append(('drop all consumers', [(c, '') for c in CONS]))
variants.append(('drop all producers', [(p, '') for p in PROD]))
# absorption on the uninit producers (all five)
ABS = '    addressBlocker%s = (int)((unsigned int)addressBlocker%s | ((unsigned int)addressBlocker%s & 3u));\n'
variants.append(('producers -> absorption (all)',
                 [(PROD[i], ABS % (s, s, s)) for i, s in enumerate(('', '2', '3', '4', '5'))]))
variants.append(('consumers -> absorption (all)',
                 [(CONS[i], ABS % (s, s, s)) for i, s in enumerate(('', '2', '3', '4', '5'))]))
variants.append(('both -> absorption (all)',
                 [(PROD[i], ABS % (s, s, s)) for i, s in enumerate(('', '2', '3', '4', '5'))] +
                 [(CONS[i], ABS % (s, s, s)) for i, s in enumerate(('', '2', '3', '4', '5'))]))
pathlib.Path('scratchpad/w86/D2_i1.txt').write_text(repr(variants))
print(len(variants))

import pathlib

OFF7D = ('              int off7d = 0x7d; /* SYM-CODEGEN-CARRIER: off7d -- one-site opacity prevents the four 0x7d stores from becoming a loop movable */\n'
         '              __asm__("" : "=r"(off7d) : "0"(off7d)); sd->offset = off7d; }\n')

G1 = ('            g = goffsets;\n'
      '            __asm__("" : "=r"(g) : "0"(g));\n'
      '            objectOffset = *(signed char *)(zo + (int)g); }\n')

G2 = ('        g = offsets;\n'
      '        __asm__("" : "=r"(g) : "0"(g));\n'
      '        zo = objInstance->zoffset;\n'
      '        objectOffset = *(signed char *)(zo + (int)g); }\n')

variants = [
    ('off7d: doubleset AFTER store', [(OFF7D,
        '              int off7d = 0x7d;\n'
        '              sd->offset = off7d; off7d = 0x7d; }\n')]),
    ('off7d: doubleset consecutive', [(OFF7D,
        '              int off7d = 0x7d; off7d = 0x7d;\n'
        '              sd->offset = off7d; }\n')]),
    ('off7d: decl + set + store + set', [(OFF7D,
        '              int off7d; off7d = 0x7d;\n'
        '              sd->offset = off7d; off7d = 0x7d; }\n')]),
    ('off7d: device removed (control)', [(OFF7D,
        '              int off7d = 0x7d;\n'
        '              sd->offset = off7d; }\n')]),

    ('g1: doubleset after use', [(G1,
        '            g = goffsets;\n'
        '            objectOffset = *(signed char *)(zo + (int)g); g = goffsets; }\n')]),
    ('g1: removed (control)', [(G1,
        '            g = goffsets;\n'
        '            objectOffset = *(signed char *)(zo + (int)g); }\n')]),

    ('g2: doubleset across zo load', [(G2,
        '        g = offsets;\n'
        '        zo = objInstance->zoffset;\n'
        '        g = offsets;\n'
        '        objectOffset = *(signed char *)(zo + (int)g); }\n')]),
    ('g2: doubleset after use', [(G2,
        '        g = offsets;\n'
        '        zo = objInstance->zoffset;\n'
        '        objectOffset = *(signed char *)(zo + (int)g); g = offsets; }\n')]),
    ('g2: removed (control)', [(G2,
        '        g = offsets;\n'
        '        zo = objInstance->zoffset;\n'
        '        objectOffset = *(signed char *)(zo + (int)g); }\n')]),
]
pathlib.Path('scratchpad/w86/D2_p3.txt').write_text(repr(variants))
print(len(variants))

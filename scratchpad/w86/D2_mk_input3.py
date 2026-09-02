import pathlib

PROD = ['    __asm__("" : "=r"(addressBlocker%s));\n' % s for s in ('', '2', '3', '4', '5')]
CONS = ['    __asm__("" : : "r"(addressBlocker%s));\n' % s for s in ('', '2', '3', '4', '5')]
DROP = [(x, '') for x in PROD + CONS]

LOOP = ('    for (; i < 32; i++) {\n'
        '      if ((interfaceActive[i] != 0) && (*h != 0) &&\n'
        '          (((Input_tDeviceCall *)Input_DeviceRows[*h & 0xff].PrimPtr)(*h >> 8) >= 65)) {\n'
        '        menukeys |= (left << i);\n'
        '      }\n'
        '      h++;\n'
        '    }\n')

def loop(body):
    return '    for (; i < 32; i++) {\n' + body + '      h++;\n    }\n'

IFROWS = ('      if ((interfaceActive[i] != 0) && (*h != 0) &&\n'
          '          (((Input_tDeviceCall *)rows[*h & 0xff].PrimPtr)(*h >> 8) >= 65)) {\n'
          '        menukeys |= (left << i);\n'
          '      }\n')

# (a) base pointer local in the loop, given a SECOND SET by the absorption identity
A = loop('      Draw_PrimStruct *rows = Input_DeviceRows;\n'
         '      rows = (Draw_PrimStruct *)((unsigned int)rows | ((unsigned int)rows & 3u));\n' + IFROWS)
# (b) same, absorption only (no plain init first) - single statement
B = loop('      Draw_PrimStruct *rows = (Draw_PrimStruct *)((unsigned int)Input_DeviceRows |\n'
         '          ((unsigned int)Input_DeviceRows & 3u));\n' + IFROWS)
# (c) base local declared OUTSIDE the loop with the absorption INSIDE it
C0 = '    Draw_PrimStruct *rows = Input_DeviceRows;\n'
C = loop('      rows = (Draw_PrimStruct *)((unsigned int)rows | ((unsigned int)rows & 3u));\n' + IFROWS)
# (d) dead first set of the base local inside the loop
D = loop('      Draw_PrimStruct *rows = 0;\n'
         '      rows = Input_DeviceRows;\n' + IFROWS)

variants = [
    ('drop cluster + rows absorb (in-loop decl)', DROP + [(LOOP, A)]),
    ('drop cluster + rows absorb (single stmt)', DROP + [(LOOP, B)]),
    ('drop cluster + rows absorb (outer decl)', DROP + [(LOOP, C0 + C)]),
    ('drop cluster + rows dead-first-set', DROP + [(LOOP, D)]),
]
pathlib.Path('scratchpad/w86/D2_i3.txt').write_text(repr(variants))
print(len(variants))

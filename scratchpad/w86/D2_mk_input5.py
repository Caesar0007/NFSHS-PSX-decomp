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

SPLIT = ('    for (; i < 32; i++) {\n'
         '      if ((interfaceActive[i] != 0) && (*h != 0)) {\n'
         '        Draw_PrimStruct *row;\n'
         '%s'
         '        if (((Input_tDeviceCall *)row->PrimPtr)(*h >> 8) >= 65) {\n'
         '          menukeys |= (left << i);\n'
         '        }\n'
         '      }\n'
         '      h++;\n'
         '    }\n')

plain = '        row = &Input_DeviceRows[*h & 0xff];\n'
dowh = '        do { row = &Input_DeviceRows[*h & 0xff]; } while (0);\n'
idxf = '        row = (Draw_PrimStruct *)(((*h & 0xff) * 12) + (int)Input_DeviceRows);\n'
dowh_idx = '        do { row = (Draw_PrimStruct *)(((*h & 0xff) * 12) + (int)Input_DeviceRows); } while (0);\n'
absorb = ('        row = &Input_DeviceRows[*h & 0xff];\n'
          '        row = (Draw_PrimStruct *)((unsigned int)row | ((unsigned int)row & 3u));\n')

variants = [
    ('split-guard plain', DROP + [(LOOP, SPLIT % plain)]),
    ('split-guard do{}while(0)', DROP + [(LOOP, SPLIT % dowh)]),
    ('split-guard index-first', DROP + [(LOOP, SPLIT % idxf)]),
    ('split-guard do{}while(0)+index-first', DROP + [(LOOP, SPLIT % dowh_idx)]),
    ('split-guard absorb', DROP + [(LOOP, SPLIT % absorb)]),
]
pathlib.Path('scratchpad/w86/D2_i5.txt').write_text(repr(variants))
print(len(variants))

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

IDX = ('    for (; i < 32; i++) {\n'
       '      if ((interfaceActive[i] != 0) && (*h != 0) &&\n'
       '          (((Input_tDeviceCall *)((Draw_PrimStruct *)(((*h & 0xff) * 12) +\n'
       '              (int)Input_DeviceRows))->PrimPtr)(*h >> 8) >= 65)) {\n'
       '        menukeys |= (left << i);\n'
       '      }\n'
       '      h++;\n'
       '    }\n')

SHIELD = ('    for (; i < 32; i++) {\n'
          '      do {\n'
          '      if ((interfaceActive[i] != 0) && (*h != 0) &&\n'
          '          (((Input_tDeviceCall *)Input_DeviceRows[*h & 0xff].PrimPtr)(*h >> 8) >= 65)) {\n'
          '        menukeys |= (left << i);\n'
          '      }\n'
          '      } while (0);\n'
          '      h++;\n'
          '    }\n')

BOTH = ('    for (; i < 32; i++) {\n'
        '      do {\n'
        '      if ((interfaceActive[i] != 0) && (*h != 0) &&\n'
        '          (((Input_tDeviceCall *)((Draw_PrimStruct *)(((*h & 0xff) * 12) +\n'
        '              (int)Input_DeviceRows))->PrimPtr)(*h >> 8) >= 65)) {\n'
        '        menukeys |= (left << i);\n'
        '      }\n'
        '      } while (0);\n'
        '      h++;\n'
        '    }\n')

variants = [
    ('drop cluster + index-first', DROP + [(LOOP, IDX)]),
    ('drop cluster + dowhile0 shield', DROP + [(LOOP, SHIELD)]),
    ('drop cluster + both', DROP + [(LOOP, BOTH)]),
    ('index-first only (cluster kept)', [(LOOP, IDX)]),
]
pathlib.Path('scratchpad/w86/D2_i2.txt').write_text(repr(variants))
print(len(variants))

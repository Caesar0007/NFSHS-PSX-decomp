import pathlib

A = ('  objInstance = (Trk_SimpleInst *)(group + 1);\n'
     '  __asm__("" : "=r"(objInstance) : "0"(objInstance));\n')
G1 = ('            g = goffsets;\n'
      '            __asm__("" : "=r"(g) : "0"(g));\n'
      '            objectOffset = *(signed char *)(zo + (int)g); }\n')
G2 = ('        g = offsets;\n'
      '        __asm__("" : "=r"(g) : "0"(g));\n'
      '        zo = objInstance->zoffset;\n'
      '        objectOffset = *(signed char *)(zo + (int)g); }\n')

variants = [
  ('A deadset0-pre', [(A, '  objInstance = 0;\n  objInstance = (Trk_SimpleInst *)(group + 1);\n')]),
  ('A deadsetGroup-pre', [(A, '  objInstance = (Trk_SimpleInst *)group;\n  objInstance = (Trk_SimpleInst *)(group + 1);\n')]),
  ('G1 deadset0-pre', [(G1, '            g = 0;\n            g = goffsets;\n'
                            '            objectOffset = *(signed char *)(zo + (int)g); }\n')]),
  ('G1 deadset0-post', [(G1, '            g = goffsets;\n'
                             '            objectOffset = *(signed char *)(zo + (int)g); g = 0; }\n')]),
  ('G2 deadset0-pre', [(G2, '        g = 0;\n        g = offsets;\n'
                            '        zo = objInstance->zoffset;\n'
                            '        objectOffset = *(signed char *)(zo + (int)g); }\n')]),
  ('G2 deadset0-post', [(G2, '        g = offsets;\n'
                             '        zo = objInstance->zoffset;\n'
                             '        objectOffset = *(signed char *)(zo + (int)g); g = 0; }\n')]),
  ('G2 deadset-mid', [(G2, '        g = offsets;\n'
                           '        zo = objInstance->zoffset;\n'
                           '        g = 0;\n        g = offsets;\n'
                           '        objectOffset = *(signed char *)(zo + (int)g); }\n')]),
]
pathlib.Path('scratchpad/w86/D2_p5.txt').write_text(repr(variants))
print(len(variants))

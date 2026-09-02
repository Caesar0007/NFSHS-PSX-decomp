OLD = '    fade = (short)fadeCalc;\n    __asm__("" : "+r"(fadeCalc));\n    do {'
VARIANTS = [
  ('K1 plain drop', OLD, '    fade = (short)fadeCalc;\n    do {'),
  ('K2 via int copy', OLD, '    int fadeSrc = fadeCalc;\n\n    fade = (short)fadeSrc;\n    do {'),
]

OLD = '  if (firstTick + 0x32 <= ticks) {\n    i = 0;\n    bufferPtr = buffer;\n    numLetters = (ticks - firstTick - 0x32) / 3;\n    __asm__("" : : "r"(ticks));'
VARIANTS = [
  ('T1 yoda guard', OLD, '  if (ticks >= firstTick + 0x32) {\n    i = 0;\n    bufferPtr = buffer;\n    numLetters = (ticks - firstTick - 0x32) / 3;'),
  ('T2 paren group', OLD, '  if (firstTick + 0x32 <= ticks) {\n    i = 0;\n    bufferPtr = buffer;\n    numLetters = (ticks - (firstTick + 0x32)) / 3;'),
  ('T3 numLetters first', OLD, '  if (firstTick + 0x32 <= ticks) {\n    numLetters = (ticks - firstTick - 0x32) / 3;\n    i = 0;\n    bufferPtr = buffer;'),
  ('T4 guard on subtraction', OLD, '  if (0x32 <= ticks - firstTick) {\n    i = 0;\n    bufferPtr = buffer;\n    numLetters = (ticks - firstTick - 0x32) / 3;'),
  ('T5 elapsed temp', OLD, '  if (firstTick + 0x32 <= ticks) {\n    long elapsed = ticks - firstTick;\n\n    i = 0;\n    bufferPtr = buffer;\n    numLetters = (elapsed - 0x32) / 3;'),
]

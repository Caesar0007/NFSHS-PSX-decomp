OLD = '  if (firstTick + 0x32 <= ticks) {\n    i = 0;\n    bufferPtr = buffer;\n    numLetters = (ticks - firstTick - 0x32) / 3;\n    __asm__("" : : "r"(ticks));'
VARIANTS = [
  ('U1 T2 + yoda', OLD, '  if (ticks >= firstTick + 0x32) {\n    i = 0;\n    bufferPtr = buffer;\n    numLetters = (ticks - (firstTick + 0x32)) / 3;'),
  ('U2 T2 + numLetters first', OLD, '  if (firstTick + 0x32 <= ticks) {\n    numLetters = (ticks - (firstTick + 0x32)) / 3;\n    i = 0;\n    bufferPtr = buffer;'),
  ('U3 T2 + i/bufferPtr after', OLD, '  if (firstTick + 0x32 <= ticks) {\n    numLetters = (ticks - (firstTick + 0x32)) / 3;\n    bufferPtr = buffer;\n    i = 0;'),
]

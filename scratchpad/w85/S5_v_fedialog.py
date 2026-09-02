VARIANTS = [
  ('S1 plain copy', '    long loadedTicks = ::ticks[0];\n    ticks = loadedTicks;\n    __asm__("" : "+r"(loadedTicks));\n  }', '    long loadedTicks = ::ticks[0];\n    ticks = loadedTicks;\n  }'),
  ('S2 direct', '    long loadedTicks = ::ticks[0];\n    ticks = loadedTicks;\n    __asm__("" : "+r"(loadedTicks));\n  }', '    ticks = ::ticks[0];\n  }'),
  ('S3 two locals', '    long loadedTicks = ::ticks[0];\n    ticks = loadedTicks;\n    __asm__("" : "+r"(loadedTicks));\n  }', '    long loadedTicks = ::ticks[0];\n    long copyTicks = loadedTicks;\n    ticks = copyTicks;\n  }'),
  ('S4 numLetters no fence', '    numLetters = (ticks - firstTick - 0x32) / 3;\n    __asm__("" : : "r"(ticks));', '    numLetters = (ticks - firstTick - 0x32) / 3;'),
  ('S5 numLetters split', '    numLetters = (ticks - firstTick - 0x32) / 3;\n    __asm__("" : : "r"(ticks));', '    numLetters = (ticks - firstTick - 0x32) / 3;\n    firstTick = ticks;'),
]

OLD = "  seedrandom(frontEnd.randomSeed = (short)*(volatile int *)ticks);\n"

CASES = [
 ("T0 baseline (volatile)", []),
 ("T1 plain ticks[0]", [(OLD, "  seedrandom(frontEnd.randomSeed = (short)ticks[0]);\n")]),
 ("T2 int temp", [(OLD, "  {\n    int t = ticks[0];\n    seedrandom(frontEnd.randomSeed = (short)t);\n  }\n")]),
 ("T3 int temp, two uses", [(OLD, "  {\n    int t = ticks[0];\n    frontEnd.randomSeed = (short)t;\n    seedrandom((short)t);\n  }\n")]),
 ("T4 shift pair spelled out", [(OLD, "  seedrandom(frontEnd.randomSeed = (short)((ticks[0] << 16) >> 16));\n")]),
 ("T5 mask then cast", [(OLD, "  seedrandom(frontEnd.randomSeed = (short)(ticks[0] & 0xFFFF));\n")]),
 ("T6 unsized-array int view via *ticks", [(OLD, "  seedrandom(frontEnd.randomSeed = (short)*ticks);\n")]),
 ("T7 int temp declared at fn scope",
  [("  int trackLang;\n", "  int trackLang;\n  int tickNow;\n"),
   (OLD, "  tickNow = ticks[0];\n  seedrandom(frontEnd.randomSeed = (short)tickNow);\n")]),
 ("T8 int temp, store then reload",
  [(OLD, "  {\n    int t = ticks[0];\n    frontEnd.randomSeed = (short)t;\n  }\n  seedrandom(frontEnd.randomSeed);\n")]),
]

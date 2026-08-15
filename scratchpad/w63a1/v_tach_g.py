TU = "recon/game/psx/hud.cpp"
FN = "Hud_BuildTach__Fi"

Y2P = "  ((POLY_F3 *)prim2)->y2 = ts1 + 2;\n"
TS1STORES = ("  ((POLY_F3 *)prim)->y2 = ts1;\n"
             "  ((POLY_F3 *)prim2)->y2 = ts1;\n")
ELSEARM = "    clut = clut | (x + 0x1d);\n"
IFHEAD = "  if (player != 0) {\n    clut = clut | (x + 0x75);\n  }\n"

VARIANTS = [
    ("control", []),
    ("ro-fence on ts1 after y2+2", [(Y2P, Y2P + '  __asm__ ("" : : "r"(ts1));\n', 1)]),
    ("named copy ts2 after the ts1 stores",
     [(TS1STORES, TS1STORES + "  ts2 = ts1;\n", 1),
      (Y2P, "  ((POLY_F3 *)prim2)->y2 = ts2 + 2;\n", 1),
      ("  short ts1;\n", "  short ts1;\n  short ts2;\n", 1)]),
    ("identity fence on ts1 before y2+2",
     [(Y2P, '  __asm__ ("" : "=r"(ts1) : "0"(ts1));\n' + Y2P, 1)]),
    ("block temp t = ts1 at the +2 site",
     [(Y2P, "  { short t = ts1; ((POLY_F3 *)prim2)->y2 = t + 2; }\n", 1)]),
    ("x+0x1d hoisted above the if",
     [(IFHEAD, "  xd = x + 0x1d;\n" + IFHEAD, 1),
      (ELSEARM, "    clut = clut | xd;\n", 1),
      ("  short ts1;\n", "  short ts1;\n  int xd;\n", 1)]),
]

SUBS = [('    __asm__("" : "=r"(d0), "=r"(d1), "=r"(d2),\n                  "=r"(d3), "=r"(d4));\n    __asm__("" : : "r"(d0), "r"(d1), "r"(d2),\n                     "r"(d3), "r"(d4));\n', '')]
FNS = "MemCardGetDirentry"

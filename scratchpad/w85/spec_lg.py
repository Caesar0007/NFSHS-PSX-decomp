LG = '    __asm__("" : : "m"(FEApp));\n'
BODY = """    app = *(tFEApplication **)&FEApp;
    mc = *(tScreenMemcard **)&screenMemcard;
    mc->message = 0x27d;
"""

CASES = [
 ("N0 baseline", []),
 ("N1 dial on app only", [(LG, ""), (BODY,
   "    do { app = *(tFEApplication **)&FEApp; } while (0);\n"
   "    mc = *(tScreenMemcard **)&screenMemcard;\n    mc->message = 0x27d;\n")]),
 ("N2 dial on mc only", [(LG, ""), (BODY,
   "    app = *(tFEApplication **)&FEApp;\n"
   "    do { mc = *(tScreenMemcard **)&screenMemcard; } while (0);\n    mc->message = 0x27d;\n")]),
 ("N3 dial on both", [(LG, ""), (BODY,
   "    do { app = *(tFEApplication **)&FEApp; } while (0);\n"
   "    do { mc = *(tScreenMemcard **)&screenMemcard; } while (0);\n    mc->message = 0x27d;\n")]),
 ("N4 dial on app, mc read first", [(LG, ""), (BODY,
   "    mc = *(tScreenMemcard **)&screenMemcard;\n"
   "    do { app = *(tFEApplication **)&FEApp; } while (0);\n    mc->message = 0x27d;\n")]),
 ("N5 dial on app x2", [(LG, ""), (BODY,
   "    do { do { app = *(tFEApplication **)&FEApp; } while (0); } while (0);\n"
   "    mc = *(tScreenMemcard **)&screenMemcard;\n    mc->message = 0x27d;\n")]),
 ("N6 dial on app + on the store", [(LG, ""), (BODY,
   "    do { app = *(tFEApplication **)&FEApp; } while (0);\n"
   "    mc = *(tScreenMemcard **)&screenMemcard;\n    do { mc->message = 0x27d; } while (0);\n")]),
 ("N7 dial on mc, app read first plainly", [(LG, ""), (BODY,
   "    do { mc = *(tScreenMemcard **)&screenMemcard; } while (0);\n"
   "    app = *(tFEApplication **)&FEApp;\n    mc->message = 0x27d;\n")]),
 ("N8 dial on app, then mc, store last, order swapped", [(LG, ""), (BODY,
   "    do { app = *(tFEApplication **)&FEApp; } while (0);\n"
   "    mc = screenMemcard;\n    mc->message = 0x27d;\n")]),
]

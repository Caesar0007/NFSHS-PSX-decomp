T1 = """  manager = &tournamentManager;
  frontEndState = frontEndBase;
  __asm__("" : : "r"(manager), "r"(manager), "r"(manager), "r"(manager),
          "r"(manager), "r"(manager));
"""
T2 = """  frontEndState = &frontEnd;
  manager = &tournamentManager;
  __asm__("" : : "r"(frontEndState), "r"(manager), "r"(manager), "r"(manager),
          "r"(manager), "r"(manager), "r"(manager));
"""
S1 = '\n    __asm__("" : "+r" (selectedTourney));\n'
S2 = '    __asm__("" : "+r" (selectedTourney));\n'
BC = '  __asm__("" : "+r" (this_00));\n'
LG = '    __asm__("" : : "m"(FEApp));\n'

CASES = [
 ("M0 baseline", []),
 ("M1 tourn fences out (both fns)",
  [(T1, "  manager = &tournamentManager;\n  frontEndState = frontEndBase;\n"),
   (T2, "  frontEndState = &frontEnd;\n  manager = &tournamentManager;\n")]),
 ("M2 tourn fences + selectedTourney launders out",
  [(T1, "  manager = &tournamentManager;\n  frontEndState = frontEndBase;\n"),
   (T2, "  frontEndState = &frontEnd;\n  manager = &tournamentManager;\n"),
   (S1, "\n"), (S2, "")]),
 ("M3 selectedTourney launders out only", [(S1, "\n"), (S2, "")]),
 ("M4 selectedTourney -> do{}while dial",
  [(S1, "\n    do { selectedTourney = tourn; } while (0);\n"),
   (S2, ""),
   ("    selectedTourney = tourn;\n    do { selectedTourney", "    do { selectedTourney")]),
 ("M5 BuyCar this_00 launder out", [(BC, "")]),
 ("M6 BuyCar this_00 -> do{}while dial",
  [(BC, ""),
   ("  this_00 = &FEApp->messagePopup;\n", "  do { this_00 = &FEApp->messagePopup; } while (0);\n")]),
 ("M7 BuyCar this_00 assigned after GetStockCar",
  [(BC, ""), ("  this_00 = &FEApp->messagePopup;\n", ""),
   ("  popUp = this_00;\n", "  this_00 = &FEApp->messagePopup;\n  popUp = this_00;\n")]),
 ("M8 LoadGame FEApp m-fence out", [(LG, "")]),
 ("M9 LoadGame m-fence -> do{}while dial",
  [(LG, ""),
   ("    app = *(tFEApplication **)&FEApp;\n    mc = *(tScreenMemcard **)&screenMemcard;\n    mc->message = 0x27d;\n",
    "    do { app = *(tFEApplication **)&FEApp; } while (0);\n    mc = *(tScreenMemcard **)&screenMemcard;\n    mc->message = 0x27d;\n")]),
 ("M10 LoadGame m-fence out, app read plainly",
  [(LG, ""),
   ("    app = *(tFEApplication **)&FEApp;\n    mc = *(tScreenMemcard **)&screenMemcard;\n    mc->message = 0x27d;\n",
    "    app = FEApp;\n    mc = screenMemcard;\n    mc->message = 0x27d;\n")]),
]

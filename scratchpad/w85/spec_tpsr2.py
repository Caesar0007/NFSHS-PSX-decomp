FENCE = '      __asm__("" : "+r" (screenState));\n'
DOW = "      do { command.nextMenu = nextMenu; } while (0);\n"
SS = "      screenState = 2;\n"
NM = "      nextMenu = (tMenu *)(tMenu*)&menuDefs[0]->menuCarDealer;\n"
CS = "      carSelectScreen = screenCarSelect[0];\n"

CASES = [
 ("K0 baseline", []),
 ("K1 no fence, plain store", [(FENCE, ""), (DOW, "      command.nextMenu = nextMenu;\n")]),
 ("K2 no fence, do{}while on SetState",
  [(FENCE, ""),
   ("      carSelectScreen->SetState(screenState);\n",
    "      do { carSelectScreen->SetState(screenState); } while (0);\n")]),
 ("K3 no fence, do{}while on screenState AND the store",
  [(FENCE, ""), (SS, "      do { screenState = 2; } while (0);\n")]),
 ("K4 no fence, no do{}while, literal 2",
  [(FENCE, ""), (SS, ""), (DOW, "      command.nextMenu = nextMenu;\n"),
   ("      carSelectScreen->SetState(screenState);\n",
    "      carSelectScreen->SetState(2);\n")]),
 ("K5 no fence, nextMenu inlined at the store",
  [(FENCE, ""), (NM, ""),
   (DOW, "      command.nextMenu = (tMenu *)(tMenu*)&menuDefs[0]->menuCarDealer;\n")]),
 ("K6 no fence, store before the carSelectScreen load",
  [(FENCE, ""), (CS, ""), (DOW, DOW + CS)]),
 ("K7 no fence, two do{}while nested on the store",
  [(FENCE, ""), (DOW, "      do { do { command.nextMenu = nextMenu; } while (0); } while (0);\n")]),
 ("K8 no fence, do{}while around store+SetState pair",
  [(FENCE, ""),
   (DOW + "      carSelectScreen->SetState(screenState);\n",
    "      do { command.nextMenu = nextMenu;\n           carSelectScreen->SetState(screenState); } while (0);\n")]),
]

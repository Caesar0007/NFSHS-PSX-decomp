BLOCK = """      menuDefinitions = menuDefs[0];
      frontEnd.raceType = '\\0';
      command.type = kMenu_Command_GoToMenu;
      menuDefinitions->iteratorDealerCar.Decrement(kPlayerBoth);
      menuDefs[0]->iteratorDealerCar.Increment(kPlayerBoth);
      screenState = 2;
      __asm__("" : "+r" (screenState));
      carSelectScreen = screenCarSelect[0];
      nextMenu = (tMenu *)(tMenu*)&menuDefs[0]->menuCarDealer;
"""

TAIL = """      do { command.nextMenu = nextMenu; } while (0);
      carSelectScreen->SetState(screenState);
"""


def blk(body):
    return body


CASES = [
 ("J0 baseline", []),
 ("J1 plain removal", [(BLOCK, BLOCK.replace('      __asm__("" : "+r" (screenState));\n', ''))]),
 ("J2 screenState=2 hoisted to top of block",
  [(BLOCK, """      screenState = 2;
      menuDefinitions = menuDefs[0];
      frontEnd.raceType = '\\0';
      command.type = kMenu_Command_GoToMenu;
      menuDefinitions->iteratorDealerCar.Decrement(kPlayerBoth);
      menuDefs[0]->iteratorDealerCar.Increment(kPlayerBoth);
      carSelectScreen = screenCarSelect[0];
      nextMenu = (tMenu *)(tMenu*)&menuDefs[0]->menuCarDealer;
""")]),
 ("J3 screenState=2 in do{}while(0)",
  [(BLOCK, BLOCK.replace('      screenState = 2;\n      __asm__("" : "+r" (screenState));\n',
                         '      do { screenState = 2; } while (0);\n'))]),
 ("J4 screenState=2 after the carSelectScreen load",
  [(BLOCK, BLOCK.replace('      screenState = 2;\n      __asm__("" : "+r" (screenState));\n      carSelectScreen = screenCarSelect[0];\n',
                         '      carSelectScreen = screenCarSelect[0];\n      screenState = 2;\n'))]),
 ("J5 screenState=2 after nextMenu",
  [(BLOCK, BLOCK.replace('      screenState = 2;\n      __asm__("" : "+r" (screenState));\n', '')
    .replace('      nextMenu = (tMenu *)(tMenu*)&menuDefs[0]->menuCarDealer;\n',
             '      nextMenu = (tMenu *)(tMenu*)&menuDefs[0]->menuCarDealer;\n      screenState = 2;\n'))]),
 ("J6 no device + store not in do{}while",
  [(BLOCK, BLOCK.replace('      __asm__("" : "+r" (screenState));\n', '')),
   (TAIL, "      command.nextMenu = nextMenu;\n      carSelectScreen->SetState(screenState);\n")]),
 ("J7 no device + literal 2 at the call",
  [(BLOCK, BLOCK.replace('      screenState = 2;\n      __asm__("" : "+r" (screenState));\n', '')),
   (TAIL, "      command.nextMenu = nextMenu;\n      carSelectScreen->SetState(2);\n")]),
 ("J8 hoist screenState to the top, keep do{}while store",
  [(BLOCK, """      screenState = 2;
      carSelectScreen = screenCarSelect[0];
      menuDefinitions = menuDefs[0];
      frontEnd.raceType = '\\0';
      command.type = kMenu_Command_GoToMenu;
      menuDefinitions->iteratorDealerCar.Decrement(kPlayerBoth);
      menuDefs[0]->iteratorDealerCar.Increment(kPlayerBoth);
      nextMenu = (tMenu *)(tMenu*)&menuDefs[0]->menuCarDealer;
""")]),
]

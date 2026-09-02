A = """  state = 2;
  commandPtr = &command;
  __asm__("" : "+r"(commandPtr), "+r"(state));
  carSelectScreen = screenCarSelect[0];
  menuDefinitions = menuDefs[0];
  cmdType = 1;
  __asm__("" : "+r"(menuDefinitions));
  commandPtr->type = cmdType;
  __asm__("" : : "r"(cmdType));
  commandPtr->nextMenu = (tMenu *)&menuDefinitions->menuCarDealer;
"""
B = """  state = 3;
  commandPtr = &command;
  __asm__("" : "+r"(commandPtr), "+r"(state));
  carSelectScreen = screenCarSelect[0];
  menuDefinitions = menuDefs[0];
  cmdType = 1;
  __asm__("" : "+r"(menuDefinitions));
  commandPtr->type = cmdType;
  __asm__("" : : "r"(cmdType));
  commandPtr->nextMenu = (tMenu *)&menuDefinitions->menuCarSeller;
"""


def mk(st, member, body):
    return body.replace('@ST', st).replace('@M', member)


SHAPES = [
 ("plain, no devices", """  state = @ST;
  commandPtr = &command;
  carSelectScreen = screenCarSelect[0];
  menuDefinitions = menuDefs[0];
  cmdType = 1;
  commandPtr->type = cmdType;
  commandPtr->nextMenu = (tMenu *)&menuDefinitions->@M;
"""),
 ("do{}while dial on each fenced stmt", """  do { state = @ST; } while (0);
  do { commandPtr = &command; } while (0);
  carSelectScreen = screenCarSelect[0];
  do { menuDefinitions = menuDefs[0]; } while (0);
  cmdType = 1;
  do { commandPtr->type = cmdType; } while (0);
  commandPtr->nextMenu = (tMenu *)&menuDefinitions->@M;
"""),
 ("do{}while on the type store only", """  state = @ST;
  commandPtr = &command;
  carSelectScreen = screenCarSelect[0];
  menuDefinitions = menuDefs[0];
  cmdType = 1;
  do { commandPtr->type = cmdType; } while (0);
  commandPtr->nextMenu = (tMenu *)&menuDefinitions->@M;
"""),
 ("cmdType literal, no devices", """  state = @ST;
  commandPtr = &command;
  carSelectScreen = screenCarSelect[0];
  menuDefinitions = menuDefs[0];
  commandPtr->type = kMenu_Command_GoToMenu;
  commandPtr->nextMenu = (tMenu *)&menuDefinitions->@M;
"""),
 ("order: defs first", """  menuDefinitions = menuDefs[0];
  state = @ST;
  commandPtr = &command;
  carSelectScreen = screenCarSelect[0];
  cmdType = 1;
  commandPtr->type = cmdType;
  commandPtr->nextMenu = (tMenu *)&menuDefinitions->@M;
"""),
 ("order: nextMenu store before type", """  state = @ST;
  commandPtr = &command;
  carSelectScreen = screenCarSelect[0];
  menuDefinitions = menuDefs[0];
  cmdType = 1;
  commandPtr->nextMenu = (tMenu *)&menuDefinitions->@M;
  commandPtr->type = cmdType;
"""),
 ("direct command, no commandPtr", """  state = @ST;
  carSelectScreen = screenCarSelect[0];
  menuDefinitions = menuDefs[0];
  cmdType = 1;
  command.type = cmdType;
  command.nextMenu = (tMenu *)&menuDefinitions->@M;
"""),
]

CASES = [("L0 baseline", [])]
for i, (nm, sh) in enumerate(SHAPES):
    CASES.append(("L%d %s" % (i + 1, nm),
                  [(A, mk('2', 'menuCarDealer', sh)), (B, mk('3', 'menuCarSeller', sh))]))

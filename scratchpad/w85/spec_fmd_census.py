D = {
 'd286': '      __asm__("" : "+r" (screenState));\n',
 'd653': '  __asm__("" : "+r"(commandPtr), "+r"(state));\n  carSelectScreen = screenCarSelect[0];\n  menuDefinitions = menuDefs[0];\n  cmdType = 1;\n  __asm__("" : "+r"(menuDefinitions));\n  commandPtr->type = cmdType;\n  __asm__("" : : "r"(cmdType));\n  commandPtr->nextMenu = (tMenu *)&menuDefinitions->menuCarDealer;\n',
 'd705': '  __asm__("" : "+r"(commandPtr), "+r"(state));\n  carSelectScreen = screenCarSelect[0];\n  menuDefinitions = menuDefs[0];\n  cmdType = 1;\n  __asm__("" : "+r"(menuDefinitions));\n  commandPtr->type = cmdType;\n  __asm__("" : : "r"(cmdType));\n  commandPtr->nextMenu = (tMenu *)&menuDefinitions->menuCarSeller;\n',
 'd1122': '  __asm__("" : : "r"(manager), "r"(manager), "r"(manager), "r"(manager),\n          "r"(manager), "r"(manager));\n',
 'd1132': '\n    __asm__("" : "+r" (selectedTourney));\n',
 'd1192': '  __asm__("" : : "r"(frontEndState), "r"(manager), "r"(manager), "r"(manager),\n          "r"(manager), "r"(manager), "r"(manager));\n',
 'd1201': '    __asm__("" : "+r" (selectedTourney));\n',
 'd1258': '  player = *(volatile u_char *)&FEApp->fInputPlayer;\n',
 'd1552': '  __asm__("" : "+r" (this_00));\n',
 'd1827': '    __asm__("" : : "m"(FEApp));\n',
 'd2194': '  __asm__("" : "+r"(mgr));\n',
 'd2280': '({ __asm__("" : "+r"(playerNum) : "r"(fWinner)); playerNum; })',
}

REPL = {
 'd653': '  carSelectScreen = screenCarSelect[0];\n  menuDefinitions = menuDefs[0];\n  cmdType = 1;\n  commandPtr->type = cmdType;\n  commandPtr->nextMenu = (tMenu *)&menuDefinitions->menuCarDealer;\n',
 'd705': '  carSelectScreen = screenCarSelect[0];\n  menuDefinitions = menuDefs[0];\n  cmdType = 1;\n  commandPtr->type = cmdType;\n  commandPtr->nextMenu = (tMenu *)&menuDefinitions->menuCarSeller;\n',
 'd1132': '\n',
 'd1258': '  player = FEApp->fInputPlayer;\n',
 'd2280': 'playerNum',
}

CASES = [("BASE", [])]
for k, v in D.items():
    CASES.append(("remove " + k, [(v, REPL.get(k, ''))]))

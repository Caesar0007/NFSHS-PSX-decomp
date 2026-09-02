HELPER = """static inline tCarManager *AwardPinkSlipsCarManagerArg(tCarManager *mgr)
{
  __asm__("" : "+r"(mgr));
  return mgr;
}
"""

CALL = """  AddToPinkSlipsList_intarg(
             AwardPinkSlipsCarManagerArg(&carManager),
              (short)carInfo.fCarID,(ushort)carInfo.fColor,
             ({ __asm__("" : "+r"(playerNum) : "r"(fWinner)); playerNum; }));
"""

PN = "  playerNum = fWinner;\n"

CASES = [
 ("F0 baseline", []),
 ("F1 caller local mgr, keep stmt-expr",
  [(HELPER, ""),
   (CALL, "  {\n    tCarManager *mgr = &carManager;\n    AddToPinkSlipsList_intarg(mgr,\n              (short)carInfo.fCarID,(ushort)carInfo.fColor,\n             ({ __asm__(\"\" : \"+r\"(playerNum) : \"r\"(fWinner)); playerNum; }));\n  }\n")]),
 ("F2 mgr local declared before playerNum assign",
  [(HELPER, ""),
   (PN, "  {\n  tCarManager *mgr = &carManager;\n  playerNum = fWinner;\n"),
   (CALL, "  AddToPinkSlipsList_intarg(mgr,\n              (short)carInfo.fCarID,(ushort)carInfo.fColor,\n             ({ __asm__(\"\" : \"+r\"(playerNum) : \"r\"(fWinner)); playerNum; }));\n  }\n")]),
 ("F3 plain &carManager arg",
  [(HELPER, ""),
   (CALL, "  AddToPinkSlipsList_intarg(&carManager,\n              (short)carInfo.fCarID,(ushort)carInfo.fColor,\n             ({ __asm__(\"\" : \"+r\"(playerNum) : \"r\"(fWinner)); playerNum; }));\n")]),
 ("F4 args hoisted to locals, mgr first",
  [(HELPER, ""),
   (CALL, "  {\n    tCarManager *mgr = &carManager;\n    short cid = (short)carInfo.fCarID;\n    ushort col = (ushort)carInfo.fColor;\n    AddToPinkSlipsList_intarg(mgr, cid, col,\n             ({ __asm__(\"\" : \"+r\"(playerNum) : \"r\"(fWinner)); playerNum; }));\n  }\n")]),
 ("F5 mgr fn-scope carrier",
  [(HELPER, ""),
   ("  int playerNum;\n", "  int playerNum;\n  tCarManager *mgr;\n"),
   (PN, "  mgr = &carManager;\n  playerNum = fWinner;\n"),
   (CALL, "  AddToPinkSlipsList_intarg(mgr,\n              (short)carInfo.fCarID,(ushort)carInfo.fColor,\n             ({ __asm__(\"\" : \"+r\"(playerNum) : \"r\"(fWinner)); playerNum; }));\n")]),
 ("F6 mgr fn-scope carrier set before GetPinkSlipsCar",
  [(HELPER, ""),
   ("  int playerNum;\n", "  int playerNum;\n  tCarManager *mgr;\n"),
   ("  carManager.GetPinkSlipsCar((ushort)(byte)frontEnd.pinkSlipsCar[1 - fWinner],carInfo,\n",
    "  mgr = &carManager;\n  carManager.GetPinkSlipsCar((ushort)(byte)frontEnd.pinkSlipsCar[1 - fWinner],carInfo,\n"),
   (CALL, "  AddToPinkSlipsList_intarg(mgr,\n              (short)carInfo.fCarID,(ushort)carInfo.fColor,\n             ({ __asm__(\"\" : \"+r\"(playerNum) : \"r\"(fWinner)); playerNum; }));\n")]),
]

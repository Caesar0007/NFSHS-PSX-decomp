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

UPG = ("  AddUpgradesToPinkSlipsList_intarg(&carManager,\n"
       "             (ushort)(byte)frontEnd.pinkSlipsCar[playerNum],"
       "(ushort)carInfo.fUpgrades,playerNum);\n")
SAVE = "  SavePinkSlipsCars_intarg(playerNum,2,-1);\n"


def call(mgr, four):
    return ("  AddToPinkSlipsList_intarg(" + mgr + ",\n"
            "              (short)carInfo.fCarID,(ushort)carInfo.fColor,\n"
            "             " + four + ");\n")


PLAIN = call("&carManager", "playerNum")

CASES = [
 ("H0 baseline", []),
 ("H1 no device, fWinner in the upgrades index",
  [(HELPER, ""), (CALL, PLAIN),
   (UPG, "  AddUpgradesToPinkSlipsList_intarg(&carManager,\n"
         "             (ushort)(byte)frontEnd.pinkSlipsCar[fWinner],(ushort)carInfo.fUpgrades,playerNum);\n")]),
 ("H2 no device, fWinner in the upgrades 4th arg",
  [(HELPER, ""), (CALL, PLAIN),
   (UPG, "  AddUpgradesToPinkSlipsList_intarg(&carManager,\n"
         "             (ushort)(byte)frontEnd.pinkSlipsCar[playerNum],(ushort)carInfo.fUpgrades,fWinner);\n")]),
 ("H3 no device, fWinner in Save",
  [(HELPER, ""), (CALL, PLAIN), (SAVE, "  SavePinkSlipsCars_intarg(fWinner,2,-1);\n")]),
 ("H4 no device, fWinner in both upgrades slots",
  [(HELPER, ""), (CALL, PLAIN),
   (UPG, "  AddUpgradesToPinkSlipsList_intarg(&carManager,\n"
         "             (ushort)(byte)frontEnd.pinkSlipsCar[fWinner],(ushort)carInfo.fUpgrades,fWinner);\n")]),
 ("H5 no device, playerNum set late + fWinner in Save",
  [(HELPER, ""), ("  playerNum = fWinner;\n", ""),
   (CALL, "  playerNum = fWinner;\n" + PLAIN),
   (SAVE, "  SavePinkSlipsCars_intarg(fWinner,2,-1);\n")]),
 ("H6 no device, fWinner used after everything",
  [(HELPER, ""), (CALL, PLAIN),
   ("  ptVar3 = menuDefs[0];\n", "  ptVar3 = menuDefs[0];\n  playerNum = fWinner;\n")]),
]

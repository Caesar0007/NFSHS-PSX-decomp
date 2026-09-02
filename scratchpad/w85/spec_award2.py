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


def call(mgr, four):
    return ("  AddToPinkSlipsList_intarg(" + mgr + ",\n"
            "              (short)carInfo.fCarID,(ushort)carInfo.fColor,\n"
            "             " + four + ");\n")


CASES = [
 ("G0 baseline", []),
 ("G1 both devices out, plain",
  [(HELPER, ""), (CALL, call("&carManager", "playerNum"))]),
 ("G2 both out, playerNum from fWinner at call",
  [(HELPER, ""), (PN, ""), (CALL, call("&carManager", "(playerNum = fWinner)"))]),
 ("G3 both out, playerNum assigned late",
  [(HELPER, ""), (PN, ""),
   (CALL, "  playerNum = fWinner;\n" + call("&carManager", "playerNum"))]),
 ("G4 both out, mgr local + late playerNum",
  [(HELPER, ""), (PN, ""),
   (CALL, "  {\n    tCarManager *mgr = &carManager;\n    playerNum = fWinner;\n"
           + call("mgr", "playerNum").replace("  Add", "    Add") + "  }\n")]),
 ("G5 both out, playerNum = fWinner + 0",
  [(HELPER, ""), (PN, "  playerNum = fWinner + 0;\n"),
   (CALL, call("&carManager", "playerNum"))]),
 ("G6 both out, playerNum via short round-trip",
  [(HELPER, ""), (PN, "  playerNum = (int)(short)fWinner;\n"),
   (CALL, call("&carManager", "playerNum"))]),
 ("G7 helper out only, stmt-expr kept, mgr from a held local set early",
  [(HELPER, ""),
   ("  dlgThis2 = &RetryCancelDialog;\n",
    "  dlgThis2 = &RetryCancelDialog;\n  mgrHeld = &carManager;\n"),
   ("  int playerNum;\n", "  int playerNum;\n  tCarManager *mgrHeld;\n"),
   (CALL, call("mgrHeld", "({ __asm__(\"\" : \"+r\"(playerNum) : \"r\"(fWinner)); playerNum; })"))]),
]

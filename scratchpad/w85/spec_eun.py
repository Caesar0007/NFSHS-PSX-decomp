V = "  player = *(volatile u_char *)&FEApp->fInputPlayer;\n"
CALLSITE = "      player, frontEnd.playerNameList[FEApp->fInputPlayer]);\n"

CASES = [
 ("I0 baseline", []),
 ("I1 plain read", [(V, "  player = FEApp->fInputPlayer;\n")]),
 ("I2 plain read, 2nd via re-loaded FEApp",
  [(V, "  player = FEApp->fInputPlayer;\n"),
   (CALLSITE, "      player, frontEnd.playerNameList[(*(tFEApplication **)&FEApp)->fInputPlayer]);\n")]),
 ("I3 1st via re-loaded FEApp, 2nd plain",
  [(V, "  player = (*(tFEApplication **)&FEApp)->fInputPlayer;\n")]),
 ("I4 both via distinct byte lvalues",
  [(V, "  player = *(u_char *)((char *)FEApp + 557);\n")]),
 ("I5 plain read, 2nd indexed by player",
  [(V, "  player = FEApp->fInputPlayer;\n"),
   (CALLSITE, "      player, frontEnd.playerNameList[player]);\n")]),
 ("I6 plain, 2nd read into its own local",
  [(V, "  player = FEApp->fInputPlayer;\n"),
   (CALLSITE, "      player, frontEnd.playerNameList[(u_int)(u_char)FEApp->fInputPlayer]);\n")]),
 ("I7 defs load between the two reads swapped",
  [(V, ""), ("  defs = menuDefs[0];\n", "  defs = menuDefs[0];\n  player = FEApp->fInputPlayer;\n")]),
]

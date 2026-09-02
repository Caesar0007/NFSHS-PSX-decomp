import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from pathlib import Path
p = Path(r'C:\Temp\nfs4-decomp\recon\frontend\common\front.cpp')
s = p.read_text(encoding='latin-1')
subs = [
("""  long extraMoney;
  int result;
  /* SYM-CODEGEN-CARRIER: one""",
 """  /* SYM SCOPE/ORDER (W86-S2): `result` is the only function-scope row;
     `extraMoney` (block depth 4) and `tempCommand` (depth 3) are recorded in
     the blocks that use them, and `dummyCars` (depth 5) already is. */
  int result;
  /* SYM-CODEGEN-CARRIER: one"""),
("""  tMenuCommand tempCommand;

  result = kApp_Command_StartRace;""",
 """
  result = kApp_Command_StartRace;"""),
("""  if (needCar) {
    extraMoney = carManager.CheapestCarStockPrice();""",
 """  if (needCar) {
    long extraMoney;

    extraMoney = carManager.CheapestCarStockPrice();"""),
("""    if (gUseFrontend != 0) {
      MenuExtended_TransitionFromPostGameToMainMenu(tempCommand);""",
 """    if (gUseFrontend != 0) {
      tMenuCommand tempCommand;

      MenuExtended_TransitionFromPostGameToMainMenu(tempCommand);"""),
]
for a, b in subs:
    c = s.count(a)
    if c != 1:
        print("MISS/AMBIG:", repr(a[:70]), c)
        continue
    s = s.replace(a, b)
p.write_text(s, encoding='latin-1')
print("written")

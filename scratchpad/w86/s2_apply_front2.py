import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from pathlib import Path
p = Path(r'C:\Temp\nfs4-decomp\recon\frontend\common\front.cpp')
s = p.read_text(encoding='latin-1')
subs = [
# --- Front_SecondaryMemCardCheck: `i` is a block local of the while body ---
("""  int i;
  int j;

  MEMCARDFRONTENDISINITTED_words[0] = 0;""",
 """  /* SYM SCOPE/ORDER (W86-S2): `j` is the only function-scope row; `i` is
     recorded one block deeper, inside the loop body. */
  int j;

  MEMCARDFRONTENDISINITTED_words[0] = 0;"""),
("""  while (true) {
    if (!(j < 2)) break;
    i = 0;""",
 """  while (true) {
    int i;

    if (!(j < 2)) break;
    i = 0;"""),
# --- Front_InitTourneyTraffic order ---
("""  short i;
  /* SYM-CODEGEN-CARRIER: maxTraffic -- the named bound preserves retail's
     saved s5 and register `slt`; literal 3 is FAIL 13 at 90/93 instructions. */
  short maxTraffic;
  /* SYM-CODEGEN-CARRIER: tourn -- materializing the selected tournament
     pointer before the race-type guard preserves the retail index schedule
     and pointer-relative fTraffic load.  Repeating the expression is FAIL 21
     at 92/93 instructions. */
  tTourneyInfo *tourn;
  tCarModels carModel;
  char carColor;
""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read carModel, carColor, i; the two
     non-SYM carriers follow the SYM set. */
  tCarModels carModel;
  char carColor;
  short i;
  /* SYM-CODEGEN-CARRIER: maxTraffic -- the named bound preserves retail's
     saved s5 and register `slt`; literal 3 is FAIL 13 at 90/93 instructions. */
  short maxTraffic;
  /* SYM-CODEGEN-CARRIER: tourn -- materializing the selected tournament
     pointer before the race-type guard preserves the retail index schedule
     and pointer-relative fTraffic load.  Repeating the expression is FAIL 21
     at 92/93 instructions. */
  tTourneyInfo *tourn;
"""),
]
for a, b in subs:
    c = s.count(a)
    if c != 1:
        print("MISS/AMBIG:", repr(a[:70]), c)
        continue
    s = s.replace(a, b)
p.write_text(s, encoding='latin-1')
print("written")

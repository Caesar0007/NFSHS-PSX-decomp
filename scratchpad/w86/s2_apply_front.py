import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from pathlib import Path
p = Path(r'C:\Temp\nfs4-decomp\recon\frontend\common\front.cpp')
s = p.read_text(encoding='latin-1')
subs = [
# InitFrontEndStructure  SYM i, j
("""  int j;
  int i;

  frontEnd.randomSeed = 0;""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read i, j. */
  int i;
  int j;

  frontEnd.randomSeed = 0;"""),
# Front_GetLapsForType -- carrier after the SYM row
("""  uint uVar1;
  short lapconv [2];
""",
 """  /* SYM ORDER (W86-S2): the SYM row lapconv leads; the non-SYM uVar1 carrier
     follows it. */
  short lapconv [2];
  uint uVar1;
"""),
# Front_InitPlayerCars  SYM i, carInfo
("""  tCarInfo *carInfo;
  short i;

  streamData.numPlayers = 0;""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read i, carInfo. */
  short i;
  tCarInfo *carInfo;

  streamData.numPlayers = 0;"""),
# Front_InitCopCars  SYM fBestModel, fBestClass, copModel, copColor, i
("""  tCarModels fBestModel;
  tCarClassType fBestClass;
  short i;
  tCarModels copModel;
  char copColor;
""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read fBestModel, fBestClass, copModel,
     copColor, i. */
  tCarModels fBestModel;
  tCarClassType fBestClass;
  tCarModels copModel;
  char copColor;
  short i;
"""),
# Front_InitTraffic  SYM carModel, carColor, i, bTraffic, maxTraffic
("""  bool bTraffic;
  short maxTraffic;
  short i;
  tCarModels carModel;
  char carColor;

  carColor = '\\0';""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read carModel, carColor, i, bTraffic,
     maxTraffic. */
  tCarModels carModel;
  char carColor;
  short i;
  bool bTraffic;
  short maxTraffic;

  carColor = '\\0';"""),
# Front_AppendPlayerCarData  SYM i, carInfo, carLineup
("""  tCarInfo *carInfo;
  tCarLineup *carLineup;
  short i;

  /* MATCH: SYM-implied `short i` loop counter (index form) + pointer-increment stores
     (*stream++ = v;), same idiom as the sibling Append* fns.
     W56-A6:""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read i, carInfo, carLineup. */
  short i;
  tCarInfo *carInfo;
  tCarLineup *carLineup;

  /* MATCH: SYM-implied `short i` loop counter (index form) + pointer-increment stores
     (*stream++ = v;), same idiom as the sibling Append* fns.
     W56-A6:"""),
# Front_AppendOpponentData  SYM i, carInfo, carLineup
("""  tCarInfo *carInfo;
  tCarLineup *carLineup;
  short i;

  /* MATCH: SYM-implied `short i` loop counter (index form) + pointer-increment stores
     (*stream++ = v;), same idiom as the sibling Append* fns. Materialize p=stream FIRST""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read i, carInfo, carLineup. */
  short i;
  tCarInfo *carInfo;
  tCarLineup *carLineup;

  /* MATCH: SYM-implied `short i` loop counter (index form) + pointer-increment stores
     (*stream++ = v;), same idiom as the sibling Append* fns. Materialize p=stream FIRST"""),
# Front_AppendCopData -- carrier after i
("""  /* SYM-CODEGEN-CARRIER: carInfo -- inlining GetCarFromID at fSimNumber
     moves the call past the leading tag stores (FAIL 14 at 149/149). */
  tCarInfo *carInfo;
  short i;
""",
 """  /* SYM ORDER (W86-S2): the SYM row i leads; the non-SYM carrier follows it. */
  short i;
  /* SYM-CODEGEN-CARRIER: carInfo -- inlining GetCarFromID at fSimNumber
     moves the call past the leading tag stores (FAIL 14 at 149/149). */
  tCarInfo *carInfo;
"""),
# Front_AppendPerpData -- carriers after i
("""  /* SYM-CODEGEN-CARRIER: carInfo -- inlining the lookup at fSimNumber moves
     the call past the leading tag/cursor updates and changes the entire
     handout (FAIL 248 at 168/166). */
  tCarInfo *carInfo;
  /* SYM-CODEGEN-CARRIER: carManagerPtr -- direct carManager access is
     count-exact but schedules its `lui a0` four instructions too early
     (FAIL 2 at 166/166).  The pointer preserves retail placement. */
  tCarManager *carManagerPtr;
  short i;
""",
 """  /* SYM ORDER (W86-S2): the SYM row i leads; the two non-SYM carriers follow. */
  short i;
  /* SYM-CODEGEN-CARRIER: carInfo -- inlining the lookup at fSimNumber moves
     the call past the leading tag/cursor updates and changes the entire
     handout (FAIL 248 at 168/166). */
  tCarInfo *carInfo;
  /* SYM-CODEGEN-CARRIER: carManagerPtr -- direct carManager access is
     count-exact but schedules its `lui a0` four instructions too early
     (FAIL 2 at 166/166).  The pointer preserves retail placement. */
  tCarManager *carManagerPtr;
"""),
# Front_AppendTrafficData  SYM i, density; carriers after
("""  /* SYM-CODEGEN-CARRIER: carInfo -- the lookup result must survive the two
     leading stream stores while `i` advances.  Inlining GetCarFromID at the
     fSimNumber use is count-exact but FAIL 24 (148/148). */
  tCarInfo *carInfo;
  int density;
  /* SYM-CODEGEN-CARRIER: traffic -- widening numTraffic before division
     avoids a narrow-subreg sign-extension chain.  Direct field division is
     FAIL 4 at 150/148 instructions. */
  int traffic;
  short i;
""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read i, density; the two non-SYM
     carriers follow the SYM set. */
  short i;
  int density;
  /* SYM-CODEGEN-CARRIER: carInfo -- the lookup result must survive the two
     leading stream stores while `i` advances.  Inlining GetCarFromID at the
     fSimNumber use is count-exact but FAIL 24 (148/148). */
  tCarInfo *carInfo;
  /* SYM-CODEGEN-CARRIER: traffic -- widening numTraffic before division
     avoids a narrow-subreg sign-extension chain.  Direct field division is
     FAIL 4 at 150/148 instructions. */
  int traffic;
"""),
# Front_AppendTrackData  SYM trackInfo, valtopass; carrier speedMode after
("""  int valtopass;
  int speedMode;
  tTrackInformation trackInfo;
  """,
 """  /* SYM ORDER (W86-S2): the 8c Def rows read trackInfo, valtopass; the non-SYM
     speedMode carrier follows the SYM set. */
  tTrackInformation trackInfo;
  int valtopass;
  int speedMode;
"""),
# Front_BuildStream  SYM d, j, streamData, colourLoop, numplaylistsongs, type, config, gameLang, trackLang
("""  int colourLoop;
  int j, type;
  /* SYM-CODEGEN-CARRIER: randomSeed -- direct assignment to stream[0x31]
     is FAIL 5 at 1001/1000: it keeps the value in $a0 and removes retail's
     load-delay nop.  The captured value restores `lh v0` plus that delay. */
  int randomSeed;
  int numplaylistsongs;
  int *d;
  int trackLang;
  int gameLang;
  int config;
  tFEStream streamData;
  """,
 """  /* SYM ORDER (W86-S2): the 8c Def rows read d, j, streamData, colourLoop,
     numplaylistsongs, type, config, gameLang, trackLang; the non-SYM randomSeed
     carrier follows the SYM set. */
  int *d;
  int j;
  tFEStream streamData;
  int colourLoop;
  int numplaylistsongs;
  int type;
  int config;
  int gameLang;
  int trackLang;
  /* SYM-CODEGEN-CARRIER: randomSeed -- direct assignment to stream[0x31]
     is FAIL 5 at 1001/1000: it keeps the value in $a0 and removes retail's
     load-delay nop.  The captured value restores `lh v0` plus that delay. */
  int randomSeed;
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

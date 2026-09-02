# W86-S2 receipt — SYM/SLD-exact C, `recon/frontend/common/` (8 TUs)

Agent: W86-S2. Methodology §0 rule 8 + §3.8b applied at an UNCHANGED gate.
SYM = `C:\Temp\nfs4-psx\nfs4-psx-sym.txt`
(⚠️ the assignment's path `C:\Temp\nfs4-psx decompiles\nfs4-psx-sym.txt` does not
exist — the file lives under `C:\Temp\nfs4-psx\`).
Gate = `python tools/tugate.py recon/frontend/common/<tu>.cpp` (whole TU).
No git, no `tools/*.py` or `regiondiff/` edits, no memory edits, no new devices,
no pins/asm/volatile added.

## RESULT — 281/281 PASS before, 281/281 PASS after. Nothing regressed.

| TU | fns gated | baseline | final | fns changed |
|---|---|---|---|---|
| femenuextended.cpp | 57 | 57/57 | **57/57** | 9 |
| femenuoptions.cpp  | 92 | 92/92 | **92/92** | 13 |
| femission.cpp      |  5 |  5/5  | **5/5**   | 1 |
| fescreen.cpp       | 27 | 27/27 | **27/27** | 4 |
| fetextrender.cpp   | 17 | 17/17 | **17/17** | 0 (already exact) |
| fetourn.cpp        | 35 | 35/35 | **35/35** | 8 |
| fetv.cpp           |  5 |  5/5  | **5/5**   | 0 (already exact) |
| front.cpp          | 43 | 43/43 | **43/43** | 15 |
| **total**          | **281** | **281/281** | **281/281** | **50** |

SYM `8c Function start` block count per TU equals the gated fn count exactly in
all 8 cases (57 / 92 / 5 / 27 / 17 / 35 / 5 / 43), so the SYM↔TU mapping is total.

19 whole-TU gate runs (8 baseline + 11 verification). One regression was found,
bisected and reverted (below); one apparent regression turned out to be a
duplicate declaration in a partially-applied batch, and the change itself passes.

## Method — five read-only audits (scratchpad only, no repo tools touched)

* `s2_audit2.py` — dumps the SYM 8c block for exactly the mangled names a TU
  gates (read from `verify_asm._name2addr`), VA-ordered → `sym_<tu>.txt`.
* `s2_rev3.py` — brace-matched C bodies + a GCC-2.x demangler; diffs the SYM
  local set against the C declaration set (SYM-ONLY = missing retail local,
  C-ONLY = unSYMed compiler temp materialized as a variable).
* `s2_params.py` — SYM `REGPARM`/`ARG` rows vs the C parameter list, in order.
* `s2_types.py` — SYM row TYPE (PTR/ARY/STRUCT tag/scalar) vs the C declaration.
* `s2_order.py` — **declaration ORDER + SCOPE**: SYM Def-record order (per the
  W86-S5 convention, confirmed by the user's closed game/psx series) vs the C
  function-scope declaration order, and SYM `90 Block start`/`92 Block end`
  nesting depth vs the C brace depth. Param-copy REG rows (a REG row whose name
  also appears as REGPARM/ARG) are excluded — they sit at depth 0 and otherwise
  poison the function-scope depth baseline.

## Audit results per axis (all 281 gated fns)

| axis | before | after |
|---|---|---|
| SYM-named local MISSING from the C | **0** | 0 |
| REGPARM/ARG parameter NAMES | **0** real | 0 |
| local TYPES (SYM row vs C declaration) | **0** | 0 |
| unSYMed temps materialized as variables | 62 rows / ~45 fns — **all already carry a priced `SYM-CODEGEN-CARRIER` receipt** | unchanged |
| **declaration ORDER + SCOPE** | **53 fns** | **5 residual, all explained below** |

So the name / param / type axes were already closed by earlier frontend waves;
this TU set was, exactly as W86-S5 found for `frontend/psx/`, **name- and
type-clean but order-and-scope-blind**. All 50 edits are in that axis.

## Changes applied (each whole-TU gated; 0 reverts among these)

### femenuextended.cpp (9)
* `tMenuNFS4::Initialize` — **SCOPE**: `item` (SYM block depth 4, in the block
  opened by the `fFlags & 0x200` test) moved out of function scope into that `if`.
* **ORDER** (8): `MenuNFS4_DrawTextBox` (textpix before dist);
  `tMenuItemGoToMenuNFS4Button::Draw` and `tMenuItemNFS4LeftRightChoice::Draw`
  (rect before dist); `tMenuItemOptionsLeftRightChoice::Draw` (r first);
  `tMenuItemOptionsTwoItemChoice::Draw` (r, left, ColTextOn, ColTextOff, Col,
  drawFlags); `tMenuNFS4::TransitionIsFinished` (i, result lead — the four
  `ptVar1/iVar2/uVar3/iVar4` carriers moved behind them); `tMenuNFS4::Draw`
  (i, drawFlags lead, `iVar3/iVar4` behind); `tMenuOptions::Draw`
  (numItems, i, deltaTicks, x, y, w, h, itemY).

### femenuoptions.cpp (13)
* `DrawLeftFlare` — **SCOPE**: `x` (SYM depth 3) moved into the
  `if (0 < flare_intensity)` block; this also leaves the function-scope pair in
  SYM order (flare_intensity, glintFade).
* **ORDER / carrier placement** (12): `SubtractiveBox` (dr_mode, prim; packetCell
  after); `tOptionsMenu::Draw` (i, drawFlags lead); `tInsideBoxMenu::Draw`
  (i, j lead); `tMenuItemLeftRightFade::MyLeftRightDraw` (aCol, ColText);
  `tMenuItemOnOffLeftRightChoice::Draw` (ColTextOn, ColTextOff lead);
  `tMenuItemLeftRightAudioSlider::Draw` (coltext, tCol lead);
  `tInsideBoxSongMenu::Draw` (j, drawY, song); `tInsideBoxSongMenu::DrawOneSong`
  (Col, ColTextOn, ColTextOff, ColText);
  `tMenuItemControllerLeftRightChoice::Draw` (shape, Col, ColText lead);
  `tInsideBoxLeftRightSlider::Draw` (col $s3, coltext $s4);
  `tInsideBoxTwoWaySlider::Draw` (ww, col, col2, coltext; selection and fWidth
  after); `tMemoryCardMenuItem::Draw` (fEnableFade, fEnableSlide, x, y, ColText,
  Col, tCol, fWidth, shape; sVar2/v/sv/less after).
* 🔴 **Stale in-source claim corrected**: `tInsideBoxLeftRightSlider::Draw`
  carried a note asserting "decl order coltext-before-col is the s3/s4
  assignment". The SYM says the opposite (`col` $13=$s3, `coltext` $14=$s4) and
  the SYM order gates identically (92/92). Note rewritten.

### femission.cpp (1)
* `tMissionManager::LoadDescription` — **ORDER**: input, data, numMissions,
  numStages, filename (was data, input, numStages, numMissions, filename).

### fescreen.cpp (4) — all ORDER
`tScreen::DrawBackgroundImage` (drawFlags, i); `tScreen::IsShapeFileLoaded`
(result, async_status, bogus); `tScreen::Initialize` (numPermShapes,
numSwapShapes, permFileName, swapFileName, shapesLoaded);
`tScreen::FreeShapes` (i, async_status).

### fetourn.cpp (8)
* `tTournamentManager::CalcTrackFinishDamageBill` — **SCOPE** `i` into the
  `if (recalculate)` block, **plus ORDER** of the depth-1 set (retbill, retbonus,
  dummyCars, carInfo, damage, totalcarprice; `mask` carrier last).
* `tTournamentManager::AdvanceToNextTrack` — **SCOPE**: `numGarageCars`
  (SYM block depth 11) moved into the completed-tier arm.
* **ORDER** (6): `LoadDescription` (input, data, tier, tourney, track, filename;
  tourneyDef/trackId/trnId after); `tournPointsCompare` (result, dummyCars;
  tm/comps after); `UpdateAwardInformation` (bonus, bill);
  `tListIteratorTournament::Decrement` (tier, then the `value` carrier);
  `StartNewTournament` (i, tourn, track lead, seven carriers after);
  `GetTrophyName` (`best` carrier moved behind `trophySizeLetter`).

### front.cpp (15)
* **SCOPE** (3): `Front_SecondaryMemCardCheck` — `i` (SYM depth 3) into the loop
  body, leaving `j` as the only function-scope row; `Front_Menu` — `extraMoney`
  (depth 4) into the `if (needCar)` arm and `tMenuCommand tempCommand` (depth 3)
  into the `if (gUseFrontend)` arm, leaving `result` as the only function-scope
  row (`dummyCars`, depth 5, was already a block local).
* **ORDER** (12): `InitFrontEndStructure` (i, j); `Front_GetLapsForType`
  (lapconv leads, uVar1 after); `Front_InitPlayerCars` (i, carInfo);
  `Front_InitTourneyTraffic` (carModel, carColor, i; maxTraffic/tourn after);
  `Front_InitCopCars` (fBestModel, fBestClass, copModel, copColor, i);
  `Front_InitTraffic` (carModel, carColor, i, bTraffic, maxTraffic);
  `Front_AppendPlayerCarData` and `Front_AppendOpponentData` (i, carInfo,
  carLineup); `Front_AppendCopData` and `Front_AppendPerpData` (i leads, carriers
  after); `Front_AppendTrafficData` (i, density; carInfo/traffic after);
  `Front_AppendTrackData` (trackInfo, valtopass; speedMode after);
  `Front_BuildStream` (d, j, streamData, colourLoop, numplaylistsongs, type,
  config, gameLang, trackLang; randomSeed after).

## Mismatches that could NOT be applied (with measured cost)

1. **femenuoptions `tUserNameMenuItem::TransitionOn` — `NumberOfRows` scope —
   REVERTED, FAIL 28.** SYM puts `short NumberOfRows[6]` at function scope
   (block depth 1, AUTO slot -0x28); the C declares it inside the block that
   performs the `menu_kUserNameRows` store. Hoisting it to function scope
   compiles clean but the aggregate initializer's rodata→stack block copy
   (3× `lwl/lwr` + `swl/swr` from `D_80010A00`) then runs *before* the sprintf
   loop instead of at the store, moving the whole group above the loop:
   **28 diffs**. Reverted; an in-source note records the cost at the declaration.
2. **fetourn `GetTrophyName` — `best` cannot go fully behind the SYM set.**
   The SLD places its `fBestPlacement` read on line 1042/1043, i.e. *between*
   the two array initializers and inside the entry basic block (sched1 cannot
   move a load across the following branch). Its declaration was moved as far
   right as that statement allows (now after `trophySizeLetter`); moving it past
   `trophyPlacementLetter` would require moving the statement too, contradicting
   the SLD. **SLD-directed, not a defect.**
3. **femenuoptions `tMenuItemControllerLeftRightChoice::Draw` — x/y/w still
   precede `drawFlags`.** `drawFlags` is a function-scope SYM AUTO deliberately
   declared *after* the inner `tCol` block (documented: that is what lets gcc
   reuse AUTO slot -56, which SYM confirms `tCol` and `drawFlags` share). x/y/w
   are used long before that point, so they cannot follow it. **Structural.**
4. **`__in_chrg` and repeated `this` REG rows** (tAllScreens, tMenuNFS4*,
   tScreen ctors/dtors; `FETextRender_Title`) — the gcc-2.x destructor
   in-charge flag and inlined-method `this` pseudos. Not source variables;
   nothing to apply.
5. **Params SYM omits entirely** (`selected`, `fromPlayer`, `command`, the
   unnamed 5th `short` of `tInsideBoxMenu::Draw`, the `tPlayer` of the
   `tListIteratorTournament` accessors) — unused arguments the optimized debug
   build dropped. The mangled signature proves they exist, so the C keeps them;
   the existing `SYM-ABI-PARAM` notes are correct.

## Residual audit output and why it is clean

`s2_order.py` still prints 5 rows; each is a known heuristic artefact:
* `tMenuNFS4::Initialize` "SYM fn-scope but C nested" — degenerate: the function
  has exactly one local, so the "minimum Def depth = function scope" baseline
  collapses onto it. The SYM's own `Block start line = 11/12/13` chain proves the
  nesting, and the applied move gates 57/57.
* the four rows named in "could not be applied" above.

`s2_rev3.py`/`s2_types.py` residuals (`tourn`/`track` in `StartNewTournament`,
`openClassAdjust` in `GetTrackFinishPrize`, the nine front.cpp "type" rows) are
declaration-regex limitations — `Type* name;` with the star bound to the type,
multi-line aggregate initializers, and `return stream;` read as a declaration.
Each was inspected by hand and is correct in the source.

Seal-criteria scan (comments stripped) over all 8 TUs: **0** Ghidra-isms.

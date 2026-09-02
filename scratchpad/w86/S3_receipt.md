# W86-S3 receipt — SYM/SLD-exact C, frontend/common screen* set

Agent: W86-S3 (SYM/SLD exactness). Repo `C:\Temp\nfs4-decomp`.
SYM read via `tools/symblk.py`'s source `C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt`
(the repo-trusted MND dump; `C:\Temp\nfs4-psx\nfs4-psx-sym.txt` is the same SYM in the
w86 GUIDE's wording — the GUIDE's path `C:\Temp\nfs4-psx decompiles\...` does not exist).
Gate: `python tools/tugate.py <cpp>` whole-TU after EVERY edit (iron rule).

## GATE — unchanged, before and after (145 fns, 6 TUs)

| TU | before | after |
|---|---|---|
| screenaudio.cpp      |  8/8 PASS |  8/8 PASS |
| screencarselect.cpp  | 59/59 PASS| 59/59 PASS|
| screencongrats.cpp   | 28/28 PASS| 28/28 PASS|
| screencontroller.cpp | 22/22 PASS| 22/22 PASS|
| screenmain.cpp       | 13/13 PASS| 13/13 PASS|
| screenmemcard.cpp    | 15/15 PASS| 15/15 PASS|

**0 regressions. 0 reverts needed** — every change below gated PASS on its first try.
Totals: **23 declaration-ORDER fixes, 9 SCOPE fixes (fn-scope → the SYM's nested block),
8 carrier-placement fixes, 6 decompiler-name renames** across the six TUs.

Cross-check with the W86-S5 relay: independently derived the same rule (8c `Def`-record
order IS source declaration order, not reversed) — confirmed here by the already-exact
`InitDynamicImages` and `DrawBackground__11tScreenMain` fn-scope blocks, whose C order and
8c order agree element-for-element. This pass found the same two defect classes S5 reports
(wrong declaration ORDER: 23 fns; a nested-block SYM local wrongly at function scope:
9 fns) plus a third (non-SYM carriers declared before/among the SYM set: 8 fns).

## Method

1. Per TU, listed every oracle symbol (`verify_asm._name2addr`) and pulled each function's
   SYM `8c Function start` block (REGPARM/ARG params, `REG $N`/AUTO/STAT locals with type,
   size, register/stack home, and the interleaved `90/92 Block start/end` scope stream).
2. Diffed SYM records against the C: NAME present, TYPE, SCOPE (which block), and the
   *declaration ORDER within each block* (the 8c record order — confirmed to equal source
   decl order by the already-exact `InitDynamicImages` / `DrawBackground__11tScreenMain`
   fn-scope blocks, where C order and SYM order agree exactly).
3. Applied one change at a time, re-gating the whole TU each time (§3.12 #15: decl scope and
   order are load-bearing; renames are codegen-free, scope/order changes are not).

## Audit numbers

| TU | fns gated | SYM local/param records | inlined-callee `this` records (inapplicable) | documented codegen carriers |
|---|---|---|---|---|
| screenaudio      |  8 |  17 |  1 |  8 |
| screencarselect  | 59 | 177 | 36 | 44 |
| screencongrats   | 28 |  46 |  0 | 14 |
| screencontroller | 22 |  71 |  3 | 35 |
| screenmain       | 13 |  49 |  6 | 12 |
| screenmemcard    | 15 |  47 |  0 | 31 |

After this pass **every SYM-named local and param in all six TUs exists in the C with the
SYM's name and type**, in the SYM's block scope and the SYM's within-block declaration order,
except the two classes listed under "Inapplicable" below.

## Changes applied (all gate-verified)

### screenmain.cpp — 4 decl-order fixes
* `SwapBackground`   fn scope `oldState, buffer` → **`buffer, oldState`** (SYM order).
* `SetState`         fn scope `shape, i` → **`i, shape`**.
* `PreLoad`          fn scope `i, buffer` → **`buffer, i`**.
* `Initialize`       fn scope `shapesLoaded, i` → **`i, shapesLoaded`**.
* `DrawBackground`   movie block `r, moviename` → **`moviename, r`** (8c record order; note
  the stack offsets run the other way — moviename sp+96, r sp+88 — because `r` re-uses the
  warning block's slot; the record order, not the offset order, is the decl order).

### screencongrats.cpp — 1 order + 3 scope fixes, 1 stale comment corrected
* `GetShapeInfo__15tScreenCongrats`: `tourneyInfo` moved to first fn-scope decl (SYM order);
  **`j` and `i` moved out of fn scope into the trophy `if` block**, `i` in a further nested
  block, matching the SYM's `blk@14 { blk@19 j { blk@19 i } }`.
* `GetCar__23tScreenTournamentTrophy`: **`tInfo` moved from fn scope into the
  `congratsMessage == Congrats` block** (SYM: AUTO sp+16, block opened at SLD 3).
* `DrawCongratsMessage__23tScreenTournamentTrophy`: **`buffer[256]` and `money[64]` moved
  from fn scope into the `tInfo.fAwardCarGarageFull` block** (SYM: AUTO sp+1112 / sp+1368 in
  the block opened at SLD 72). The in-file comment claimed they were fn-scope — corrected.
* `DrawCongratsMessage__23tScreenBeTheCopCongrats`: `r, congrats` → **`congrats, r`**.
* `CalculatePrizes__23tScreenPinkSlipCongrats`: `carinfo` (the fn's ONLY 8c record) moved
  ahead of the two carriers; tagged `[SYM]`.

### screencontroller.cpp — 2 order + 2 scope fixes
* `ShakeIt`: `padState, padnum` → **`padnum, padState`**.
* `SetCurrentController`: `setmenutonull, fSetMenu` → **`fSetMenu, setmenutonull`**.
* `DrawController`: the three STAT records (`flare_intensity`, `max_fi`, `max_fidir`) moved
  **after `fadelevel`** — the 8c block emits them there, not at the head; and
  **`int frame` scoped into a block** spanning the twist-range arm (SYM: REG $a1 in the block
  opened at SLD 322 / closed at 334 — it does not reach the two tail arms).
* `DrawBackground`: **`i` moved into a block around the ScaleShapeExtended loop**
  (SYM: REG $s0, block opened at SLD 44).

### screenmemcard.cpp — 2 order + 2 scope fixes
* `LoadIcon`: `done, i, clutx, cluty` → **`done, clutx, cluty, i`**.
* `PlaceIcons`: `yy, xx` → **`xx, yy`**; **`fFlags` moved into the NFS4-icon arm**
  (SYM: AUTO sp+32, block opened at SLD 16).
* `DrawForeground`: **`k` scoped into a block around the shape loop** (SYM: REG $s0,
  block opened at SLD 5).

### screencarselect.cpp — 7 order + 2 scope fixes + 6 decompiler-name renames
* `tScreenCarSelect::tScreenCarSelect`: `i, overlay` → **`overlay, i`**.
* `DrawOverlay`: whole fn-scope block re-ordered to the 8c order
  **`pos, temp, carInfo, fade, i, j, drawFlags, text, value, validCar, moneyColor,
  upgradeTranslate, upgradeIcons`** (was `value, text, moneyColor, validCar, i, j, fade,
  pos, temp, carInfo, drawFlags, …`).
* `CalcSplinePosition`: `i, T, G, Result1, Result2` → **`T, G, i, Result1, Result2`**.
* `ProcessInput__16tScreenCarSelect`: **`carInfo, validCar, item` moved from fn scope into
  the `keyval == Square` block** (SYM block opened at SLD 3), in that 8c order.
* `DrawVideoWall__16tScreenCarSelect`: → **`carInfo, validCar`**.
* `DrawVideoWall__20tScreenCarSelectDuel`: → **`validCar, carInfo, i`**.
* `DrawBackground__20tScreenCarSelectDuel`: → **`r, carInfo, drenv, daprim, temp, validCar`**.
* `DrawVideoWall__25tScreenCarSelectTwoPlayer`: → **`i, validCar, carInfo`**.
* `DrawBackground__25tScreenCarSelectTwoPlayer`: → **`r, carInfo, carY, drenv, daprim, temp`**.
* `DoMemCardStuff__25tScreenPinkSlipsCarSelect`: fn scope → **`player, card`** first;
  **`ret` scoped into the card-load arm** (SYM: REG $v1, block opened at SLD 39).
* Renamed 6 leftover **decompiler** temp names to semantic ones (codegen-free, gated):
  `bVar1`→`country` (×3 `UpdateVideoWall` overrides), `uVar1`→`color`
  (`GetCar__16tScreenCarSelect`), `bVar1`→`p2Ready` / `bVar2`→`p1Ready`
  (`DrawBackground__20tScreenCarSelectDuel`). These are the only `xVarN`/`local_*`/`in_rN`
  identifiers left anywhere in the six TUs; the set is now empty (one historical mention
  survives inside a prose comment only).

### screenaudio.cpp — 1 carrier-placement fix
Already SYM-exact from the prior wave (locals `opts, sndover, vol, RepresentativeSound,
azimuth, fade, i, lastpercentage, perfade, percent, ColText, sBuildOutput` all present with
SYM names, types, scopes and relative order).
* `DrawBackground`: carriers `optionsMenu` / `fadeValue` had been interleaved between the
  SYM records `fade` and `percent` → moved **after** the SYM set.

### Carrier-placement sweep (S5 relay rule: non-SYM carriers AFTER the SYM set)
A second pass moved every fn-scope carrier that sat before/among the SYM records to after
them. All gated PASS:
* screenaudio `DrawBackground`: `optionsMenu`, `fadeValue` → after `fade, percent`.
* screenmain `DrawDropShadow`: `addr_24, addrMask, tagMask, pal_link, palTag` → after `i, prim`.
* screencarselect `CalcSplinePosition` `_i`; `DrawForeground` `currentItemValue`;
  `PreLoad__20tScreenCarSelectDuel` `useDefault`; `DrawVideoWall__20tScreenCarSelectDuel`
  `vtbl`; `DrawBackground__25tScreenCarSelectTwoPlayer` `vtbl, elapsed, uploadY`;
  `SetDialog__25tScreenPinkSlipsCarSelect` `wordnum` (SYM `player` now first).
* Already compliant and left alone: screencongrats (`numRanked`, `vtbl`, `cashAwarded`),
  screencontroller (`shockModeActive`, `dialog`, `om`), screenmemcard (`cardInfo`,
  `animFrame`, box-metric carriers).
* NOT moved: screenmemcard `DrawIcon` `u` — it sits between SYM `bpp` and SYM `v` but its
  declaration carries an *initializer* (`((sposx & 0x3f) << bpp) / bpp`), so moving it is a
  statement-order change, and the in-file receipt measures that move as FAIL 87 / 125 vs the
  PASS-126 placement. Recorded as inapplicable.

## Mismatches that could NOT be applied (with cost)

**(a) Inlined-callee `this` records — structurally inapplicable (46 records).**
Many 8c blocks carry `REG this` records of a *different* class type (`tOptionsMenu`,
`tFEApplication`, `tMenuItem`, `tDialogBase`, `tDialogMessageString`, `tCarStatType`
helpers). These are the `this` pseudos of member functions the retail build INLINED into the
caller; `this` is a keyword and cannot be declared as a C++ local, so the recon carries them
under a descriptive name where the value web is load-bearing:
`optionsMenu` (screenaudio `DrawBackground`, cost of removing it: FAIL 7 @153/154),
`om` (screencontroller `DrawBackground`, FAIL 27 documented), `curMenu` (screenmain
`DrawBackground`, the documented %hi-rematerialization edge), `feApp`/`menus` etc.
Cost of naming them `this`: **does not compile**. Inapplicable by language, not by codegen.

**(b) SYM-omitted value webs ("SYM-CODEGEN-CARRIER") — 144 across the six TUs.**
Each is a C local with NO 8c record whose removal was previously measured and receipted
in-file. They are retained under the iron rule (removing them regresses the gate). Spot list
of the costs recorded in the sources for the ones that sit *inside* the blocks I re-ordered
or re-scoped (unchanged by this pass):

| TU / fn | carrier | measured cost of folding it back |
|---|---|---|
| screenaudio `PlaySound` | `validItem` | FAIL 7 (direct `&&`), FAIL 3 (nameless ternary) |
| screenaudio `DrawForeground` | `fadeCalc` | FAIL 20 @64/68; block-limited FAIL 7 @69/68 |
| screenaudio `DrawBackground` | `optionsMenu` / `fadeValue` / `displayPercent` | FAIL 7 / FAIL 20 @156/154 / FAIL 2 |
| screenaudio `Initialize` | `menus`, `audioMode` | FAIL 9 @25/24 |
| screenmain `DrawDropShadow` | `addr_24, addrMask, tagMask, pal_link, palTag` | 32 → PASS (allocsim-priced 3-way rotation) |
| screenmain `DrawBackground` | `videoY` / `startMovie` / `elapsedTicks` / `nextAnimation` / `animationFrame` / `fadeComponent` | 24 @820/822 / 5 @821/822 / 10 (count-exact) / 3 @823/822 / 22 (count-exact) / 22 (count-exact) |
| screencongrats `GetShapeInfo` | `numRanked` | FAIL 100 @156/150 (+frame growth, saved-reg rotation) |
| screencongrats `CalculatePrizes` (PinkSlip) | `player` / `speechId2` / `base` | FAIL 71 @65/68 / required 3-step mutation / 9–14 |
| screencongrats `CalculatePrizes` (Trophy) | `knockout` / `ranked` | FAIL 17 @145/144 / FAIL 2 (lh→lhu) |
| screencontroller `SetCurrentController` | `dialog`,`dialogIsIdle`,`previousNegconChoice`,`menuDefinitions` | FAIL 40 @220/222 / FAIL 5 @221/222 / FAIL 214 @220/222 |
| screencontroller `DrawController` | `shockModeActive` / `shockImpactActive` / `rangeValue` / `modeBase` / `controller` | FAIL 18 @832/836 / FAIL 52 @834/836 / FAIL 55 @837/836 / — / FAIL 21 @839/836 |
| screencontroller `DrawBackground` | `om` | W57/W64 receipt (36→27→PASS) |
| screencontroller `DrawForeground` | `selectedConfig` / `textLocationOut,copyCount,textLocationIn` / `textLength` | FAIL 2 (count-exact) / FAIL 43 @411/410 / FAIL 151 @411/410 |
| screenmemcard `LoadIcon` | `cardInfo` / `one` / `pulled` | 2 diffs @215/215 / documented / documented |
| screenmemcard `PlaceIcons` | `animFrame`/`nfs4Icon`/`tickFrame`/`numIcons`/`tickPtr`/`savedY` | 93 @214/213 / 3 @214/213 / 18 (count-exact) / 64 @217/213 / 2 / 2 |
| screenmemcard `DrawVerticalLine`,`DrawHorizontalLine` | `innerHeight,pos,test,shifted` / `width,pos,test,shifted` | documented in-file (SYM records NO local for either fn) |
| screenmemcard `DrawBackground` | `w,h,gouraudX,gouraudY,extraY,startX,startY` | 28 / 16 / 20 (count-exact) / … per-carrier in-file |
| screenmemcard `DrawForeground` | `fade` | retail $s1 web (IDA/m2c cross-checked) |
| screencarselect `CalcSplinePosition` | `_i` | FAIL 107 @185/176 |
| screencarselect `DrawOverlay` | `tournamentMoney,yOffset,flags,xPos,curItem` | in-file receipts |
| screencarselect `DrawBackground` (TwoPlayer) | `elapsed` / `uploadY` / `uploadReady` | FAIL 10 (count-exact) / FAIL 6 (count-exact) / FAIL 24 @338/342 |
| screencarselect `DrawBackground` (Duel) | `p2Ready` / `p1Ready` | FAIL 16 (count-exact) / FAIL 7 @413/414 |
| screencarselect `UpdateVideoWall` ×3 | `country` | FAIL 2 / FAIL 3 (direct fCountry store) |
| screencarselect `GetCar` | `color` | retail records no caller local; direct store measured |
| screencarselect (5 sites) | `vtbl` | byte-identical either way; kept for `audit_vtable_indexing` safety |

**(c) One SYM record with no C counterpart, deliberately:** `DrawIcon__14tScreenMemcard`
has SYM `u` absent while the recon keeps a `u` carrier — the SYM lists `bpp` then `v` with no
`u` record (dead after CSE); the recon's `u` is the documented shared-texture-coordinate
carrier, so the C is a superset here, not a mismatch.

## Not touched
No git operations, no `tools/*.py` / `regiondiff/tools/*.py` / board / MANIFEST / memory-dir
edits, no new devices, no volatile/asm added or removed, no pins.

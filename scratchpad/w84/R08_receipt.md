# W84 R08 receipt — regional-variant matching (22 rows)

Gate (authoritative, run for every row below):
```
python regiondiff/tools/verify_region.py <REGION> <candidate> <fn[,fns]> --lane-as=recon/<unit>.<ext>
```
Helper used for full (untruncated) aligned diffs, read-only, no tool edits:
`scratchpad/w84/rvdiff.py` (execs verify_region.py's own compile/normalizer/oracle loader up to its
diff driver and prints the same skeleton-aligned pairing without the 12-line cap).

## RESULT: 20 / 22 rows REGION-PASS. 2 rows count-exact near-misses (both documented below).

| # | fn | region | status |
|---|---|---|---|
| 1 | DoMemCardStuff__25tScreenPinkSlipsCarSelect | USA | **REGION-PASS** (193) — was FAIL 61 |
| 2 | DrawCar__FR8tCarInfossffcbUl7tPlayer | USA | **REGION-PASS** (125) — was FAIL 60 |
| 3 | DrawForeground__16tScreenCarSelect | USA | FAIL 16, count-exact 566/566 — was FAIL 31 @557 |
| 4 | DrawVideoWall__25tScreenCarSelectTwoPlayers | USA | **REGION-PASS** (104) — was FAIL 6 |
| 5 | GetShapeInfo__25tScreenCarSelectTwoPlayer... | USA | **REGION-PASS** (58) — was FAIL 50 @38 |
| 6 | GetShapeInfo__25tScreenPinkSlipsCarSelect... | USA | **REGION-PASS** (30) — arrived sealed, re-verified |
| 7 | Initialize__25tScreenCarSelectTwoPlayer | USA | **REGION-PASS** (32) — was FAIL 16 @20 |
| 8 | Initialize__25tScreenPinkSlipsCarSelect | USA | **REGION-PASS** (28) — arrived sealed, re-verified |
| 9 | ProcessInput__16tScreenCarSelect... | USA | **REGION-PASS** (111) — was FAIL 25 @98 |
| 10 | ProcessInput__25tScreenPinkSlipsCarSelect... | USA | **REGION-PASS** (58) — was FAIL 62 @42 |
| 11 | Initialize__11tScreenMain | JPN | **REGION-PASS** (223) — was TODO (seed 129/223) |
| 12 | SwapBackground__11tScreenMaini | JPN | **REGION-PASS** (109) — was TODO (seed 111/109) |
| 13 | FEInput_GetKeyFromPlayer__F7tPlayerl | JPN | **REGION-PASS** (77) — arrived sealed, re-verified |
| 14 | FEInput_GetNoDebounceKey__Fii | JPN | FAIL 4 (= 2 mismatched pairs), count-exact 122/122 — was FAIL 2 @124/122 |
| 15 | FEInput_VerifyControllerValues__Fi | JPN | **REGION-PASS** (28) — arrived sealed, re-verified |
| 16 | DoLanguageScreen__Fv | FR-DE | **REGION-PASS** (183) — was TODO (seed 15/183) |
| 17 | Movie_Play__Fc | USA | **REGION-PASS** (134) — arrived sealed, re-verified |
| 18 | func_80012F50 | USA | **REGION-PASS** (106) — arrived sealed, re-verified |
| 19 | GoNonInterlaced__7tScreen | AU | **REGION-PASS** (51) — arrived sealed, re-verified |
| 20 | func_8004DD3C | UK-ES-IT | **REGION-PASS** (37) — arrived sealed, re-verified |
| 21 | func_800A7884 | USA | **REGION-PASS** (8) — arrived sealed, re-verified |
| 22 | func_800A7810 | AU | **REGION-PASS** (6) — arrived sealed, re-verified |

Files touched (candidates only; no base-tree / tool / memory edits, no git ops):
* `regiondiff/recon/NFS4-R-USA/frontend/common/screencarselect.cpp` (rows 1-10)
* `regiondiff/recon/NFS4-R-JPN/frontend/common/screenmain.cpp` (rows 11-12, NEW seed)
* `regiondiff/recon/NFS4-R-JPN/frontend/common/feinput.cpp` (row 14)
* `regiondiff/recon/NFS4-R-FR-DE/frontend/psx/psxfront.cpp` (row 16, NEW seed)
* `scratchpad/w84/rvdiff.py`, `scratchpad/w84/frde_dolang.txt`, backups `feinput_jpn*.cpp` (scratch)

---

## screencarselect (USA) — `--lane-as=recon/frontend/common/screencarselect.cpp`

* **Row 4 DrawVideoWall (seed FAIL 6 -> PASS).** Regional delta: `SetAvailableText` x-arg
  `0xf8` -> `0xf9`, and `::UpdateTransition(fVideoWall)` moved from BEFORE `SetValid`/`SetAvailable`
  to AFTER them.
* **Row 7 Initialize__25tScreenCarSelectTwoPlayer (seed FAIL 16, 20/32 -> PASS).** Retail wraps the
  three `fPrevious* = -1` stores in `if (FEAppB[0]->fPlayer == 1)` with an
  `else SetAvailableText(fVideoWall,0xf9,0x10e,0x2d);`, and `fState = 0` moves after the merge point.
* **Row 5 GetShapeInfo__25tScreenCarSelectTwoPlayer (seed FAIL 50, 38/58 -> PASS).** The
  unconditional `carManager.GetStockCar(0,carInfo)` seed is replaced by the virtual GetCar dispatch
  (`(*this->_vf)[13]`, same call shape as DrawVideoWall); a `useSwapCar` flag
  (= call succeeded && `FEAppB[0]->fPlayer == 0`) gates publishing the swap car: true path stores
  fCarIndex/fCountry/`(signed char)`fCarID into `fPrevious*` + `sprintf(gSwapFileName[0],"%s",
  carInfo.fSmallName)`; false path `*swapFileName = NULL`. (Field offsets read off the oracle:
  216(sp)=carInfo+200=fCarIndex, 215(sp)=+199=fCountry, 16(sp)=+0=fCarID, sp+32=+16=fSmallName.)
* **Row 10 ProcessInput__25tScreenPinkSlipsCarSelect (seed FAIL 62, 42/58 -> PASS).** Every path now
  ends in a direct `this->tScreenCarSelect::ProcessInput(player,keyval,menuCommand)` tail call; the
  two early exits become `goto processBase;`. Parameters had to be named.
* **Row 9 ProcessInput__16tScreenCarSelect (seed FAIL 25, 98/111 -> PASS).** Inside the
  `keyval == Square` arm: all three ABS text ids +1 (0x10b/0x10c/0x10d -> 0x10c/0x10d/0x10e);
  `item->fFlags &= ~1;` added right after the first SetTextDescription; `fCarID == 8` becomes
  `fCarID == 8 || fCarID == 24`; and a new `if (carInfo.fABSAvailable == 0) item->fFlags |= 1;`
  inside the `validCar` block (the `beqz validCar` skips it, per the oracle's branch target).
* **Row 2 DrawCar (seed FAIL 60, 107/125 -> PASS).** An ELSE arm on `if (-1 < carInfo.fCarID)`
  calling the REGION-ONLY helper
  `func_80012F50(&gCView,(int)x,(int)y,player,0,rotate,camerax,cameray)` (row 18's TU; arg mapping
  read off the oracle's stack slots). Declared `extern "C"` at the top of the TU. The extra
  cross-call live values are what widen the frame 80 -> 88 and add s6/s7.
* **Row 1 DoMemCardStuff (seed FAIL 61, 198/193 -> PASS).** Retail drops the two result-discarded
  probe calls (`carManager.GetNumPinkSlipsCars(player); carManager.CheapestCarStockPrice();`) the
  base build makes right after a successful `LoadGame`. Removing them also restores the s2/s3 pairing.
* **Row 3 DrawForeground — FAIL 16, COUNT-EXACT 566/566** (seed FAIL 31, 557/566). Four regional
  deltas found and applied:
  1. cheat id at the tournament gate: `cheat_FinishedTournament`(25) -> **13** (retail cheat table
     renumbered; the identity of id 13 in the regional table is left `[INFERRED]`, no invented name).
  2. the `fState == 4` arm also sets `fOverlays[5].direction = 1; fOverlays[3].direction = 1;`
     (oracle offsets 240/192 = fOverlays base 100 + n*24 + 20).
  3. speech text base `0x3e4` -> `0x3e5`.
  4. the shape fade is recomputed from ELAPSED speech time and the draw is gated:
     `shapeTicks = (ticks[0]-fSpeechTicks)-0x80; shapeFade = 0x80;
      if (0 < shapeTicks) shapeFade = (shapeTicks < shapeFade) ? shapeFade-shapeTicks : 0;
      if ((fSwapShapes.fFlags & 1) && shapeFade < 0x80) DrawShapeExtended(0xA,0x200,0,0,shapeFade,0,&drawFlags);`
     replacing the base build's raw-`fSpeechTicks` three-way fade + unconditional draw. Initializing
     `shapeFade` to the shared constant reproduces the oracle's `li t1,128`-in-the-blez-delay-slot
     and its register-register `slt` (a separate `fadeBase` local const-folds to `slti` + an extra `li`).
     The base TU's `__asm__` fence in that arm was dropped (W84 no-asm rule) and is not needed.

  **RESIDUAL (16 diffs) = a pure two-register rotation inside that one block**: ours
  `delta=$v1, fade=$t0` vs oracle `delta=$t0, fade=$t1`; opcodes, order, delay slots and every other
  register are identical, and the whole 566-insn stream matches elsewhere.
  Falsified (each measured): ternary form (19), inverted `if (fadeBase <= x)` polarity (19),
  `shapeFade = 0` -first form (19), split delta variable (16), `(long)`-cast form (16), separate
  `fadeBase` constant (19), all three decl-order permutations of `{shapeFade, shapeTicks, fadeBase}`
  (16), fade block moved before the `drawFlags` stores (28), nested guard instead of `&&` (16).

## screenmain (JPN) — NEW seed, `--lane-as=recon/frontend/common/screenmain.cpp`

* **Row 12 SwapBackground (seed FAIL 20, 111/109 -> PASS).** One-line regional delta:
  `rand() % 0x1c` -> `rand() % 0x1d` (29 backgrounds). The magic-divide constants
  (0x92492493/x28 vs 0x8D3DCB09/x29 with the extra `addu v1,v1,a0`) confirm it, and the correct
  modulus also dissolved the base build's extra `s2` constant-1 register + its frame slots.
* **Row 11 Initialize__11tScreenMain (seed FAIL 222, 129/223 -> PASS).** Retail FOLDS the whole
  `tScreenMain::PreLoad` shape/background setup into `Initialize` (with 29/28 moduli) and turns the
  shape-wait `do{}while(!shapesLoaded)` into a `while (!shapesLoaded)` whose flag is initialized up
  front (`move s4,zero` before `tScreen::Initialize`, and reused as the 0 source for `i`):
  `shapesLoaded = false; tScreen::Initialize(); {2x fVideoShapes[i].fShapes=0 + InitializeShapes(...,0x10)};
   fCurrentBG[0] = rand()%0x1d; i = 0; fCurrentBG[1] = (fCurrentBG[0]+rand()%0x1c+1)%0x1d;
   {2x sprintf("zyVid%02d") + AsyncLoadShapeFile}; while (!shapesLoaded) {...}`
  plus `char buffer[32]` (frame 88, buffer at sp+24). Callee identification: region 80025D94 /
  800260D4 map to base `Initialize__7tScreen` / `InitializeShapes__7tScreen` via the local
  region-delta anchor (AsyncLoadShapeFile region 80025F28 = base 80026240, delta -0x318) — NOT by
  looking a regional VA up in configs/symbol_addrs.txt.

## feinput (JPN) — row 14, FAIL 4 (2 mismatched pairs), count-exact 122/122

Regional delta: JPN drops the base build's second (`ID=='#'`) negCon-key switch entirely — the
`'#'` arm just returns 0.
Work done: removed the `highReturn` funnel (`return_high_result:` block) that forced an extra
`j` + `li v0,1` pair at the tail (124 -> 122 insns; the tail
`beqz v1,epilogue / move v0,zero / li v0,1 / epilogue` now matches exactly), and rewrote the switch
arms in the m2c-reference shape (per-arm `lowResult=`/`highResult=` + shared `return_bool:` /
`return_not_bool:` funnels, mirroring `regiondiff/m2c/NFS4-R-JPN/...c` block_25/block_28).

RESIDUAL (2 pairs), fully diagnosed:
```
ours   beqz v0,T / li v0,1        (delay slot filled from the TARGET, branch redirected to epilogue)
oracle beqz v0,T / move v0,zero   (delay slot filled from the FALL-THROUGH zero block)
ours   j T / move v0,zero    vs   oracle j T / nop
```
Root cause (gcc-2.8 `reorg.c:fill_eager_delay_slots`): with `prediction <= 0` (EQ condition) gcc
fills from the fall-through thread **only if `own_thread_p(NEXT_INSN(branch))`** — i.e. the
fall-through block carries no externally-referenced label. In the oracle the `'#'` goto binds to the
LOW funnel's zero block (`.L800237E0`), leaving the HIGH funnel's zero block anonymous and fillable;
in our build gcc rebinds that label onto the HIGH funnel's zero block (`$L37`/`$L39` in
`build/recon/frontend/common/feinput__region_gate.cpp.s`), so reorg falls back to the target-copy fill.
Falsified (each measured): inline `return 1` / `return highResult==0` at the high funnel (22 diffs,
120 insns); inline `return 0;` for the `'#'` arm (11 @119); `'#'` retargeted at the DEFAULT arm's
zero (11 @119); `'#'` routed through the low funnel with `lowResult=0` (11 @121); `'#'` test inverted
(4 @122 but a different, larger residual); branch-polarity flip at the high funnel (neutral);
if/else instead of default+override (neutral); `return_zero:` moved onto the high arm (7 @119) or the
default arm (11 @119).

## psxfront (FR-DE) — row 16, NEW seed, REGION-PASS (183)

The base build's `DoLanguageScreen` is a 15-insn stub (`frontEnd.language = 0`); FR-DE retail ships a
full two-language selection screen. Reconstructed from the oracle + the regional image's own rodata
(`NFS4-R-FR-DE.EXE` @0x80012818: shape names `back / yDEU / yFRA / bDEU / bFRA / lite / dark`,
psh name `lang.psh` @0x80012834) and cross-compared with the sibling UK-SW candidate. Language codes
are `{1, 2}` (the `sb 1,80(sp)` / `sb 2,81(sp)` pair). `creatememclass`/`setmemclass`/`VSync`/
`GetPSXPadValue` + the two `RegionalLanguageShapeMemory*` globals are declared locally in the TU;
the 48-byte stack blob and those two globals are marked `[INFERRED]` (no invented semantic names).

Four levers, each measured, took it 192 -> 39 -> 18 -> 16 -> 6 -> 4 -> **0**:
1. `selectedShapeOffset` as a real **if/else** (both arms assign) rather than default+override —
   puts `addu v0,s2,zero` in the `beq` delay slot instead of hoisting it into `$a3` far above (39 -> 6
   in combination with 2/3).
2. the y-coordinate as an explicit local with `y = 0xb9; if (languages[i] == 3) y = 0xb8;` instead of
   a ternary inside the call — this is what stops gcc hoisting `li 3` into a **callee-saved** register
   ($s7 + its save/restore = exactly the 3 surplus instructions and the 176-vs-168 frame) (37 -> 18).
3. address and x-arg computed into locals (`shapePtr`, `drawX`) BEFORE the y select, matching the
   oracle's `addu a0,s4,v0 / addu a1,s0,v1` -before- the languages compare (18 -> 16).
4. statement order in the per-frame prologue: `settrans(1); x = 0xe2 - shapes[5]->width; VSync(0);
   i = 0; shapeOffset = 4;` — this is the only ordering that yields the oracle's shared zero
   (`addu a0,zero,zero; addu s1,a0,zero`, i.e. `i` is a COPY of the call argument) AND keeps the
   `li s2,4` after the `lw` (6/4 -> 0).
   Falsified orderings: VSync first (4), i last (6), `VSync(i)` (6), `VSync(i = 0)` (6),
   for-init after the call (6), shapeOffset before i (4).
Also falsified: `(int)` cast on the languages compare (37), dropping the `shapeBase` alias (37),
do/while inner loop (44), selecting the shape POINTER instead of the offset (100).

## Notes / carry-overs
* `DrawForeground` (USA) and `FEInput_GetNoDebounceKey` (JPN) are left in their best measured state;
  both are count-exact with the regional delta fully identified — what remains is one allocator
  rotation and one reorg delay-slot-thread choice respectively, with the falsified-lever lists above.
* The screencarselect candidate inherits two `__asm__("" : : ...)` zero-insn fences from the base TU
  (`tScreenCarSelect::ProcessInput`, `DrawForeground`); they are pre-existing base-tree constructs in
  the seed, not introduced by this wave. The one in the DrawForeground fade arm WAS removed because
  the regional rewrite replaced that code.
* No `update_region_progress.py` run (per wave rules); the board still shows the pre-wave statuses.

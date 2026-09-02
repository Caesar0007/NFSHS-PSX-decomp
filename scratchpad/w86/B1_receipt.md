# W86-B1 receipt — regional row sealing (USA)

Assignment: `scratchpad/w86/B1_rows.tsv` — 11 rows across 3 units, all NFS4-R-USA.
**Result: 11/11 REGION-PASS. 0 regressions (11 prior seals in the touched
candidates re-gated and held).**

Gate: `python regiondiff/tools/verify_region.py USA <cand> <fns> --lane-as=recon/<unit>.cpp`
Rules honoured: candidates edited IN PLACE (existing ones never overwritten);
every manifest row of every candidate I touched was re-gated after the edits;
no git, no `tools/*.py` / `regiondiff/tools/*.py` / board / MANIFEST / memory edits;
source-level C++ only (no volatile added, no asm, no pins).

---

## The class: the retail string-table `+1` shift

All 11 rows were the same thing — a pure text-id constant delta. Signature on
the unedited seed, uniform across every row: **`diff count == 2 × audit words`
with instruction counts already exact on both sides** (e.g. DrawOverlay 551/551,
FAIL 24 for 12 audit words). No logic deltas in this batch, so none needed the
measure-first / lever treatment.

The retail (later) link inserted one entry into the string table below id 0x7b,
so every text id at or above the insertion point is one higher than the base
build. Confirmed non-shifting in the same functions: ids below the insertion
point (`0x41` in DrawOverlay, present unchanged in the oracle as `li $a0,65`),
shape ids (`0x62` upgrade-icon base), and all geometry/timing constants.

**32B-5 trap — how it was avoided.** The gate prints at most `VA_MAX` (default
12) diff lines, so on the two big rows part of the delta set was invisible in the
first gate (6 of DrawOverlay's 12 words, 3 of PinkSlips-SetDialog's 9). Patching
only the visible sites and re-scanning is exactly the blind loop where a
CSE-shared `li` bites. Instead the **full** delta set was read off the regional
oracle `.s` directly — `grep` its `li`/`addiu` immediates, map each to its source
constant, then apply the whole set in one pass. Every predicted value was present
in the oracle before the edit was made. (`VA_MAX=200` was also used to confirm
LoadGame's residual is genuinely 3 diffs, not a truncated view.)

Second CSE check performed per site: where the same literal appears twice in a TU
(`0x292` in fememcard: `Confirm`'s `yesnowords[1]` **and**
`SavePinkSlipsCarsWithErrorDialogs`'s `SetChoices`), only the site inside the
gated function was touched — `SavePinkSlipsCarsWithErrorDialogs` has **no oracle
slice** (it is byte-identical base↔region), so its ids provably do *not* shift and
editing them would have been wrong.

---

## Unit 1/3 — `frontend/common/screencarselect` — 6 rows

Candidate: `regiondiff/recon/NFS4-R-USA/frontend/common/screencarselect.cpp`
(pre-existing, hosting 10 already-SEALED rows — preserved, re-gated).

| fn | seed | words | edits applied |
|---|---|---|---|
| InitializeVideoWall__16tScreenCarSelect | FAIL 2 | 1 | `SetAvailableText(...,0xf8→0xf9,...)` |
| InitializeVideoWall__20tScreenCarSelectDuel | FAIL 4 | 2 | both `SetAvailableText` 0xf8→0xf9 (two separate `li a1` in the diff = two cse windows) |
| DrawBackground__25tScreenCarSelectTwoPlayer | FAIL 2 | 1 | `carID + 0x121→0x122` |
| SetDialog__25tScreenCarSelectTwoPlayer | FAIL 2 | 1 | `TextSys_Word(0x2a8→0x2a9)` |
| SetDialog__25tScreenPinkSlipsCarSelect | FAIL 18 | 9 | `0x2a8→0x2a9`; `player + {0x2ab,0x2a9,0x2af,0x2b1,0x2ad,0x32d,0x32f,0x280}` each +1 |
| DrawOverlay__16tScreenCarSelectP8tOverlay | FAIL 24 | 12 | `carID+0x121→0x122` ×2; ternary `0x8c/0x8d/0x8e → 0x8d/0x8e/0x8f`; `0x7b→0x7c`; `fCurrentItem+0x96→0x97`; `+0xaf→0xb0` **together with** its `descrItem==0xb0→0xb1` compare (semantics preserved); `0xa0/0x9e/0x9f → 0xa1/0x9f/0xa0`; **`0x41` deliberately left alone** |

Full candidate re-gate — **16/16 REGION-PASS**:
DoMemCardStuff 193, DrawBackground(TwoPlayer) 342, DrawCar 125,
DrawForeground 566, DrawOverlay 551, DrawVideoWall(TwoPlayers) 104,
GetShapeInfo(TwoPlayer) 58, GetShapeInfo(PinkSlips) 30,
InitializeVideoWall(CarSelect) 46, InitializeVideoWall(Duel) 71,
Initialize(TwoPlayer) 32, Initialize(PinkSlips) 28,
ProcessInput(CarSelect) 111, ProcessInput(PinkSlips) 58,
SetDialog(TwoPlayer) 48, SetDialog(PinkSlips) 164.
→ 6 new seals, 10 prior seals held.

## Unit 2/3 — `frontend/common/fememcard` — 4 rows

Candidate: `regiondiff/recon/NFS4-R-USA/frontend/common/fememcard.cpp` (pre-existing).

| fn | seed | words | edits applied |
|---|---|---|---|
| FormatConfirm__Fv | FAIL 4 | 2 | `Confirm(CURRENTPLAYER[0] + 0x327→0x328, 0x290→0x291)` |
| OverwriteConfirm__Fv | FAIL 4 | 2 | `Confirm(CURRENTPLAYER[0] + 0x323→0x324, 0x28f→0x290)` |
| Confirm__Fii | FAIL 4 | 2 | `yesnowords[1] = 0x292→0x293`; `TextSys_Word(CURRENTPLAYER[0] + 0x32b→0x32c)` |
| Init_MemcardFile__FR12MCRDFILE_defsb | FAIL 4 | 2 | `TextSys_Word(0x278→0x279)` and `TextSys_Word(0x279→0x27a)` (applied deepest-first so the two sites can't collide) |

Full candidate re-gate — **7/9 REGION-PASS**:
Confirm 109 PASS, DeInit_Memcard 42 PASS, FormatConfirm 11 PASS,
Init_MemcardFile 58 PASS, Init_Memcard 89 PASS, OverwriteConfirm 11 PASS,
SaveGame 298 PASS.
→ 4 new seals, 3 prior seals held.

**Two rows in this candidate are NOT mine and were left exactly as found**
(both were already failing at the same counts on the board before my edits;
verified unchanged after): `LoadGame__FsbT1` FAIL 3 (387/388) and
`SavePinkSlipsCars__Fss` FAIL 47 (237/236). Neither appears in any `B*_rows.tsv`
this wave. Handover notes from measuring them:
- **LoadGame** is not a constant delta — the residual is a **cross-jump / block-layout**
  difference in the two near-duplicate memcard-error blocks at oracle
  `.L800352F4` / `.L80035330`. The oracle keeps **two** copies of the shared tail
  `j .L80035184; li $s1,1` (0x800352EC and 0x80035380) plus two `li $s2,810`
  (0x8003532C, 0x8003537C); ours merged one away, hence 387 vs 388 and the
  `li s2,810` position swap. Per §3.12 this is an arm-duplication /
  store-in-both-arms shape question (catalog 33B-4), not a constant patch.
- **SavePinkSlipsCars** is a `$s6`↔`$s7` uniform allocation swap plus a
  `sll v0,s6,16` vs `lui v0,32785` divergence — a register-budget row
  (33B-1/33B-3 territory), also 1 insn long, also not a constant shift.

## Unit 3/3 — `frontend/common/screentrophyroom` — 1 row (was TODO)

No candidate existed. Seeded per README step 2 (CHANGED → verbatim copy of the
base TU `recon/frontend/common/screentrophyroom.cpp`), measured the unedited
seed (FAIL 8, 261/261 — 4 words), then edited.

| fn | seed | words | edits applied |
|---|---|---|---|
| DrawBackground__17tScreenTrophyRoom | FAIL 8 | 4 | `fTournamentID + 0x354→0x355`; `texttoshow` chain `0x3de/0x3df/0x3e0 → 0x3df/0x3e0/0x3e1` |

Gate: **DrawBackground__17tScreenTrophyRoom: REGION-PASS (261 insns)** — the only
manifest row for this (unit, region) pair.

---

## Files changed (all under `regiondiff/recon/NFS4-R-USA/frontend/common/`)

- `screencarselect.cpp` — edited in place (8 constant sites + comments)
- `fememcard.cpp` — edited in place (6 constant sites + comments)
- `screentrophyroom.cpp` — **new** candidate, seeded from the base TU + 4 constant sites

Base tree (`recon/`, `src/`, `asm/`, `configs/`) untouched. Board not regenerated
(`update_region_progress.py` is a board write — prohibited for this wave's agents);
the per-row gate output above is the seal evidence.

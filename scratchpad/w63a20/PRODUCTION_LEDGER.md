# W63-A20 — PRODUCTION-LANE LEDGER (psq43 cc1 + ASPSX 2.77) over the SEALED EA board

Supersedes `scratchpad/w62a20/PRODUCTION_LEDGER.md` (which stays as the W62
snapshot). Scope unchanged: every `MATCH_PROGRESS.txt` row at 100.00% under
`game/**`, `frontend/**`, `eaclib/**` — syslib excluded (Sony vendor-prebuilt,
gate-parity only). **2972 rows / 304 TUs** (2965 at W62 close + 7 new seals).

Pipeline = `tools/psyqproof.py`, imported verbatim by the batch harness
(`pqbatch2.py`) — the compile / dialect-shim / redundant-extern-strip / ASPSX /
`parse_obj` / word-compare steps are the shipped prover's own code, batched one
compile per TU (12H anti-drift: nothing re-implemented).

Certified controls, re-run after every change to the prover:
`iSND100hzserver` REAL=0 / RELOP=0 / 12 reloc · `Night_KillNightDriving__Fv`
REAL=0 / RELOP=0 / 18 reloc.

---

## 1. COUNTS

| # | class | meaning |
|---:|---|---|
| 442 | `REAL0_CLEAN` | REAL=0, zero diffs of any kind — production-identical, no link needed |
| 2474 | `REAL0_RELOC_ONLY` | REAL=0, reloc-site diffs only — production-sealed modulo link |
| 46 | `SHIM_MASKED` | REAL+RELOP > 0 **and** a `build.py` per-fn shim covers the fn |
| 0 | `LANE_DIVERGENT` | ← **was 5 at W62** (closed by the redundant-`.extern` shim) |
| 10 | `INAPPLICABLE_LANE` | `eacpsxz/nsync.c` is wired `cc1_ver: 2.8.1`; the prover always uses psq43 |
| 0 | `HARNESS_GAP` | ← **was 7 at W62** (closed by this wave's dialect shim) |
| **2972** | **total** | **REAL=0 = 2916 = 98.12 % of the board, 98.45 % of the 2962 provable rows** |

W62 → W63: **97.8 % → 98.1 %**, and — the structural result — the
gate↔production distance is now **exactly the per-fn shim set and nothing
else**. There is no longer any row that fails for a toolchain-portability or
harness reason.

Per scope:

| scope | REAL=0 | rows | rate |
|---|---:|---:|---:|
| eaclib/psx | 480 | 501 | 95.8 % |
| frontend/common | 797 | 813 | 98.0 % |
| frontend/psx | 81 | 81 | 100.0 % |
| game/common | 1208 | 1219 | 99.1 % |
| game/psx | 350 | 358 | 97.8 % |

### 12H anti-vacuity

`RELOP` (a reloc-masked word differing beyond its relocated field) is reported
separately and counted into the residual, so no REAL=0 in this table is
vacuous. The W62 table folded RELOP into `REAL`; the totals match row for row
(e.g. `InGame_ResetPSXController` W62 276 = W63 228 REAL + 48 RELOP;
`AudioCmn_SoundCar` 241 = 218 + 23; `DrawW_DrawQuad` 310 = 303 + 7).

---

## 2. WHAT CHANGED IN THE PROVER (`tools/psyqproof.py`, commit `b1aa1e8b`)

### 2.1 The GNU→ASPSX dialect shim, generalized and DEFAULT-ON

`to_aspsx_dialect()` was a two-regex cut in W62 (register names + a blanket
`.set pop` → `.set reorder; .set at`) behind a `--dialect` flag. It is now a
general line transform, always applied, derived from a **construct probe run
against the real ASPSX 2.77** (`aspsxprobe.py`, `aspsxprobe2.py` — 42
constructs, accept/reject + first error text):

| # | GNU spelling ASPSX rejects | rewrite | scope |
|---|---|---|---|
| 1 | ABI register NAMES `$a0` | numeric `$4` | whole file, **except** `.ascii/.asciz/.string` data |
| 2 | `.set push` / `.set pop` | tracked save/restore of the `at` / `reorder` / `macro` axes; only changed axes re-emitted | whole file |
| 3 | `sym2 = sym` | `sym2:` inserted immediately after `sym:` (a second LABEL at the same address) | detected in `#APP` |
| 4 | 3-operand `div`/`divu` with a `$0` dest | the 2-operand raw form | **`#APP` only** |
| 5 | `.type X,@function` / `.size X,N` / `.weak X` | dropped (ELF-only, zero bytes) | whole file |

Probe results behind those rows (all measured, not inferred):

* **ASPSX has NO working symbol-assignment form.** `sym2 = sym` → *Op-code not
  recognised*; `.set a,b` → *Unrecognised .set option*; `a equ b` → *Op-code not
  recognised*; `.equ a,b` → *Expression must evaluate*. But **two labels at the
  same address are accepted**, which is exactly what a GNU-as symbol assignment
  to a label means. `aliascheck.py` proves all **25** co-equal XDEFs land at the
  canonical symbol's `(section, offset)`: `nullfunc` 20/20, `fixddiv` 1/1,
  `fixdinv` 1/1, `sinfunc` 1/1, `isqrttbl` 2/2.
* 🔴 **Rule 4 is load-bearing and MUST stay `#APP`-scoped.** In GNU-as a `$0`
  destination means *raw machine op, no guard*; ASPSX instead expands
  `divu $0,$4,$5` into the raw op **plus a 4-word divide-by-zero guard**
  (measured bytes: `0085001b` alone vs
  `0085001b a0140200 00000000 0d000700`), and under `.set noat` it fails
  outright — *"Assembler does not have AT register available"*, which is how the
  class surfaced. Compiler-emitted `div $0,rs,rt` (outside `#APP`) **must keep
  the 3-operand form**: that assembler-side guard expansion IS what retail
  carries — it is the same expansion `maspsx --expand-div` reproduces on the
  gate lane. A whole-file rewrite here would have silently deleted the ÷0 guard
  from every compiler divide in the production build.
* The two hand-asm TUs affected (`fixddiv.c`, `fixdinv.c`) are the only sites in
  `recon/**` that spell a raw divide as `divu $zero,rs,rt` — so the rule is
  general but currently exercised twice.

`main()` is now `__main__`-guarded, so a batch harness can `import` the shim
instead of copying it. `--dialect` is accepted as a no-op; `--no-dialect`
disables the shim for A/B probes.

### 2.2 The 7 W62 harness gaps → 0

| rows | TU | W62 ASPSX error | closed by |
|---:|---|---|---|
| 2 | `eacpsxz/isqrttbl.c` | `Op-code not recognised` (`decodeshiftjis2 = decodeshiftjis`) | rule 3 |
| 1 | `eacpsxz/nullfunc.c` | same, ×20 aliases | rule 3 |
| 2 | `eacpsxz/sinfunc.c` | same (`fastintcos = intcos`) | rule 3 |
| 1 | `eacpsxz/fixddiv.c` | `Assembler does not have AT register available` | rules 3 + 4 |
| 1 | `eacpsxz/fixdinv.c` | same | rules 3 + 4 |

All 7 now prove **REAL=0 RELOP=0**: `rdiv` 42 words, `fixedinverse` 14,
`setclipwindow` 2, `intcos` 1, `intsin` 26 (2 reloc), `decodeshiftjis` 26
(2 reloc), `remapshiftjiscode`.

### 2.3 Per-TU result for the whole GNU-dialect set (the acceptance table)

The 29 TUs the W62 `--dialect` retry covered, re-run through the shipped prover
with the shim on by default — **260 rows, 255 REAL=0 (98.1 %)**:

| TU | rows | REAL=0 | REAL | RELOP | non-zero fns |
|---|---:|---:|---:|---:|---|
| `eacpsxz/blkfill.c` | 2 | 2 | 0 | 0 | |
| `eacpsxz/blkmov.c` | 1 | 1 | 0 | 0 | |
| `eacpsxz/crc.c` | 1 | 1 | 0 | 0 | |
| `eacpsxz/fastmovf.c` | 1 | 1 | 0 | 0 | |
| `eacpsxz/fileroot.c` | 9 | 9 | 0 | 0 | |
| `eacpsxz/fixddiv.c` | 1 | 1 | 0 | 0 | **(was TU_BUILD_FAIL)** |
| `eacpsxz/fixdinv.c` | 1 | 1 | 0 | 0 | **(was TU_BUILD_FAIL)** |
| `eacpsxz/fixdmult.c` | 1 | 1 | 0 | 0 | |
| `eacpsxz/fixdsqrt.c` | 1 | 1 | 0 | 0 | |
| `eacpsxz/getm.c` | 2 | 2 | 0 | 0 | |
| `eacpsxz/isqrttbl.c` | 2 | 2 | 0 | 0 | **(was TU_BUILD_FAIL)** |
| `eacpsxz/math64a.c` | 2 | 2 | 0 | 0 | |
| `eacpsxz/movf.c` | 1 | 1 | 0 | 0 | |
| `eacpsxz/nasync.c` | 23 | 23 | 0 | 0 | |
| `eacpsxz/nfile.c` | 26 | 24 | 7 | 4 | `FILE_completeop` 6+2 (PROLOGUE_UNSINK); `iFILE_ExecCommand` 1+2 (TEXT_MOVES) |
| `eacpsxz/nullfunc.c` | 1 | 1 | 0 | 0 | **(was TU_BUILD_FAIL)** |
| `eacpsxz/random.c` | 2 | 2 | 0 | 0 | |
| `eacpsxz/savegp.c` | 3 | 3 | 0 | 0 | |
| `eacpsxz/shpdepth.c` | 1 | 1 | 0 | 0 | |
| `eacpsxz/shpsubs.c` | 3 | 3 | 0 | 0 | |
| `eacpsxz/sinfunc.c` | 2 | 2 | 0 | 0 | **(was TU_BUILD_FAIL)** |
| `eacpsxz/stream.c` | 30 | 30 | 0 | 0 | |
| `sndpsxz/sdma.c` | 6 | 6 | 0 | 0 | |
| `sndpsxz/sdpacket.c` | 12 | 12 | 0 | 0 | |
| `sndpsxz/slib.c` | 5 | 5 | 0 | 0 | |
| `frontend/common/screencarselect.cpp` | 56 | 56 | 0 | 0 | |
| `frontend/common/screencontroller.cpp` | 22 | 22 | 0 | 0 | |
| `game/psx/drawc.cpp` | 17 | 16 | 3 | 3 | `DrawC_NightHeadlight` 3+3 (TEXT_MOVES) |
| `game/psx/draww.cpp` | 26 | 24 | 463 | 31 | `DrawW_DrawQuad` 303+7, `DrawObjectSimple` 160+24 (both TEXT_MOVES) |

**No new ledger entries.** Every non-zero row in the dialect set was already a
shim-masked row before the shim existed; the shim added zero residual.

### 2.4 Source-fidelity note (unchanged, still open)

The shim makes those 25 TUs *provable*; it does not make them *production-
buildable as written*. Their `__asm__` blocks are still GNU-as dialect. A source
pass (numeric registers, `.set noreorder`/`.set reorder` in place of
`.set push/pop`, a real second label instead of `sym2 = sym`, the 2-operand raw
divide, drop `.type`/`.size`) would make them assemble under the original
toolchain unmodified. That is a lane-portability defect the gate cannot see, and
is the honest reading of "the shim recovers 260 rows".

---

## 3. THE HONEST DISTANCE: SHIM-MASKED ROWS (all 46, REAL+RELOP desc)

Every row is 100.00 % under the gate **because `build.py` rewrites the
compiler's `.s` for that function**. The production lane sees the unshimmed
compiler output, so this is the true residual of the SOURCE.

| REAL | RELOP | tot | words | shim | unit | function |
|---:|---:|---:|---:|---|---|---|
| 303 | 7 | 310 | 592 | `TEXT_MOVES` | game/psx/draww | `DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad` |
| 228 | 48 | 276 | 305 | `TEXT_MOVES` | game/psx/psxcontroller | `InGame_ResetPSXController__Fii` |
| 218 | 23 | 241 | 530 | `TEXT_MOVES` | game/common/audiocmn | `AudioCmn_SoundCar__FP8Car_tObjiiiiiii` |
| 160 | 24 | 184 | 189 | `TEXT_MOVES` | game/psx/draww | `DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi` |
| 147 | 21 | 168 | 402 | `TEXT_MOVES` | game/common/camera | `Camera_UpdateTailCam__Fii` |
| 36 | 9 | 45 | 82 | `FORCE_ADDR` | eaclib/spchpsxz/spchevnt | `SPCH_AddEvent` |
| 17 | 7 | 24 | 69 | `TEXT_MOVES` | frontend/common/femenudefs | `MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand` |
| 13 | 2 | 15 | 409 | `TEXT_MOVES` | game/psx/flare | `Flare_LensFlare__FP7DVECTORP15Draw_FlareCache` |
| 14 | 0 | 14 | 29 | `TEXT_MOVES` | frontend/common/screencongrats | `CalculatePrizes__15tScreenCongrats` |
| 11 | 0 | 11 | 158 | `TEXT_MOVES` | eaclib/eacpsxz/unref | `unrefpack` |
| 4 | 7 | 11 | 52 | `TEXT_MOVES` | frontend/common/fescreen | `GoNonInterlaced__7tScreen` |
| 11 | 0 | 11 | 159 | `TEXT_MOVES` | game/common/audioeng | `AudioEng_Set__Fiiiiiiii` |
| 9 | 0 | 9 | 299 | `TEXT_MOVES` | frontend/common/screentracks | `DrawBackground__18tScreenTrackSelect` ← **new (W62-A15 seal)** |
| 9 | 0 | 9 | 358 | `TEXT_MOVES` | game/common/speech | `Status__Q26Speech13MobileSpeaker` |
| 6 | 2 | 8 | 47 | `PROLOGUE_UNSINK` | eaclib/eacpsxz/nfile | `FILE_completeop` |
| 8 | 0 | 8 | 81 | `TEXT_MOVES` | eaclib/eacpsxz/trnsmult | `transmult` |
| 8 | 0 | 8 | 165 | `TEXT_MOVES` | eaclib/eacpsxz/vramfxya | `vramfxya` |
| 6 | 2 | 8 | 42 | `TEXT_MOVES` | frontend/common/femenuoptions | `__20tMenuItemSlidingMenuUissssb` |
| 0 | 8 | 8 | 94 | `G8` | game/common/audiocmn | `AudioCmn_Init__Fv` (REAL=0/RELOP=0 when compiled at -G8 — a real per-region flag identity) |
| 6 | 2 | 8 | 270 | `TEXT_MOVES` | game/common/speech | `LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell` |
| 4 | 3 | 7 | 88 | `TEXT_MOVES` | frontend/common/fefades | `CalcOnOffFade__F13tMenuTextTypesssRiT4` |
| 3 | 4 | 7 | 26 | `TEXT_MOVES` | frontend/common/femenudefs | `MenuExtended_GoToDealer__FR12tMenuCommand` |
| 3 | 4 | 7 | 26 | `TEXT_MOVES` | frontend/common/femenudefs | `MenuExtended_GoToSeller__FR12tMenuCommand` |
| 3 | 4 | 7 | 211 | `FORCE_ADDR` | game/psx/weather | `Weather_Init__Fv` |
| 3 | 3 | 6 | 107 | `TEXT_MOVES` | game/psx/drawc | `DrawC_NightHeadlight__FP8Car_tObj` |
| 5 | 0 | 5 | 358 | `TEXT_MOVES` | game/common/physics | `Physics_DoBarrierCheck__FP8Car_tObj` |
| 5 | 0 | 5 | 130 | `RA_SINK` | game/psx/textureprocess | `CV_ColorTracks__Fiii` |
| 4 | 0 | 4 | 83 | `TEXT_MOVES` | eaclib/spchpsxz/spchpick | `iSPCH_ConstantRuleSet` |
| 1 | 3 | 4 | 90 | `TEXT_MOVES` | frontend/common/femenudefs | `MenuExtended_GoToTournTrackInfo__FR12tMenuCommand` |
| 4 | 0 | 4 | 138 | `TEXT_MOVES` | frontend/common/femenudefs | `MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand` |
| 4 | 0 | 4 | 293 | `TEXT_MOVES` | frontend/common/femenuextended | `MenuNFS4_DrawTextBox__FiR4RECTissbT5` |
| 4 | 0 | 4 | 32 | `TEXT_MOVES` | frontend/common/screenusername | `DrawVerticalLine__15tScreenUserNamesss` |
| 4 | 0 | 4 | 33 | `TEXT_MOVES` | frontend/common/screenusername | `DrawHorizontalLine__15tScreenUserNamesss` |
| 4 | 0 | 4 | 94 | `TEXT_MOVES` | game/common/speech | `Roger__Q26Speech13MobileSpeaker` |
| 4 | 0 | 4 | 247 | `TEXT_MOVES` | game/psx/flare | `Flare_2DHalo__Fiiiii` ← **new** |
| 1 | 2 | 3 | 290 | `TEXT_MOVES` | eaclib/eacpsxz/nfile | `iFILE_ExecCommand` |
| 3 | 0 | 3 | 28 | `EPILOGUE_UNFILL` | eaclib/pad | `padinit` |
| 3 | 0 | 3 | 21 | `NO_DELAYED_BRANCH` | eaclib/pad | `PAD_restore` |
| 1 | 2 | 3 | 39 | `TEXT_MOVES` | eaclib/spchpsxz/spchinit | `SPCH_Init` |
| 2 | 1 | 3 | 42 | `TEXT_MOVES` | frontend/common/femenu | `ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand` |
| 3 | 0 | 3 | 86 | `TEXT_MOVES` | frontend/common/femenudefs | `MenuExtended_SellCar__FR12tMenuCommand` |
| 1 | 2 | 3 | 72 | `TEXT_MOVES` | game/common/aistate | `___17AIState_Purgatory` ← **new** |
| 3 | 0 | 3 | 461 | `NO_THREAD_JUMPS` | game/common/audioclc | `AudioClc_SoundPlayersCar__Fi` |
| 3 | 0 | 3 | 65 | `TEXT_MOVES` | game/common/speech | `CheckLocationBank__6SpeechPQ26Speech12LocationBankPci` |
| 2 | 0 | 2 | 20 | `EPILOGUE_UNFILL` | eaclib/pad | `PAD_state` |
| 2 | 0 | 2 | 80 | `TEXT_MOVES` | frontend/common/femenudefs | `MenuExtended_PurchaseUpgrade__Fi` |

Reading (unchanged from W62 and now the ONLY story):

* `PER_FN_TEXT_MOVES` dominates — **36 of 46**. It is a post-cc1 line relocation
  invented for the maspsx+GNU-as lane; ASPSX sees the un-relocated residual.
* The five heavies (310 / 276 / 241 / 184 / 168) are whole-schedule divergences,
  not one-line moves — their gate PASS rests **entirely** on the shim.
* **21 of 46 rows sit at REAL+RELOP ≤ 4** — small, real, source-shaped residuals
  and the cheapest dual-lane seals available.
* 3 rows are NEW since W62 (all newly sealed fns that landed on a shim):
  `DrawBackground__18tScreenTrackSelect` 9, `Flare_2DHalo` 4,
  `___17AIState_Purgatory` 3.
* `Camera_UpdatePulloverCam__Fi` — the W62 production-bug case — is now
  **REAL0_RELOC_ONLY**: the fix held on the production lane.

---

## 4. W62 → W63 REGRESSION DIFF

Over the **2955 rows present in both sweeps**:

```
REAL+RELOP worse : 0
REAL+RELOP better: 5      (all game/psx, the redundant-.extern shim landed at W62 close)
status changed   : 7      (all TU_BUILD_FAIL -> OK, this wave's dialect shim)
```

| Δ | fn | W62 → W63 |
|---:|---|---|
| −174 | `overlays::RaceSummary__Fv` | 174 → 0 |
| −51 | `overlays::Hud_RenderStatsView__Fv` | 51 → 0 |
| −15 | `night::Night_KillNightDriving__Fv` | 15 → 0 |
| −6 | `night::Night_SetCopColor__FP18GameSetup_tCarData` | 6 → 0 |
| −4 | `night::Night_InitWeatherTables__Fv` | 4 → 0 |

The 17 "new" rows are the 10 `nsync.c` rows (W62's jobgen dropped lane-wired
TUs silently; this sweep emits an explicit `INAPPLICABLE_LANE` row for each so
all 2972 board rows are accounted for) plus the 7 genuinely new seals:
`DrawBackground__18tScreenTrackSelect` (shim), `AIHigh_StartUp__Fv`,
`__13AIState_Chase…`, `___17AIState_Purgatory` (shim),
`Camera_UpdatePulloverCam__Fi`, `Object_AddCustomObject__FP9SceneElemi`,
`Flare_2DHalo__Fiiiii` (shim).

---

## 5. HAZARD HIT DURING THE SWEEP (for the catalog)

`recon/game/psx/draww.cpp` reported `cc1 failed: parse error at end of input`
in the batch run. Not a source defect: `build/recon/game/psx/draww.cpp.i` was
**rewritten by a concurrent belt inside the run window** (mtime landed mid-sweep)
and cc1 read a half-written file. Re-run alone: **26/26 OK**. Merged with
`merge.py` (last write per `(tu, fn)` wins). Standing rule for any harness that
reads `build/**` while other belts are live: a single TU failure is a
concurrency artifact until re-run in isolation.

---

## 6. THE BRANCH-DISTANCE SCREEN (tree-wide, cross-validated against this ledger)

`tools/brdist.py` over **458 TUs / 3500 fns**, cross-checked row-for-row against
the psyqproof results above. Two further false-positive sources found and
patched (spec: `brdist_guard.patch`); full write-up in `RECEIPTS.md` §3.2:

| brdist version | divergent | on 100.00 % board rows |
|---|---:|---:|
| as shipped (w63-a15 fix included) | 129 | 25 — 21 of them `psyqproof` REAL=0, i.e. impossible |
| + "a spimdisasm `.word` IS an instruction" | 104 | 1 |
| + case-exact oracle lookup (`cd_read` ≠ `CD_Read`) | 103 | **0** |

**No production bug hides behind a green gate anywhere in the tree.** The
remaining 103 hits are all on known non-100 % near-misses. The two screens agree
exactly on gate-PASSing rows in both directions once brdist is fixed — which is
also an independent confirmation of this ledger: a fn that psyqproof scores
REAL=0 provably cannot have a wrong branch distance, and after the patch none
is reported to.

## 7. FILES

| file | what |
|---|---|
| `PRODUCTION_LEDGER.md` | this document |
| `PRODUCTION_LEDGER.csv` | 2972-row per-fn table (class, REAL, RELOP, reloc, words, -G, flags, shim, unit, tu, fn, oracle dir, symsrc, tail pad) |
| `per_tu_table.md` | the 304-TU roll-up |
| `final.jsonl` / `final_classified.json` | raw sweep data |
| `analyze.py` / `analyze.out` | classification + the W62 regression diff |
| `pqbatch2.py`, `jobgen.py`, `merge.py`, `mkledger.py` | the harness |
| `aspsxprobe.py`, `aspsxprobe2.py` | the real-ASPSX construct tables the shim rules come from |
| `aliascheck.py` | proof that all 25 co-equal XDEFs land at the canonical offset |
| `dialect_tus.out` | the §2.3 per-TU acceptance table |
| `psyqproof.py.orig.bak`, `psyqproof.py.bak.*` | pre-edit backups |

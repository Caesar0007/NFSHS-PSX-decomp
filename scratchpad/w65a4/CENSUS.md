# W65-A4 — THE WAVE'S ACCEPTANCE SHEET

Repo `C:\Temp\nfs4-decomp` · census HEAD `d33895ec`, final board read at HEAD `f81d7efe`
(2026-08-15 18:35–18:47 WAST). **~20 belts were building concurrently for the whole run** —
every number is a timestamped snapshot and §7 lists what demonstrably moved under me.

---

## 0. HEADLINE

| number | W64 close | W65-A4 census | Δ |
|---|---|---|---|
| board rows at 100 (`MATCH_PROGRESS` counting) | 3358 / 3489 = **96.2 %** | **3368 / 3489 = 96.5 %** | **+10** |
| board rows at 100 (raw, incl. the 7 SUPERSEDED) | 3358 / 3496 | **3368 / 3496 = 96.34 %** | +10 |
| `matched_code_percent` (the honest *bytes* number) | 82.58 | **83.4996** | **+0.92 pp** |
| `fuzzy_match_percent` (byte-weighted) | 99.39 | **99.3859** | ≈ 0 |
| class **c** board-only ARTIFACTS | 5 | **0** | **−5, class CLOSED** |
| class **d** BRANCH-WORD divergences | 28 | **20** (+1 board-blind, §4) | **−8** |
| class **x** gate-FAIL-but-board-100 | 1 | **0** | −1 |
| PROVEN wrong-call-target sites | 147 → 143 | **8** | **−135** |
| full build | — | **exit 0, 0 TUs failed** | — |
| `tu_order_audit` | 0 | **0 inversions / 508 objects** | — |

`MATCH_PROGRESS.txt` was **not** regenerated or committed (per the mission). The numbers above
come from `scratchpad/w65a4/mpcount.py`, which replicates `tools/update_match_progress.py`'s
counting rule exactly and **refuses to run unless it first reproduces W64-A21's published
3358/3489 from that census's own `board_final.json`.** It does.

---

## 1. METHOD — and the ordering law that makes it honest

Three instruments, cross-classified, each with an anti-vacuity leg:

| # | instrument | what it sees | what it is blind to |
|---|---|---|---|
| 1 | `objdiff-cli report generate` (×2) | `fuzzy_match_percent` per row | relocation identity; **and, newly, one reordered-stream branch word — §4** |
| 2 | `verify_asm`'s own module, driven per-TU | instruction stream after normalisation | branch **targets**, call-target identity |
| 3 | `tools/brdist.py` | per-branch **distance** | nothing here, but it has 2 recorded vacuity defects (w63) |

> ### 🔴 THE ORDERING LAW (W64-A21 §7, re-proven empirically here)
> **`report generate` does NOT build** — it reads `build/recon/**.o` as they lie on disk. During a
> 20-belt wave those objects are a mix of committed-source builds and leftover **probe-patched**
> variants, so *a board read taken without a rebuild is neither honest nor reproducible.*
>
> Measured proof: the `--limit=3` smoke test found **four units whose every board row read 100.00**
> but which grew a brdist divergence the instant their TU was recompiled from committed source
> (`screenusername` DrawBackground, `aih_opp` CheckForWipeOut, `camera` UpdateHeliCam + UpdateSplineCam).
> Conversely the full rebuild *revealed* work peers had committed but not rebuilt: the board went
> 3364 → 3367 and `matched_code` 83.09 → 83.47 across the rebuild alone.
>
> **So the census rebuilds first (`tools/build.py --skip-asm`, which is objdiff.json's own
> `custom_make`) and reads the board after.** Both directions of error are real.

Reproducibility: board run1 == run2 **exactly** (all 3496 rows), twice — before and after the
gate/brdist phases. A post-gate re-read (step 3c) caught 2 rows moving under concurrent belts and
the classification was rebased onto the final read (`finalize.py`).

**Anti-vacuity / known-positive validation, done before trusting any instrument** (catalog w43):

* gate driver reproduces `tugate` exactly — `Physics_Real` FAIL:4, `R3DCar_InsertCarFacetMenu`
  FAIL:12, and PASS on `Physics_CalculateCarAcceleration` / `R3DCar_CalcCarDimensions` / `func_8010CA40`.
* `brdist` reproduces W64-A21's recorded triple on physics: **(25, 71, 72)**.
* **brdist CONTROL LEG: a deterministic 40-unit sample of units where *every* row is 100 →
  0 divergences.** So the sub-100 brdist results are not vacuous, and W63's "0 divergent on
  100 %-rows tree-wide" still holds at this wave's end state.
* `mpcount.py` reproduces 3358/3489 (above).
* `calltarget_audit` independently corroborated w65a3's live 143→117 landing mid-run.

---

## 2. CLASS CENSUS

| class | meaning | W64-A21 | **W65-A4** |
|---|---|---|---|
| **a** GATE_FAIL | gate FAIL + board < 100 — ordinary near-misses | 101 | **101** |
| **d** BRANCH_REAL | gate PASS + board < 100 + brdist divergence | 28 | **20** |
| **c** ARTIFACT | gate PASS + board < 100, no brdist divergence | 5 | **0** |
| **x** GATE-ONLY | gate FAIL + board 100 (board blind) | 1 | **0** |
| **?** UNRESOLVED | no gate verdict | 0 | **7** |

The 7 "unresolved" are **exactly** `update_match_progress.py`'s `SUPERSEDED` list — rows whose
retail home unit is tracked elsewhere, so `NOT IN OBJECT` is *correct ownership*, not a defect.
They are excluded from the 3489 denominator by design. **They are not a regression.**

**Class a costs 7738 diff lines** across 101 fns. Heaviest: `__15tGlobalMenuDefs` 3473 (86.03 %),
`DrawC_PrimClip` 420, `Hrz_BuildSky` 370, `Draw_kCtrlSkidmark` 303, `Hud_BuildNumbers` 200,
`InGame_GetPSXPadValue` 168, `DrawSlider` 168, `DrawC_Prim` 166, `Hrz_BuildHorizon` 118,
`Sfx_BuildSouffleFacet` 116.

---

## 3. CLASS c — THE ARTIFACT CLASS IS CLOSED (5 → 0)

W64-A21's raw `classified.json` labels these `b_LANE_GAP` while its prose calls them class c and
reports class b = 0; they are the same five rows.

| row | closed by |
|---|---|
| `2mbyte` `stup0` 42.86 → 100 | W64-A21 (st_size / `.type`+`.size`) |
| `libcard/PATCH` `func_8010CA40` 97.78 → 100 | **w65a4** |
| `aispeeds` `AISpeeds_CalcOpponentTopSpeed` 99.956 → 100 | **w65a4** |
| `r3dcar` `R3DCar_CalcCarDimensions` 99.955 → 100 | **w65a4** |
| `libmath/DIVSF3` `__divsf3` 99.877 → 100 | **w65a4** |

Mechanism and receipts: commit `f983db77`. spimdisasm had invented *data symbols* for plain
constants, so the assembled `expected/` object carried `R_MIPS_HI16/LO16` relocations our (correct)
recon object has none of — not a reloc *name* difference, so `functionRelocDiffs` could never reach
it. Fixed on the **oracle** side: 14 operands relabelled to the bare constants the retail words
already encode, each verified by decoding the retail word out of that line's own comment.
`Physics_CalculateCarAcceleration` also carried two of these charges and improved
99.9789 → 99.9930; it stays class d for its own branch word.

---

## 4. BRANCH WORDS REMAINING — 28 → 20, **0 new**

### 4.1 Closed since W64-A21 (8)

`fememcard SavePinkSlipsCars` · `femenuoptions ProcessInput__17tUserNameMenuItem…` ·
`femenuoptions UpdateTransition__12tOptionsMenu` · `screenmemcard DrawMemCardStuff` ·
`statchk StatChk_IsTopTime` · `aistate CheckIfCarIsNearbyAndStop` ·
`camera Camera_UpdateHeliCam` (⚠ see §4.3) · `MCXMAIN _padIntRecvHdr`

### 4.2 Still open (20) — the next wave's class-d worklist

| unit | function | board |
|---|---|---|
| eaclib/psx/eacpsxz/cdfs | `CdReadyHandler` | 99.9833 |
| frontend/common/fememcard | `LoadGame__FsbT1` | 99.9599 |
| frontend/common/femenuextended | `Draw__29tMenuItemOptionsTwoItemChoiceiib` | 99.9689 |
| frontend/common/fescreen | `InitializeShapes__7tScreen…` | 99.8809 |
| frontend/common/screencarselect | `DrawBackground__25tScreenCarSelectTwoPlayer` | 99.9269 |
| frontend/common/screencarselect | `DrawOpponentVideoWall__20tScreenCarSelectDuels` | 99.9315 |
| frontend/common/screencarselect | `DrawVideoWall__20tScreenCarSelectDuels` | 99.9419 |
| frontend/common/screencongrats | `CalculatePrizes__23tScreenTournamentTrophy` | 99.9653 |
| frontend/common/screenmain | `DrawBackground__11tScreenMain` | 99.9939 |
| frontend/psx/memcard | `MCRD_handlecardevents` | 99.9763 |
| game/common/aiphysic | `AIPhysic_CalcAcceleration` | 99.9728 |
| game/common/audiotrk | `AudioTrk_AddCustomObject` | 99.9879 |
| game/common/physics | `Physics_CalculateCarAcceleration` | 99.9930 |
| game/psx/hud | `Hud_BuildString` | 99.9767 |
| game/psx/weather | `Weather_ChangeDensityBasedOnTime` | 99.9074 |
| syslib/psx/libcd/streamhelp | `StGetNext` | 99.8913 |
| syslib/psx/libgpu/FONT | `FntPrint` | 99.9792 |
| syslib/psx/libmcrd/LIBMCRD | `MemCardWriteData_cb` | 99.9367 |
| syslib/psx/libpad/MCXMAIN | `_padIntRecvData` | 99.9776 |
| syslib/psx/libpad/PADSEQD | `_dirSendAuto` | 99.9219 |

### 4.3 🔴 NEW — THE FIFTH BLIND SPOT: the board metric can miss a branch word

W64-A21 §2 concluded *"the board is NOT lenient about branch words"*. **That is now falsified by a
counter-example**, and the exception has a named mechanism.

`Camera_UpdateHeliCam__Fii` — gate **PASS** (443 insns), board **100.00**, and yet:

```
ours     PC-rel branch #20   04610003   bgez v1, +4 insns
expected PC-rel branch #20   04610002   bgez v1, +3 insns
```

Three independent instruments agree the word really differs: `brdist` (26, 4, 3), a raw
`objdump` word-for-word compare of `build/recon/…/camera.cpp.o` vs
`expected/src/game/common/camera.c.o`, and **objdiff's own per-symbol `match_percent` = 99.809** —
while the *report's* `fuzzy_match_percent` (the only metric the board carries) says 100.00.

**Mechanism.** The fuzzy metric charges 0.05 per surviving *argument* mismatch on instructions its
aligner pairs. When both streams are in the same order the aligner pairs the branches and charges
the differing destination. `Camera_UpdateHeliCam` is sealed by a `PER_FN_TEXT_MOVES` entry whose
own in-source comment says rows 3–4 *"move LABELS and un-wrap `.set noreorder` blocks"* — i.e. the
seal deliberately **reorders our stream relative to expected**, and the aligner then pairs across
the shift and absorbs the branch.

⇒ **`PER_FN_TEXT_MOVES`-sealed functions are exactly the population where the board can be
flattered.** `scratchpad/w65a4/textmoves_audit.py` audits all of them by comparing encoded
PC-relative branch words directly. **Result: 73 sealed fns audited, 1 board-blind — this one.**
So the exposure is real but currently *bounded to a single row*; `objdiff-cli diff`'s
`match_percent` is the cheap cross-check, and `brdist` already catches it.

> ⚠ **Do not read that tool's "PC-REL BRANCH COUNT" rows as findings.** Its walker stops at the
> next `<label>:` header, so an interior splat `alabel` (exported global in the *expected* object)
> truncates the expected-side scan and manufactures a bogus count mismatch — the same hazard
> `verify_asm` documents for `ours()`. Every large count-mismatch row (`iFILE_ExecCommand` 29v10,
> `vramfxya` 9v2, `AudioCmn_SoundCar` 75v23, `CD_get_intr` 38v14, `sprintf` 63v16, `FntPrint`
> 27v11) is that artifact; several are board 100.00, which is the tell. Only the **equal-count
> word-comparison** rows are trustworthy. Fixing the walker to continue through `alabel`s is the
> obvious next-wave upgrade.

Other equal-count word differences it found (all already class a/d, i.e. **not** blind spots):
`DrawGouraudShape` (board 97.12, gate FAIL:7), `PutDispEnv` (98.99, FAIL:38), `__divdf3`
(94.80, FAIL:16), `_padIntRecvData` (99.978, PASS — already class d).

---

## 5. CALL-TARGET IDENTITY — 143 → **8**

`tools/calltarget_audit.py` (the fourth blind spot: a `jal` to the wrong function scores 100 % on
*both* lanes). Readings this wave: **147** (W64-A21) → 143 (W64 close) → 117 (my mid-wave run,
which independently corroborated w65a3's landing) → **8 now**, after w65a3's `BASE-SCOPE
QUALIFICATION` sweep. All 8 remaining, in full:

| unit | caller | retail calls | we call |
|---|---|---|---|
| frontend/common/screenpost | `DrawBackground__26tScreenTournamentStandings` | `TextValue__23tListIteratorTournament7tPlayer` | `TextValue__13tListIterator7tPlayer` |
| game/common/aih_btccop | `___18AIHigh_BTC_Wingman` | `___11AIHigh_Base` | `___14AIHigh_BTC_Cop` |
| game/common/aih_btccop | `___19AIHigh_BTC_HumanCop` | `___11AIHigh_Base` | `___14AIHigh_BTC_Cop` |
| game/common/aih_btccop | `___14AIHigh_BTC_Cop` | `___11AIHigh_Base` | `___15AIHigh_BasicCop` |
| game/common/aih_btcperp | `___17AIHigh_BTC_AIPerp` | `___11AIHigh_Base` | `___15AIHigh_BTC_Perp` |
| game/common/aih_btcperp | `___20AIHigh_BTC_HumanPerp` | `___11AIHigh_Base` | `___15AIHigh_BTC_Perp` |
| **game/common/sim** | **`Sim_MainGameLoop__Fv`** | **`Sim_ProcessSimSchedules__Fv`** | **`Camera_Update__Fv`** |
| **game/common/sim** | **`Sim_MainGameLoop__Fv`** | **`Camera_Update__Fv`** | **`Sim_ProcessSimSchedules__Fv`** |

* 6 of 8 are the **C++ hierarchy-depth dtor chain** (§3.23c / W58 family): retail chains to the
  BASE, we chain to an INTERMEDIATE. Same instruction stream, different callee.
* 🔴 **The last two are a SWAPPED PAIR in one function** — `Sim_MainGameLoop` calls
  `Camera_Update` where retail calls `Sim_ProcessSimSchedules` **and vice versa**. That is a real
  per-frame **ordering** divergence (camera update vs sim scheduling), invisible to both lanes,
  and it is a behavioural finding rather than a naming one. **Recommended as the first
  calltarget item of the next wave.**

---

## 6. WHAT I LANDED (mission items 1 and 3)

| item | commit | result |
|---|---|---|
| objdiff.json `metadata.source_path` | `90714e0d` | 42 stale `.cpp` → `.c` (14 at W64-A21's audit; more TUs migrated since). Metadata layer only, `base_path`/`target_path` untouched, diff exactly 42+/42−. Board-neutral, proven by report ×2. |
| the 4 splat literal-`D_` relabels | `f983db77` | 14 operands, 5 oracle `.s` files, 4 board rows → 100.00. Gate 2× unchanged, tugate 2×, `tu_order_audit` 0, `psyqproof` REAL=0, full build clean. |

Layer enumeration for the relabel (all 7 accounted for) and the deliberate decision **not** to touch
`linkers/undefined_syms_auto.txt` (D_1000001 is still referenced by `asm/data/data_8010CCD4_o25.data.s`;
the other four assignments are inert, and removing them is zero-upside/nonzero-risk while a peer belt
is rewriting that blob) are recorded in full in `f983db77`'s message.

---

## 7. CONCURRENCY — what moved under me

* Peer commits landing during the census: `a1b08620`, `25214fa4`, `02a03a9d`, `421e3ba1`,
  `e3231dd9`, `9f62ef5f`, `16270aac`, `cd0c6f64` (+ mine). The census's step-3c re-read caught
  2 rows moving mid-run and the classification was rebased onto the final board.
* Two rows fell during my relabel's board check — `libcd/streamhelp StGetNext` 100 → 99.89 and
  `libmcrd/LIBMCRD MemCardWriteData_cb` 99.94 → 97.91. **Proven not mine:** their `expected/`
  objects are untouched (17:15) while their `build/recon` objects were rewritten at 18:25/18:27 by
  concurrent belts. I rebuilt 5 expected objects, neither of those units.
* **Coverage caveat.** The census refreshed every base object at 18:35, then re-compiled the 76
  sub-100 TUs + a 40-unit control sample during the gate/brdist phases. A peer landing after 18:35
  in a unit outside those sets is not reflected — an **under-count**, i.e. the conservative
  direction. Anything landed after HEAD `f81d7efe` is not in these numbers.

---

## 8. RECOMMENDATIONS FOR THE NEXT WAVE

1. **`Sim_MainGameLoop`'s swapped call pair** (§5) — the only *behavioural* item in the census.
2. **The 20 open class-d branch-word rows** (§4.2). W64-A21's triage still applies: the ±1
   shifts are cheap, the large-delta ones are whole-block routing and most likely to hide a real
   bug (W59-11C found three that way).
3. **Fix `textmoves_audit.py`'s walker to continue through interior `alabel`s** (§4.3), then re-run
   it as a standing check — it is the only instrument that sees the fifth blind spot directly.
   Cheaper alternative: read `match_percent` (not just `fuzzy_match_percent`) from
   `objdiff-cli diff` for every `PER_FN_TEXT_MOVES`-sealed fn.
4. **Promote `calltarget_audit` + `brdist` + a board-rebuild-first rule into the wave-close ritual.**
   The ordering law in §1 is the cheapest correctness win available: without it the board is read
   off a build tree that no single source state produced.
5. The 6 remaining dtor-chain calltarget sites are one mechanical class (§3.23c) — one fix pattern.

---

## 9. FILES (all under `scratchpad/w65a4/`)

`census.py` (the 4-phase harness) · `finalize.py` (final board + coherent reclassification) ·
`delta.py` (tables + W64→W65 delta) · `mpcount.py` (MATCH_PROGRESS readout without writing the
file; self-validating) · `textmoves_audit.py` (§4.3) · `relabel_literal_d.py` (word-decode-verified
oracle relabeller) · `rebuild_expected.py` · `fix_source_path.py` · data: `board_rows.json`,
`gate_rows.json`, `brdist_rows.json`, `classified.json`, `w64a21_baseline.json`,
`report_final_{a,b}.json`, `calltarget_{mid,final}.txt`, `census_run.log`, `bak/` (the 5 pre-relabel
oracle `.s` files), `objdiff.json.bak`.

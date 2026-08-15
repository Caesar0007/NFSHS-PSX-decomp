# W65-A4 — THE WAVE'S ACCEPTANCE SHEET

Repo `C:\Temp\nfs4-decomp` · **final census at HEAD `deae02d7`, 2026-08-15 18:50–18:55 WAST.**
~20 belts were building concurrently throughout; §7 records exactly what moved and what that
costs the numbers. An earlier census pass (HEAD `d33895ec`, `census_run.log`) is retained because
its intermediate state is the evidence for the ordering law in §1 and the blind spot in §4.3 —
the numbers below are the **later** run (`census_run2.log`), which is internally coherent.

---

## 0. HEADLINE

| number | W64 close | **W65-A4 census** | Δ |
|---|---|---|---|
| board rows at 100 (`MATCH_PROGRESS` counting) | 3358 / 3489 = 96.2 % | **3379 / 3489 = 96.8 %** | **+21** |
| board rows at 100 (raw, incl. the 7 SUPERSEDED) | 3358 / 3496 | **3379 / 3496 = 96.65 %** | +21 |
| **`matched_code_percent`** (the honest *bytes* number) | 82.58 | **84.4593** | **+1.88 pp** |
| `fuzzy_match_percent` (byte-weighted) | 99.39 | 99.386 | ≈ 0 |
| class **c** board-only ARTIFACTS | 5 | **0** | **−5 — CLASS CLOSED** |
| class **d** BRANCH-WORD divergences | 28 | **9** | **−19** |
| class **x** gate-FAIL-but-board-100 | 1 | **0** | −1 |
| class **a** GATE_FAIL (ordinary near-misses) | 101 | 101 | 0 |
| PROVEN wrong-call-target sites | 147 → 143 | **3** | **−140** |
| board-blind TEXT_MOVES rows (§4.3) | (unknown class) | **0** | — |
| full build | — | **exit 0, 0 TUs failed** | — |
| `tu_order_audit` | 0 | **0 inversions / 508 objects** | — |

`MATCH_PROGRESS.txt` was **not** regenerated or committed (per the mission). The numbers come from
`mpcount.py`, which replicates `tools/update_match_progress.py`'s counting rule and **refuses to run
unless it first reproduces W64-A21's published 3358/3489** from that census's own `board_final.json`.
It does, on every invocation above.

---

## 1. METHOD — and the ordering law that makes it honest

| # | instrument | sees | blind to |
|---|---|---|---|
| 1 | `objdiff-cli report generate` ×2 | `fuzzy_match_percent` per row | reloc identity; and — newly — a branch word in a *reordered* stream (§4.3) |
| 2 | `verify_asm`'s own module, driven per-TU | the normalised instruction stream | branch **targets**, call-target identity |
| 3 | `tools/brdist.py` | per-branch **distance** | (2 recorded vacuity defects, w63) |

> ### 🔴 THE ORDERING LAW — rebuild BEFORE reading the board
> **`report generate` does not build.** It reads `build/recon/**.o` as they lie. In a 20-belt wave
> those are a mix of committed-source builds and leftover **probe-patched** variants, so a board read
> taken without a rebuild is neither honest nor reproducible.
>
> Measured in **both** directions this session:
> * *Flattering:* the `--limit=3` smoke test found **four units whose every board row read 100.00**
>   that grew a brdist divergence the moment their TU was recompiled from committed source
>   (`screenusername` DrawBackground, `aih_opp` CheckForWipeOut, `camera` UpdateHeliCam +
>   UpdateSplineCam).
> * *Understating:* the full rebuild alone moved the board 3364 → 3367 and `matched_code`
>   83.09 → 83.47, because peers had committed work they had not rebuilt.
>
> ⇒ the census runs `tools/build.py --skip-asm` (objdiff.json's own `custom_make`) **first**, and
> reads the board after. Census-2 then verified the loop closes: **"board unchanged by gate/brdist
> recompiles: True"** — a coherent snapshot from one source state.

**Anti-vacuity — every instrument validated against a known positive before use** (catalog w43):

* gate driver reproduces `tugate` exactly (`Physics_Real` FAIL:4, `R3DCar_InsertCarFacetMenu` FAIL:12,
  PASS on the three I sealed). Written because `tugate` prints only *failing* fns and therefore cannot
  distinguish PASS from NO-ORACLE.
* `brdist` reproduces W64-A21's recorded triple on physics: **(25, 71, 72)**.
* **brdist CONTROL LEG — a deterministic 40-unit sample of units where *every* row is 100 → 0
  divergences** (both census runs). So the sub-100 result is not vacuous, and W63's "0 divergent on
  100 %-rows tree-wide" still holds at this end state.
* board run1 == run2 exactly (all 3496 rows) on every read; `mpcount` self-check as above;
  `calltarget_audit`'s mid-run reading independently corroborated w65a3's live 143→117 landing.

---

## 2. CLASS CENSUS

| class | meaning | W64-A21 | **W65-A4** |
|---|---|---|---|
| **a** GATE_FAIL | gate FAIL + board < 100 — ordinary near-misses | 101 | **101** |
| **d** BRANCH_REAL | gate PASS + board < 100 + brdist divergence | 28 | **9** |
| **c** ARTIFACT | gate PASS + board < 100, no brdist divergence | 5 | **0** |
| **x** GATE-ONLY | gate FAIL + board 100 | 1 | **0** |
| **?** UNRESOLVED | no gate verdict | 0 | **7** |

The 7 "unresolved" are **exactly** `update_match_progress.py`'s `SUPERSEDED` list — rows whose retail
home unit is tracked elsewhere, so `NOT IN OBJECT` is *correct ownership*. They sit outside the 3489
denominator by design and are **not** a regression.

**Class a costs ~7.7 k diff lines** across 101 fns; heaviest `__15tGlobalMenuDefs` 3473 (86.03 %),
`DrawC_PrimClip` 420, `Hrz_BuildSky` 370, `Draw_kCtrlSkidmark` 303, `Hud_BuildNumbers` 200,
`InGame_GetPSXPadValue` 168, `DrawSlider` 168, `DrawC_Prim` 166.

---

## 3. CLASS c — THE ARTIFACT CLASS IS CLOSED (5 → 0)

W64-A21's raw `classified.json` labels these `b_LANE_GAP` while its prose calls them class c and
reports class b = 0. Same five rows.

| row | closed by |
|---|---|
| `2mbyte stup0` 42.86 → 100 | W64-A21 (st_size / `.type`+`.size`) |
| `libcard/PATCH func_8010CA40` 97.78 → 100 | **w65a4** |
| `aispeeds AISpeeds_CalcOpponentTopSpeed` 99.956 → 100 | **w65a4** |
| `r3dcar R3DCar_CalcCarDimensions` 99.955 → 100 | **w65a4** |
| `libmath/DIVSF3 __divsf3` 99.877 → 100 | **w65a4** |

Mechanism + receipts: commit `f983db77`. spimdisasm had invented *data symbols* for plain constants,
so the assembled `expected/` object carried `R_MIPS_HI16/LO16` relocations our (correct) recon object
has none of — not a reloc *name* difference, so `functionRelocDiffs` could never reach it. Fixed on
the **oracle** side: 14 operands across 5 `.s` files relabelled to the bare constants the retail words
already encode, each verified by decoding the retail word out of that line's own comment.
`Physics_CalculateCarAcceleration` carried two of the same charges and improved 99.9789 → 99.9930 at
the time (it has since reached 100.00 via A2's branch fix).

---

## 4. BRANCH WORDS REMAINING — 28 → 9, **0 new**

19 rows closed this wave — 15 of them by **w65-a2's label-move belt** (`f81d7efe`, `35b804ce`), the
rest by a1/a3.

### 4.1 Still open (9) — the next wave's class-d worklist

| unit | function | board |
|---|---|---|
| frontend/common/fememcard | `LoadGame__FsbT1` | 99.9599 |
| frontend/common/fescreen | `InitializeShapes__7tScreen…` | 99.8809 |
| frontend/common/screencarselect | `DrawBackground__25tScreenCarSelectTwoPlayer` | 99.9269 |
| frontend/common/screenmain | `DrawBackground__11tScreenMain` | 99.9939 |
| frontend/psx/memcard | `MCRD_handlecardevents` | 99.9763 |
| game/psx/hud | `Hud_BuildString` | 99.9767 |
| syslib/psx/libgpu/FONT | `FntPrint` | 99.9792 |
| syslib/psx/libmcrd/LIBMCRD | `MemCardWriteData_cb` | 99.9367 |
| syslib/psx/libpad/PADSEQD | `_dirSendAuto` | 99.9219 |

A2 already classified the residue: `FntPrint` is a **maspsx law** (the label is emitted before an
inserted load-delay nop — needs a 3-line maspsx option), and 4 fns have **two labels one word apart**,
inexpressible by moves → their `PER_FN_BRANCH_RETARGET` mechanism wish.

### 4.2 🔴 THE FIFTH BLIND SPOT — and it was hiding a real bug

W64-A21 §2 concluded *"the board is NOT lenient about branch words"*. **Falsified by counter-example,
with a named mechanism — and the counter-example turned out to be a genuine correctness defect.**

Mid-census, `Camera_UpdateHeliCam__Fii` read gate **PASS** (443/443) and board **100.00**, yet:

```
ours     PC-rel branch #20   04610003   bgez v1, +4 insns
expected PC-rel branch #20   04610002   bgez v1, +3 insns
```

Three independent instruments agreed the word really differed: `brdist` (26, 4, 3); a raw `objdump`
word-for-word compare of `build/recon/…/camera.cpp.o` vs `expected/src/game/common/camera.c.o`; and
**objdiff's own per-symbol `match_percent` = 99.809** — while the *report* carries only
`fuzzy_match_percent`, which said 100.00.

**Mechanism.** The fuzzy metric charges 0.05 per surviving *argument* mismatch on instructions its
aligner **pairs**. Same-order streams pair the branches and charge the differing destination. This
function is sealed by a `PER_FN_TEXT_MOVES` entry whose own comment says rows 3–4 *"move LABELS and
un-wrap `.set noreorder` blocks"* — the seal deliberately **reorders our stream relative to
expected**, and the aligner then pairs across the shift and absorbs the branch.

**Independently corroborated and now FIXED.** w65-a2 reached the same word from the other direction
and their commit (`35b804ce`) records it as *"A CORRECTNESS FIX, NOT A COSMETIC BRANCH WORD"*: the
w63-a11 row-4 deletion left the `bgez` pointing at the label reorg had planted **past** the stolen
`slt`, so on the `z >= 0` path the shipped object skipped both the `negu` and the `slt` and
`beq $2,$0` tested a **stale `$v0`** — the `|z| < |x|` heli-cam fallback comparison never ran.
Retail's word `0x04610002` is restored.

⇒ **`PER_FN_TEXT_MOVES`-sealed functions are the population where the board can be flattered, and a
flattered row can conceal a behavioural bug.** `textmoves_audit.py` audits all of them by encoded
PC-relative branch word. **Final state: 80 sealed fns audited, 9 with a real PC-relative branch-word
difference, 0 board-blind** (all 9 are already class a/d: `DrawGouraudShape` board 97.12/FAIL:7,
`PutDispEnv` 98.99/FAIL:38, `__divdf3` 94.80/FAIL:16, …). The exposure is closed *today*, but the
metric property is permanent — this audit belongs in the wave-close ritual.

> ⚠ **Do not quote that tool's "PC-REL BRANCH COUNT" rows as findings.** Its walker stops at the next
> `<label>:` header, so an interior splat `alabel` (a global symbol in the *expected* object)
> truncates the expected-side scan and manufactures a bogus count mismatch — the same hazard
> `verify_asm` documents for `ours()`. Several such rows sit at board 100.00, which is the tell.
> Only the **equal-count word-comparison** rows are trustworthy. Teaching the walker to continue
> through `alabel`s is the obvious upgrade. `j`/`jal` are excluded throughout (absolute +
> `R_MIPS_26` pre-link — the same reason `calltarget_audit` excludes section-relative relocs).

---

## 5. CALL-TARGET IDENTITY — 143 → **3**

`tools/calltarget_audit.py` (the fourth blind spot: a `jal` to the wrong function scores 100 % on
*both* lanes). Readings: **147** (W64-A21) → 143 (W64 close) → 117 (my mid-wave run) → **3 now**,
after w65a3's `BASE-SCOPE QUALIFICATION` sweep and dtor-chain work. All three remaining:

| unit | caller | retail calls | we call |
|---|---|---|---|
| frontend/common/screenpost | `DrawBackground__26tScreenTournamentStandings` | `TextValue__23tListIteratorTournament7tPlayer` | `TextValue__13tListIterator7tPlayer` |
| **game/common/sim** | **`Sim_MainGameLoop__Fv`** | **`Camera_Update__Fv`** | **`Sim_ProcessSimSchedules__Fv`** |
| **game/common/sim** | **`Sim_MainGameLoop__Fv`** | **`Sim_ProcessSimSchedules__Fv`** | **`Camera_Update__Fv`** |

🔴 **The two `sim` rows are a SWAPPED PAIR inside one function** — `Sim_MainGameLoop` calls
`Camera_Update` where retail calls `Sim_ProcessSimSchedules`, **and vice versa**. That is a real
per-frame **ordering** divergence (camera update vs sim scheduling), invisible to both lanes and to
`brdist`. It is a *behavioural* finding, not a naming one. **Recommended as the next wave's first
calltarget item.** The remaining `screenpost` row is the familiar tListIterator hierarchy-depth class.

---

## 6. WHAT I LANDED (mission items 1 and 3)

| item | commit | result |
|---|---|---|
| objdiff.json `metadata.source_path` | `90714e0d` | 42 stale `.cpp` → `.c` (14 at W64-A21's audit; more TUs migrated since). **Metadata layer only** — `base_path`/`target_path` untouched, diff exactly 42+/42−, CRLF preserved. Board-neutral, proven by report ×2. |
| the 4 splat literal-`D_` relabels | `f983db77` | 14 operands, 5 oracle `.s` files → 4 board rows at 100.00. Gate 2× unchanged, tugate 2×, `tu_order_audit` 0, `psyqproof` REAL=0, full build clean. |

`tools/gen_objdiff_units.py` was deliberately **not** run for the metadata fix: it is non-idempotent
(rewrites `src/**` stubs, strips catch-all `INCLUDE_ASM` lines, re-appends units).

The relabel's 7-layer enumeration, and the reasoned decision **not** to touch
`linkers/undefined_syms_auto.txt` (`D_1000001` is still referenced by
`asm/data/data_8010CCD4_o25.data.s`; the other four assignments are inert and removing them is
zero-upside / nonzero-risk while a peer belt rewrites that blob), are recorded in full in `f983db77`.

---

## 7. CONCURRENCY — what moved, and what it costs these numbers

* Census-2 is internally coherent: **"board unchanged by gate/brdist recompiles: True"**. Census-1
  was not (2 rows moved mid-run); its numbers are superseded but its log is the evidence for §1.
* During my relabel's board check two rows fell — `libcd/streamhelp StGetNext` and
  `libmcrd/LIBMCRD MemCardWriteData_cb`. **Proven not mine:** their `expected/` objects were untouched
  (17:15) while their `build/recon` objects were rewritten at 18:25/18:27 by concurrent belts. I
  rebuilt 5 expected objects; neither of those units.
* **Coverage caveat.** Census-2 refreshed every base object, then recompiled the 70 sub-100 TUs and a
  40-unit control sample. Anything a peer landed after HEAD `deae02d7` is not reflected — an
  **under-count**, the conservative direction.
* **Peer sweep.** A peer's `git add -A`-style commit (`deae02d7`, w65a6) swept 11 of my staged
  `scratchpad/w65a4/` files into their commit. Content is preserved in the repo; only the attribution
  moved. This is the catalog's standing "stage EXPLICIT paths only" hazard, observed from the
  receiving end — worth noting that staging explicitly protects *you*, not from *others*.

---

## 8. RECOMMENDATIONS FOR THE NEXT WAVE

1. **`Sim_MainGameLoop`'s swapped call pair** (§5) — the only *behavioural* item in this census.
2. **The 9 open class-d rows** (§4.1), with A2's classification already attached: `FntPrint` needs a
   small maspsx option; 4 need `PER_FN_BRANCH_RETARGET`.
3. **Adopt the ordering law (§1) as a wave-close rule**: rebuild, *then* read the board. It is the
   cheapest correctness win available — without it the board is read off a build tree that no single
   source state produced, in both the flattering and the understating direction.
4. **Fix `textmoves_audit.py`'s `alabel` walker and run it at wave close** (§4.2). The cheap
   equivalent is reading `match_percent`, not just `fuzzy_match_percent`, for every
   `PER_FN_TEXT_MOVES`-sealed fn.
5. A2's own standing lesson, which this census corroborates: **any TEXT_MOVES row whose `take` is a
   branch line, or whose `drop_after` empties a delay slot, must be paired with a `brdist` run** —
   the gate cannot see stolen-slot semantics, and neither can the board.

---

## 9. FILES (all under `scratchpad/w65a4/`)

`census.py` (4-phase harness) · `finalize.py` (final board + coherent reclassification) · `delta.py`
(tables + W64→W65 delta) · `mpcount.py` (self-validating `MATCH_PROGRESS` readout that does not write
the file) · `textmoves_audit.py` (§4.2) · `relabel_literal_d.py` (word-decode-verified oracle
relabeller) · `rebuild_expected.py` · `fix_source_path.py` · data: `board_rows.json`,
`gate_rows.json`, `brdist_rows.json`, `classified.json`, `w64a21_baseline.json`,
`report_final_{a,b}.json`, `calltarget_{mid,final}.txt`, `textmoves_final.txt`,
`census_run.log` (pass 1 — the §1 evidence), `census_run2.log` (pass 2 — the numbers above),
`bak/` (the 5 pre-relabel oracle `.s` files), `objdiff.json.bak`.

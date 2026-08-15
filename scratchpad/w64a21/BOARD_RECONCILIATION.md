# W64-A21 — BOARD RECONCILIATION (MATCH_PROGRESS.txt vs the verify_asm gate)

Repo `C:\Temp\nfs4-decomp` · measured 2026-08-15 17:09–17:32 WAST · HEAD at start
`fbc974f7`, my landing `7a662a6e`. **20 belts were building concurrently for the whole
run** — every number below is a timestamped snapshot, and §7 lists the rows that
demonstrably moved under me.

---

## 0. HEADLINE — the mission's premise was half right

| claim in the brief | verdict |
|---|---|
| "the board lane misses gate shims" (class **b**) | **FALSE — no such class exists.** `objdiff.json`'s `custom_make` IS `tools/build.py --skip-asm`, and objdiff's base object is the *same file* `build/recon/<tu>.<ext>.o` that `verify_asm` writes. Every `PER_TU_FLAGS`, `PER_FN_TEXT_MOVES`, splice and lane selection is therefore applied identically. 0 rows. |
| "board-low from reloc rendering" (class **c**) | **FALSE as stated — reloc differences are FREE on the board.** A report generated with `-c functionRelocDiffs=none` is *row-for-row identical* to the default (0 differing rows of 3489); with `=all` 1225 extra rows drop below 100. The board already ignores splat-`D_<VA>`-vs-our-C-symbol spelling. |
| stup0 42.86 % is a rendering artifact | **TRUE but for a different reason** — symbol **st_size**, not relocs. Fixed and landed (§4). |
| "cars pair … REAL branch-word divergence — the board sees what the gate normalizes" | **TRUE, and it is the dominant disagreement class**: 27 rows. |
| MATCH_PROGRESS rows are stale | **TRUE**: 19 of the 150 audited rows are already at 100.00 % on a fresh regen. |

**Net: the board is not under-counting. Where the board and the gate disagree, the
board is (almost always) RIGHT and the gate is blind.**

---

## 1. What each lane actually is

| | GATE (`tools/verify_asm.py`) | BOARD (`MATCH_PROGRESS.txt`) |
|---|---|---|
| our side | `build.py compile_c/compile_cpp(<recon TU>)` → `build/recon/<tu>.o`, disassembled with `objdump -d -r -z` | the **same** `build/recon/<tu>.o` file |
| retail side | the splat **text** oracle `asm/nonmatchings/{main,front}/<FN>.s`, span = `glabel`→`endlabel` | the **assembled** object `expected/src/<tu>.o` (built from the same `.s` via the `src/**` INCLUDE_ASM stubs) |
| extent of a function | the ORACLE's span; `ours()` walks **through** interior `alabel`s | the ELF **`st_size`** of the symbol in each object |
| metric | count of unified-diff lines after normalisation | objdiff `fuzzy_match_percent` |
| **normalises away** | `$`-prefix, `s8`≡`fp`, hex→dec, `%hi/%lo/%gp_rel`→0, `R_MIPS_LO16/GPREL16` addends→0, `move`/`or`-move→`addu`, `addiu/ori r,zero,N`→`li`, `break/syscall` code 0, cop2 by raw word, dead-`%hi` pairs, **and every branch/jump TARGET → `T`** | **all relocation name/addend differences** (measured, §2) |
| **charges for** | everything else, per instruction | 1.00 instr per insert/delete; **0.05** instr per surviving argument mismatch |

Consequence: the two lanes have *different* blind spots, and neither is a superset of
the other.

---

## 2. The board metric, measured (not guessed)

Three back-to-back reports over identical objects:

| `functionRelocDiffs` | rows at 100 % (of 3489) |
|---|---|
| default | 3355 |
| `none` | 3355 — **0 rows differ from default** |
| `all` | 2130 |

and per-row: `charged_instructions = (100 − fuzzy%)/100 × n_instructions` fits
`1.00 × (insert/delete) + 0.05 × (surviving arg mismatch)`; e.g. `func_8010CA40`
9 insns, 4 arg diffs → 0.200 charged → 97.778 % (exact), `__divsf3` 81 insns, 2 →
99.877 % (exact), `stup0` 7 insns, 4 deletes → 42.857 % (exact).

⇒ **The board is already lenient about relocs. It is NOT lenient about branch words,
about instruction count, or about `st_size`.**

---

## 3. FULL CENSUS — 150 rows (non-100 on the committed board **or** on a fresh regen)

Method: 82 TUs whole-TU-gated with `verify_asm`'s own module (`scratchpad/w64a21/w64a21_gate.py`,
same compile + normalisers + dead-`%hi` collapse as `tools/tugate.py`); objdiff report
regenerated **after** that gate run so both lanes read the same freshly built objects;
per-row mechanism from `objdiff-cli diff -u <unit> <sym>` classified by
`scratchpad/w64a21/objclass.py`.

| class | rows | meaning |
|---|---|---|
| **a — GATE_FAIL** | **101** | gate FAIL and board < 100: the two lanes agree. Ordinary near-misses; nothing to reconcile. |
| **b — LANE_GAP** | **0** | *no shim gap exists* (§0). |
| **c — BOARD-ONLY ARTIFACT** | **4 (+1 fixed)** | gate PASS, board < 100, byte-identical after link. See §4. |
| **d — BRANCH_REAL** | **27** | gate PASS, board < 100, a real branch/jump **word** differs. Production signal. See §5. |
| **e — STALE** | **19** | already 100.00 % on a fresh regen; the committed row is out of date. |

(Row-level tables: `scratchpad/w64a21/tables.md`, machine-readable
`scratchpad/w64a21/final_table.json` / `classified.json` / `gpass_final.json`.)

### 3.1 The honest single board number

| number | value | what it is |
|---|---|---|
| committed `MATCH_PROGRESS.txt` | **3340 / 3489 = 95.73 %** | stale by 19 rows |
| fresh regen (17:31, incl. my landing) | **3358 / 3489 = 96.25 %** | the honest *board* number today |
| board with the 4 measured board-only artifacts discounted | **3362 / 3489 = 96.36 %** | the honest *code* number the board could show |
| **gate truth** (verify_asm PASS) | **≈ 3389 / 3489 = 97.13 %** | = 3358 board-100 + 27 branch-real + 4 artifacts |
| whole-project `fuzzy_match_percent` | **99.39 %** | byte-weighted, from `measures` |
| whole-project `matched_code_percent` | **82.58 %** | the honest *bytes* number — the one that is not flattered by tiny functions |

**Recommendation: regenerate `MATCH_PROGRESS.txt` (`python tools/update_match_progress.py`)
— the committed file understates the board by 18 rows.** No code change to that tool is
needed or justified (§0).

---

## 4. Class c — board-only artifacts (4 open + 1 LANDED)

### 4.1 LANDED: `stup0` 42.86 % → 100.00 % (commit `7a662a6e`)

Not a reloc artifact — a **symbol-size** artifact, the W52 "fix_symsizes st_size
truncation / PATCHGTE 50 %" class, on the recon side:

* retail `stup0` is `0x1C` (the oracle's own `nonmatching stup0, 0x1C`; the four inline
  `.word`s are *inside* the symbol);
* our object had `0x0C`, because the interior label `D_800E40D8:` is the next symbol and
  `tools/fix_symsizes.py` sizes a symbol up to the next symbol value;
* the gate slices by the ORACLE span and walks through interior labels → PASS 7/7;
  objdiff reads `st_size` → 3/7 = 42.857 %.

Fix = the explicit `.type`/`.size` idiom already used by `PATCH.c`'s `func_8010CA40`
(`fix_symsizes` only fills `size==0`), **plus** the same symbol shape for `D_800E40D8`
that splat's `alabel` gives the expected object (global / `STT_FUNC` / `0x10`) — without
that second half, stup0's new extent swallowed those bytes and that row would have gone
100.00 → 0.00. Receipts: gate 2× 4/4 PASS, `psyqproof` REAL=0 RELOP=0 on all four TU
symbols, `tu_order_audit` 0 inversions, board regen: stup0 → 100.00, `D_800E40D8` stays
100.00, **zero rows moved the wrong direction**. Our symtab now mirrors
`expected/src/syslib/psx/2mbyte/2mbyte.c.o` exactly.

A tree-wide sweep for the same class is in `scratchpad/w64a21/sizeaudit.py` (55 size
mismatches; all the others are genuine instruction-count near-misses, i.e. class a).

### 4.2 OPEN: the splat **literal-`D_` pseudo-label** class — 4 rows, NOT source-reachable

| VA | unit / function | board | oracle renders | we render |
|---|---|---|---|---|
| — | `syslib/psx/libcard/PATCH` `func_8010CA40` | 97.778 | `%hi/%lo(D_A000DFAC)`, `(D_A000DF80)` | `lui 0xa001` / `addiu -0x2054`, `lui 0xa001` / `addiu -0x2080` |
| 0x8006D938 | `game/common/aispeeds` `AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi` | 99.956 | `%hi/%lo(D_100FF)` ×3 | `lui 0x1` / `addiu 0xff` |
| 0x800AE750 | `game/common/r3dcar` `R3DCar_CalcCarDimensions__…` | 99.955 | `%hi/%lo(D_FF9D0001)` ×3 | `lui 0xff9d` / `addiu 0x1` |
| 0x800F66E4 | `syslib/psx/libmath/DIVSF3` `__divsf3` | 99.877 | `%hi/%lo(D_1000001)` ×2 | `lui 0x100` / `addiu 0x1` |

spimdisasm invented a data symbol for a value that is **a constant, not an address**
(`0x100FF` is the div-guard pair; `0xFF9D0001` is `-0x62FFFF`; `0xA000DF80` is a BIOS
kernel-scratch literal). `verify_asm` already resolves these (`_literal_dlabel` /
`_dlabel_hi` / `_dlabel_lo`, the w52-a9 fix) which is why they gate PASS. objdiff cannot:
the *expected object* really carries `R_MIPS_HI16/LO16` relocations there while ours has
none, so it is not a reloc-*name* difference and `functionRelocDiffs` cannot reach it
(verified: identical under `none`, `default` and `all`).

**These 4 are byte-identical after link. Do not grind them.** The only real fix is on the
ORACLE side — relabel those `%hi/%lo(D_<literal>)` pairs in the four `.s` files to their
bare constants (the w52-a9 gate fix's mirror image). That is a 4-layer rename
(`asm/**.s` + `expected/` rebuild + `src/**` INCLUDE_ASM + `configs/symbol_addrs.txt`
hygiene, methodology gotcha 0b) touching a CI-visible artifact, so I have **specced it,
not landed it**. Expected yield: +4 rows, ≈ +0.11 %.

---

## 5. Class d — 27 REAL branch-word divergences (next-wave targets)

Gate PASS, board < 100, and at least one branch/jump **destination word** differs. This is
the 04Q law ("THE GATE IS BLIND TO BRANCH TARGETS") at scale, and the W59-11C branch-audit
programme's unfinished tail: 11C swept the 99 %-band and found 26/33 dirty; these are what
is left.

Cross-checked with a second, independent instrument — `tools/brdist.py` (fresh compile,
per-branch *distance* comparison, post-w63 vacuity fix): **27 of 28 candidates confirmed**;
the 28th (`StatChk_IsTopTime__FP10Car_tStatss`) was a concurrent-belt transient and is
byte-clean now.

| VA | unit | function | board | objdiff | brdist (idx, ours, oracle) |
|---|---|---|---|---|---|
| 0x8001AE14 | frontend/common/femenuextended | `Draw__29tMenuItemOptionsTwoItemChoiceiib` | 99.969 | 1 branch | (2, 6, 4) |
| 0x8001C854 | frontend/common/femenuoptions | `UpdateTransition__12tOptionsMenu` | 99.971 | 1 | (5, 23, 135) |
| 0x8001FD2C | frontend/common/femenuoptions | `ProcessInput__17tUserNameMenuItem…` | 99.979 | 1 | (17, 113, 140) |
| 0x800263EC | frontend/common/fescreen | `InitializeShapes__7tScreen…` | 99.881 | 1 | (1, 8, 20) |
| 0x80034E18 | frontend/common/fememcard | `LoadGame__FsbT1` | 99.960 | 3 | (17,-4,45) (21,-41,8) (23,-46,3) |
| 0x800353F0 | frontend/common/fememcard | `SavePinkSlipsCars__Fss` | 99.978 | 1 | (5, 103, 88) |
| 0x800379C0 | frontend/common/screenmain | `DrawBackground__11tScreenMain` | 99.994 | 1 | (9, 11, 12) |
| 0x8003D364 | frontend/common/screencarselect | `DrawVideoWall__20tScreenCarSelectDuels` | 99.942 | 1 | (3, 14, 15) |
| 0x8003D4BC | frontend/common/screencarselect | `DrawOpponentVideoWall__20tScreenCarSelectDuels` | 99.931 | 1 | (3, 13, 14) |
| 0x8003E4BC | frontend/common/screencarselect | `DrawBackground__25tScreenCarSelectTwoPlayer` | 99.927 | 5 | (3,21,9) (5,21,22) (6,19,20) (7,12,13) (8,3,4) |
| 0x80046D60 | frontend/common/screenmemcard | `DrawMemCardStuff__14tScreenMemcards` | 99.985 | 1 | (20, 19, 166) |
| 0x8004923C | frontend/common/screencongrats | `CalculatePrizes__23tScreenTournamentTrophy` | 99.965 | 1 | (9, 17, 18) |
| 0x8004FE80 | frontend/psx/memcard | `MCRD_handlecardevents` | 99.976 | 1 | (13, 148, 94) |
| 0x800696B0 | game/common/aiphysic | `AIPhysic_CalcAcceleration__FP8Car_tObji` | 99.973 | 1 | (27, 5, 6) |
| 0x800718B4 | game/common/aistate | `CheckIfCarIsNearbyAndStop__21AIState_RovingTraffic…` | 99.954 | 1 | (9, 15, 16) |
| 0x8007C750 | game/common/audiotrk | `AudioTrk_AddCustomObject__…` | 99.988 | 1 | (48, 14, 13) |
| 0x800813CC | game/common/camera | `Camera_UpdateHeliCam__Fii` | 99.989 | 1 | (26, 4, 3) |
| 0x800AA984 | game/common/physics | `Physics_CalculateCarAcceleration__FP8Car_tObj` | 99.979 | 1 | (25, 71, 72) |
| 0x800D42C8 | game/psx/hud | `Hud_BuildString__FPciiiib` | 99.977 | 1 | (2, 154, 155) |
| 0x800E2218 | game/psx/weather | `Weather_ChangeDensityBasedOnTime__Fv` | 99.907 | 1 | (5, 10, 11) |
| 0x800F7034 | syslib/psx/libgpu/FONT | `FntPrint` | 99.979 | 1 | (10, 8, 9) |
| 0x800F9A28 | syslib/psx/libcd/streamhelp | `StGetNext` | 99.891 | 1 | (0, 15, 14) |
| 0x800F9CA4 | eaclib/psx/eacpsxz/cdfs | `CdReadyHandler` | 99.983 | 1 | (12, 104, 99) |
| 0x800FB30C | syslib/psx/libmcrd/LIBMCRD | `MemCardWriteData_cb` | 99.937 | 1 | (6, 53, 52) |
| 0x8010A0E4 | syslib/psx/libpad/PADSEQD | `_dirSendAuto` | 99.922 | 1 | (1, 32, 33) |
| 0x8010C288 | syslib/psx/libpad/MCXMAIN | `_padIntRecvHdr` | (churned to 100 at 17:28, objdiff still 2 at 17:29) | 2 | (1,6,7) (2,4,5) |
| 0x8010C314 | syslib/psx/libpad/MCXMAIN | `_padIntRecvData` | 99.978 | 1 | (13, 34, 35) |

**Triage shape (measured over the brdist triples).** **17 of the 27** have *only*
**±1-instruction** target shifts — the classic "one insn on the wrong side of the branch
target": a statement that belongs inside/outside the guard, a reload placed in the wrong
block, or a delay-slot/steal decision. Cheap, high-yield, and each one also unlocks a true
byte-exact row.

The **10 large-delta** rows are **whole-block routing** differences — an early-out jumping
to the wrong join, or a matching device that re-shaped the CFG while keeping the word
stream identical: `UpdateTransition__12tOptionsMenu` (23 vs 135),
`ProcessInput__17tUserNameMenuItem…` (113 vs 140), `InitializeShapes__7tScreen…` (8 vs 20),
`LoadGame__FsbT1` (3 branches, −4 vs 45 / −41 vs 8 / −46 vs 3),
`SavePinkSlipsCars__Fss` (103 vs 88), `DrawBackground__25tScreenCarSelectTwoPlayer`
(21 vs 9 + four ±1), `DrawMemCardStuff__14tScreenMemcards` (19 vs 166),
`MCRD_handlecardevents` (148 vs 94), `CdReadyHandler` (104 vs 99),
`Draw__29tMenuItemOptionsTwoItemChoiceiib` (6 vs 4).
**Start here** — these are the ones most likely to hide a behavioural bug; W59-11C found
three real ones (`MainLoop` case-4 skipping the two-player unwind, `AudioCmn_DeInit`
stores outside their guard, `RovingTraffic`) by exactly this route.

**Recommended standing gate:** `tools/strict_branch.py` already implements the byte-exact
branch-word comparison, but it is **currently broken** — `ROOT = Path(__file__).resolve().parents[2]`
resolves to `C:\Temp`, not the repo (its own comment says otherwise), so `BUILD_RECON`
never exists. `parents[1]` is the one-character fix. (`tools/ownmap.py` carries the identical
promoted-from-scratchpad bug **and** imports a `blobparse` module that is not in `tools/`.)
Until then `tools/brdist.py` is the working instrument.

---

## 6. 🔴 NEW — THE FOURTH BLIND SPOT: reloc **TARGET IDENTITY**, invisible to BOTH lanes

`verify_asm` is reloc-name lenient *by design* (AGENT_GUIDE §0c — and that leniency is
right, because mangled/demangled and same-VA aliases legitimately differ). §2 shows the
board's fuzzy metric ignores relocs *entirely*. So **a `jal` to the wrong function is
scored 100 % by both lanes.**

`scratchpad/w64a21/calltarget_audit.py` closes it: it re-runs every unit under
`-c functionRelocDiffs=all`, keeps only `R_MIPS_26` sites where **both** sides name a real
symbol (section-relative `.text`+addend relocs — the file-static callee form, methodology
§3.12 #12 — are excluded, they prove nothing), and requires both names to be in
`configs/symbol_addrs.txt` at **different VAs**.

**Result: 147 sites, 96 distinct target pairs.** Two families:

1. **C++ hierarchy depth (the bulk).** Retail chains to the BASE where we chain to an
   INTERMEDIATE: `___7tScreen` vs `___12tDialogYesNo` (16 sites), `___24tMenuItemLeftRightChoice`
   vs `___31tMenuItemOptionsLeftRightChoice` (9), `___11AIHigh_Base` vs `___14AIHigh_BTC_Cop`
   (2), plus `Draw__11tDialogBase` vs `Draw__20tDialogMessageString`,
   `ProcessInput__12tDialogYesNo…` vs `…__15tDialogYesNoMem…`, `Initialize__5tMenu` vs
   `Initialize__9tMenuNFS4`, `UpdateTransition__9tMenuItemb` vs `…__20tMenuItemSlidingMenub`.
   The instruction streams are byte-identical; only the *callee* differs, so after link the
   `jal` **word** differs. This is the §3.23c / W58 dtor-modelling family and it is the
   single largest remaining fidelity debt that no current gate reports.
2. **Wrong overload binding (real bugs).** `AIWorld_ApxSplineDistance` has FOUR overloads at
   four VAs — `__FP8Car_tObjT0` @0x800730B8, `__FP8Car_tObji` @0x80073128,
   `__FiP8Car_tObj` @0x80073194, `__Fii` @0x800731BC — and the OWNER
   (`recon/game/common/AIWORLD.cpp:17-20`) declares all four correctly. The **consuming**
   `*_externs.h` files declare only `(Car_tObj*, Car_tObj*)`, so every call site binds to
   `__FP8Car_tObjT0` via an implicit `0`→pointer / `int`→pointer conversion that gcc-2.8
   accepts silently. Retail calls `__FP8Car_tObji` at 3 sites and `__FiP8Car_tObj` at 2;
   we call `__FP8Car_tObjT0` at all five: `AI_AddCollidableObjects__FP8Car_tObjP5Group`,
   `AI_AvoidSpikeBelt__FP8Car_tObj`, `AI_PushFinishedCarsToSide__FP8Car_tObj` (game/common/ai),
   `AICop_NoCopsInArea__Fii` (aicop), `AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi`
   (aispeeds, `aispeeds_externs.h:35`, call at `aispeeds.cpp:280` passing a literal `0`).
   Exactly the catalog's w22-a14 "missing overload declaration in the consuming `*_externs.h`"
   row — **it is back, and neither lane can see it.** Fix = copy AIWORLD.cpp's four
   declarations into each consumer's externs header, then re-gate those 5 fns.

Full list: `scratchpad/w64a21/calltarget2.txt`. **Recommendation: promote
`calltarget_audit.py` to `tools/` and make it a standing wave-close check**, exactly like
the phantom census — it costs 15 s over all 461 units.

---

## 7. Concurrency notes (build/** churn, 20 belts)

* **objdiff `report generate` does NOT build** (0.2 s over 461 units); it reads whatever
  `build/recon/**.o` currently is. The committed board can therefore be stale in *both*
  directions, and a report taken mid-belt can catch a half-written object.
* Rows measurably moved by OTHER belts during my 23-minute run: `Physics_Real` 99.97→99.99,
  `Sfx_BuildSouffleFacet` 97.39→98.09, `_padIntRecvHdr` 99.71→100.00,
  `StatChk_IsTopTime` (transient branch diff → clean), `Night_SetEnviroment`
  (transient gate-2 → clean), `DrawW_DrawQuad` 100→99.63→100, `FeAudio_InitViv` 96.60→85.82→…
  `recon/game/common/newton.cpp` failed to COMPILE at 17:12 and compiled clean at 17:15.
* **Do not compare a gate result and a board row taken minutes apart.** My census
  re-gated first (which rewrites the very object objdiff reads) and only then regenerated
  the report.

## 8. Hygiene defects found in passing

1. **`objdiff.json` `metadata.source_path` is stale for 14 units** — they say `.cpp` where
   the recon file is `.c` (the task-#90 C-lane migration): `eacpsxz/asinfunc`, `eacpsxz/cdfs`,
   `2mbyte/2mbyte`, `libapi/FIRST`, `libc/SPRINTF`, `libcd/{cdread,iso9660,toc}`,
   `libetc/{INTR,INTR_DMA}`, `libgpu/FONT`, `libmcrd/LIBMCRD`, `libpad/{PADCMD,PADMAIN}`.
   `base_path`/`target_path` are correct so the board is unaffected, but any tool that
   resolves unit→source (mine did) silently gets a non-existent file. Regenerate with
   `tools/gen_objdiff_units.py`.
2. **`tools/strict_branch.py` and `tools/ownmap.py` both have `ROOT = parents[2]`** (→ `C:\Temp`)
   left over from promotion out of a scratchpad; `strict_branch` therefore finds no objects
   and `ownmap` additionally imports a missing `blobparse`. Both are *silent* failures — the
   catalog's own "VALIDATE ANY CENSUS TOOL AGAINST A KNOWN-POSITIVE" rule (w43) applies.
3. `update_match_progress.py`'s `SUPERSEDED` list (7 rows) is correct and current; its
   docstring's claim that "fuzzy 100.00 and gate PASS almost always agree" is now
   quantified: 27 rows where gate PASS ≠ board 100, plus 1 measured board-100/gate-FAIL
   transient.

## 9. Files (all under `scratchpad/w64a21/`)

`w64a21_gate.py` (whole-TU gate census) · `objclass.py` (per-instruction mechanism
classifier over objdiff's own engine) · `boardcmp.py` · `worklist.py` · `merge.py` ·
`relocmap.py` · `fuzzyfit.py` (the metric fit of §2) · `sizeaudit.py` (tree-wide st_size
audit) · `calltarget_audit.py` (§6) · data: `gate.jsonl`, `gate2.jsonl`, `objclass.jsonl`,
`board_{now,after,final}.json`, `b{A,B,C}.json` (the reloc-config experiment),
`classified.json`, `final_table.json`, `tables.md`, `brdist.txt`, `calltarget2.txt`,
`2mbyte.c.bak`.

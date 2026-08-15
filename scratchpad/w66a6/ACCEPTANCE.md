# W66-A6 — THE -G SPLICE VERDICT + WAVE ACCEPTANCE

Repo `C:\Temp\nfs4-decomp`. Mission items 1 and 2 are **COMPLETE and committed**
(`1a3c67eb`, `bfc8c614`, `5a0b174f`).

### 🔴 PROVENANCE OF THE §3 NUMBERS — READ FIRST

The acceptance chain was measured on the tree at **HEAD `5a0b174f`**, build
finished **20:05**. At that moment no peer W66 commit existed. Since then:

* **`de791715`/`f3cab3d2` (w66a1) landed** — the `PER_FN_BRANCH_RETARGET`
  mechanism. It is delivered as a **patch, not applied**:
  `grep -c PER_FN_BRANCH_RETARGET tools/build.py` = **0**, the deliverable is
  `scratchpad/w66a1/branch_retarget.patch`. So the tree as measured does not
  carry it, and §3's numbers are the correct picture *of the tree as it stands*.
* peer belts are still editing (25 modified `recon/` files; 5 touched at
  20:13–20:16, i.e. **after** my build).

⇒ **§3 is a timestamped snapshot, not the wave close.** Everything in §1, §2,
§4 and §6 is independent of that and final.

**RE-RUN REQUIRED AT WAVE CLOSE** (after `branch_retarget.patch` is applied and
peers have committed) — the whole chain, in order, each one command:

```
python tools/build.py --no-link
python tools/update_match_progress.py --skip-build
python tools/relink.py --lane recon --json <out>.json
python tools/probe_link.py --json <out>.json          # re-scans by default
python scratchpad/w66a6/brdist_all.py                 # ALL rows, not the 100%-band
python tools/calltarget_audit.py
python scratchpad/w66a6/stale_absolutes_fixed.py      # tools/ copy is unrunnable, sec.4
python tools/tu_order_audit.py
python tools/ownmap.py --blob <ctl> --end <VA> ...    # x3 regions, sec.3
python scratchpad/w66a6/classd.py                     # the [99,100) band screen
python scratchpad/w66a6/gcensus.py                    # the -G census, sec.2
```

**Predicted deltas from w66a1's patch alone** (their receipts, not re-measured
by me): class-d **6 → 0**, `calltarget_audit` **2 → 0**, `Sim_MainGameLoop`
FAIL 6 → PASS 321/321, board +1 substantive row. That closes §3.1 exactly —
and note it independently confirms §3.1's finding that those seven rows were
real defects sitting at board-100, not noise.

---

## 1. THE PER-FN `-G8` VERDICT — the mechanism CANNOT express data placement

**Claim: `PER_FN_G8` is a TEXT-form lever only. It can never move an object into
`.sdata`. Proven two independent ways, at the mechanism's maximum reach.**

`_apply_fn_splice` (build.py:2008) substitutes the region returned by
`_extract_fn_region`, which is exactly `.ent NAME … .end NAME`. Every data
directive cc1plus emits (`.data` / `.sdata` switches, `.globl`, `.align`,
`label:`, `.space`) lives OUTSIDE that region, so no set of function names can
ever reach it. There is also no *data-owning function* to name: in a C++ TU the
five objects are file-scope definitions emitted by `finish_file`, not by any
`.ent` body.

### Proof A — the `.s` section walk at maximum reach (`probe_g8_data.py`)

| config | fns spliced | `bestLapTime` | `gtotallaptimes` | `AudioCmn_gPlayerArrested` | `currentWindVal` | `nextWindVal` |
|---|---|---|---|---|---|---|
| A baseline (wired: `AudioCmn_Init` only) | 1 | `.data` | `.data` | `.data` | `.data` | `.data` |
| **B per-fn `-G8` on ALL 48 fns of the TU** | **48** | **`.data`** | **`.data`** | **`.data`** | **`.data`** | **`.data`** |
| C whole-TU `-G8` (`g_value: 8`) | 1 | `.sdata` | `.sdata` | `.sdata` | `.sdata` | `.sdata` |

### Proof B — the ELF symbol table of the produced object (same run)

| config | section of all five |
|---|---|
| A baseline | `.data` (0x9f0, 0x9f8, 0xa00, 0xa08, 0xa10) |
| **B all 48 fns spliced** | **`.data` — byte-for-byte the same offsets as A** |
| C whole-TU `-G8` | `.sdata` (0x9c, 0xa4, 0xac, 0xd4, 0xdc) |

Relocations are `R_MIPS_HI16`/`LO16` (13 + 13) in **all three** configs, so the
splice is not even creating a gp-rel/section mismatch hazard — it is simply
inert on data.

### What the per-fn `-G8` splice *does* buy (why the wired entry is still right)
Under `-G8` cc1plus stops pre-splitting the address of a now-gp-eligible symbol
and emits the **unschedulable `la` macro** instead of the schedulable
`lui %hi / addiu %lo` pair (`la $5,bestLapTime` vs `lui $5,%hi(...)` +
`addiu $5,$5,%lo(...)`). That is an *address-materialization form* lever, the
same family as the W48 `-mno-split-addresses` identity — and it is exactly what
seals `AudioCmn_Init`. **Keep the entry; re-label it in the source comment as a
form lever, not a placement lever.**

### The alternative, landed and gated
`__attribute__((section(".sdata")))` — storage-only, leaves `-G` (and therefore
every address materialization in the whole TU) untouched, so **CheckState's
basin is untouched by construction**:

* object TEXT **byte-identical** to the un-attributed build, **3765/3765 words**
  (`probe_sdata_attr.py`);
* `tugate recon/game/common/audiocmn.cpp` **47/48 PASS, twice**, CheckState
  unchanged at 4;
* maspsx accepts the emitted `.section .sdata,"aw",@progbits`.

This is the mirror of the already-established in-tree `movie.cpp` idiom
(`__attribute__((section(".bss")))`, catalog §I-addendum) pointed the other way.
⚠️ It is a **cc1plus-lane** device only — W65-17B proved the attribute is INERT
on the gcc-2.7.2 syslib lane.

### Bonus: the run is now retail-ORDERED (the W64-16E `=0` pair lever)
cc1plus emits initialised objects first and tentative ones second; retail's run
interleaves them, so retail initialised everything. 32 explicit initialisers on
the run `0x8013C628..0x8013C71C` collapse both batches into one declaration-order
batch:

| | symbols in the run | order matches retail | delta mismatches |
|---|---|---|---|
| before | 41 | no | 9/40 |
| + section attribute | 46 | no | 7/45 |
| **+ `=0` lever** | **46** | **YES** | **1/45** |

Gate held 47/48 twice at every step. The single survivor is a **genuine 56-byte
retail gap** after `fReverbLevel@0x8013c679`, which the blob shows is occupied by
`D_8013C684/690/694/698…` — i.e. **audiocmn's pooled string literals**
(`"eng"/"ger"/"frn"/"spn"/"itl"`, the targets of `AudioCmn_LanguageName`) which
retail put in `.sdata` and cc1plus puts in `.rodata`. That is the named next
angle for closing this window (precedent already in-tree: `cars.cpp:352`, "the
empty format literal occupies .sdata @0x8013c7e0").

**Orchestrator action: none required in `build.py`.** No new mechanism, no new
table row; `PER_FN_G8` stays exactly as wired.

---

## 2. THE TREE-WIDE `-G` CENSUS — CLOSED

`scratchpad/w66a6/gcensus.py` → `GCENSUS.txt`. Method: every recon file-scope
declaration carrying a `/* @0xVA */` breadcrumb is cross-checked against the
section its symbol lands in inside the built object.

* **Decidable class (the W64-16E `-G8` tell):** VA inside retail's blob-decidable
  `.sdata` run `0x8013C54C..0x8013DD7C` but emitted under `.data`.
  After the audiocmn landing exactly **one** row remained tree-wide —
  `aih_play.cpp gBlockadeTypes` (`char[5]`, i.e. over `-G4`) — cured with the
  same section attribute, **gate 10/10 held twice**, object now `.sdata`, and
  ownmap now reports it as an **OWN+ window**. **The class is now 0.**
* **Inverse class (29 rows, left for the link lane):** objects we emit
  small whose retail VA is outside the small-data window — `libpad/PAD.c` ×24
  (`_padFunc*` @0x80137c…, `_waitTime`/`_startTime` @0x80148a…),
  `drawshp kNoColor`, `psxfront ofs`, `track Track_gShapeNamePtrs_end` (all
  three FRONT-overlay VAs @0x8005…), `libgte` `_InitGeom_ra_save` /
  `_patch_gte_ra_save`. Cure = the `movie.cpp` `.bss`/`.data` attribute, but
  ⚠️ the two `libgte` rows are on the **2.7.2 lane where the attribute is inert**
  (W65-17B) — those need `-G0` or a storage reshape instead.
* Undecidable band recorded honestly: `0x8013DD7C..0x8013DF00` is retail
  `.sbss`, whose section membership leaves no bytes in the image; the census
  deliberately does not judge it.

---

## 3. WAVE ACCEPTANCE

Chain: full build → `update_match_progress` → relink → probe_link →
brdist tree-wide → calltarget_audit → stale_absolutes → tu_order_audit → ownmap.
All logs in `scratchpad/w66a6/`.

| gate | W65 close | W66 acceptance | Δ |
|---|---|---|---|
| board (`MATCH_PROGRESS.txt`) | 3382/3489 = 96.9% | **3389/3489 = 97.1%** | +7 rows *(see the caveat below — none is substantive)* |
| relink `REAL` dup | 0 | **0** | = |
| relink `HIDDEN PHANTOMS` | 0 | **0** | = |
| relink unresolved (reloc-referenced) | 20 | **5** | −15 |
| recon-link undefined | 15 | **5** (`D_1000001`, `D_80000004`, `__last_org`, `_gp`, `ticksA`) | −10 |
| `calltarget_audit` | 2 | **2** | = |
| `tu_order_audit` | 0 inversions | **0 inversions** (508 objects, 5 multi-VA names excluded) | = |
| `stale_absolutes` | 0 | **0** *(tool is UNRUNNABLE as promoted — see §4)* | = |
| `probe_link` | ~83% | **82.97%** (765 016 / 922 016 B; placed 443, exact objs 161/443) | see §3.2 |
| ownership (ownmap, 3 regions) | 83 windows / 36 752 B | **87 windows / 36 820 B** | +4 / +68 B |
| class-d (gate-PASS, board <100, wrong branch words) | ~9 → "~0" | **6** *(honest re-count — see §3.1)* | — |
| brdist tree-wide | "0 divergent on 100%-rows" | **41 TUs / 64 fns divergent**, of which **7 are board-100** | see §3.1 |

`relink` **GATE: GREEN**. 747 objects, `DUP total=797 blob-class=797 REAL=0`.

ownmap per region (excludes `femenu/fetv/screenpost/screenusername`, as W65):

| region | windows | bytes owned | of |
|---|---|---|---|
| `sdata_8013C54C` (end 0x8013DD7C) | 40 | 868 | 6 192 |
| `data_8010CCD4` (end 0x8013C54C) | 35 | 35 476 | 194 680 |
| `front_data` (end 0x80052B38) | 12 | 476 | 6 360 |
| **total** | **87** | **36 820** | — |

### 3.1 🔴 THE BOARD'S +7 IS NOT PROGRESS — and class-d is 6, not ~0

The seven rows that moved 99.9x → 100.00% in the regen are **exactly** the seven
rows brdist reports as branch-divergent while the board calls them perfect:

| VA | fn | gate | brdist |
|---|---|---|---|
| 0x800379C0 | `DrawBackground__11tScreenMain` | PASS 822 | 1 offset diff `(9, 11, 12)` |
| 0x8004FE80 | `MCRD_handlecardevents` | PASS 211 | offset diff |
| 0x800D42C8 | `Hud_BuildString__FPciiiib` | PASS 215 | `(2, 154, 155)` |
| 0x800F7034 | `FntPrint` | PASS 240 | `(10, 8, 9)` |
| 0x800FB30C | `MemCardWriteData_cb` | PASS 79 | `(6, 53, 52)` |
| 0x8010A0E4 | `_dirSendAuto` | PASS 64 | `(1, 32, 33)` |
| 0x800B6D4C | `Sim_MainGameLoop__Fv` | **FAIL 6 (319/321)** | BRANCH COUNT 53 vs 54 |

* Six are the **±1 LABEL-PLACEMENT class** W65-17B already named (word stream is
  retail's, one label sits one word off; four of them were flagged then as
  needing a `PER_FN_BRANCH_RETARGET` mechanism). They are **class-d = 6**.
* The seventh, `Sim_MainGameLoop`, is a **board OVER-REPORT**: the board says
  100.00% while the gate says FAIL 6 — and it is also both `calltarget_audit`
  rows (the known `Camera_Update` ↔ `Sim_ProcessSimSchedules` swap). One row,
  three independent lanes disagreeing.
* Why W65's "0 divergent on 100%-rows" and this "7" are both true: at the W65
  close these rows sat at 99.9x, so a *100%-rows* sweep never looked at them.
  **The lesson is a gate-composition one — a row can migrate INTO the
  100%-band and take its defect with it, so the brdist sweep must be run over
  ALL rows, not the 100%-band.** My `brdist_all.py` does that.
* The remaining 56 divergent fns are on rows the board already reports <100%
  (their word streams differ anyway — expected, not a blind spot), plus one fn
  absent from the board (`func_80106878`, `INTR_DMA.c`).

**A screen of the whole `[99,100)` band (`classd.py`, 18 rows) found 0
gate-PASS rows** — every sub-100 near-miss is a genuine gate FAIL.

### 3.2 🔴 `probe_link`'s SCORE IS NOW BEING PUSHED DOWN BY THE DATA CAMPAIGN

Against the last on-disk run (`scratchpad/w63a19/link_probe.txt`, 83.14%):

| | prior | now | Δ |
|---|---|---|---|
| identical bytes | 764 590 | **765 016** | **+426** |
| bytes compared | 919 680 | 922 016 | +2 336 |
| placed objects | 440 | 443 | +3 |
| exact objects | 201 | **161** | **−40** |

The percentage fell while the **absolute identical-byte count rose**. Root
cause, traced to the word: `probe_link` places every object's `.text` at its
implied retail base but dumps **all data** into one dummy catch-all
`.other 0x80300000`. As the data-materialization belt migrates a datum out of
`linkers/undefined_syms_auto.txt` (where it carried its true retail VA) into a
real object definition, every `%hi/%lo` of that datum starts resolving into the
dummy region and mismatches.

Worked exhibit: `sndpsxz/sover.c.o` differs in exactly 2 words —
`lui $2,0x8031 / lb $2,0x358c($2)` vs retail `lui $2,0x8014 / lb $2,0x789c($2)`
— i.e. `sndgs`, now defined in `ssysinit.c.o`'s `.bss` and placed by the probe
at `0x80313550`. **All 41 lost-exact objects are sndpsxz TUs and every one of
them lost a multiple of 3 bytes** (3/6/9) = whole `%lo`/`jal` immediates, never
a codegen word.

**Orchestrator action (tool spec):** give `probe_link` the same
implied-base treatment for `.sdata`/`.sbss`/`.data`/`.bss` that it already gives
`.text` (data-symbol retail VAs are available from the same breadcrumb/vamap
source `ownmap` uses), or link it against the real `nfs4.ld` data placement.
Until then the percentage **under-reports and will keep falling as the data lane
succeeds** — track `identical bytes` alongside it.

---

## 4. 🔴 TOOL DEFECT: `tools/stale_absolutes.py` HAS BEEN VACUOUS SINCE PROMOTION

```
ROOT = Path(__file__).resolve().parents[2]      # tools/ -> C:\Temp   (WRONG)
```
It needs `parents[1]`. As committed the standing gate dies with
`FileNotFoundError: C:\Temp\scratchpad\w65a6\census_recon.json` — i.e. it has
never actually run from `tools/`. This is precisely the W64-16F promotion
root-resolution class ("CHECK ROOT RESOLUTION ON EVERY PROMOTION"), firing again.

Both the as-designed run (w65a6 census, 7 283 defined names) and a fresh
re-census straight off the build objects (7 184 names) report **0 rows** — the
gate is genuinely green, it just could not say so. Runnable copy with the fix
and a self-contained census: `scratchpad/w66a6/stale_absolutes_fixed.py`.
It also no longer depends on a w65a6 session artifact.

---

## 5. FILES / RECEIPTS

Landings (3 commits, all gated twice, zero PASS→FAIL):
* `1a3c67eb` `recon/game/common/audiocmn.cpp` — five `.sdata` section attributes
* `bfc8c614` `recon/game/common/audiocmn.cpp` — 32 `=0` initialisers
* `5a0b174f` `recon/game/common/aih_play.cpp` — `gBlockadeTypes` attribute + census

Probes/tools (all in `scratchpad/w66a6/`, all restore-on-`finally`, all
absolute-path + byte-mode writes):
`probe_g8_data.py` (A/B/C configs, private out-tree) ·
`probe_sdata_attr.py` (text byte-identity) · `probe_sdata_order.py` ·
`probe_sdata_full.py` · `probe_zeroinit.py` / `land_zeroinit.py` ·
`sdata_order_check.py` (read-only receipt generator) · `gcensus.py` ·
`classd.py` · `brdist_all.py` (anti-vacuity: a missing summary line or
`0 fns checked` counts as a HARNESS ERROR, never as clean) ·
`brdist_classify.py` · `stale_absolutes_fixed.py`.

Backup of the pre-belt TU: `scratchpad/w66a6/audiocmn.cpp.pre_w66a6.bak`.

## 6. CATALOG ROW CANDIDATES (I do not write the memory dir)

1. **`PER_FN_G8`/`_apply_fn_splice` is a TEXT-region mechanism — it can never
   move DATA.** Symptom: an ownership window blocked by an object `-G4` exiles
   to `.data`. Fix: `__attribute__((section(".sdata")))` (cc1plus lane only —
   INERT on 2.7.2 per 17B). Evidence: splicing ALL 48 fns of a TU leaves every
   object in `.data`; whole-TU `-G8` moves them. What the splice actually buys
   is the **unschedulable `la` macro** address form (the `-mno-split-addresses`
   family), which is why `AudioCmn_Init` seals with it.
2. **The `.sdata` section attribute is the missing DIRECTION of the `movie.cpp`
   `.bss` idiom** — and it is provably codegen-neutral (3765/3765 words), so it
   is a zero-risk ownership lever, unlike `-G8`.
3. **The W64-16E `=0` pair lever, quantified:** it does not merely reorder — it
   merges cc1plus's two data batches into one declaration-order batch
   (audiocmn 9/40 → 1/45 delta mismatches, order_matches False → True).
4. **A retail `.sdata` gap that no reordering closes can be the TU's STRING
   LITERAL POOL** (retail pools `.sdata`, cc1plus emits `.rodata`); tell = splat
   `D_` interior labels in the gap that a `char *X[]` table points at.
5. **Gate-composition law:** a defective row can MIGRATE INTO the 100%-band
   between waves and carry its defect with it, so the brdist blind-spot sweep
   must run over ALL rows, never the 100%-band alone (this wave: 6 class-d rows
   materialised out of the 99.9x band with no source change).
6. **`probe_link` under-reports as the DATA lane succeeds** — its dummy
   `.other 0x80300000` catch-all mis-resolves every newly-materialized datum's
   `%hi/%lo`; track identical BYTES, not the percentage, until it places data at
   implied bases. Tell: lost-exact objects whose diffs are multiples of 3 bytes.
7. **Promotion root-resolution fired again** (`tools/stale_absolutes.py`,
   `parents[2]`) — the 16F rule needs to be a checklist item on every promotion.

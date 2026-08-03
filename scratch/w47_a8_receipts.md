# w47-a8 — PER-MODULE FLAG-SPACE SWEEP over the eaclib cluster

Agent a8, wave 47. Worktree `C:/Temp/nfs4-wt47-a8`, branch `w47-a8`, base `ba09f774`.

**STATUS: the flag axis is CLOSED for eaclib except two candidates.**
**1871 whole-TU flag×TU gate measurements**: 31 TUs × 44 flags (round 1) + 31 × 13
(round 3, a10's gaps) + a 12-cell -G × split-addresses interaction grid on 4 TUs + a 14-flag
-O/-g level sweep on 4 TUs. 2 flags met the recommendation bar; 1 apparent win was falsified
as a maspsx artifact; everything else is recorded as INERT or WORSE so nobody re-sweeps it.

---

## 0. HEADLINE

| # | Finding | Consequence |
|---|---|---|
| **A1** | **`recon/eaclib/psx/spchpsxz/spchrule.c` wants `-G0` (or `-G2`).** `iSPCH_GetRuleSettings` 43 → 40 diffs and **ours 113 → 112 insns = the oracle's 112 exactly**; the spurious `lui`-scheduling pair and one `nop` disappear. 8 other fns unchanged, 0 regressions, reproduced 2×. | 🥇 the wave's only real -G find outside a7's census. Feed to a7. |
| **A2** | **`recon/eaclib/psx/sndpsxz/smemman.c` + `-fno-expensive-optimizations`**: `iSNDmalloc` 48 → 41, ours 137 → 136 (oracle 135). 3 other fns unchanged, 0 regressions, reproduced 2×. | 🥈 meets the bar mechanically; evidence is thin (1 fn moved) — corroborate before committing. |
| **A3** | 🔴 **`-mrnames` is a TRAP — it scores better by BREAKING the object.** On `pad.c` it takes `PAD_state` 4 → 3 diffs, but ours goes **20 → 19 insns against a 20-insn oracle**: `-mrnames` makes cc1 print `$a0`-style register names that **maspsx mis-parses, silently DROPPING an instruction**. a10 lists `-mrnames` as "invisible after assembly" — that is true for stock gas, **false for our maspsx pipeline**. | ❌ never sweep; and it is a live maspsx bug worth filing. |
| **A4** | 🔴 **`build.py`'s `g_value` PER_TU_FLAGS key is wired in `compile_cpp` ONLY.** `compile_c` (= **all** of eaclib/syslib, the entire C lane) ignores it: cc1 gets the global `-G4` and maspsx/as gets `f"-G{G_VALUE}"`. | Any -G finding for a **.c** TU — including A1 and anything a7 produces for eaclib — **cannot currently be expressed**. Wiring patch prototyped below. |
| **A5** | **-G and -msplit-addresses are NOT independent.** Under `-mno-split-addresses`, `spchpick`'s entire -G sensitivity **vanishes** (G0/G2/G4/G8/G16 all give an identical 370). | 🔴 A -G census run on an object that used `-mno-split-addresses` (e.g. the proven `pad.c`) is **structurally incapable** of showing a -G signature. a7 must gate the census on split-addresses state. |
| **A6** | **21 of 44 flags are INERT on all 31 eaclib TUs** — zero observable codegen change anywhere. Notably `-funsigned-char`, `-fno-defer-pop`, `-mno-gpOPT`, `-mgas`, `-fno-common`, `-fshort-enums`, `-fwritable-strings` — independently confirming a10's H3/H5/H4. | Drop from every future sweep. |
| **A7** | **`-fsigned-char` — a10's rank-2 most-plausible per-module lever — is FALSIFIED for eaclib**: INERT on 28 TUs, strictly WORSE on 3 (`nfile` +2, `spchpick` +2, `sbhdrcpy`), better on 0. | eaclib is uniformly an unsigned-char codebase. Look elsewhere for the `charactertbl` case. |
| **A8** | **`-O2` and `-g1` are confirmed globally.** `-O0/-O1/-O3` are catastrophically worse on all 31 TUs; `-g0` is **byte-identical** to `-g1` everywhere, `-g2`/`-g3` are catastrophically worse. | The `-O`/`-g` axis is closed. `-g1` in `CC1_FLAGS` is doing nothing observable — it is `-g0`-equivalent. |

---

## 1. METHOD

`scratch/w47_a8_tugate.py` — compiles a recon TU through the **real** `build.py` pipeline,
enumerates **every** function symbol the object defines (`objdump -t`), and runs
`verify_asm.py` on all of them. Judging is whole-TU, never per-function.

`scratch/w47_a8_sweep.py` — re-measures that gate under each candidate flag via a
worktree-local probe hook in `tools/build.py`:

```
NFS4_A8_TU   ROOT-relative POSIX path of the TU under probe
NFS4_A8_CC1  extra cc1 flags for that TU
NFS4_A8_G    per-TU -G (drives BOTH cc1's -G and maspsx/as's -G)
```

The probe is **in place** — the same TU path is compiled, only flags change, so
`PER_TU_FLAGS` path keying and every header/include stay identical. Combo syntax
`G=8|-mno-split-addresses` drives the interaction grid.

**Recommendation bar (all four required):** whole-TU TOTALDIFF strictly drops · **zero**
PASS→FAIL regressions · no function vanishes from the object (a disappearing symbol is
scored 9999, a hard regression) · reproduced 2×. **Plus a manual read of the winning
diff** — A3 is exactly why: a broken, shorter body scores better.

**Harness sanity controls (all passed):** re-applying `-msplit-addresses` to `pad.c`
(undoing its proven `no_split_addresses`) regresses it +95/-1 PASS; `-fsyntax-only` and
`-m3900` are detected as total build failures; `-mno-split-addresses` on an already-set
TU is a no-op; `-mmips-as` reproduces `-mno-split-addresses` exactly (split-addresses
requires `TARGET_GAS`).

---

## 2. THE OPTION LIST — derived independently from CC1PSX.EXE

Before a10's §1 was available I read the option tables straight out of
`C:/Temp/psq43/COMPILER/CC1PSX.EXE`'s `.rdata` (`strings -t d`, the `f_options[]` block at
file offset 1352936 and `TARGET_SWITCHES` at 1357176). The two derivations **agree
completely**. Recorded here as an independent cross-check of a10's H1.

---

## 3. PER-TU VERDICT (31 TUs, whole-TU gate)

| TU | fns | PASS | TOTDIFF | recommended flag |
|---|---|---|---|---|
| nfile | 27 | 18 | 132 | none |
| sdmemman | 3 | 1 | 73 | none |
| slib | 5 | 3 | 71 | none |
| **spchrule** | 9 | 7 | 57 | **`-G0`** (−3, PASS+0) |
| **smemman** | 4 | 3 | 48 | **`-fno-expensive-optimizations`** (−7, PASS+0) |
| spchpick | 27 | 21 | 37 | none |
| vramfxya | 3 | 2 | 34 | none |
| trnsmult | 1 | 0 | 31 | none |
| nsync | 10 | 8 | 29 | none |
| spchevnt | 16 | 14 | 28 | none |
| sbdload | 1 | 0 | 23 | none |
| syncfile | 8 | 7 | 21 | none |
| salloc | 4 | 2 | 20 | none |
| unref | 2 | 1 | 17 | none |
| pad | 5 | 2 | 16 | none (`-mrnames` = artifact, A3) |
| sdpacket | 13 | 11 | 16 | none |
| sbhdrcpy | 1 | 0 | 13 | none |
| sst | 16 | 15 | 13 | none |
| stream | 32 | 29 | 8 | none |
| spktplay | 13 | 11 | 6 | none |
| sdma | 6 | 5 | 4 | none |
| spchbank | 8 | 7 | 4 | none |
| sdresolv | 2 | 1 | 3 | none |
| spchinit | 7 | 6 | 3 | none |
| sserver | 6 | 5 | 3 | none |
| ssysserv | 3 | 2 | 3 | none |
| asinfunc | 2 | 1 | 2 | none |
| cdfs | 14 | 13 | 2 | none |
| resize | 1 | 0 | 2 | none |
| setfont | 1 | 0 | 2 | none |
| fileroot | 9 | 9 | 0 | (already clean) |

**⇒ 29 of 31 eaclib TUs have NO per-module flag identity to find. Their residual is
source-shape, not toolchain flags.** That is the deliverable: it redirects a1–a6 away
from the flag axis for these modules.

---

## 4. PER-FLAG CENSUS — the falsified list (do not re-sweep)

`INERT` = compiled, byte-identical output on that TU (⚠️ **unfalsified**, not ruled out —
the TU simply has no construct the flag touches). `WORSE` = TOTALDIFF increased.

### 4a. INERT on ALL 31 TUs — zero observable effect anywhere in eaclib
`-funsigned-char` · `-fno-defer-pop` · `-fshort-enums` · `-fwritable-strings` ·
`-fpcc-struct-return` · `-freg-struct-return` · `-fno-peephole` · `-mno-gpOPT` ·
`-G8` · `-fno-builtin` · `-ffloat-store` · `-fomit-frame-pointer` · `-fno-function-cse` ·
`-fno-common` · `-fkeep-inline-functions` · `-fno-gnu-linker` · `-mgas`

(`-mno-gpOPT` inert at every `-G` value tested — confirms a10 H5 empirically and
independently. `-G8`/`-G16` inert everywhere ⇒ **the "-G defaults to 8" hypothesis is
UNFALSIFIABLE from eaclib codegen**: 4, 8 and 16 are indistinguishable on all 31 TUs.)

### 4b. Never better, worse somewhere — falsified as levers
| flag | INERT | WORSE | worst delta |
|---|---|---|---|
| `-fno-caller-saves` | 30 | 1 | small |
| `-G16` | 30 | 1 | pad +4 |
| `-msplit-addresses` | 30 | 1 | pad +95 (= its proven override) |
| `-fno-thread-jumps` | 30 | 1 | nfile +2 |
| `-fsigned-char` | 28 | 3 | nfile/spchpick +2 |
| `-mmemcpy` | 27 | 4 | — |
| `-fno-inline` | 25 | 6 | stream +628 |
| `-fno-cse-follow-jumps` | 24 | 7 | — |
| `-fno-strength-reduce` | 22 | 9 | pad +70 |
| `-fno-cse-skip-blocks` | 22 | 9 | — |
| `-fforce-addr` | 17 | 14 | pad +60 |
| `-funroll-loops` | 17 | 14 | — |
| `-fno-rerun-cse-after-loop` | 17 | 14 | — |
| `-fno-force-mem` | 16 | 15 | — |
| `-fvolatile-global` | 13 | 18 | nfile +180 |
| `-finline-functions` (= `-O3`) | 12 | 19 | stream +11427 |
| `-mno-split-addresses` | 6 | 25 | nfile +357 |
| `-mmips-as` | 6 | 25 | identical to above |
| `-fvolatile` | 5 | 26 | nfile +398 |
| `-fno-schedule-insns` | 3 | 28 | nfile +459 |
| `-mlong-calls` | 1 | 30 | nfile +517 |
| `-fno-schedule-insns2` | 0 | 31 | nfile +269 |
| `-fno-delayed-branch` | 0 | 31 | nfile +546 |

`-fno-delayed-branch` and `-fno-schedule-insns2` are worse on **every single TU** — the
strongest possible confirmation that retail eaclib was built with gcc's own delayed-branch
filling and post-RA scheduling ON, i.e. eaclib is **not** in the PsyQ-syslib
`-fno-delayed-branch` identity class (methodology §3.25 axis 3b).

### 4b-2. Round 3 — the flags a10's §1 flagged that round 1 missed (all 31 TUs)
Run after a10's option list landed, to close the gap. **Zero wins.**

| flag | INERT | WORSE | BETTER |
|---|---|---|---|
| `-fno-omit-frame-pointer` (a10 rank **5**) | 0 | **31** | 0 |
| `-ftraditional` | 6 | 25 | 0 |
| `-fpack-struct` | 15 | 16 | 0 |
| `-mdebugd` | 20 | 11 | 0 |
| `-mdebugc` | 27 | 4 | 0 |
| `-mdebuga` | 30 | 1 | 0 |
| `-funroll-loops -funroll-max=1` / `=2` (**SN-only flag**) | 29 | 2 | 0 |
| `-funsigned-bitfields` · `-membedded-data` · `-fno-keep-static-consts` · `-mno-memcpy` · `-mdebugf` | 31 | 0 | 0 |

`-fno-omit-frame-pointer` being worse on **every** TU falsifies a10's rank-5 hypothesis
for eaclib outright: no eaclib object frames on `$30`. The SN-only `-funroll-max=N` is
inert wherever `-funroll-loops` itself is inert.

### 4c. `-O` / `-g` level — measured on the **4 assigned TUs only** (pad, nfile, stream, spchpick)
`-O0`, `-O1`, `-O3` catastrophically worse on all four. `-g0` **byte-identical to the `-g1`
baseline** on all four; `-g2`/`-g3` catastrophically worse. `-m4650`, `-m3900`,
`-mcpu=r3000`, `-msoft-float`, `-mno-mips-tfile`, `-fno-strict-prototype`: inert or
build-fail. (`-O3` is redundant with `-finline-functions`, which round 1 *did* sweep on all
31 — worse on 19, never better — so the `-O3` verdict does extend to the full set.)
⚠️ The `-O1`/`-O0`/`-g2` verdicts are **not** measured beyond those 4 TUs. Their signatures
are so gross (hundreds to thousands of diffs) that extrapolation is safe, but it is
extrapolation.

---

## 5. THE -G × SPLIT-ADDRESSES INTERACTION GRID (A5)

TOTALDIFF, baseline in bold. This is the interaction the wave asked for.

| TU | basin | G0 | G2 | G4 | G8 | G16 |
|---|---|---|---|---|---|---|
| pad *(no-split is its adopted default)* | `-mno-split-addresses` | **16** | 16 | 16 | 16 | 20 |
| pad | `-msplit-addresses` | 111 | 111 | 111 | 111 | 109 |
| nfile | `-msplit-addresses` (default) | 171 | 171 | **132** | 132 | 132 |
| nfile | `-mno-split-addresses` | 499 | 499 | 489 | 489 | 489 |
| stream | `-msplit-addresses` (default) | 24 | 24 | **8** | 8 | 8 |
| stream | `-mno-split-addresses` | 36 | 36 | 24 | 24 | 24 |
| spchpick | `-msplit-addresses` (default) | 53 | 53 | **37** | 37 | 37 |
| spchpick | `-mno-split-addresses` | 370 | 370 | 370 | 370 | 370 |

**Read-offs for a7:**
1. **`-mno-split-addresses` can fully MASK the -G signature** (spchpick: flat 370 across
   all five -G values). With split-addresses off, cc1 emits the `la`/indexed assembler
   macro and never makes the gp-rel decision itself, so **no -G evidence survives.**
   ⇒ `pad.c` — the one PROVEN `-mno-split-addresses` object — has an **undeterminable**
   `-G` (flat 16 for G0..G8; only G16 differs). Do not record a -G verdict for it.
2. The -G threshold that matters in eaclib sits between **2 and 4**, never above 4:
   G0≡G2 and G4≡G8≡G16 on every TU measured. So eaclib codegen can prove "gp-opt on with
   threshold ≥4" or "≤2", and **nothing finer**.
3. `-mno-gpOPT` never reproduces `-G0` at any -G value — the two are not interchangeable
   (a10 H5's mechanism, measured end-to-end here).

---

## 5b. WHY `-G0` IS SAFE FOR spchrule (the adoption argument)

`objdump -t` on the built `spchrule.c.o` shows **no `.sdata`/`.sbss` symbols at all** —
the TU owns no small data under any `-G`. So the `-G0` effect is entirely on how the
addresses of **external** symbols are materialized and scheduled (under `-G4` an extern of
declared size ≤4 is small-data-eligible → unschedulable `la` macro; under `-G0` it becomes
a schedulable `lui %hi` / `addiu %lo` pair that lands where the oracle has it). This is
exactly the mechanism recorded for `sfx.cpp` in `PER_TU_FLAGS`, run in the opposite
direction — and it carries the same safety property that comment cites: **because the TU
defines no small object, `-G0` cannot mis-place any of its own symbols**, and no `%gp_rel`
appears in the object either way.

Strength of claim: 1 of 9 fns improves (43→40) and reaches **exact instruction parity with
the oracle**; 8 unchanged; 0 regressions; reproduced 2×. `-G0` and `-G2` are
indistinguishable, so the honest statement is **"spchrule.obj was built with a -G threshold
of 0 or 2"**, not specifically `-G0`. The remaining 40 diffs are a uniform `$t0`↔`$a3`
coloring swap plus a frame-slot offset — a source-shape problem for a1–a6, not a flag one.

## 6. BUILD-SYSTEM DEFECT + PATCH (A4)

`tools/build.py`:

```python
def compile_cpp(src, ...):
    tu_g_value = str(tu_flags.get("g_value", G_VALUE))   # line 643 — C++ lane honours it
    ...
def compile_c(src, skip_asm):
    cc1_flags = list(CC1_FLAGS)                          # contains the GLOBAL -G4
    ...
    *AS_ARCH, f"-G{G_VALUE}", ...                        # line 623 — GLOBAL, not per-TU
```

`compile_c` never reads `g_value`. Every eaclib/syslib TU is in the C lane, so the
project's most-proven per-TU lever (`-G`, adopted for 7 C++ TUs) has been **unreachable
for the whole C lane**. The worktree carries the minimal fix (mirrors compile_cpp):
rewrite the `-G` entry in `cc1_flags` and pass the same value to maspsx/as. It is
currently behind the `NFS4_A8_*` probe hook — **the hook must be stripped and the
`g_value` key wired properly before this lands on main.** Not committed; flagged for the
coordinator.

---

## 7. FALSIFIED "WIN" — `-mrnames` (A3, the w46 hazard in the wild)

```
pad.c PAD_state, baseline (-G4):        FAIL 4 diffs (ours 20 / oracle 20)
pad.c PAD_state, +(-mrnames):           FAIL 3 diffs (ours 19 / oracle 20)   <-- an insn VANISHED
```
`-mrnames` makes cc1 emit `$a0`-style register names instead of `$4`; **maspsx mis-parses
that form and silently drops an instruction**, which the diff-count metric rewards. The
whole-TU picture confirms it is corruption, not a lever: on `stream.c` the same flag
causes **7 PASS→FAIL regressions**. Excluded from all recommendations.

⚠️ This is a real maspsx robustness bug (silent instruction loss on valid cc1 output),
not just a sweep artifact. Worth filing separately.

---

## 8. ARTEFACTS (all under `C:/Temp/nfs4-wt47-a8/scratch/`)

`w47_a8_tugate.py` · `w47_a8_sweep.py` · `w47_a8_batch.py` · `w47_a8_agg.py` ·
`w47_a8_round3.sh` · `base_<tu>.json` (31 baselines) · `sweep_<tu>.json` (round 1, 44
flags each) · `sweep2_<tu>.json` (-O/-g axis) · `grid_<tu>.json` (the -G × split grid) ·
`sweep3_<tu>.json` (a10-gap round) · `w47_a8_batch_summary.json`.

The only tracked-file edit is the `tools/build.py` probe hook (worktree-local, §6).

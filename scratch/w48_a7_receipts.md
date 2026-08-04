# WAVE-48 a7 receipts -- syslib/libetc + small singles

Worktree `C:/Temp/nfs4-wt48-a7`, branch `w48-a7`, base `a12f7b8b`.
Gate = `python tools/verify_asm.py <file> <names>` from the worktree root, sole authority.
Every number below is a GATE number, re-measured in this worktree.

## 0. RE-GATED BASELINE vs the worklist (worklist wrong on 5 of 25 rows)

| TU | fn | worklist % | GATE baseline | note |
|---|---|---|---|---|
| 2mbyte | `__main` | 0.00% | **NOT IN OBJECT** | fn was MISSING from the TU |
| 2mbyte | `stup1` | 96.67% | FAIL 1 (31/30) | |
| 2mbyte | `stup0` | 42.86% | **ALREADY PASS** | worklist wrong |
| libapi/COUNTER | `SetRCnt` | 98.46% | FAIL 2 (39/39) | |
| libapi/COUNTER | `GetRCnt` | 64.29% | FAIL 5 (13/14) | |
| libapi/COUNTER | `StartRCnt` | 26.25% | FAIL 10 (14/12) | |
| libetc/VMODE | `SetVideoMode` | 77.00% | FAIL 7 (4/5) | |
| libetc/VSYNC | `VSync` | 84.20% | FAIL 45 (95/94) | |
| libetc/VSYNC | `_VSync_wait` | 91.45% | FAIL 8 (38/38) | |
| libetc/INTR | `VSyncCallback` | 90.77% | FAIL 4 (13/13) | |
| libetc/INTR | `_initIntr` | 84.30% | FAIL 41 (55/54) | |
| libetc/INTR | `_intrhand` | 75.59% | FAIL 80 (112/116) | |
| libetc/INTR | `_set_intr_callback` | 88.44% | FAIL 34 (80/82) | |
| libetc/INTR | `StopCallback` | 60.17% | FAIL 47 (43/40) | |
| libetc/INTR | `RestartCallback` | 0.00% | FAIL 31 (31/30) | not 0% -- 31 diffs |
| libetc/INTR_VB | `startIntrVSync` | 73.41% | FAIL 11 (21/22) | |
| libetc/INTR_VB | `startIntrVSync_helper_1` | 0.00% | **NOT IN OBJECT** | name phantom |
| libetc/INTR_VB | `startIntrVSync_helper_2` | 0.00% | **NOT IN OBJECT** | name phantom |
| libetc/INTR_VB | `startIntrVSync_helper_3` | 0.00% | **NOT IN OBJECT** | fn MISSING from the TU |
| libetc/INTR_DMA | `startIntrDMA` | 71.84% | FAIL 14 (19/19) | |
| libetc/INTR_DMA | `_dma_isr` | 93.75% | FAIL 16 (94/96) | |
| libsn/READ | `PCread` | 93.12% | FAIL 39 (47/48) | |
| libsn/WRITE | `PCwrite` | 93.12% | FAIL 39 (47/48) | |
| libapi/FIRST | `firstfile` | 83.30% | FAIL 60 (103/103) | |
| libapi/FIRST | `_first_patch` | 90.50% | FAIL 40 (64/64) | |

## 1. LANDED (commit-per-lever)

### 1a. `2mbyte.obj` -- COMPLETE, 4/4 PASS (`e1d146a6`)
* **`__main` @0x800E4024 was ABSENT from the TU** (gate `NOT IN OBJECT`; the worklist rendered it
  as "0.00%").  Oracle body = `jr ra; nop`.  Added as a file-scope `__asm__` block placed FIRST so
  it lands physically before `__SN_ENTRY_POINT` like retail.  It must be asm, not a C
  `void __main(void){}`: this TU's asm blocks leave maspsx in `.set noreorder` state for the whole
  file, so a C empty fn would lose its delay-slot nop (w45 file-scope-asm pitfall).  -> **PASS (2)**
* **`stup1` 1 -> PASS (30)**: the SYM span is `0x78` = 30 insns and ENDS at the `lw $ra`; the
  following load-delay `nop` @0x800E40C8 is a PAD word between stup1 and stup0, not part of stup1.
  Labelled `D_800E40C8:` before it -- the byte stays in the image (retail layout preserved) and
  objdump attributes it to the pad symbol instead of stup1.  (Preferable to the catalog's
  "drop the trailing nop" recipe, which would shorten the object by a word.)
* `stup0` was **already PASS** (worklist 42.86%).

### 1b. `INTR_VB.obj` phantom class -- +2 PASS, +1 fn made gate-visible (`8e5c0b6`-ish)
The two helpers were reconstructed under DESCRIPTIVE names (`trapIntrVSync` / `_vsync_setcb`)
while `configs/symbol_addrs.txt` + every oracle `.s` call them `startIntrVSync_helper_1/_2` ->
the gate said **NOT IN OBJECT** for both, permanently, and the worklist rendered that as 0.00%.
Renamed (role documented in comments).  A THIRD oracle symbol, `startIntrVSync_helper_3`, was
**missing from the TU entirely**: it is INTR_VB.obj's OWN private word-clear helper (byte-identical
to INTR.obj's and INTR_DMA.obj's `_bzero_w`), which `startIntrVSync` jal's -- the recon had been
calling INTR.obj's copy across the object boundary.  Added + wired.
* `startIntrVSync_helper_2` **PASS (11)**, `startIntrVSync_helper_3` **PASS (9)**
* `startIntrVSync_helper_1` NOT IN OBJECT -> FAIL 8, count exact 27/27

### 1c. `COUNTER.StartRCnt` 10 -> 7 (count 14 -> 13) (`f4d1a1c`-ish)
Methodology 3.25-3c: the oracle puts the RCnt-ctrl store in the **`jr ra` delay slot**
(`jr ra; sw $v1,4($a1)`); gcc's reorg refuses to slot-fill a *volatile* MEM, so the `volatile`
qualifier alone cost the fill.  Cast it away on that one store.

### 1d. `INTR_DMA.startIntrDMA` 14 -> 7 (count 19 -> 18)
Same lever, second hit: the oracle fills the `jal InterruptCallback` delay slot with
`sw $zero,0($v0)` (the `DICR = 0` store).  `*(unsigned int *)g_dicr_ptr = 0;` instead of the
volatile macro lands the fill.

### 1e. `libsn PCread` + `PCwrite` 39 -> 23 each -- allocsim/reqdelta PREDICT-BEFORE-PROBE
Dumped `-dg`/`-dl` (`tools/rtl_dump_c.py`), ran `tools/reqdelta.py` against the oracle handout.
Baseline (allocsim-verified == our build):

```
p85 v0 refs=12 live=6  pri=6.0000     p83 s3 refs=6  live=22 pri=0.5454   (total)
p82 s0 refs=12 live=21 pri=1.7142     p88 s4 refs=3  live=36 pri=0.0833   ((-1))
p84 s1 refs=8  live=15 pri=1.6000     p86 s5 refs=3  live=38 pri=0.0789   (0x8000)
p81 s2 refs=7  live=21 pri=0.6666     p80 s6 refs=3  live=42 pri=0.0714   (fd)
```
Oracle wants `total=s2, buff=s3, fd=s4, (-1)=s5, 0x8000=s6` -- TWO independent flips.
reqdelta priced flip 1 as **`p83 refs 6 -> 8` (floor_log2 2 -> 3)**.  Source form:
write the short-read exit as a DUPLICATE `return total;` instead of `break` -- `cross_jump`
merges the two tails back into ONE (insn count unchanged, 47) while `flow.c` counts both refs,
and the in-loop copy is loop-depth-weighted, so refs land exactly on 8.  pri .545 -> 1.043;
`total` takes `$s2`, `buff` drops to `$s3`.  **39 -> 23 on both twins.**

## 2. OPEN RESIDUALS -- named angle + receipts (NO FLOORS)

### 2a. THE EPILOGUE-SWAP CLASS is 100% COMPILER-SIDE -- proven at the cc1 `.s` level (04C-relevant)
Present in `VSyncCallback` (its ONLY residual, 4 diffs, count exact), `startIntrVSync`,
`startIntrDMA`, `_VSync_wait`, `RestartCallback`, `StopCallback`.
Shape: ours `lw $ra,N(sp); nop; jr $ra; addiu $sp,$sp,N` -- oracle `lw $ra,N(sp);
addiu $sp,$sp,N; jr $ra; nop`.

**RECEIPT (new this wave):** `mips_expand_epilogue` (gcc-2.8.1 `config/mips/mips.c`) expands the
epilogue into REAL RTL insns (`gen_addsi3` for the sp adjust + `gen_return_internal`), so gcc's
**own dbr pass** fills the return's delay slot with the sp-adjust.  Read straight off the cached
cc1 output: `build/recon/syslib/psx/libetc/INTR.c.s` has
`.set noreorder / j $31 / addu $sp,$sp,24 / .set reorder` -- **gcc emits the swap itself**, and
`INTR.c.nodb.s` (the `-fno-delayed-branch` compile) has `addu $sp,$sp,24 / j $31` in reorder mode
= the ORACLE order.  So this class is NOT an assembler question at all; the 04C law's
"back to the compiler side" verdict is CONFIRMED for the epilogue half.

**BUT the two halves of the class are coupled and pull opposite ways**, and `VSyncCallback` is the
minimal exhibit (both halves in one 13-insn function):
* `-fdelayed-branch` (default): jal delay slot filled with `addiu $a0,$zero,4` = **oracle**;
  epilogue swapped = **wrong**.
* `-fno-delayed-branch`: epilogue = **oracle**; the `li $4,4` sits before the `jal` in *reorder*
  mode and maspsx nops the slot = **wrong** (maspsx never fills a reorder-mode branch slot).
Measured: per-fn splice of `VSyncCallback` into `PER_FN_NO_DELAYED_BRANCH` = **4 diffs before,
4 diffs after** (different 4).  Ditto whole-TU on INTR_VB: `startIntrVSync` 11 -> 8 but count
goes 21 -> 24 (2 extra nops) = below the w47 flag-identity bar.
**=> a10/a9 lane:** either the real assembler DOES fill a `.set reorder` jal slot (which the 04C
runs say it does not), or retail's cc1 differs from ours inside `mips_expand_epilogue`/dbr.  This
function is the cheapest possible differential test case for the real-ASPSX lane: 13 insns, one
jal, one epilogue.

### 2b. `-mno-split-addresses` per-TU SIGNATURES (for a9; NOT wired -- build.py is report-only here)
Whole-TU probes (patch PER_TU_FLAGS in place, gate, restore; tree verified clean after each):

| TU | fn | default | `-mno-split-addresses` |
|---|---|---|---|
| **INTR.c** | `_initIntr` | 41 (55/54) | **6 (54/54 count EXACT)** |
| | `_intrhand` | 80 (112/116) | 110 (**116/116 count EXACT**) |
| | `_set_intr_callback` | 34 (80/82) | 34 (80/82) |
| | `StopCallback` | 47 (43/40) | **25 (41/40)** |
| | `RestartCallback` | 31 (31/30) | **7 (29/30)** |
| | `VSyncCallback` | 4 | 4 |
| | (7 PASSing fns) | PASS | **PASS -- 0 regressions** |
| INTR_VB.c | `startIntrVSync` | 11 | 5 |
| | `helper_1` | 8 | **PASS (27)** |
| | `helper_2` | PASS | 11 -- **REGRESSION** |
| INTR_DMA.c | `startIntrDMA` | 7 | 5 |
| | `_dma_isr` | 16 (94/96) | 31 (91/96) |
| FIRST.c | `firstfile` | 60 (103/103) | 50 (105/103) |
| | `_first_patch` | 40 | 28 |
| COUNTER.c | `StartRCnt` | 7 (13/12) | 3 (13/12) |
| | `SetRCnt`/`GetRCnt` | 2 / 5 | 2 / 5 (inert) |
| VSYNC.c | `VSync` | 45 | 45 (inert) |
| | `_VSync_wait` | 8 (38/38) | 7 (39/38) |
| VMODE.c | `SetVideoMode` | 7 | 7 (inert); `-G0` also inert |

**RECOMMENDATION: `recon/syslib/psx/libetc/INTR.c` is the strongest candidate in this cluster** --
0 PASS regressions, 4 of 6 FAILs improve, and it makes `_initIntr` AND `_intrhand` count-EXACT
(54/54 and 116/116), i.e. it removes the whole instruction-count deficit of the TU.  It is still
below the w47 identity bar (no FAIL->PASS conversion), so it is a *nudge-plus*; a9 should decide.
INTR_VB is MIXED (1 conversion, 1 regression) -- do NOT wire it TU-wide.

### 2c. `SetRCnt` (2, count exact) + `GetRCnt` (5) -- the JUMP-TO-RETURN canonicalization
Both COUNTER exits are the same single residual class: the oracle reaches its **shared** `jr ra`
by `j .L…` (SetRCnt `j .L800E9F04`, GetRCnt `j .L800E9F3C`), where our build turns the
jump-to-return back into an inline `jr ra` (`jump.c`'s jump-to-RETURN rewrite, enabled because
`mips_can_use_return_insn()` is true for these frameless leaves so `mips_expand_epilogue` emits a
real `(return)` rtx).  FALSIFIED spellings (numbers are gate diffs):
* SetRCnt single-`ret` funnel + `goto out`: 2 -> **26** (the funnel var re-colors the whole fn).
* GetRCnt symmetric `if/else` result-funnel: 5 -> **7** (adds an `andi v0,v0,0xffff` from the
  `long ret` / `unsigned short` field mix).
Angle left: the transform is gated on the epilogue being a real `(return)` insn -- anything that
makes `mips_can_use_return_insn()` false (a frame) would keep the `j`, but these functions have no
frame in retail either, so the honest next step is an instrumented-cc1 `-dj`/jump.c trace.

### 2d. `SetVideoMode` (7, ours 4 / oracle 5) -- the ASSEMBLER-MACRO addressing form
Oracle: `lui $v0,%hi(G); lw $v0,%lo(G)($v0)` (dest-as-scratch) **and** `lui $at,%hi(G);
sw $a0,%lo(G)($at)` -- i.e. the `lw $2,G` / `sw $4,G` **assembler macros**, two INDEPENDENT
materializations, one of them through `$at` (a register gcc never allocates).  Ours CSEs one base
register for both.  Falsified this wave (all gate-measured):
* `extern int g[9]` + `g[0]` (current): 7, `lui v1; lw v0,0(v1); jr ra; sw a0,0(v1)`.
* `-mno-split-addresses`: 7 -- becomes the `la` form `lui v1; addiu v1,v1,0; lw v0,0(v1)`, still
  ONE shared base, still no `$at`.
* `struct VideoModeBlk { int mode; int rest[8]; }` (bare SYMBOL_REF at offset 0, still >-G4 so not
  gp-relative) x `-mno-split-addresses`: 8 -- same `la` form.
* `-G0`: 7 (inert).
Named angle: cc1 only emits the bare `lw $2,sym`/`sw $4,sym` macro when the symbolic address is a
*legitimate memory address* -- on MIPS that is the small-data path.  So the reachable
hypothesis is a **declaration whose size makes the symbol small-data-eligible while the ORACLE's
`%hi/%lo` proves it is not gp-relative in the link** -- i.e. an `asm()`-label view pair
(sized storage decl + a 4-byte scalar view), not yet tried.  a9/consolidator input.

### 2e. `_VSync_wait` (8, count exact 38/38) -- LICM hoist of the message's `%hi` half
Ours hoists `lui $a1,%hi($LC0)` OUT of the spin loop and leaves `addiu $a0,$a1,%lo` at the call;
the oracle materializes the whole address at the call (`lui $a0; addiu $a0,$a0`).  The other 2 of
the 8 lines are the 2a epilogue swap.  Falsified: the w42 asm-label VIEW idiom on the string
(`static const char msg[] = ...` + `extern const char msg_v[] asm("msg")`) -- **8, no change**
(the `la` still splits into high/lo_sum under `-msplit-addresses`); hand-rotated goto loop
(guard + bottom test + `goto` back edge, which kills loop.c) -- **8 -> 11 at count 37**, one insn
short.  Next angle: the loop.c savings/lifetime budget razor (`-dL`), or `-mno-split-addresses`
(7 diffs but count 39, i.e. +1).

### 2f. `PCread` / `PCwrite` residual 23 -- ONE priced flip left
`p80` (`fd`) needs **refs 3 -> 4** (a floor_log2 1->2 step; a single NON-loop-weighted reference)
or **live 42 -> 36**; that alone reorders `fd/(-1)/0x8000` into the oracle's `$s4/$s5/$s6`.
FALSIFIED: `do { n = _SN_read(...); } while (0);` depth wrapper -- **23 -> 43**, because it also
lifts `chunk` 8 -> 9 refs, jumping it above `len` (1.80 vs 1.714) and rotating `$s0`/`$s1`.
A zero-insn +1 ref on a *parameter* that is referenced only inside the loop is the open problem
(the catalog's three inflators -- no-op re-mask, cross-jumped arm duplication, depth wrapper --
all either need an arm/mask that does not exist here or over-lift the neighbours).

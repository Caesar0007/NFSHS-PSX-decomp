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

## 0b. FINAL SCOREBOARD (whole-TU re-gate on the final tree, ZERO regressions)

| | baseline | final |
|---|---|---|
| fns PASS in scope | 1 (`stup0`, mis-reported by the worklist) | **5** |
| fns invisible to the gate | 4 (`__main`, `helper_1/2/3`) | 0 |
| total gate diffs over the 20 measurable fns | 534 | **383** (-151, -28%) |

New PASSes: `__main`, `stup1`, `startIntrVSync_helper_2`, `startIntrVSync_helper_3`.
`2mbyte.obj` is now a COMPLETE object (4/4).
Big movers: `firstfile` 60->16 (count now exact), `_first_patch` 40->9 (all saved-reg roles
oracle-exact), `StopCallback` 47->22, `PCread`/`PCwrite` 39->23 each, `RestartCallback` 31->23,
`startIntrDMA` 14->7, `StartRCnt` 10->7.

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

### 1f. `INTR.StopCallback` 47 -> 22 (count 43 -> 42)
Two independent source levers, whole-TU re-gated, zero regressions:
1. **`I_STAT = I_MASK = 0;` (CHAINED)** -- the oracle stores 0 to I_MASK and then RE-READS it
   (`sh $zero,0($v0); lhu $v0,0($v0); sh $v0,0($a0)`).  That re-read is exactly gcc's *volatile*
   handling of `a = b = 0` (the inner assignment's value is fetched back from the volatile
   lvalue); two separate `= 0` statements emit two independent stores.  **A NEW CATALOG ROW.**
2. methodology 3.25-3c (3rd hit): the DPCR read-modify-WRITE store sits in the
   `jal ResetEntryInt` delay slot; the volatile qualifier blocked reorg's fill.
FALSIFIED: a single named base pointer `IntrState *ip = &g_intr;` used for every field -- exactly
NEUTRAL (22), gcc folds it back.

### 1g. `INTR.RestartCallback` 31 -> 23 (count 31 -> 29)
1. **BRANCH POLARITY**: the oracle skips AWAY on the already-running case (`bnez $v0,.L800F2E5C`)
   and falls straight through into the body, with the `return 0` block out-of-line before the
   epilogue.  `if (inited == 0) { body } return 0;` inverts that; `if (inited != 0) return 0;` +
   an inline body reproduces it.
2. methodology 3.25-3c (4th hit): the saved-DPCR restore store belongs in the
   `jal ExitCriticalSection` delay slot.

### 1h. `FIRST._first_patch` 40 -> 9 -- ALL saved-reg roles now oracle-exact
Three stacked levers, each measured:
1. **GOTO BACK-EDGE on the DCB search loop** (hand-written zero-trip guard + else-arm advance +
   `goto scan`): loop.c emits no LOOP notes, so it can no longer hoist the
   `(high _first_devname)` half out of the loop into a CALLEE-SAVED register.  That hoist cost a
   whole extra saved reg (ours s0..s6 vs the oracle's s0..s5) and rotated every other saved-reg
   role.  **40 -> 26.**  (Declaring `_first_devname` UNSIZED was tried FIRST and is INERT here --
   the array is >-G4 either way, so gcc splits the address regardless.  That is a useful negative:
   the unsized-array lever does NOT reach a LICM hoist of the `high` half.)
2. **UNCOALESCED BOUND COPY**: the oracle computes the table end into a caller-saved temp, tests
   THAT in the zero-trip guard, and copies it into the callee-saved loop bound INSIDE the guard
   (`addu $v1,$s0,$v0; sltu; beqz; addu $s1,$v1,$zero`).  Split `lim` (short-lived) from `end`
   (outlives it) so `make_regs_eqv` keeps the copy.  **26 -> 20.**
3. **LIVE-RANGE DEMOTE via statement POSITION** (allocsim dial, dumps read not guessed):
   p80 (`state`) refs 4 / live 60 = pri .1333 vs p87 (`saved`) refs 2 / live 14 = .1428, so
   `saved` was taking `$s2` and `state` `$s3` -- the oracle has them the other way.  Assigning
   `saved = _first_save;` as the FIRST statement lengthens its live range past the flip point.
   **20 -> 9**, and every saved-reg role (state $s2, saved $s3, args $s4/$s5, e $s0, end $s1)
   matches.  Three later positions (after the div / after `e =` / after `lim =`) all measure 20 --
   the dial is the statement POSITION, exactly as the w45 basin law predicts.
Residual 9: a `sw $ra` prologue-save position, the `lui $s3/lw $s3` pair scheduled 6 insns early,
and two oracle-only insns (a speculative `addu $a0,$s2,$zero` in the guard delay slot, later
recomputed, + an unfilled nop after `beqz $a0`).

### 1i. `FIRST.firstfile` 60 -> 16, count now EXACT 103/103
1. **GOTO back-edges on BOTH DCB searches** + **`found` assigned in the two EXIT paths** (never
   before the loop, so it never lives across `strcmp` and stays caller-saved -- the oracle's
   `addu $v1,$zero,$zero` / `li $v1,1` / `bnez $v1`).  Frame 48 -> 40, saved set s0..s5 -> s0..s3,
   both now oracle-exact.  **60 -> 35.**
2. **OUT-OF-LINE MATCH HANDLERS**: the oracle branches TO the match handler
   (`beqz $v0,<block after the loop>`) and falls through into the advance.  An inline if-body
   inverts that.  Written `if (match) goto hitN;` + the handler block after the loop, both passes.
   **35 -> 18 -> 16**, instruction count now oracle-exact.
Residual 16: the `p = _first_devname` prologue address uses a separate `%hi` scratch
(`lui $v0; addiu $a0,$v0,0`) where the oracle self-temps (`lui $a0; addiu $a0,$a0,0`) -- the
canonical 3.15 HI-scratch class -- plus a 3-insn ordering difference inside the pass-2 hit block.

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

### 2g. NOT ATTACKED this wave (budget) -- current gate numbers, no work done
`_intrhand` 80 (112/116), `_set_intr_callback` 34 (80/82), `_initIntr` 41 (55/54),
`VSync` 45 (95/94), `_dma_isr` 16 (94/96).  ALL FIVE carry the same `-msplit-addresses`
{high, lo_sum} signature seen in StopCallback/RestartCallback (an extra callee-saved register
holding the shared `(high g_intr)` half); `_initIntr` additionally shows the oracle REBASING its
`g_intr` pointer to `g_intr+60` mid-function (`addiu $a0,$s0,-4` / `sw $v0,0($s0)` /
`sh $v0,-60($s0)` / `addiu $s0,$s0,-60` at the end) -- i.e. the base anchor is
`&g_intr.jmpbuf[1]`, a source-reachable pointer-anchor choice, not a floor.  These are the
obvious next targets and they are exactly the TU the 2b table recommends for
`-mno-split-addresses`.

## 3. NEW CATALOG ROWS EARNED THIS WAVE (for the consolidator)

1. **`a = b = 0` on VOLATILE lvalues emits a RE-READ** -- `sh $zero,0(p); lhu $v0,0(p);
   sh $v0,0(q)`.  Symptom: the oracle stores a constant to one volatile and then *loads it back*
   before storing to a second; two separate `= 0` statements can never produce it.
   (INTR `StopCallback`, `I_STAT = I_MASK = 0`.)
2. **methodology 3.25-3c generalizes hard**: "cast the volatile away on an MMIO STORE whose
   oracle sits in a delay slot" hit FOUR times in one small cluster (StartRCnt/jr-slot,
   startIntrDMA/jal-slot, StopCallback/jal-slot, RestartCallback/jal-slot).  Whenever a syslib
   near-miss shows `store; jal/jr; nop` against an oracle `jal/jr; store`, check the store's
   volatility FIRST -- it is the cheapest lever in the cluster.
3. **A `goto` back-edge is the anti-LICM-address-hoist lever** (new use of the known goto-loop
   row): when a call inside a loop takes a GLOBAL's address as an argument, `-msplit-addresses`
   gives loop.c a `(high sym)` movable that it parks in a callee-saved register, costing a whole
   saved reg and rotating the frame.  A goto back-edge emits no LOOP notes, so the address
   materializes at the use site (`lui $aN; addiu $aN`) exactly like retail.
   **The unsized-array declaration lever does NOT reach this** (falsified on `_first_devname`).
4. **A boolean flag set BEFORE a loop and tested after it is a saved-register tax** -- assign it
   in the loop's two EXIT paths instead so it never crosses the call (firstfile `found`,
   -1 saved reg + frame -8).
5. **`return VAL;` duplicated instead of `break` is a zero-insn REF INFLATOR** (4th member of the
   w44 floor_log2 family, alongside the no-op re-mask / arm duplication / depth wrapper): the
   in-loop copy is loop-depth-weighted, so it delivers +2 refs where the others deliver +1 or
   over-lift the neighbours.  `cross_jump` merges the tails back, count unchanged.
   (PCread/PCwrite, reqdelta-predicted.)
6. **Symbol-span bookkeeping for hand-asm TUs**: when a SYM span ENDS before a trailing pad word,
   LABEL the pad (`D_<addr>:`) instead of deleting it -- objdump attributes bytes to the preceding
   symbol, so a label is the only way to keep the byte AND get the symbol length right.
   (2mbyte `stup1`.)
7. **A "0.00%" worklist row is most often a NAME PHANTOM, not a hard function.**  3 of the 4
   0.00% rows in this scope were `NOT IN OBJECT` (two descriptive-name mismatches + one function
   that did not exist in the TU at all); fixing them cost minutes and yielded 2 instant PASSes.
   Grep every 0.00% row against `nm`/the oracle `.s` filename BEFORE planning any codegen work.

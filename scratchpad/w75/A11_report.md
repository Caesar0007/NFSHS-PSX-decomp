# W75-A11 report — game-misc belt (bworld / nfs3 / cario)

Repo `C:\Temp\nfs4-decomp`. No commits, no staging. `tools/build.py` untouched (the
uncommitted foreign edit is preserved verbatim). Memory dir read-only, unmodified.

## Baseline → final (gated TWICE at each end, identical both times)

| fn | TU | baseline | final | delta |
|---|---|---|---|---|
| `SetupChunkBuildList__FP13DRender_tView` | game/common/bworld | FAIL 4 @203/203 | FAIL 4 @203/203 | 0 |
| `NFS3_CheckForFileOperations__Fv` | game/common/nfs3 | FAIL 2 @21/21 | FAIL 2 @21/21 | 0 |
| `CarIO_ReadInCarTextureData__FPcP8Car_tObjii` | game/psx/cario | FAIL 19 @492/491 | FAIL 19 @492/491 | 0 |

Whole-TU gates, before and after, twice each:
`bworld 20/21 PASS`, `nfs3 10/11 PASS`, `cario 10/11 PASS`.
**ZERO PASS→FAIL anywhere.** No function sealed this belt; all three carry a NEW
named angle plus new falsifications (NO-FLOORS rule).

Note on the brief's premise for target 2: the board name is
`NFS3_CheckForFileOperations__Fv` (the plain name returns `NO ORACLE`), and the
W72 bworld TEXT_MOVES row is already wired — the current bworld baseline is 4
@203/203 (count-exact), not the 7 @202 of the pre-row basin.

Re-baseline of the whole cario TU after the user's "Restore exact SYM type graph
for CarIO" commit: **10/11 PASS, zero regressions**; `ReadInCarTextureData` is the
only FAIL and it is at its recorded 19 @492/491.

## Source changes landed

**Comments only.** All three `.cpp` diffs vs their pre-belt state are a single
receipt line replaced by a receipt block; the code text is byte-identical (verified
by diff). Gates re-run after every edit.

## NEW INSTRUMENT (reusable)

`scratchpad/w75/vprobe_flag.py` — a generic **per-FUNCTION arbitrary-cc1-flag
splice**, built by wrapping `build.py::_apply_fn_splice` (whose flag list is a
hard-coded 5-tuple, so no existing env hook could reach a new flag).

```
W75_FN_FLAG='{"recon/<tu>.cpp": {"-fno-caller-saves": ["MangledFn"]}}' \
  python scratchpad/w75/vprobe_flag.py recon/<tu>.cpp MangledFn
```

It dual-compiles the same `.i`, extracts the named function's region from the
flagged `.s`, uniquifies its local labels and splices it in — i.e. exactly the
mechanism behind `PER_FN_NO_SPLIT_ADDRESSES` / `PER_FN_FORCE_ADDR`, but for any
flag, with no build.py edit. This opened a flag axis that had never been swept
per-function on any of the three targets.

## Target 2 — nfs3 `NFS3_CheckForFileOperations__Fv` (2 @21/21)

Residual: ours `addu a3,a2,zero`, retail `addu a0,a2,zero` (one instruction).

### The reload model is now VALIDATED BY PREDICTION (the headline result)

Read off `gcc-2.8.1-src/extracted/reload1.c`, not probed:

* `order_regs_for_reload` (:3840) builds `potential_reload_regs` in **three runs**
  (MIPS defines no `REG_ALLOC_ORDER`): **[1]** `hard_reg_n_uses==0 && call_used`,
  **ascending regno**; **[2]** `uses==0 && !call_used`; **[3]** `uses!=0`, qsorted
  by *increasing* uses. Fixed regs and every `regs_explicitly_used` reg get
  `uses += large+1` and enter `bad_spill_regs` (:3888-3903).
* `allocate_reload_reg` (:5083) walks `spill_regs` **round-robin from the
  function-global cursor** `last_spill_reg` (reset to −1 at :823):
  `i = (i + 1) % n_spills`, advanced **per reload**, not per insn.

Ours: pseudos occupy `$v0,$v1,$a0`(G = guard bound)`,$a1`(L = loop bound) ⇒ run[1]
starts 6,7 ⇒ `n_spills=2`, `spill_regs=[$a2,$a3]`, cursor −1 ⇒ trap operand0→`$a2`,
operand1→`$a3`. Exactly what we emit.

**Prediction test.** Adding `: "$7"` to the trap asm must push `$a3` into
`bad_spill_regs`, make `spill_regs=[$a2,$t0]`, and turn operand1 into `$t0`.
**Measured: FAIL 2 @21/21 with `-addu t0,a2,zero / +addu a0,a2,zero`.**
Predicted == measured. (Reverted.) The model is an oracle for this residual.

### The exact requirement (supersedes W74's wording)

Retail's pair is `spill_regs[1]` **then** `spill_regs[0]` — a **wrap** — which forces
*both* (a) `spill_regs=[$a0,$a2]`, i.e. `hard_reg_n_uses[$a0]==0` (no pseudo
allocated to `$a0` anywhere), *and* (b) an **earlier reload** so the cursor already
sits at index 0. One fact gives both: retail's guard bound **G is unallocated with
`REG_EQUIV(mem gFileDevice+0x1C)`**, so `lw a0,0x1C(v0)` *is* that earlier reload and
`addu a1,a0,zero` is reload **inheritance** feeding L. W74 stated the two halves as
separate dials; they are one.

### Why no device buys it (certificate sharpened, all source-cited)

* A clobber only ever **removes** a register from the pool ⇒ cannot free `$a0`.
* Demotion via `REG_LIVE_LENGTH` is unreachable from C: `flow.c:1179/1200` set −1
  only for setjmp-live pseudos; `global.c:558` honours −2 only for parameters; with
  3–4 allocnos and ~20 free regs `global.c:561 find_reg` always succeeds.
* `local-alloc.c`'s `reg_equiv_replace` escape needs `REG_N_REFS==2 &&
  REG_BASIC_BLOCK<0`; our G has **three** refs (set + guard test + preheader copy)
  and its set/use share a block.

### Falsified this wave (every one a real gate run, all 2 @21/21 unless noted)

* **per-fn `-mno-split-addresses`** — *the very angle W74 named as next* — **6 @21/21**.
  It folds `+0x18/+0x1C` into the address (loads become `0(v0)`/`4(v0)`) and leaves
  the `a3`-vs-`a0` pick unchanged, i.e. it does not demote G.
* **per-fn cc1 flag sweep (new axis, 16 flags)**: `-fno-expensive-optimizations`,
  `-fno-caller-saves`, `-fno-rerun-cse-after-loop`, `-fno-cse-follow-jumps`,
  `-fno-cse-skip-blocks`, `-fno-thread-jumps`, `-fno-force-mem`, `-fno-peephole`,
  `-fno-function-cse`, `-fno-inline`, `-fno-defer-pop`, `-fno-strength-reduce`,
  `-fno-schedule-insns`, `-fno-schedule-insns2`, `-G0`, `-G8` — **all exactly 2
  (inert)**; `-fno-omit-frame-pointer` 9 @26. **Flag axis CLOSED.**

### Next named angle (unwalked)

A source shape where the guard bound is never a pseudo — the guard test carrying the
MEM directly, the loop bound a separate pseudo — so G's references collapse to one
reload plus inheritance.

## Target 1 — bworld `SetupChunkBuildList` (4 @203/203)

Residual: the `%hi` scratch of `BWorld_gChunkBuildList`, ours `$v0` vs retail `$v1`
(`lui X,%hi; addiu s1,X,%lo`).

### Angle (e) — the one the W74 receipt named as unwalked — WALKED AND FALSIFIED

Spelling the walker as an **index form born in the loop**
(`buildList = (volatile tBuildEntry *)BWorld_gChunkBuildList + chunkCount;` inside
the innermost visible-block, `buildList++` deleted, head-block init removed) so
loop.c would drop the base in the **preheader**: gate **FAIL 134 @201**. Strength
reduction does rebuild a walker but drops a callee-saved register (frame 136 vs
retail's 144, `s4/s5` re-roled) and re-colors the body. Not a basin.

Side result: the volatile worry is void — `loop_has_volatile` is consulted **only**
by the loop-*reversal* gate (`loop.c:6070`); it never blocks invariant hoisting.

### NEW LAW — why the `%hi` pair is immune to source statement order

W72/W74 both observed "moving the statement gives byte-identical cc1 output" without
a mechanism. It is a scheduling law: both scheduling passes are **reverse list
schedulers** (W72's own correction — `priority()` walks `LOG_LINKS` = predecessors,
so `INSN_PRIORITY` is the longest chain from the block **TOP**, and the first insn
picked becomes the block **TAIL**). An address materialization has **no in-block data
predecessor**, so `lui %hi` has priority 0 and `addiu %lo` priority 1 — the two
lowest in this 28-insn head block — hence they are picked last and land first,
regardless of where RTL generation emitted them. The immunity is a property of the
insn's *dependence depth*, not of the statement position.

### Requirement, restated so it can be attacked

W74-A10(b) fixed the arithmetic: retail's `$v1` needs a rival qty with
`pri = refs*floor_log2(refs)*10000/life > 10000` spanning the pair, i.e. `refs>=4`
and `life<=7` — only this block's `qty5` (the `Track_gInViewCount`
address+load+store chain, refs 4 / life 6 / window `[22,28)`) qualifies. Combined
with the law above: **the pair can only reach that window by acquiring an in-block
DATA PREDECESSOR chain of depth >= 3**, because nothing else raises its
`INSN_PRIORITY`. No known zero-byte device supplies a *predecessor* — W69's launder
chain was measured in the *successor* direction and costs a real `addu` per link past
depth 1 — and every asm in this head costs >= 20 diffs. That is the next named angle.

### Also falsified: per-fn cc1 flag axis (never swept for this fn)

`-fno-expensive-optimizations`, `-fno-caller-saves`, `-fno-rerun-cse-after-loop`,
`-fno-cse-follow-jumps`, `-fno-cse-skip-blocks`, `-fno-thread-jumps`,
`-fno-peephole`, `-fno-function-cse`, `-fforce-addr` = **4 @203 (inert)**;
`-fno-force-mem` 21 @202. **Flag axis CLOSED.**

## Target 3 — cario `CarIO_ReadInCarTextureData` (19 @492/491)

### The W74-A13 conclusion is REFUTED

W74 closed this fn with "RETAIL'S POOL CONTAINS `$v0` AND OURS DOES NOT ⇒ the only
route is to lower `hard_reg_n_uses[$v0]` for the whole body". That is **impossible**:

* `order_regs_for_reload` run[1] = `uses==0 && call_used`, **ascending**, and run[3]
  comes after *every* zero-use register.
* Oracle register census of `asm/nonmatchings/main/<fn>.s`:
  `v0 184 | v1 83 | t0 46 | t1 45 | t2..t9 **0** | a0 31 a1 27 a2 12 a3 11`.
  So retail's run[1] already contains eight zero-use registers (`$t2..$t9`).
* For `$v0` to be a spill reg it would have to have **zero** allocated-pseudo refs —
  yet retail computes real values into `$v0` with **no spill store around them**
  (`andi v0,t1,16; bnez v0`, `lhu v0,2240(t1)`, `sll v0,v1,16`). An *unallocated*
  pseudo's def must be followed by a store to its home; there is none.
* And even granting it, `$v0`=2 sorts before `$t0`=8 ascending, so the head-block
  pair would be `($v0,$v1)`-flavoured, not retail's `($v0,$t0)`.

⇒ **retail's pool is `{$t0,$t1}`, exactly like ours**, and `lw v0,0(gp)` in the head
block is an **allocated pseudo**, not a spill reload. The live route reverts to the
w41 reading (i), which W74 had discarded.

### What that makes coherent

Our head block consumes **two** pool slots (`$t0` for the value, `$t1` for the
`carObj` ARG reload); retail consumes **one** (`$t0` for `carObj`; the value lives in
an allocated pseudo `$v0`). One extra round-robin step at insn ~105 de-phases
`allocate_reload_reg`'s cursor (`i=(i+1)%n_spills`, reload1.c:5091) for the remaining
~380 insns — and the landed `r`-fence re-phases it by consuming one *more* slot at
the join. That is the causal statement behind w74's "buys the right answer with the
wrong evidence", and it predicts that creating the missing temp would also make the
fence (and its +1 insn) unnecessary ⇒ 491 count-exact.

Retail's RTL must be
`(set (reg T) (mem gprel)) ; (set (reg 88) (reg T)) ; (set (mem field) (reg T))`
with `T` in `$v0` and 88 memory-homed (so the copy prints as `sw v0,68(sp)`).
Ours has no `T` at all (`rtl_dump -dl`: `(set (reg/v:SI 88) (mem (symbol_ref ...)))`).

### Falsified this wave (real gate runs, from the 19 basin)

* **memory-resident-from-the-start**: `(void)&carPixMapCount;` in place of the fence
  (make the local addressable, so the value necessarily gets its own temp) —
  **466 @499**; `put_var_into_stack` reshapes the whole frame. The temp must come
  from the expression, not from the variable's storage class.
* **the merger is NOT `optimize_reg_copy_1/2`**: with `int n = CarIO_carPixMapCount;
  carPixMapCount = n; field = n;` **plus** per-fn `-fno-expensive-optimizations`
  (which disables both copy optimizers) the head block *still* emits `lw t0,0(gp)`
  (87 @492 overall). `T` is collapsed into pseudo 88 earlier than local-alloc — at
  expand/cse — so an escape has to be tree-level. (Named temp alone re-confirmed
  inert at 19.)
* **field re-read** (`field = CarIO_carPixMapCount; carPixMapCount = field;` in the
  then-arm — semantically identical and the one shape that structurally *must* mint
  a temp): **169 @492**; it reverses the two stores so reorg steals the wrong one
  into the `j` delay slot.
* **per-fn cc1 flag axis (new)**: `-fno-caller-saves` 19, `-fno-thread-jumps` 19,
  `-fno-peephole` 19, `-fno-function-cse` 19 (inert); `-fno-cse-follow-jumps` 27
  @496, `-fno-cse-skip-blocks` 32 @497, `-fno-rerun-cse-after-loop` 33 @498,
  `-fno-force-mem` 41 @492, `-fno-expensive-optimizations` 87 @492. Nothing under
  19. **Flag axis CLOSED** (complements w74's per-TU row, which covered a different
  six).

### Next named angle (unwalked, and now the only one)

A head-block spelling in which the loaded value and the memory-homed local have
**overlapping live ranges** (catalog 22C-7) so cse/copy-prop cannot collapse `T` into
pseudo 88 — every `int n` form tried so far leaves them sequential, which is exactly
the condition 22C-7 says keeps them one qty.

## Catalog-worthy items for the orchestrator

1. **RELOAD SPILL-POOL LAW (validated by prediction).** `order_regs_for_reload`'s
   three runs (uses==0 call-used ascending / uses==0 callee-saved / uses!=0 by
   increasing uses) + `allocate_reload_reg`'s `i=(i+1)%n_spills` cursor **fully
   determine** which scratch every reload gets. A hard-reg clobber shifts the pool by
   removing one member — predicted and confirmed insn-exact on
   `NFS3_CheckForFileOperations` (`"$7"` ⇒ `$a3`→`$t0`). Use it to *derive* the
   required pool instead of sweeping devices.
2. **POOL-MEMBERSHIP FALSIFIER (cheap, one objdump).** A register can be in the
   retail spill pool only if **no pseudo is allocated to it anywhere**. Census the
   oracle: any register that receives a computed value with no store to a home is an
   allocated pseudo ⇒ it is NOT in the pool. This one check refuted a standing
   whole-function certificate on cario.
3. **ADDRESS-MATERIALIZATION HEAD LAW.** A `%hi/%lo` pair with no in-block data
   predecessor has `INSN_PRIORITY` 0/1; the reverse list scheduler therefore always
   places it at the block head, immune to statement order. Explains a class of
   "byte-identical cc1 output" observations. Moving such a pair needs a *predecessor*
   chain, not a barrier, a fence or a reorder.
4. **NEW INSTRUMENT**: `scratchpad/w75/vprobe_flag.py`, generic per-FUNCTION cc1 flag
   splice (`W75_FN_FLAG`). Promote to `tools/` — the per-fn flag axis was unswept on
   all three of this belt's targets and is now closed on all three (35 flag runs).
5. **`loop_has_volatile` does NOT block invariant hoisting** (loop.c:6070 — it gates
   loop reversal only). Retires a plausible-sounding blocker for any volatile-store
   loop.

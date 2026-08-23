# W75-A15 REPORT — libgpu belt (`_gpu_que_drain`, `FntFlush`)

**Result: `_gpu_que_drain` 10 → 6 (count-exact, source-only); `FntFlush` held at 2 with its
6-wave certificate's MECHANISM REFUTED by the compiler's own dump. Zero PASS→FAIL anywhere.**

> ⚠️ POLICY: mid-belt the orchestrator relayed the 2026-08-23 user policy — **post-recompile
> instruction rewrites are FORBIDDEN**. A two-row `PER_FN_TEXT_MOVES` relocation for
> `_gpu_que_drain` had already been built, probe-verified and wired (**PASS 152/152, wordcmp
> REAL=0, brdist clean, TU 44/44**). **It was removed again**; `tools/build.py` now carries only
> the peer/foreign edits (verified by `git diff`). Everything shipped below is source-only.

| fn | unit | baseline | final (shipped) | gate runs |
|---|---|---|---|---|
| `_gpu_que_drain` | syslib/psx/libgpu/SYS | FAIL 10 @152/152 | **FAIL 6 @152/152** (posmis 6) | 2× fn, 4× whole-TU |
| `FntFlush` | syslib/psx/libgpu/FONT | FAIL 2 @199/199 | FAIL 2 @199/199 (held) | 2× fn, 4× whole-TU |

`recon/syslib/psx/libgpu/SYS.c`: 43/44 PASS (unchanged; the 44th is now −4 diffs).
`recon/syslib/psx/libgpu/FONT.c`: 1/2 PASS (FntPrint held).

---

## 1. `_gpu_que_drain` — 10 → 6, count-exact (source cell)

### The cell: retail's volatile read order × a clobber register nobody had tried

The three `_qout` reads are **volatile**, so their TEXT order *is* their SOURCE order once `fidx`
is counted as the first read. Reloc addends give the mapping (`_que+0 = .func`, `+4 = .arg`,
`+8 = .extra`): retail = **func, arg, extra**; ours was **func, extra, arg**. Swapping to
`arg`-before-`extra` alone is the banked "aef" row (18) — but that row had only ever been measured
**with the `"$2"` clobber inherited from the W72 landing**. The clobber *register* is a free axis.
Grid (`scratchpad/w75/a15_grid.py`, 8 clobber sets × 3 positions):

```
none 24/24/24   $v0 18/18/18   $v1 24/24/24   $a0 22/28/28
$a1 14/14/ 6    $a2 24/24/24   $v0+$a2 18/18/18   $a2+$v1 24/24/24     (p0/p1/p2)
```

Single minimum — **`"$5"` ($a1), placed AFTER both field reads** — shipped as:

```c
fidx = _qout * 96;
arg   = _que.plain[_qout].arg;
extra = _que.plain[_qout].extra;
__asm__("" : "=r"(fidx) : "0"(fidx) : "$5");
func  = *(QueFunc *)((char *)_que.plain + fidx);
```

Mechanism: denying `$a1` to `fidx`'s launder collapses the handout so only **two** `_qout` reloads
are live at once and the third **reuses the first's register** — retail's exact 2-register shape
(ours previously needed three: `$a2,$a1,$v1`). Position is the second half of the dial (22B-1).
Confirmed in grid 2 (`a15_grid2.py`): adding `$a2`/`$a3`/`$t0` to the clobber set is **bit-for-bit
inert at 6**; the dial is *exactly* the `$a1` denial.

### The residual 6, characterised (DIAGNOSTIC only — no row shipped)

```
ours   : [sll $3,$3,5] [lw $5,_qout] [lw $4,_que+4($2)]
retail : [lw $4,_que+4($2)] [lw $5,_qout] [sll $3,$3,5]
```

23D-2 pre-flight **PASSES** (same words, same registers, no `.set`/label/branch moved) — which is
what the W64/W72 receipts said it did *not* (their rejection was register-based and is now stale).
So the target for any future **source** dial is precise: sink BOTH the third volatile `_qout`
reload and the func chain's closing shift below the `.arg` field load. Registers already agree; it
is purely sched1 emission position.

### Axes CLOSED (measured here; never measured for this fn before — and re-run in BOTH basins per 04Z)

* **COMPILER VERSION** (per-fn `CC1_VER_SPLICE_272`), 10-basin | 6-basin: 2.6.0 26|22 ·
  2.6.3 26|22 · 2.7.2 20|16 · 2.7.2-970404 141@151|135@151 · **2.8.0 10|6** · 2.8.1 (wired) 10|6 ·
  2.91.66 97@161 · 2.95.2 82@156. No rung wins ⇒ the 04M/W73 *"whole-fn PsyQ-4.0 (2.7.2) codegen
  matches retail"* precondition **FAILS**, so `PER_FN_RAW40_SPLICE` is inapplicable — and it is
  additionally **unreachable in this lane**: the raw40 mechanism lives only in `compile_c`'s
  **maspsx** branch, and SYS.c is a `cc1_alt=2.8.1` / 272-recipe TU.
* **FLAGS** (per-fn `FLAG_SPLICE_272`), 10-basin: `-fno-strength-reduce`,
  `-fno-expensive-optimizations`, `-fforce-mem`, `-fno-cse-follow-jumps`, `-fno-cse-skip-blocks`,
  `-fno-thread-jumps`, `-fno-peephole`, `-fno-function-cse`, `-fno-caller-saves`, `-fcaller-saves`,
  `-fno-defer-pop`, `-fno-inline`, `-G4`, `-G8` **all inert at 10**; `-fno-rerun-cse-after-loop`
  23@155; `-fforce-addr` 128@162. 6-basin: `-fno-schedule-insns` 64@154 · `-fno-schedule-insns2`
  12@154 · `-fno-delayed-branch` 19@155 · `-fno-rerun-cse-after-loop` 24@156 ·
  `-fno-expensive-optimizations` 26 · the rest inert at 6. ⇒ **the 3.25-3b delayed-branch identity
  class is not this fn's, on either basin.**
* **BRIEF hint — the W72 `reload_cse` donor tell** (`addu rD,rS,zero` where retail has `li/lui`):
  **ABSENT** here (the 10 diffs were 5 reload/chain lines, no copy-vs-constant divergence), so the
  `_dws`/`_drs` cure correctly does not apply to this fn.
* **SOURCE, falsified this pass:** interleaved `_qout*3`+`<<5` split across the arg read
  (8 arrangements, `a15_S{1..8}.json`) 19–21 @**151**; `<<5` moved into the func-read statement
  21–24; E-before-A order with the `$a1` clobber 10–11; A/F/E order 11–14.

---

## 2. `FntFlush` — held at 2; the standing certificate's MECHANISM is REFUTED

### 🔴 W74-A17's attribution (choose_reload_regs inheritance) is wrong — proof by dump

The `-dg` post-reload RTL (`scratchpad/w75/a15_FONT_base.greg`), printed by `toplev.c` **before**
`reload_cse_regs` runs — which is exactly what makes it the discriminator — contains, adjacent:

```
(insn 547 (set (mem:SI (plus (reg sp) (const_int 16))) (reg:SI 6 a2)))
(insn 117 (set (reg:SI 4 a0) (mem:SI (plus (reg sp) (const_int 16)))))
```

**Reload already emits retail's `sw $a2,16($sp) ; lw $a0,16($sp)` verbatim — there is no
inheritance and never was.** The copy is manufactured afterwards by **`reload_cse_regs`**
(`toplev.c:3501`, `if (optimize > 0)`, no `-f` switch): `reload_cse_simplify_set`
(`reload1.c:8178`) rewrites `(set hardreg MEM)` into a copy from the **lowest-numbered** hard reg
whose recorded value equals that MEM (`for (i = 0; i < FIRST_PSEUDO_REGISTER; i++)` at :8203, gated
only by `MEMORY_MOVE_COST >= 2` / `REGISTER_MOVE_COST == 2`, both fixed on MIPS). `$a2` still holds
the value, so the load becomes `move $4,$6`; **sched2 then swaps it above the store**, giving our
`addu $a0,$a2,$zero ; sw $a2,16($sp)`. ⇒ FntFlush is the **MEM flavour of catalog 23A-2**, the same
pass that sealed `_dws`/`_drs` in the sibling TU.

### Why no source device can win (quantified from the pass)

`reload_cse_regs`'s record for `$a2` is cleared in exactly three places — `reload1.c:7899`
**CODE_LABEL**, `:7929` **CALL_INSN** (call-used regs), `:7786` `reload_cse_invalidate_rtx` via
`note_stores` (**any** insn writing `$a2` or storing to an aliasing MEM). The store and the load are
**adjacent by construction** (output reload of `dr`, then the call's input reload), so there is no
window for any of the three — which is why W74's branch probe worked (+2 insns) and why every
colour-default relocation costs +1. Naming `"$6"` in an asm stays self-defeating (16B
`bad_spill_regs` function-wide).

### Falsified this pass (all gated, all reverted)

* 🆕 **zero-insn PRESERVED-LABEL device** `{ void *lp = &&term; (void)lp; } term:` before the call
  (and its `if (lp == 0) goto term;` variant): **2 @199, inert** — the dead label-address set is
  DCE'd and jump.c then deletes the label, so **no CODE_LABEL survives to reload_cse**. The device
  is real but needs an *escaping* reference, which costs code.
* 🆕 **zero-insn ADDRESS-TAKING device** `(void)&dr;` (3 positions): **38 @199 count-exact** — the
  side-by-side shows why it can never win: `dr` leaves the spilled-pseudo pool for the
  address-taken-scalar pool (16A frame-order sub-law), its slot moves 16 → 36 and every other slot
  shifts, **and** cse store-forwards the memory home anyway, so the copy survives.
* **PER-FN VERSION LADDER re-measured in this basin** (maspsx-lane `PER_FN_CC1_VER_SPLICE`):
  2.6.3 98@201 · 2.7.2 85@200 · 2.7.2-970404 27@200 · **2.8.0 2@199** (ties the wired 2.8.1) ·
  2.91.66 178@205. No rung wins — even though the 23A-2 fingerprint says 2.6.x/2.7.2 **lack
  `reload_cse_regs` entirely**: those rungs lose the whole-fn shape.
* **TEXT_MOVES pre-flight, run first as the BRIEF asked: FAILS** — the two words differ in
  **opcode** (`addu` vs `lw`), so the diff is not a line-multiset permutation. (Moot under the new
  policy, which also retires W74's "per-fn POST-cc1 line rewrite" ask as the forbidden class.)

**Standing angle (the only legitimate one left):** a compiler-INPUT lane that is 2.8.0 in every
pass **except** `reload_cse_regs` — i.e. a ladder rung or a rebuilt cc1 with that one call
disabled. The pass has no `-f` switch, so this is a toolchain build item, not a source item.

---

## 3. NEW LAWS / corrections for the catalog

1. **🏆 `.greg` IS THE reload-vs-`reload_cse_regs` DISCRIMINATOR (one run, zero risk).** `toplev.c`
   prints the global-reg dump **before** `reload_cse_regs`. `.greg` showing the ORACLE's insn while
   the `.s` shows ours proves the actor is `reload_cse_regs` (`toplev.c:3501`), **not** reload.
   Every standing *"reload-inheritance / choose_reload_regs"* verdict should be re-checked this
   way; the first one checked (FntFlush, a 6-wave certificate) was wrong.
2. **🏆 The 20B clobber REGISTER is an axis independent of position and operand.** A banked
   read-order/spelling row measured with an *inherited* clobber is **not** closed — re-price it
   across the clobber-register grid after any landing that put a clobber in the function.
   (`_gpu_que_drain`: the same source shape is 24 with no clobber, 18 with `"$2"`, **6** with
   `"$5"` — a 3-way spread on one token.)
3. **A "not a pure relocation" rejection is BASIN-RELATIVE (04Z for the pre-flight).** The
   rejection is a statement about *registers agreeing*; any lever that fixes the register handout
   can flip it. Re-run the 23D-2 pre-flight after every allocation-side landing — as a diagnostic
   now that rows are forbidden, since a PASSING pre-flight tells a source dial exactly what to move.
4. **The reload-inheritance invalidator list has a 5th member** (`forget_old_reloads_1`,
   `reload1.c:4253-4292`): *"Storing into a spilled-reg invalidates its contents"* — **any** ordinary
   insn writing the hard reg, not only another reload. (W74's list was cited as exhaustive; it is
   not. Not load-bearing here once the mechanism was corrected.)
5. **`PER_FN_RAW40_SPLICE` scope, restated from the code:** the mechanism exists only in
   `compile_c`'s **maspsx** branch — a `cc1_alt`/272-recipe TU cannot use it at all. Its per-fn
   equivalent there is `PER_FN_CC1_VER_SPLICE_272`, and the PADSEQD scope rule (whole-fn 4.0
   codegen must match retail) is tested by laddering that splice, which is what was done here.

## 4. Files touched
* `recon/syslib/psx/libgpu/SYS.c` — the 4-line source cell (10 → 6) + a W75-A15 receipt block.
* `recon/syslib/psx/libgpu/FONT.c` — receipt block only (mechanism correction; **no code change**).
* `tools/build.py` — **net zero from me**: two rows were added, probe-verified, then removed under
  the new policy. The uncommitted foreign edit (stale psxcontroller rows) is preserved; peers'
  concurrent edits untouched. No commit, no staging.
* `scratchpad/w75/a15_*` — probe harnesses, case files, grids, `.greg`/`.s` dumps, side-by-sides
  (all untracked names).

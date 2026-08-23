# W75-A18 -- libmcrd belt (LIBMCRD.c, cc1_272 lane)

## Headline

| fn | baseline | final | verdict |
|---|---|---|---|
| MemCardDeleteFile  | FAIL 2  @109/111 | **PASS 111/111** | 🏆 SEALED (gated 3x; strict_branch 11/11 branch words CLEAN) |
| MemCardCreateFile  | FAIL 6  @128/130 | **FAIL 4 @130/130 COUNT-EXACT** | -2, residual = ONE named row, blocked on a USER POLICY decision |
| MemCardGetDirentry | FAIL 23 @153/152 | FAIL 23 @153/152 | unchanged; the standing (b)+(c) rows PROVEN to be one mutually-exclusive cell, new named angle filed |

Whole TU: **23/26 -> 24/26 PASS**, zero PASS->FAIL, gated twice at the close.
Source delta = **3 lines of C** (plus receipts); `tools/build.py` NOT touched (its
uncommitted foreign edit -- the psxcontroller TEXT_MOVES removal -- is intact).

## 1. THE LANDING: the three-read volatile cell in `MemCardSyncAt` (3 lines)

```c
cmd  = *(volatile int *)&base[0];
rslt = *(volatile int *)&base[1];
...
if (*(volatile int *)&base[2] == 0) {   /* the zero-trip guard on `done` */
```

Retail's shape (MemCardDeleteFile @0x800FBF28) is three consecutive reads, in source
order, ALL into `$v0`, followed by the guard load's own load-delay `nop`:

```
lw $v0,0x0($s0)   <- cmd    (dead in the mode==0 instantiation)
lw $v0,0x4($s0)   <- rslt   (dead)
lw $v0,0x8($s0)   <- the `done` zero-trip guard
nop
bnez $v0,...
```

Five prior waves (W71/W72/W74) priced the two dead loads as a **local-alloc handout**
problem ("make the second dead load reuse `$v0`") and every dial -- named temps, shared
temps, read-only fences, identity launders, `"i"(0)` hard-reg clobbers on
`$2/$3/$4/$8` -- measured INERT, with volatile-on-the-two-reads reading as
"count-exact but +1 diff".

**It was never a register handout.** With only `base[0]`/`base[1]` volatile, ours emitted
`0 / 8 / 4`: sched1 is free to sink the PLAIN 8-load past the volatile 4-load, and then
uses the 4-load to FILL the 8-load's load-delay slot. That simultaneously (a) deleted
retail's `nop` (one insn short, 110/111) and (b) forced the second dead value into `$v1`
(its live range now spans the guard load's `$v0`). Both halves of the "+1" come from one
scheduling decision, not from the allocator.

The cure is the THIRD volatile, not a dial. With all three reads volatile, sched1 may not
reorder them, the 4-load can no longer fill the 8-load's delay slot (retail's `nop` comes
back), and each dead pseudo dies on its own insn -> local-alloc hands all three `$v0`.
It is also the honest declaration: `mc.cmd` / `mc.rslt` / `mc.done` are all written
asynchronously by the VSync pump (same class as the W48 `MemCardStop` spin-hoist bug), so
the reconstruction was under-declaring two thirds of them.

**NEW LAW (belt-wide).** *When a volatile-vs-plain read pair reads as "+1 insn and a
register rename", check whether the NEXT PLAIN read of the same aggregate is eating the
residual as a load-delay filler before pricing anything as a register handout -- one
non-volatile sibling read is enough to re-order and absorb a whole volatile group.*
Corollary (a 23B two-half cell): measured, `base[2]` volatile with the two reads left
PLAIN is **exactly the baseline, completely inert** (2/6) -- the three reads are one
indivisible cell, which is precisely why five waves of half-probes read as "+1".

## 2. MemCardCreateFile: 6 -> 4, count-EXACT, one named row left

Residual (whole diff): retail `... lui $at ; jal open ; [slot] sw $v1,%lo(_mc_present)($at)`
with `li $a1,1` emitted EARLY; ours `... sw $v1,0($at) ; jal open ; [slot] li $a1,1`.

The W74 receipt specced `PER_FN_SLOT_UNFILL_272` for this. **I did not build it**, and the
reason is recorded in the TU:

* Commit `75be7d4c` ("Restore exact SYM graph for textureprocess without rewrites") records
  the **user policy of 2026-08-23: post-recompile instruction rewrites are forbidden**;
  `PER_FN_RA_SINK` was emptied for it, and the concurrent working copy is removing
  `PER_FN_TEXT_MOVES` rows (psxcontroller) for the same reason.
  `PER_FN_SLOT_UNFILL_272` is exactly that class (it deletes an instruction cc1 emitted and
  re-emits it above the branch). **Wiring it is a USER CALL, not a belt call.**
  Everything else in the W74 spec still stands -- its `-fno-delayed-branch` byte-proof is real.

What I DID establish, so the row is now fully closed on the compiler-input side:

* **The four-row `-fno-delayed-branch` alternative is DEAD, not merely expensive.**
  Re-measured on the post-volatile basin: `-fno-delayed-branch` spliced onto this fn gives
  10 @134/130, and its four missing insns are THREE distinct slot classes:
  the busy-guard `beq` slot (`addu $s1,$0,$0`) and the probe `bltz` slot (`sll $20,$20,16`)
  are gas-backward-fillable if the source statements move, **but the third is reorg's EAGER
  TARGET-THREAD STEAL** -- retail's `beq $3,$v0,.L800FBCDC` jumps PAST `addiu $a0,$sp,0x10`
  and carries it in the slot, i.e. the insn comes from the branch's TARGET side with the
  branch re-pointed one insn later. GNU as only ever fills backwards (w48 04K), so under
  `-fno-delayed-branch` that fill is structurally unrecoverable. The route's floor is >= 4
  diffs = exactly the row it was meant to buy.
* **No source fence can reach it (reorg.c cited).** `fill_simple_delay_slots` starts its
  backward scan at `prev_nonnote_insn(jal)` and takes the FIRST eligible trial
  (reorg.c:3082-3125). `stop_search_p` (reorg.c:685-712) fires at any asm -- but C can only
  place an asm BEFORE the argument-register moves (calls.c emits those last, inside
  expand_call), so the scan always meets `li $5,1` before any fence. A fence can only BLOCK
  theft (13B) and here there is nothing to block it with.
* **Ladder + flag sweeps (new, all measured):** cc1 rungs via `PER_FN_CC1_VER_SPLICE_272` --
  2.7.2 = the lane (6/2/23 pre-landing), 2.7.2-970404 77/62/134, 2.8.0 86/66/166,
  2.8.1 86/62/166, and **2.6.0 + 2.6.3 REJECT the TU outright** ("inconsistent operand
  constraints in an asm", MemCardGetDirentry) => the version axis is CLOSED for LIBMCRD.
  Per-fn flag splices on CreateFile: `-fno-peephole` 4 (inert), `-fno-function-cse` 4
  (inert), `-fno-schedule-insns2` 18, `-fno-schedule-insns` 20, `-fno-delayed-branch` 10.

## 3. MemCardGetDirentry: the standing (b)+(c) rows are ONE mutually-exclusive cell

The two long-standing classes are not independent:

* **(c)** wants the opacity-fenced `pc` block -- the only device that produces retail's
  one-insn chan read `lw $a0,12($s3)` (plain `mc.chan` folds to the two-insn assembler
  macro `lui $a0,%hi ; lw $a0,%lo`).
* **(b)** wants retail's `addu $s5,$0,$0` (`stored = 0`) in the `blez` delay slot. That is a
  reorg BACKWARD fill (the value runs on both edges, so it can never come from a thread),
  and `stop_search_p` aborts the backward scan at the first asm. **The `pc` launder IS that
  asm**, and it necessarily sits between the inits and the blez (it feeds the
  `lw $a0,12(pc)` the RMW chain consumes right before the branch).

Measured this wave (each whole-TU gated, restored):

| variant | result |
|---|---|
| launder kept (shipped) | 23 lcs @153/152, blez slot `nop` |
| launder dropped, plain `mc.chan` | **24 lcs @152/152 COUNT-EXACT** -- blez slot fills with `addu $s5,$0,$0` exactly like retail and the s5 emission order matches; the entire loss is the chan read becoming 2 insns, which then slides ~55 positions (posmis 70, ~60 of it slide) |
| `stored = 0` moved (before the pc block / last inside it / after it) | **ALL INERT at 23** -- position is not the dial (sched2 hoists the independent `li`, and the launder walls the scan anyway). Explains, rather than merely repeats, the W62/W72 "init-order sweep" rows |
| assignment-order swap (fretry before idx, fences left) | 43 |
| fn-scope `pc` + launder at the top (asm out of the blez scan) | 29 (chan read only) / 37 (guard `pc[0]` too) -- the 9th global allocno rotates the s0/s1 band, as w53-a7/w59-a8 measured on older basins. **The base-anchor family is now falsified on FOUR basins; stop re-testing it.** |
| fence-position sweep on the `"m"(files)` parm pin (swap with the `dir` fence; move below the guard) | inert at 23 |

**NEW NAMED ANGLE (unclaimed, precise):** a device that makes `mc.chan` read as base+offset
off the compiler's OWN `mc` cse base **without an asm in that basic block**. Root cause is
cse-block scope: the busy guard's `lw $v0,0($s3)` and the loop's `sw ...,0($s3)` group both
reuse the base, but the RMW sits in its own cse block (cse.c blocks end at CODE_LABELs,
22A(8)) where the address is re-expanded as a symbol macro. Anything that puts a second
`mc` access in the SAME block as the chan read -- or carries the base pseudo across the
guard's label without minting a named allocno -- collects (b) AND (c) together, worth ~6
rows plus the ~55-position slide.

Class (a) (`sw $a3,156($sp)` vs retail `92($sp)` + the tail reload) keeps its W74
compiler-source certificate (2.7.2's `alter_reg` passes align=-1 unconditionally -> 8/8
spill slots; 2.8.x gates it on a paradoxical subreg that a plain SImode pointer cannot
have). A20's `[reload_pick]` instrument is still the right customer for the ring-order half
of it; its report had not landed at my close.

## 4. build.py

**No rows added, none changed.** The uncommitted foreign edit (removal of the stale
psxcontroller `InGame_ResetPSXController` TEXT_MOVES rows) is preserved untouched -- and it
is what surfaced the policy question in section 2.

## 5. Artifacts (all untracked, under scratchpad/w75/)

* `A18_base_tugate.txt` -- pre-edit whole-TU baseline
* `A18_base_LIBMCRD.c.bak` -- pre-probe source snapshot
* `A18_tugate.py` -- tugate driven through `tools/vprobe.py` so `W60_*`/`W61_TABLE` hooks
  apply (whole-TU regression screen for a per-fn table probe; promotion candidate)
* `A18_posmis.py` -- index-by-index positional mismatch using verify_asm's own normalizers
  (23D(4); promotion candidate -- `scratchpad/w75/posmis.py` is hard-wired to hrzsku.cpp)
* `A18_probe.py` -- byte-mode, CRLF-preserving, always-restoring source-variant prober
* `A18_sbs_del_vol.txt`, `A18_sbs_gd_base.txt`, `A18_sbs_cf_nodbr.txt` -- side-by-sides

## 6. Process notes

* `W60_FN_FLAGS` in `tools/vprobe.py` **REPLACES** a flag's fn-set instead of unioning it --
  probing `-fno-delayed-branch` for CreateFile silently dropped the wired
  `MemCardFormat` entry and manufactured a phantom PASS->FAIL. Use the generic
  `W61_TABLE` hook (which unions) for any table that already has a row for that key.
  This is the DUP-KEY/table-shadowing hazard firing from the probe side again.
* Heredoc backslash-collapse fired once more (a `b"""...\r\n"""` anchor inside a quoted
  heredoc arrived with the escapes eaten -> zero-match assertion). Edit/Write tool only.
* `tools/psyqproof.py` is INAPPLICABLE-LANE for this TU (cc1_272), so no production leg.
* `tools/strict_branch.py` takes `--fn`, not positional args.

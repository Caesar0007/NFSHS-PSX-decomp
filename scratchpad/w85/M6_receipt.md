# W85-M6 receipt — the two count-exact regional rows

Scope (from the dispatch): the two USA rows W84 left count-exact.

| row | before (W84) | after (W85-M6) |
|---|---|---|
| `DrawForeground__16tScreenCarSelect` (USA, frontend/common/screencarselect) | FAIL 16 @566/566 | **REGION-PASS (566)** ✅ |
| `DrawForeground__14tScreenMemcard` (USA, frontend/common/screenmemcard) | FAIL 16 @67/67 | **FAIL 2 @67/67** (14 of 16 diffs cleared) |

Gate used for every number below (run from `C:\Temp\nfs4-decomp`):

```
python regiondiff/tools/verify_region.py USA <candidate> <fns> --lane-as=recon/frontend/common/<unit>.cpp
```

Full untruncated diffs read with the pre-existing read-only helper
`scratchpad/w84/rvdiff.py` (no tool edits). RTL evidence produced with a new
read-only harness `scratchpad/w85/M6_dump.py` (copies the candidate next to its
base TU exactly like `verify_region.py`, then runs the SAME cpp + CC1PLPSX lane
with gcc's `-d*` dump letters in a private working dir; touches nothing in the
repo).

Files touched: `regiondiff/recon/NFS4-R-USA/frontend/common/screencarselect.cpp`,
`regiondiff/recon/NFS4-R-USA/frontend/common/screenmemcard.cpp`,
`scratchpad/w85/M6_dump.py`, `scratchpad/w85/M6_receipt.md`, plus verbatim
pre-edit backups `scratchpad/w85/M6_{memcard,carselect}_base.cpp`.
No git ops, no `tools/**` or `regiondiff/tools/**` edits, no base-tree edits,
no new `__asm__` / `volatile` / pins.

---

## Row 1 — `DrawForeground__16tScreenCarSelect` (USA) → REGION-PASS ✅

### The residual W84-R08 left

Count-exact 566/566, 16 diffs, all one **two-register rotation** inside the new
regional shape-fade block: ours `shapeTicks=$v1, shapeFade=$t0`; retail
`shapeTicks=$t0, shapeFade=$t1`. Everything else in the 566-instruction stream
already matched.

### Angle (b) — the allocno dumps settled it in one read

`python scratchpad/w85/M6_dump.py <cand> recon/frontend/common/screencarselect.cpp -dl -dg`
→ `screencarselect.i.lreg` names the pseudos (422 = `shapeFade`, 423 =
`shapeTicks`, insns 1187/1191/1200/1206), and `screencarselect.i.greg` prints
global.c's conflict table for `tScreenCarSelect::DrawForeground`:

```
;; 39 regs to allocate: 322 263 423 107 506 116 262 258 437 634 81 422 647 ...
;; 422 conflicts: 80 85 422 423  2 3 4 5 6 7 29      <- shapeFade
;; 423 conflicts: 80 85 422 423  2 29                <- shapeTicks
```

That is the whole answer, and it shows the ALLOCATION ORDER is irrelevant here:

* `shapeFade` is live across the `DrawShapeExtended(0xA,0x200,0,0,shapeFade,…)`
  argument setup, so it conflicts with `$v0`+`$a0-$a3` → its first free hard reg
  is `$t0` whichever order it is allocated in.
* a **dedicated** `shapeTicks` local dies at the `subu`, long before that setup,
  so it only conflicts with `$v0` → it always takes `$v1`.

Feeding either allocno first still yields `{$v1,$t0}`. To reach retail's
`{$t0,$t1}` the TICK DELTA must itself carry `$a0-$a3` conflicts.

### The fix — retail REUSES `elapsedticks`, it is not a local of its own

The oracle slice says so directly: `$t0` is the register for **all three** tick
deltas in the function —

```
8003CF4C  addiu $t0,$v0,-256     elapsedticks = ticks - fSpeechTicks - 0x100
8003D0A0  addiu $t0,$v0,-128     the regional shape-fade delta
8003D108  subu  $t0,$v1,$v0      elapsedticks = ticks - fShowroomTicks
8003D138  addiu $t0,$t0,-600     elapsedticks -= 600
```

`elapsedticks` is a function-scope `long` whose OTHER live ranges (the speech
text block above, the 600-tick loop below) do cross the `FETextRender_*` /
`DrawShapeExtended` argument setups, so its allocno carries the `$a0-$a3`
conflicts, takes `$t0`, and pushes `shapeFade` to `$t1` — retail's exact pair.

Edit (one block, `regiondiff/recon/NFS4-R-USA/frontend/common/screencarselect.cpp`):

```c
elapsedticks = (ticks[0] - this->fSpeechTicks) - 0x80;   /* was: u_long shapeTicks */
shapeFade = 0x80;
if (0 < elapsedticks) {
  if (elapsedticks < shapeFade) shapeFade = shapeFade - elapsedticks;
  else                          shapeFade = 0;
}
```

plus deletion of the now-dead `u_long shapeTicks;` / `int fadeBase;` locals and
their stale carrier comments. Result: **REGION-PASS (566 insns)**, first try.

This also generalises W84-R08's falsified list: every angle it tried
(ternary 19, inverted polarity 19, `shapeFade = 0`-first 19, split delta 16,
`(long)` cast 16, separate `fadeBase` 19, all three decl-order permutations 16,
block moved 28, nested guard 16) kept the delta in a **fresh** local, so none of
them could change the conflict set — the decisive quantity.

### No sibling regressed (all 10 screencarselect USA manifest rows re-gated)

```
DoMemCardStuff__25tScreenPinkSlipsCarSelect                REGION-PASS (193)
DrawCar__FR8tCarInfossffcbUl7tPlayer                       REGION-PASS (125)
DrawForeground__16tScreenCarSelect                         REGION-PASS (566)   <- NEW
DrawVideoWall__25tScreenCarSelectTwoPlayers                REGION-PASS (104)
GetShapeInfo__25tScreenCarSelectTwoPlayerRsT1PPcT3         REGION-PASS  (58)
GetShapeInfo__25tScreenPinkSlipsCarSelectRsT1PPcT3         REGION-PASS  (30)
Initialize__25tScreenCarSelectTwoPlayer                    REGION-PASS  (32)
Initialize__25tScreenPinkSlipsCarSelect                    REGION-PASS  (28)
ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyType…  REGION-PASS (111)
ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInp…  REGION-PASS  (58)
```

---

## Row 2 — `DrawForeground__14tScreenMemcard` (USA) → FAIL 16 → FAIL 2

### 14 of the 16 diffs: the missing `addu s1,a0,zero`

W84-R10 described the residual as "one allocation decision: retail keeps the
clamp in caller-saved `$a0` and copies to `$s1`; ours coalesces", and recorded
that a separate carrier (`short fadeArg = (short)fade;` and `int fadeArg = fade;`
before the guard) "coalesces away — 16 diffs either way".

The RTL dumps say WHICH pass coalesces it and therefore how to stop it:

* `-ds` (cse1): the copy `(set (reg/v:SI 83) (reg/v:SI 82))` **survives** — the
  uses of `fadeArg` sit past the clamp join, so cse1's EBB walk cannot reach them.
* `-dL` (loop): still there; LICM has now hoisted the `(short)fadeArg`
  sign-extension into the loop preheader.
* `-dt` (cse2): the copy's uses have been rewritten back to `fade` — **cse2 is
  the coalescer**, because after LICM the preheader use is reachable and `fade`
  is unmodified between copy and use.
* `-df`/`-dc`: the now-dead copy is gone.

Fix = give cse2 a reason to stop: redefine `fade` between the copy and the use.
`fade` is dead there, so `flow` deletes the store again **after** cse2 has been
blocked — the store emits no instruction:

```c
fadeArg = fade;
if ((short)fadeRaw >= 100) { … }
fade = 0;        /* LOAD-BEARING, emits nothing; see the in-file comment */
k = 0;
do { DrawShapeExtended(0x38 + k,0,0,0,(short)fadeArg,0,0); k++; } while (k < 4);
```

With that, `fade`→`$a0`, `fadeRaw`→`$a1`, `fadeArg`→`$s1`, and retail's
`addu s1,a0,zero` lands in the guard's `bnez` delay slot exactly as in the
oracle. **16 → 2 diffs, still count-exact 67/67.**

### The remaining 2 diffs, fully diagnosed (a scheduler ordering decision)

```
oracle:  sll v0,v0,1 ; addu a1,v0,zero ; addiu a0,v0,-128
ours:    sll v0,v0,1 ; addiu a0,v0,-128 ; addu a1,v0,zero
```

Same registers, same instructions — only the two independent entry-block insns
are swapped. `-dc` proves it is NOT the source: with the retail spelling
(`doubled` temp, copy statement first) the RTL chain is already
`sll(20) → copy(26) → addiu(30)`, and **sched1 swaps them**. `-dS` shows why:

```
;; insn[  20]: priority = 2   ;; insn[  26]: priority = 2   ;; insn[  30]: priority = 2
;; ready list at T-5: 26 (7f000001) 30 (2), now 26 30
```

`sched.c` schedules a block BACKWARD, and `adjust_priority()` → `birthing_insn_p()`
bumps a ready insn to `LAUNCH_PRIORITY` (0x7f000001) when it makes a register
live *and* `REG_N_SETS(dest) == 1`. The copy's destination (`fadeRaw`) has
exactly one set, so it is bumped and taken at the LATER slot; `fade` has three
sets (the clamp arms) so the `addiu` is never bumped and lands earlier. Had
neither been bumped they would tie at priority 2 and `rank_for_schedule`'s
`INSN_LUID` tie-break would have preserved the source order — i.e. retail's
order.

So the row needs `REG_N_SETS(fadeRaw) != 1` at flow/sched time, and every
spelling of a second set costs at least the 2 diffs it buys:

| angle | result |
|---|---|
| statement order `fadeRaw` first (`sll a1,v0,1`) | FAIL 5 @66 — copy never created |
| `fade = expr; fadeRaw = fade; fade += -0x80;` | FAIL 5 @66 — cse merges the copy back |
| third local `doubled` + copy-first order | FAIL 5 @66 — cse.c "(set REG0 REG1) where REG0 is cheapest" rewrite (cse.c:7624) fires: prev insn sets the copy's src, and `make_regs_eqv` makes the longer-lived dest the qty's first reg |
| …plus `doubled = 0;` AFTER the guard (extends `REGNO_LAST_UID(doubled)` past `fadeRaw`'s last use, so `qty_first_reg` stays `doubled` and the rewrite is blocked) | FAIL 2 @67 — RTL order now matches retail exactly, sched still swaps |
| …plus a dead `fadeRaw = 0;` to force a 2nd set | FAIL 2 @67 — cse's `delete_trivially_dead_insns` removes it before `flow` computes `REG_N_SETS` |
| `fadeRaw = (int)(ushort)fld; doubled = fadeRaw*2; fadeRaw = doubled;` (a genuinely live 2nd set) | rejected by inspection: puts the `lhu` and the `sll` source in `$a1` (2 diffs at insns 4/6) — a wash |
| `fadeRaw = (short)fadeRaw;` before the guard (live 2nd set) | rejected by inspection: makes the guard `sra $a1,$v0,16` / `slti $v0,$a1,100` (2 diffs) — a wash |
| reuse `fadeRaw` as `k`, or as `fadeArg` (the row-1 variable-reuse lever) | rejected by inspection: one pseudo then crosses the four `DrawShapeExtended` calls → callee-saved, so the entry copy becomes `addu s0/s1,v0,zero`, worse |
| `fadeArg` carrier without the `fade = 0` blocker | FAIL 16 (the W84-R10 state) — confirms the blocker is what buys the 14 |

Shipped form = the **minimal-device** one: the W84 32B-2 double-spelling
(`fade = expr - 0x80;` then `fadeRaw = expr;`) + the `fadeArg` carrier + the one
`fade = 0;` blocker. The copy-first variant scores identically (2) but needs a
second dead store, so it is documented here rather than shipped. Note that the
copy-first variant is the one that would PASS if this unit ever gets a
`no_schedule_insns` lane — its RTL is retail's RTL.

Sibling row re-gated, unchanged: `Cleanup__14tScreenMemcard` REGION-PASS (36).

---

## Reusable findings (catalog candidates)

1. **32C/allocno rule — "a rotation you cannot reach by reordering allocnos is a
   CONFLICT-SET problem, and the usual cause is that retail REUSED a
   function-scope variable."** Read `-dg`'s `;; N conflicts:` lines for the two
   fighting pseudos: if one lacks the `$a0-$a3` entries the other has, no
   priority/decl-order/expression tweak can swap them — you must give it the
   extra live range, and the honest way is to find the retail variable it is a
   reuse of (the oracle shows it: same hard reg used for the other deltas).
   (`DrawForeground__16tScreenCarSelect`, 16 → PASS.)
2. **cse2, not the allocator, is what kills a source-level reg-reg copy whose use
   is past a join** — because `loop`'s LICM first pulls that use into the
   preheader. A redefinition of the copy's SOURCE between copy and use blocks it,
   and `flow` then deletes that (dead) redefinition, so it costs no instruction.
   Companion to catalog 32B-2 (which manufactures the copy); this one makes it
   SURVIVE. (`DrawForeground__14tScreenMemcard`, 16 → 2.)
3. **`sched.c` birthing-bump decides the order of two independent, equal-priority
   entry-block insns.** `adjust_priority`/`birthing_insn_p` bumps an insn to
   LAUNCH_PRIORITY iff its dest is live and `REG_N_SETS(dest)==1`; the backward
   list scheduler then places it LATER. Two unbumped insns tie and keep source
   order via `INSN_LUID`. So "ours emits A;B, retail emits B;A" with identical
   registers is a REG_N_SETS question, not a source-order question.
4. **cse.c:7624 "(set REG0 REG1) where REG0 is the cheapest"** rewrites a copy
   that IMMEDIATELY follows its source's def, redirecting the def to the copy's
   dest — it is why a `t = expr; a = t; b = t - k;` shape collapses to two insns.
   It is gated on `qty_first_reg[qty[src]] == dest`, which `make_regs_eqv` only
   sets when the dest's `REGNO_LAST_UID` is LATER than the src's. A later
   (even dead, DCE'd) mention of the temp therefore blocks it.

---

## Device census + clearing on the rows I own (W85 CLEAR list)

Both candidates were seeded from their base TUs, so they inherit the base tree's
zero-insn identity fences. Every one that lies inside a row I own was measured
(remove → re-gate → restore if it regresses). No device was ADDED anywhere.

`regiondiff/recon/NFS4-R-USA/frontend/common/screenmemcard.cpp`
* `DrawForeground__14tScreenMemcard`: **0 devices**. The only `__asm__` in the
  file are `extern T A_x[] __asm__("x")` symbol-label views (naming, not
  codegen) and no `volatile` is involved. The 14-diff fix I added is plain C.

`regiondiff/recon/NFS4-R-USA/frontend/common/screencarselect.cpp`
* `ProcessInput__16tScreenCarSelect…` — **CLEARED** ✅.
  `__asm__("" : : "i"(0));` sat as the statement of the trailing label. Replaced
  with a plain empty statement `;`. The fence was never doing the work: C just
  requires a label to be followed by a statement, and an empty one gives reorg
  the same otherwise-empty branch-target head. `ProcessInput` REGION-PASS (111),
  and all ten screencarselect USA rows re-gated PASS.
* `DrawForeground__16tScreenCarSelect` — two inherited fences, both measured,
  both **KEPT with reason**:
  - `__asm__("" : : "r"(currentItem));` (state-1 arm) — removing it alone:
    FAIL 10, count-exact 566/566 (`$s2`↔`$s4`/`$s0` rotation across the whole
    menuDefs base + item web). Removing BOTH: FAIL 9 @565.
  - `__asm__("" : "=r"(currentItemValue) : "0"(currentItemValue));` — removing
    it alone: **FAIL 2, count-exact**, and the residual is exactly ONE operand:
    `bne s0,v0` (ours) vs `bne s2,v0` (retail) at the `itemSellerCar`
    comparison in the `fState == 3` arm. Diagnosis: the source already spells
    the split correctly (`currentItemValue` for the state-1/0/2 comparisons,
    `currentItem` for the state-3 one), but the `else if` chain is one
    fall-through path, so cse canonicalises `currentItem` back onto
    `currentItemValue` at that last use; the fence's only job is to keep the two
    pseudos distinct. Falsified re-crack: a `currentItemValue = 0;` blocker at
    the head of the `fState == 3` arm (the trick that works in the memcard row)
    — it is NOT dead there in the same way and rotates `$s0`/`$s2` in that arm
    instead (worse). A structural fix would need the arm to stop being
    cse-reachable from the copy (e.g. a `switch`), which retail does not use
    (`lh v1,284(s3); li a0,1; bne v1,a0` = an if/else chain).
    RESTORED verbatim; row left REGION-PASS.
* `DrawOverlay` (lines ~334/356) carries two more inherited fences, but
  `DrawOverlay` is **not a USA manifest row** — there is no regional oracle for
  it, so it cannot be gated in this lane. Left untouched; it belongs to whoever
  clears the BASE TU `recon/frontend/common/screencarselect.cpp`, where the same
  fences live.

**Iron rule honoured:** every previously-PASS function in both candidates is
still PASS; devices are strictly fewer (one cleared, none added).

### Final state

```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/screencarselect.cpp \
  DoMemCardStuff__25tScreenPinkSlipsCarSelect,DrawCar__FR8tCarInfossffcbUl7tPlayer,\
DrawForeground__16tScreenCarSelect,DrawVideoWall__25tScreenCarSelectTwoPlayers,\
GetShapeInfo__25tScreenCarSelectTwoPlayerRsT1PPcT3,GetShapeInfo__25tScreenPinkSlipsCarSelectRsT1PPcT3,\
Initialize__25tScreenCarSelectTwoPlayer,Initialize__25tScreenPinkSlipsCarSelect,\
ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand,\
ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand \
  --lane-as=recon/frontend/common/screencarselect.cpp
    -> 10/10 REGION-PASS

python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/screenmemcard.cpp \
  DrawForeground__14tScreenMemcard,Cleanup__14tScreenMemcard \
  --lane-as=recon/frontend/common/screenmemcard.cpp
    -> DrawForeground FAIL 2 (count-exact 67/67), Cleanup REGION-PASS (36)
```

No `update_region_progress.py` run (wave rule).

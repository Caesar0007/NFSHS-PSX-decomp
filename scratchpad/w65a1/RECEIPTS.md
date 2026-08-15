# W65-A1 -- THE WHOLE-BLOCK ROUTING BELT (04Q class-d, the 10 large-delta rows)

Repo `C:\Temp\nfs4-decomp`, base HEAD `14c766e6`.  Target list = the 10
whole-block-routing rows of `scratchpad/w64a21/BOARD_RECONCILIATION.md` §5
("gate PASS, board < 100, a real branch/jump WORD differs").  Every baseline
below was re-gated by me; nothing is quoted from the briefing.

Instruments built this belt (all in `scratchpad/w65a1/`, `tools/` untouched):
* `route.py` -- the missing view: OUR stream next to the ORACLE stream with every
  branch target rendered as a **target index**.  This is precisely what
  `verify_asm` normalises away (04Q) and what `brdist` only summarises.
  It also fixes a `brdist`/oracle-parser gap: splat writes jump-table entry
  points as `jlabel .L<VA>` (no colon), so those labels were missing from the
  label map and every branch to one compared as `None` -- i.e. **silently
  skipped**.  `LoadGame` alone had 6 such branches hidden.  → `tools/brdist.py`
  should adopt the same 3-line fix (see CATALOG CANDIDATES).
* `probe.py` (byte-mode variant harness: gate + brdist row per variant),
  `show.py`, `mkprobe.py` + `build_probe.py` / `verify_probe.py` /
  `tugate_probe.py` / `brdist_probe.py` (a full probe lane over a COPY of
  build.py), `rows_spec.py` (the wiring spec), `pq_rows.json` (psyqproof hook).

---

## 0. LEDGER

| # | fn | TU | re-gated baseline | branch words | verdict | outcome |
|---|---|---|---|---|---|---|
| 1 | `UpdateTransition__12tOptionsMenu` | femenuoptions | PASS 172, brdist (5,23,135) | 1 | SEMANTICALLY-EQUAL (zero-trip guard threaded past a redundant re-test) | **LANDED** source, PASS 172, REAL=0 |
| 2 | `ProcessInput__17tUserNameMenuItem…` | femenuoptions | PASS 240, (17,113,140) | 1 | SEMANTICALLY-EQUAL (tail re-reads + re-tests the same byte) | **LANDED** source, PASS 240, REAL=0 |
| 3 | `LoadGame__FsbT1` | fememcard | PASS 374, ×3 | 3 | SEMANTICALLY-EQUAL (cross-jump partner: first vs last of 3 identical tails) | **SPEC** label move, REAL 1→0 |
| 4 | `DrawMemCardStuff__14tScreenMemcards` | screenmemcard | PASS 343, (20,19,166) | 1 | SEMANTICALLY-EQUAL (zero-trip guard threaded) | **LANDED** source, PASS 343, REAL=0 |
| 5 | `MCRD_handlecardevents` | frontend/psx/memcard.c | PASS 211, (13,148,94) | 1 | SEMANTICALLY-EQUAL (funnel vs its 2-insn trampoline; both `return status`) | **OPEN**, named angle + 9 falsifications |
| 6 | `InitializeShapes__7tScreen…` | fescreen | PASS 42, (1,8,20) | 1 | SEMANTICALLY-EQUAL (thread past the 2nd identical guard) | **SPEC** label move, REAL 1→0 |
| 7 | `SavePinkSlipsCars__Fss` | fememcard | PASS 226, (5,103,88) | 1 | 🔴 **ROLE SWAP** -- our .rodata JUMP TABLE pointed at the wrong block | **LANDED** source, PASS 226, REAL=0 |
| 8 | `DrawBackground__25tScreenCarSelectTwoPlayer` | screencarselect | PASS 342, ×5 | 5 | SEMANTICALLY-EQUAL (1 thread + 4 reorg target-steals) | **SPEC** 3 label moves, REAL 5→0 |
| 9 | `CdReadyHandler` | eacpsxz/cdfs.c | PASS 300, (12,104,99) | 1 | 🔴🔴 **REAL BEHAVIOURAL BUG** -- stop-requested read never flushed the drive | **LANDED** source, PASS 300, REAL=0 |
| 10 | `Draw__29tMenuItemOptionsTwoItemChoiceiib` | femenuextended | PASS 161, (2,6,4) | 1 | SEMANTICALLY-EQUAL (low arm shares the in-range arm's clamp block) | **LANDED** source, PASS 161, REAL=0 |

**9 of 10 closed** (6 landed in source, 3 specced as label moves), 1 open with
receipts.  15 branch words fixed.  Two genuine fidelity defects found, both
invisible to `verify_asm` AND to the board:

* **#9 is a real runtime bug.** Retail's `Cdinfo & 4` (CD_Stopread) arm falls
  into the `CdFlush(); CdSync(0,0);` block that the "not reading" path also
  branches to.  Ours jumped straight to the `done` test, so a read aborted
  mid-flight never flushed the drive FIFO nor waited for the command to settle
  -- the next `CdControl` then ran against a dirty FIFO.  Same 300 instructions
  either way; only the jump word differed.  Third bug of the W59-11C family and
  the first found in eaclib.
* **#7 is a DATA defect no gate reports.**  Retail's `jtbl_800117A8`
  (`asm/data/rdata_80010000_j06.rodata.s`) sends cases 3/7/0xa/0xb/0x17 to
  `.L800356F4` = the 3-insn `finished=true; result=LoadFailed; break;` block and
  routes the READ-FAILURE arm to the 2-insn `.L800356B8` trampoline.  Ours had
  the two spellings exactly reversed, so our emitted `.rodata` jump table pointed
  at the wrong block.  `verify_asm` compares only text; `psyqproof` compares only
  the function's words; objdiff scores the code symbol.  **The oracle's own jump
  table is the only witness** -- see CATALOG CANDIDATES.

---

## 1. THE THREE ROUTING CLASSES (this belt's taxonomy)

**(A) REDUNDANT-RE-TEST THREAD (rows 1, 2, 4, 6, and 8a).**  Ours routes a
provably-known path *through* a block that re-loads and re-tests the same value
and then falls to the same join; retail routes straight to the join.  Cure = the
**explicit-goto guard**: hoist the loop/branch guard out of the `for`/nested
`if` and give its false edge an explicit `goto <join>`.
🔑 **The spelling of the guard decides whether cse folds it away.**  Measured:

| shape | result |
|---|---|
| `i = 0; if (i < n) { for (; i < n; i++) {…} } else goto join;` | **PASS, routing fixed** (row 4) |
| `i = 0; if (n != 0) { while(cond){…} } else goto join;` | **PASS, routing fixed** (row 1) |
| `i = 0; if (0 < n) { for (…) {…} } else goto join;` | +2 insns (guard not merged) |
| guard + `do{}while` | count-exact but the loop-invariant hoist is LOST (row 4: 14 diffs) |
| `if (n <= 0) goto join;` in front of an untouched `for` | +2 insns (row 4) / PASS (row 1) |
| the two guards folded (`a || b`, `a && b`) | a branch is DELETED (rows 6, 10) |

**(B) CROSS-JUMP PARTNER CHOICE (rows 3, 5).**  Two or three byte-identical
tails exist; ours and retail merge the same branches into *different* copies.
🔴 **This class is SOURCE-UNREACHABLE** -- 9 spellings measured on row 3 and 9 on
row 5, all inert or worse (full list below).  A void fence *does* un-merge, but
it costs the delay-slot fill (+1 insn) because the ASM_OPERANDS insn lands
between the value and the jump.  Expressible only as a **label move**.

**(C) REORG TARGET-STEAL (row 8b/8c, and the same shape W64-A17 named on
screenmain word 86 / DrawVideoWall word 53).**  reorg pulled an idempotent
`move $4,$16` into a branch's delay slot and retail then redirected the *other*
branches PAST that now-redundant copy; ours still targets the copy.  Pure
label move, zero risk -- and the same class 15D solved on HeliCam.

---

## 2. FALSIFICATION LISTS (every variant re-gated; basin = the row's PASS state)

### Row 3 `LoadGame__FsbT1` (PASS 374)
| variant | gate | routing |
|---|---|---|
| void fence AFTER `finished = true` (success arm) | FAIL 3 @375 | fixed, but +1 insn (`j;nop` -- the asm blocks the slot fill) |
| void fence BEFORE it | PASS 374 | unchanged (2 insns still common → still mergeable) |
| void fence after the failure arm's `finished = true` | FAIL 3 @375 | partly fixed |
| both fences | FAIL 6 @376 | — |
| `finished = true` moved inside the getcard braces | PASS 374 | unchanged |
| flat `&&` on the failure arm's dialog guard | PASS 374 | unchanged |
| `finished = true` first in the success arm | FAIL 9 @375 | — |
| `finished = true` first in the failure arm | FAIL 203 @381 | — |
| explicit `goto lg_finish` (label at the getcard tail), ± the getcard arms | PASS 374 ×2 | unchanged |
| per-fn `-fno-thread-jumps` (build_probe) | FAIL 1 @373 | unchanged → **thread_jumps is NOT the mechanism** |

### Row 5 `MCRD_handlecardevents` (PASS 211) -- THE ONE OPEN ROW
Both tails `return status`: `.L800501B0` = `move $v0,$s0` + fall into the
epilogue, `.L800500D8` = `j <epilogue>; move $v0,$s0`.  The res==0 arm's
`bne pCI->status,-1` must reach the SECOND.  The trampoline already exists --
W45 built it with a zero-insn USE fence in the task-switch NONE arm's `else`,
and that receipt already predicted this branch would join it.  It does not.

| variant | gate |
|---|---|
| `else { __asm__("" : : "r"(status)); }` in the res==0 arm (inside the w45 depth-3 wrapper) | FAIL 12 @209 |
| same with a bare `__asm__ volatile("")` | FAIL 12 @209 (identical basin ⇒ **not the ref dial, the fence POSITION**) |
| `else { … "r"(pCI) }` | FAIL 140 @209 |
| the `if` hoisted OUT of the wrappers + else fence | FAIL 2 @213 |
| `else { fence; goto MCRDhandleCard_end; }` | FAIL 73 @210 |
| the same with a bare void fence | FAIL 73 @210 |
| early-out `if (status != -1) { fence; goto end; }` | PASS 211, routing unchanged |
| early-out `goto MCRDhandleCard_end` (no fence) | PASS 211, unchanged |
| `goto` a label placed after the NONE-arm's fence | PASS 211, unchanged |

Anatomy of the failures: the fence flips the guard's polarity (`beq` where
retail has `bne`) because the else-arm becomes the fall-through, and it costs
reorg two `j` delay-slot fills.  **NAMED ANGLE:** the residual is a jump.c
`find_cross_jump` partner choice and the trampoline label is shared by another
branch, so the label-move engine cannot express it either (moving that label
would break the branch that already matches).  Route = an instrumented-cc1
`find_cross_jump` trace (which pair the jump_chain hands it first), or a
`take`-a-BRANCH-LINE extension of `_apply_text_moves` that can rewrite a branch
OPERAND rather than move a label.  Cost: 1 word of 211.

### Row 6 `InitializeShapes` (PASS 42)
`else goto` / early-out `goto` → 41 (gcc DELETES the second guard, 3 branches vs
4); `i = 0` hoisted before the first `if` → 43; moved inside it → 41; at the
declaration → 43.  An **identity launder** `__asm__("" : "+r"(numShapes))` keeps
both guards AND threads the first -- count EXACT 42 -- but recolours 36
instructions.  → label move.

### Row 10 `Draw__29tMenuItemOptionsTwoItemChoiceiib` (PASS 161)
`v < 1 || v < 0x80` and the `&&` mirror both fold to ONE test (160 insns, 8
branches vs 9).  Physically DUPLICATING the low arm's body routes correctly at
exact count 161 but costs 12 coloring diffs.  Only the explicit `goto` into the
in-range arm's clamp block is byte-clean.

### Row 7 `SavePinkSlipsCars` (PASS 226)
Both role-swap spellings gate PASS 226 with clean routing; the one landed also
drops the now-redundant `__asm__("")` at the shared tail (measured exactly
neutral).  The **jump table** is the discriminator that picks between them.

---

## 3. GATES (every landing, run 2×, zero PASS→FAIL anywhere)

| TU | tugate | brdist | psyqproof (2×, cache-warm) |
|---|---|---|---|
| femenuoptions.cpp | 91/92 (the pre-existing `Draw__17tUserNameMenuItemb` 8 unmoved) | 2 → 0 | REAL=0 RELOP=0 ×2 fns |
| fememcard.cpp | 18/18 | 4 → 3 (the 3 LoadGame rows are the spec) | SavePinkSlipsCars REAL=0 |
| screenmemcard.cpp | 15/15 | 1 → 0 | REAL=0 |
| femenuextended.cpp | 57/57 | 1 → 0 | REAL=0 |
| cdfs.c | 14/14 | 1 → 0 | REAL=0 (-G4) |
| fescreen.cpp (spec) | 27/27 under the probe | 1 → 0 | REAL 1 → 0 |
| screencarselect.cpp (spec) | 59/59 under the probe | 1 → 0 | REAL 5 → 0 |
| fememcard.cpp (spec) | 18/18 under the probe | 3 → 0 | REAL 1 → 0 |

`tu_order_audit.py` 507-508 objects / **0 inversions** after every landing.

Commits: `a1b08620` (femenuoptions ×2) · `16270aac` (SavePinkSlipsCars + LoadGame
spec) · `cd0c6f64` (DrawMemCardStuff) · `080c6372` (TwoItemChoice + fescreen
spec) · `3ffa402f` (CdReadyHandler bug) · this one (screencarselect spec +
receipts).

---

## 4. CATALOG CANDIDATES (orchestrator harvests; memory dir is read-only to me)

1. **§D / 16D -- THE FIFTH BLIND SPOT: the emitted JUMP TABLE.** A switch whose
   arms are role-swapped against retail produces a byte-identical *text* stream,
   passes `verify_asm`, passes `psyqproof` (which compares the function's words
   only) and scores 100 on the board -- while the `.rodata` jump table points at
   the wrong blocks.  **The oracle's own `jtbl_<VA>` in `asm/data/**.rodata.s` is
   the authority**: read off which `.L<VA>` each case selects and match your
   arms to it.  Found on `SavePinkSlipsCars__Fss`; a tree-wide sweep is cheap
   (every recon TU that emits a `$L<n>:` table under `.rdata` can be compared
   entry-for-entry against the oracle's table once the block VAs are known).
2. **§B -- THE EXPLICIT-GOTO GUARD, and the spelling that survives cse.**
   `i = 0; if (i < n) { for (; i < n; i++) … } else goto join;` threads the
   zero-trip edge to `join` AND keeps loop.c's invariant hoist.  `if (0 < n)`,
   `do{}while`, and a pre-guard `if (n <= 0) goto join;` all fail (guard not
   merged / hoist lost / +2 insns).  The `i`-first form is load-bearing.
3. **§F / 16C -- CROSS-JUMP PARTNER CHOICE IS SOURCE-UNREACHABLE.**  When N
   byte-identical tails exist, WHICH one a branch merges into is a jump.c
   decision; goto/label/fence spellings are inert or cost the delay-slot fill
   (a void fence between the value and the jump ALWAYS costs +1 insn, because
   the ASM_OPERANDS insn blocks reorg's backward scan).  Expression = a label
   move.  18 falsifications across two functions.
4. **§F -- 15D's TARGET-STEAL class generalises**: after reorg steals an
   idempotent `move $aN,$sN` into a delay slot, retail redirects the OTHER
   guards past the copy.  Recognise it as "ours targets an insn retail's branch
   skips, and that insn is duplicated in a nearby delay slot" -- always a label
   move, never a source change (4 instances in one function here).
5. 🔧 **`tools/brdist.py` VACUITY #4**: splat emits jump-table entry labels as
   `jlabel .L<VA>` (no trailing colon), and `oracle_branches()` skips those
   lines, so every branch targeting a jump-table entry compares as `None` and is
   **silently dropped**.  `LoadGame__FsbT1` hid 6 such branches.  Fix = the
   3-line `jlabel|alabel|dlabel` clause in `scratchpad/w65a1/route.py`.  Every
   pre-fix brdist "clean" verdict on a switch-bearing function is unaudited.
6. **`-fno-thread-jumps` is not the dial for this class** (measured on row 3:
   routing identical, one nop lost).  The redundant-re-test threads come from
   cse's jump equivalences, not from `thread_jumps`.
7. **Process**: a second dict-literal key for a TU that `PER_FN_TEXT_MOVES`
   already owns is silently dropped by Python -- always `setdefault()` in a
   probe fragment and ADD to the existing dict when wiring (cost one probe cycle
   on fescreen.cpp, which already carries a `GoNonInterlaced__7tScreen` entry).

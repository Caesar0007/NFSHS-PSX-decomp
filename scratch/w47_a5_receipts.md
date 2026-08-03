# WAVE-47 a5 RECEIPTS — recon/eaclib/psx/eacpsxz part B (C lane)

Base `ba09f774`, branch `w47-a5`, worktree `C:/Temp/nfs4-wt47-a5`.
Gate = `python tools/verify_asm.py <file> <names>` from the worktree root. Every number below is
re-gated with the gate itself, never the worklist.

## 0. ENVIRONMENT BLOCKER (fleet-wide, fixed before any work)

`git worktree add` failed for EVERY w47 agent: **C: was 100% full (8 MB free)**. Root cause found:
**211,518 loose `.i` files (30.1 GB) in `%LOCALAPPDATA%\Temp`** — cc1 preprocessor intermediates the
build/verify pipeline never cleans up (plus 211,514 `.s`, 0.7 GB). Deleted the 161,104 `.i` files
older than 60 minutes (22.8 GB reclaimed, in-use files skipped by the OS lock); disk went to 31 GB
free and all worktrees became creatable. **This will recur every wave** — the pipeline should unlink
its temporaries, or a wave-start sweep should be part of the fleet checklist.

## 1. PER-FN LEDGER (re-gated baseline -> final)

| fn | TU | worklist% | re-gated base | final | note |
|---|---|---|---|---|---|
| loadfileadratomic | nsync | 99.08 | **22** (62/62) | **PASS** | w44 REF-STEP dial |
| restartstream | stream | 99.93 | **2** (167/167) | **PASS** | USE FENCE |
| CD_Read | cdfs | 99.93 | **2** (163/163) | **PASS** | USE FENCE + addr-into-index |
| resizememadr | resize | 97.87 | **2** (94/94) | **PASS** | USE FENCE |
| loadbigfileheaderatomic | nsync | 97.16 | 7 (82/81) | **4** (81/81) | OPACITY FENCE; now count-exact |
| STREAM_create | stream | 99.55 | 4 (144/144) | 4 | 3 new forms measured |
| STREAM_cancelrequest | stream | 99.62 | 2 (173/173) | 2 | 2 new forms measured |
| setfont | setfont | 97.93 | 2 (100/100) | 2 | new angle found (below) |
| intarcsin | asinfunc | 99.79 | 2 (48/48) | 2 | **residual RECLASSIFIED** |
| synccallback | syncfile | 89.90 | 21 (72/71) | 21 | 1 new form measured |
| unrefpack | unref | 96.22 | 17 (153/158) | 17 | 1 new form measured |
| vramfxya | vramfxya | 94.55 | 34 (165/165) | 34 | untouched (see §4) |
| transmult | trnsmult | 82.16 | 31 (78/81) | 31 | FLAG SUSPICION (§5) |
| **CdReadyHandler** | cdfs | 99.98 | **already PASS** | PASS | stale worklist row |
| **openfile** | fileroot | 99.91 | **already PASS** | PASS | stale worklist row |

**+4 PASS, −3 diffs elsewhere, ZERO regressions.** Whole-TU gates after every landed edit:
nsync 9/10 PASS · stream 29/31 PASS · cdfs **14/14 PASS** · resize 1/1 PASS.

## 2. THE WAVE'S LEVER — the ZERO-INSN OPACITY FENCE (new; generalizes the w45 use fence)

```c
__asm__("" : "=r"(x) : "0"(x));   /* x becomes an unknown value; NO instruction is emitted */
```

The w45 fence `__asm__("" : : "r"(x))` is a *scheduling* barrier. Adding a **matching `"0"` output**
makes it a **value-numbering barrier** as well: cse/gcse can no longer prove `x == <the expression it
was computed from>`, and copy-prop can no longer fold a copy of it away — while the matching
constraint pins the output to the input's own register, so the emitted code is unchanged.

Three distinct jobs, all landed this wave:
1. **Force a RECOMPUTE** where cse would substitute an available pseudo
   (`loadbigfileheaderatomic`: both trailing `FILE_closesync(handle, retry - 1)` calls recompute
   `addiu a1,s4,-1` like retail instead of reusing the shared temp — 24 -> 4, and the whole
   retry/`a` allocno pair snaps to the oracle map as a side effect).
2. **Keep a retail REG-REG COPY alive** that copy-prop/coalescing would delete
   (`intarcsin`: retail's `addu v0,v1,zero` now materializes; count-exact 48/48).
3. (plain w45 form, no output) **remove a ready-list tie from the schedule instead of trying to win
   it** — `restartstream`, `CD_Read`, `resizememadr`.

**The generalizable rule for §F floors:** a "sched1/sched2 ready-list tie" verdict is a statement
that the tie cannot be WON. It says nothing about REMOVING the tie. Every floor note in this cluster
whose evidence is "N source orderings measured, all identical" should be re-tested with a fence
BEFORE being quoted again — three such STRONG floors fell this wave (`CD_Read` w34-a3,
`resizememadr` w34-a3, `restartstream` w35-a5). Do the w46 ALIAS-CHECK first: if the two insns are
chained by a may-alias store, no fence exists.

## 3. PER-FN DETAIL

### loadfileadratomic — 22 -> PASS (the w44 ref-step dial, first eaclib landing)
reqdelta/allocsim on the real `-dg`/`-dl` dumps: the ONLY minimal dial for retail's handout
(`a`->$s2, size->$s3) is **p81(`a`) refs 6 -> 8** (floor_log2 step 2->3: pri .194 -> .387, overtaking
size's .333 and staying under handle's .476). Delivered with a `do{}while(0)` phony loop wrapping
**only the two `a` dereferences** (`nm = a->name; mc = a->memclass;`), because flow.c weights refs
inside by loop_depth. **SPAN GRANULARITY IS THE WHOLE TRICK**: wrapping the entire hook CALL
statement also lifts buf(p88) 7->8, r(p92) and p93 by one each, re-sorting the list and swapping
their s0/s1 — measured 28, i.e. WORSE than the 22 baseline. The w32/w35 arithmetic ("`a` needs >=8
refs, not expressible") was right; it predates the w44 zero-insn inflators.

### loadbigfileheaderatomic — 7 -> 4, and now COUNT-EXACT 81/81
The w33/w34 note proved the oracle map falls out for free "as soon as the success close recomputes"
and concluded no source form makes it. The opacity fence does. Residual 4 = a 2-insn issue-order
swap in the first readsync's arg block (retail emits `li a3,0xA90` then `addiu s3,s4,-1`, i.e. rm1's
def sits INSIDE the arg group; ours defs rm1 first, lower luid). **Measured and rejected:** fence
before the call / after the call / at the success close (identical 4) · embedded assignment
`FILE_readsync(..., (rm1 = retry - 1))` 39 @84 · named `int n0 = 0xA90` for the 4th arg (folds, 4) ·
bare expression + alias after it 38 @85 · bare `retry-1` everywhere + fence on `retry` 30 @79.
**NEXT:** the dial is arg-group MEMBERSHIP of rm1's def (calls.c precompute: on MIPS -O2 an arg is
precomputed only when its rtx is not already a REG and rtx_cost > 2) — retail's 5th arg was an
EXPRESSION whose cse temp IS the shared rm1; reproducing that needs cse to build the temp AND have
it survive, which is the C-lane cse identity a7-a9 are chartered to probe.

### CD_Read — 2 -> PASS (two cooperating levers)
1. fence the **cache-base** materialization, not the offset: retail issues `addiu v0,s1,60` BEFORE
   `lw a0,8(s0)`, so the pin goes on the base (fencing the offset gets the load order right but
   inverts the addu operands: 6 diffs);
2. **accumulate the address INTO the index** (`off = rs->curOff; off += (int)cache;` then
   `blockmove((void *)off, ...)`) — the catalog's SampleLength row: the index's register becomes the
   addu DEST and the call argument (`addu a0,a0,v0`); the array form `&cache[off]` gives
   `addu a0,v0,a0`.
The three w34-a3 falsifications stand exactly as written — all three are ORDER hints, none is a
barrier, and none touches the addu operand roles.

### intarcsin — residual RECLASSIFIED (kept at 2; the w33/w34 verdict is half-refuted)
Their claim was: any form naming the address once loses an instruction (47), any form writing the
subscript twice always re-emits the add. **False for the instruction shape.** With
```c
const unsigned char *pt = &kArcsinTable[idx];
const unsigned char *qt = pt;  __asm__("" : "=r"(qt) : "0"(qt));
t0 = pt[0];  t1 = qt[1];
```
the build is COUNT-EXACT 48/48 with retail's exact shape (`addu`, `addu ..,zero`, `lbu`, `lbu`) —
the copy survives. It gates **24** only because the sum lands in the wrong member of the pair
(retail sum->$v1 copy->$v0; ours the reverse). That is a **local-alloc QTY_CMP_PRI** question
(w45 §A0), not a cse question. Measured around it: fence on `pt` instead 25 @47 (copy dies again);
load order t1-then-t0 22 @48. **NEXT: qtytrace/-dl the two pointer qtys and dial the pair.** Do not
go back to spelling the subscript.

### setfont — kept at 2; NEW ANGLE with numbers
Retail stores 0xA0 through the still-live `cf` (`sw v0,0xA0($s1)`), then materializes the tail base;
we store through `cf2`. Switching to retail's shape gates 74 because it flips the fontId/currentfont
allocno pair. **reqdelta on that variant says the minimal dials are p80(fontId) refs 17 -> 15
(floor_log2 4->3) or p81(cf) refs 19 -> 24.** Measured: depth-2 `do{}while(0)` on the three
cf-only constant stores delivers the +6 and DOES flip the pair — **74 -> 9** — but costs +1 insn
(101/100, a load-delay `nop`); split +3/+2 across two spans 14 @102; the w45 store-read-back ref
DELETER (`CFI(cf,0x28) = CFI(cf,0x24)`) removes 2 fontId refs but also 4 instructions (8 @96 —
retail really does re-load and re-add). So the cf-store route needs a **zero-cost +5 on cf** (or
−2 on fontId) that no inflator in the current kit provides. This is a sharper target than the old
"allocno_compare delta" note: one number, two known-good dial families.

### synccallback / unrefpack / STREAM_create / STREAM_cancelrequest — measured, not landed
* **synccallback 21**: retail's grouping is home($s1)=advance, copy($s2)=re-issue+tail. With the
  opacity fence the copy survives under ANY grouping (the make_regs_eqv exclusivity the w34 note
  relies on is gone), but the retail grouping itself gates **63** @72 — so the direction is NOT
  purely a make_regs_eqv artifact; something else (volatile-store ordering in the advance chain)
  reacts. Re-open with the fence + a -dl read of the two ctrl qtys.
* **unrefpack 17**: class (a) is combine folding `out += reverse` into the arg copy because `out`
  dies at the copy. An opacity fence on `out` at all three sites DOES restore the three
  `addu s3,s3,s0` (156 insns, +3, exactly the predicted gap) but wrecks the coloring: **124 diffs**.
  The instruction-shape half of the (a) verdict is therefore refutable; the cost is a whole-function
  re-color, so it needs the fence PLUS an allocno plan, not the fence alone.
* **STREAM_create 4**: the residual is retail's cse copy `addu v0,v1,zero` vs our real
  `lw v1,24(s0)`. Non-volatile store + fence-on-`base` = 21 @143; non-volatile store + opaque
  read-back local = 21 @143 (both lose the instruction). The volatile store is still the best form.
* **STREAM_cancelrequest 2**: the ring-walk back edge (`bne p,s6,head; j exit` retail vs
  `beq p,s6,exit; j head` ours). Re-tested in this basin: guarded do-while = 2 (identical residual,
  confirming the w33 note), fence after the loop as a cross-jump de-merger = 34. Block-layout class.

## 4. NOT TOUCHED

**vramfxya (34)** — the w35-a6 receipt is the most complete in the cluster (a 9-allocno rank
permutation with two independently unsatisfiable constraints under allocno_compare). Its one stale
premise is "ref counts are fixed by the 165/165 instruction stream", which the w44 zero-insn
inflators break; but it already measured `do{}while(0)` wrappers here (all perturb the stream:
42/54/54) and the remaining inflators (semantic no-op re-mask, deliberate arm duplication) need a
full 9-way plan, not a single dial. Left for a dedicated agent with allocsim.

## 5. FLAG-AXIS SUSPICIONS (for a7/a8/a9)

| TU | signature | evidence |
|---|---|---|
| **eacpsxz/trnsmult.c** | scheduling/reload identity | `-fno-schedule-insns2` gives **EXACT 81/81 parity** (base 78/81) in a scratch, but leaves the reload shape (52 diffs); `-fno-schedule-insns` 37 @78; both 58. Root cause named in-source: **reload INHERITANCE** (ours keeps `a` in $a3 and adds into a fresh dest; retail reloads $v1 from the home slot and consumes in place). A flag that disables reload inheritance / changes `choose_reload_regs`, not a scheduler flag, is what this obj wants. |
| **eacpsxz/syncfile.c** | NOT a scheduling flag | `-fno-schedule-insns` makes synccallback WORSE (59 @72) **and regresses its neighbour syncblockio PASS -> 9** — recorded so the sweep does not re-derive it. |
| **eacpsxz/unref.c** | weaker-combine identity | our cc1 folds `srl 8 / sll 8 / andi 0x3f00` to one `andi`, and folds `out += reverse` into the arg copy; retail does neither. Flags measured (none adopted): `-mno-split-addresses` 17, `-fno-schedule-insns` 29, `-fno-schedule-insns2` 31, `-fno-delayed-branch` 97, `-fno-expensive-optimizations` 49. If a8 finds a per-TU combine/cse-strength flag, unref+trnsmult+syncfile are its three best eacpsxz witnesses. |
| **eacpsxz/nsync.c, cdfs.c, resize.c, stream.c** | **no flag needed** | all four cracked from source this wave; do not spend flag budget on them. |

## 6. PROCESS NOTES

* Worklist fuzzy% wrong again in both directions — **two rows (CdReadyHandler 99.98, openfile 99.91)
  were ALREADY PASS**, and 82.16% (transmult) is only 3 instructions short. Re-gate first, always.
* A receipt insert written with `\n` into a CRLF TU silently mixes line endings (fired once on
  cdfs.c, caught by git's LF/CRLF warning; normalized + re-gated).
* `git checkout -- <file>` is safe to use as "revert to the last landed lever" only because every
  lever was committed immediately — that habit saved two rollbacks this wave.

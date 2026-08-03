# w47-a2 receipts — eaclib/psx/spchpsxz (C lane): spchpick / spchrule / spchevnt

Base `ba09f774`, branch `w47-a2`. Gate = `python tools/verify_asm.py <file> <names>` from the
worktree root; every number below is the GATE, re-measured from this base (the worklist's fuzzy%
was wrong again — e.g. spchpick's own header still advertised the wave-33 numbers).

## Ledger (re-gated baseline -> final)

| fn | TU | baseline | final | lever |
|---|---|---|---|---|
| iSPCH_MatchSample | spchpick | 6 (65/65) | **PASS** | cursor computed at the LOOP TOP (reorg eager-steal duplicate) |
| iSPCH_SentenceGetChoices | spchpick | 1 (79/80) | **PASS** | default assigned BEFORE the test (no arm to cross-jump) |
| iSPCH_SentenceMakeChoice | spchpick | 7 (44/43) | **PASS** | goto-loop + `do{}while(0)` ref dial on the loop-back test |
| iSPCH_OrderSentences | spchpick | 9 (82/83) | **PASS** | ONE function-scope cursor shared by both walk loops |
| iSPCH_IterateChoice | spchpick | 4 (44/44) | 4 | quantified (see below) — new named angle |
| iSPCH_ConstantRuleSet | spchpick | 10 (83/83) | 10 | untouched this wave (budget) |
| iSPCH_GetRuleSettings | spchrule | 43 (113/112) | **40 (112/112)** | a9's `gSentenceRuleTest[]` unsized-array decl (count now exact) |
| iSPCH_RuleSet | spchrule | 14 (78/78) | 14 | falsified the load-collapse; new angle recorded |
| SPCH_AddEvent | spchevnt | 16 (80/82) | 16 | mechanism sharpened (delete_noop_moves) |
| iSPCH_InitEventQueue | spchevnt | 12 (29/29) | 12 | mechanism sharpened + flag axis closed |

**+4 PASS, 1 count-exactness gain, ZERO regressions** (full-TU gates after every landed edit:
spchpick 23->27 of 27 tracked oracles, spchrule 6/8, spchevnt 10/12).

## New named angles (generalizable)

1. **REORG EAGER-STEAL DUPLICATE MASQUERADES AS A PREHEADER INIT** (MatchSample).
   When the SAME instruction appears once in the loop preheader and once in the back branch's
   delay slot, it is ONE source statement at the TOP of the loop body — reorg stole the loop's
   first insn into the delay slot, retargeted the loop label past it and left the entry copy in
   the preheader. Writing it instead as a pre-loop init + a bottom-of-body update lets cc1
   const-propagate the zeroed counter into the preheader copy (`addu v1,s6,zero` vs the oracle's
   `addu v0,s6,s1`) and drags a $v0/$v1 coloring diff along with it.

2. **PRE-SET THE DEFAULT BEFORE THE TEST** (SentenceGetChoices).
   An oracle branch whose delay slot holds a store that the fall-through immediately overwrites
   is a DEFAULT ASSIGNED BEFORE THE TEST, never an early-out arm. As an arm (`if (bad) { r = 0;
   goto out; }`) the block is byte-identical to the function's shared failure block, jump.c
   cross-jumps it away, and because that shared block re-sets the result register reorg is then
   free to fill the slot from the fall-through instead. Written before the test, the assignment
   simply precedes the branch and fill_simple_delay_slots' backward scan (which skips over — but
   does not stop at — the conflicting compare feeders) moves it into the slot.

3. **A GOTO-LOOP IS ONLY HALF A FIX — RE-WEIGHT WITH A PHONY LOOP** (SentenceMakeChoice).
   Going label+goto to kill a loop.c giv anchor also throws away the loop-depth REF WEIGHTING of
   the counter and bound, which rotates saved registers. `do { if (i < n) goto top; } while (0);`
   is stripped by loop.c as a phony loop (so the giv anchor cannot come back) while flow.c still
   counts the refs inside it at depth 1 — i 4->5, n 3->4 — which restored retail's exact
   walker/i/n/ok = $s0/$s1/$s2/$s3 order at ZERO instructions. This closed a residual two prior
   waves had certified as an allocno live-length identity.

4. **ONE C89 FUNCTION-SCOPE CURSOR ACROSS BOTH LOOPS** (OrderSentences).
   "Ours 1 insn shorter, oracle copies the call result into a fresh register" on a per-loop
   pointer: a pointer declared inside a loop body is a BLOCK-LOCAL quantity, and being a copy of
   the call's return it carries a `qty_phys_copy_sugg` of $v0 which local_alloc honours in its
   suggestion pass — so the block's other temps get pushed off $v0/$v1 and the oracle's copy has
   nowhere to come from. Declaring ONE cursor at function scope and assigning it in BOTH loops
   makes the pseudo span two blocks (`REG_BASIC_BLOCK == -1`), local_alloc ignores it, and
   global_alloc homes it in $a0 — materializing the copy and the whole 3-way rotation at once.
   Also the more faithful shape (C89 declares everything at the top).

5. **THE "NO-COPY-PROP IDENTITY" IS `delete_noop_moves`** (InitEventQueue, AddEvent, RuleSet).
   A retail `addu $dst,$src,$zero` that we never emit is not a copy-propagation difference: a
   `(set (reg d) (reg s))` whose source dies there is tied by local-alloc's `combine_regs` into one
   quantity, both ends get the same hard reg, and flow deletes the now-noop move. Retail's copies
   survive because its two ends got DIFFERENT hard regs — and `combine_regs` refuses to tie when
   the destination is a GLOBAL allocno (`if (reg_qty[sreg] >= -1) return 0`). So the reachable
   lever is "make the PRODUCER's destination a distinct short-lived pseudo", not another spelling
   of the copy. Untried follow-up recorded in-source: an address-taken NON-volatile slot for
   RuleSet's dead decode store (volatile flushes cse's whole memory table, which is what forces
   our second `lbu`).

6. **IterateChoice quantified** (still 4): the entry block has exactly TWO local qtys — the
   address base {high, lo_sum} and the n*6 chain — so local-alloc takes the hand-rolled `case 2`
   branch, which IS a priority compare (`QTY_CMP_PRI = floor_log2(refs)*refs*size/(death-birth)`,
   member refs SUMMED). la-LAST: base 2.0 vs mult 1.2 -> retail's registers, wrong order.
   la-FIRST: base 0.8 vs mult 2.0 -> right order, wrong registers. With the la emitted first the
   base cannot win at 4 refs (it needs >= 8, i.e. ~6 extra uses) and the mult chain cannot drop to
   <= 2 refs (n*6 is 3 insns). The reachable target is a form where the mult chain is NOT a
   block-local qty at all (it writes straight into `choice`'s global pseudo). 15 spellings
   falsified; flag axis closed (see below).

## Flag-axis observations (for a7/a8/a9)

- **spchrule**: a9's lead confirmed by measurement — `gSentenceRuleTest` declared as a 4-byte
  SCALAR was the whole "wants -G0" signature. `extern SentenceRuleTestFn gSentenceRuleTest[];`
  + `[0]` at the two use sites: GetRuleSettings 43 -> 40 AND count-exact 112/112, no regressions.
  LANDED here (commit `c8b1e037`). No -G change needed.
- **spchpick / iSPCH_IterateChoice**: swept -fno-schedule-insns (24), -fno-schedule-insns2 (10),
  both (28), -mno-split-addresses (15 at 43 insns), -G0, -G8, -fno-strength-reduce — all >= the
  4-diff baseline. CLOSED.
- **spchevnt / iSPCH_InitEventQueue**: 19-option sweep (expensive-optimizations, rerun-cse-after-loop,
  cse-follow-jumps, cse-skip-blocks, thread-jumps, force-mem, caller-saves, peephole, function-cse,
  strength-reduce, inline, defer-pop, omit-frame-pointer, schedule-insns{,2}, delayed-branch) —
  every cse/loop/inline switch is diff-neutral; only -fno-schedule-insns changes anything and it
  trades the inner bound test `slti`->`slt`. -fno-delayed-branch 32 insns, -fno-omit-frame-pointer
  35. CLOSED for this TU. (Prior waves already proved -mno-split-addresses breaks 9 PASSes here,
  so SPCHPSXZ.OBJ is definitively a split-addresses object.)
- No -G8 signature found anywhere in the three TUs: every small symbol they own is reached
  absolutely in the oracle, and all three TUs gate identically at -G0/-G4/-G8 on the probed fns.

## Tooling added (committed under scratch/, prefixed)

- `scratch/w47_a2_probe.py` — mini-TU probe harness: compiles a hand-written .i containing ONE
  function through CC1PSX + maspsx with build.py's real flag set and diffs it against the
  function's oracle with a gate-shaped normalizer. ~0.15 s per variant (vs ~40 s for the gate),
  and after the `beq r,zero` fix its diff count MATCHES verify_asm exactly on every function
  tried here. Known gap: it does not run GNU as, so an unexpanded assembler macro (`lw $r,sym`
  from a scalar extern) shows as ONE line where the object has two — check for that before
  trusting an insn count (it is why the ConstantRuleSet mini-TU reads 81 where the object is 83).
- `scratch/w47_a2_{iterate,makechoice,order,ieq,crs}.py` — the variant sets used above (each is a
  standalone falsification record: re-run to reproduce every number in this file).

## Bugs

None found this wave — all five landed edits are codegen-shape changes with identical semantics
(verified against the oracle instruction-by-instruction before gating, per the w46 law that a
broken body can score better).

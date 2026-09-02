# W85-S7 — NAMED ANGLES (falsified work + mechanisms) — appendix to S7_receipt.md

## A. `resize.c` resizememadr — the call-result-copy vs load PRIORITY law (2 diffs)

Residual: oracle emits `addu a2,v0,zero` (the MEM_tailsize result copy) BEFORE `lw v1,40(s5)`
(the alignment load); ours emits the load first. Count-exact 94/94.

**MECHANISM (proven from the cc1 `-dS` RTL dump + the gcc-2.8.1 `sched.c` source, not guessed).**
gcc-2.8's scheduler builds each block BACKWARD, picking `ready[0]` (the highest `INSN_PRIORITY`)
and placing it at the TAIL. `priority(insn)` is the longest DEPENDENCY-DEPTH from the block start
(max over `LOG_LINKS` of `insn_cost(pred) + priority(pred)`) — the insn's CONSUMERS are
irrelevant. The dump (`scratch/rtl_a5/resize.i.sched`) shows the two competitors' links exactly:

```
(insn 97  (set (reg 87) (reg:SI 2 v0))            ... (insn_list 95 (nil)))          <- TRUE dep on the call
(insn 100 (set (reg 84) (mem (plus (reg 91) 40))) ... (insn_list:REG_DEP_ANTI 95))   <- ANTI dep on the call
```

`mips.h`'s `ADJUST_COST` zeroes anti/output dependence costs, and `insn_cost` then clamps
`ncost <= 1` back up to 1. So `priority(load) = priority(call) + 1` while
`priority(copy) = priority(call) + result_ready_cost(call) >= priority(call) + 2`. The copy
therefore always wins the pick and is always placed LATER. Raising the load's priority requires
an extra `LOG_LINK` on a deeper predecessor, i.e. a real instruction between the call and the
load. On a priority TIE the class/LUID tie-breaks would already give the oracle's order — they
never get a vote.

**=> Structurally unreachable from source without adding an instruction. A zero-insn read-only
fence is the only barrier that stops the pick from happening at all.**

FALSIFIED (13 source shapes, all re-measured this wave; all 2 diffs @94/94 unless noted):
avail hoisted above the calls 74 @96 | avail between the call and the align load 2 |
align re-derived via `memclass[flags & 0xF]` 32 @100 | align load hoisted above the calls 70 @96 |
split `size += tail` 6 | getblockname inlined into the MEM_tailsize call 2 | `(0-align)` spelling 2 |
`tail + size` operand swap 4 | `alignpad + (size+tail)` reassociation 12 | `unsigned tail` 2 |
align load moved adjacent to the alignpad statement 2 | `tail` declared first 2 |
align read through an early `int *alignp` 2.

COMPILER AXIS CLOSED (version-only, no fence): 2.8.0 = 2, 2.8.1 = 2, 2.7.2 = 80,
2.7.2-970404 = 17 @95, 2.6.3 = 80.

---

## B. `vramfxya.c` — PURE-C REF INFLATOR FOUND (16 -> 2 with ZERO devices)

The 9 read-only fences are an allocno REF-COUNT dial (5 refs onto `maskHi`, 4 onto the
`clutXm`/`clutYm` pair). Eight prior waves recorded "no zero-insn pure-C ref inflator exists"
(constant re-masks fold at tree level, dead sets are deleted before flow counts them, copy chains
fold away).

**THAT IS NOW FALSE. The IDEMPOTENT VARIABLE-MASK / IDEMPOTENT-OR inflator works:**

- `packed = c[3] & maskHi; packed &= maskHi; packed &= maskHi; ...` — each extra `&= mask` is a
  real RTL insn (the mask is a VARIABLE, so `fold()` cannot remove it at tree level); cse then
  proves it redundant and deletes it. **Ref counted, zero bytes.**
- `c[3] = packed | clutXm | clutXm | clutXm;` — same, for the idempotent OR.

Progress with ZERO devices, count-exact 165/165 throughout:
`16 -> 14 (h=2) -> 10 -> 2` at (maskHi extra masks h=3, clutYm ORs ym=2, clutXm ORs xm=2).
Grid measured: h in {1..7} x ym in {0..4} x xm in {0..4}; the 2-diff basin is (3,2,2) and its
neighbours (5,3,2) (5,4,2) (7,3,2) (7,4,2) (5,3,3) (5,4,3) (5,4,4) (7,4,3) (7,4,4).

At 2 diffs **the register assignment is retail-EXACT** (c s0, maskHi s1, clutYm s2, clutXm s3,
maskLo s4) — the 8-wave "ALLOCNO_COMPARE DELTA / route to toolchain identity" verdict recorded in
this file is REFUTED on the source axis.

**THE REMAINING 2 DIFFS ARE ONE STATEMENT POSITION — a LICM-vs-sched2 deadlock.**
Retail emits `li s4,-4096` (maskLo) FIRST in the post-guard block; ours emits it LAST, because
the in-loop `maskLo = ~0xFFFu;` redef is LICM-hoisted and `move_movables` inserts hoisted insns at
the END of the preheader (highest LUID -> sched2's LUID tie-break places it last).

- Drop the in-loop redef => the preheader becomes EXACT, but the switch's jump-table address
  materialization breaks (10 diffs: ours `sll` index first with the base in `t0`; retail
  `lui/addiu` base first with the index in `v1`). The in-loop mask redef is what fixes that block.
- Mirror it (`maskHi = 0xF000FFFFu;` at the loop head instead, maskLo preheader-only) => 4 diffs:
  `li s4` lands first and the switch is right, but maskHi's `lui/ori` is then the hoisted pair and
  goes last.

=> **Exactly one of {maskLo, maskHi} can be non-hoisted; retail has BOTH non-hoisted.**

FALSIFIED around it (all gated this wave): dead-local reads of maskHi x5 (16 — deleted by flow) |
`maskHi &= maskHi` x5 (16 — tree-folds) | `maskHi = maskHi | (maskLo & maskHi)` x5 (16) |
self-masking clutXm/clutYm x4 (16) | drop the redundant `packed &= maskLo` (24) | drop the loop-head
maskLo redef (10, and 22/46 in combinations) | maskLo redef moved to the CLUT tail (27 @166), to
`walk:` (31 @166), to the loop bottom (55 @164) | loop-head `packed = maskLo` / `packed = 0` /
`i = 0` / `next = 0` / `data = 0` / a dead `maskSpare` constant (all 10) | switch spellings
`*(unsigned char *)c` / a named tag local / an `(int)` cast / mask-then-cast (all 10) |
`clut24[131]` / `clut24[132]` instead of the volatile pad (50) | hybrid 2-diff basin plus ONE
fence at 5 placements (20 / 20 / 20 / 14 / 2 — never better than the pure-C 2).

**NEXT ATTACK (named, NOT a floor):** either make the loop-head mask redef survive as a
NON-hoistable loop-invariant (so both constants stay in preheader source order), or find the
source form of the switch block's base-before-index materialization in the drop-both-redefs basin
— that basin already has a byte-exact preheader and only the 5-insn jump-table block differs.

---

## C. `stream.c` restartstream (2 diffs) — sched2 ready-list tie on two same-base loads

Oracle `lw a2,64(s1)` (readptr) then `lw v1,72(s1)` (fillptr); ours reversed. Registers already
match; count-exact 167/167.

FALSIFIED (all 2 @167/167): swap the two load statements | swap the two declarations | swap both |
`uVar5 < uVar3` guard polarity | fused decl-with-init | embedded assignment in the guard (one side
and both sides) | inverted guard with an early goto | `uVar5` declared signed.
Confirms the prior wave's reading: the argument-launch boost wins every ready-list tie, so source
ORDER is inert here and only a BARRIER moves it.

---

## D. `stream.c` STREAM_cancelrequest (2 diffs) — jump.c forwarding artifact

jump.c's "conditional jump around an unconditional jump" inversion (`beq exit; j head` ->
`bne head`) only fires when `Lexit:` is immediately followed by the arm's own `j <join>`. Our
build forwards the loop-exit edge straight to the join first, deleting that block.

FALSIFIED this wave: DEAD statements at the arm tail (`p = s6;`, `p = 0;`, `s6 = p;`,
`p = (int *)s6;`, `rstate = 0;`) are all 2 — they are deleted before the jump pass that forwards
the edge. (`s4 = p;` = 46 @171: it is not dead, and it perturbs the arm.)
Any C statement that SURVIVES to that pass costs bytes; the void-tail fence is the only zero-byte
insn available at that point.

---

## E. `unref.c` unrefpack (122 diffs without the fence) — NOT ATTEMPTED, named for the next agent

The device is a 4-operand allocno REF dial (`src` x1, `op` x3). The idempotent-mask inflator of
section B was discovered AFTER this file was measured and is the obvious next probe: `op` is
consumed by `op >> 0xe & 3`, `op >> 8`, `(op >> 16) & 0xff`, `op & 0x3f`, so idempotent `& mask`
chains against a VARIABLE mask local are available at every one of those sites.

---

## CATALOG ROW CANDIDATES (for the orchestrator to harvest)

1. **PURE-C ZERO-INSN CSE KILL.** Symptom: an opacity/identity fence
   `__asm__("" : "=r"(x) : "0"(x))` is holding a match by destroying a cse value-number equality.
   Fix: a DEAD REASSIGNMENT `x = <any value cse cannot prove equal to the old one>;` placed after
   x's last real read. cse sees the write (equality killed); flow's dead-store elimination deletes
   the insn (zero bytes). Must not fold — `x = x + 0` fails. C block scope is NOT a cse boundary.
   [nsync.c loadbigfileheaderatomic: 24 diffs -> PASS 81/81, fence deleted]

2. **PURE-C ZERO-INSN REF INFLATOR.** Symptom: a read-only fence `__asm__("" : : "r"(x))` is
   buying allocno REF COUNTS (catalog 06B/07B, the reqdelta dial). Fix: repeat an IDEMPOTENT
   operation with a VARIABLE operand — `v &= mask; v &= mask;` or `r = a | x | x | x;`. A variable
   operand survives `fold()` as real RTL (so flow counts the reference) and cse then deletes it
   (so it costs 0 bytes). The classic falsified inflators (constant re-masks, dead sets, copy
   chains, do-while(0) wrappers) all fail for the OPPOSITE reason: they vanish BEFORE flow counts.
   Each extra operation is +1 ref, loop-depth weighted like any other. [vramfxya.c: 16 -> 2,
   count-exact 165/165, register assignment reaching retail-exact]

3. **`volatile` ON A LOOP RECORD POINTER IS USUALLY A GIV-ANCHOR CRUTCH.** Symptom: ours grows a
   SECOND walking giv (`addiu tN,base,K`, negative displacements like `lw v1,-4(tN)`, and its own
   `addiu tN,tN,stride`) where retail keeps ONE base with displacements 0/4/8 and a single
   `addiu base,base,stride`; ours is +1 insn. Fix: the INDEX FORM `p[i].field` (methodology
   3.12 #1) or a label+goto loop — NOT `volatile`. [stream.c filterchunk: 15 @21 -> PASS @20]

4. **THE BACKWARD-SCHEDULER PRIORITY LAW (recognition row, stop-grinding).** In gcc-2.8 a
   call-result COPY always outranks a memory LOAD placed after the same call — TRUE dep cost >= 2
   vs an ANTI dep cost clamped to 1 by `ADJUST_COST` + `insn_cost` — and since the scheduler runs
   backward placing the highest-priority insn LAST, the copy is always emitted AFTER the load. If
   the oracle emits the copy BEFORE the load, no statement order, reassociation, declaration
   order, or type change can fix it: `priority` depends only on an insn's PREDECESSORS. It needs a
   barrier (or a real insn between the call and the load). [resize.c resizememadr, 2 diffs]

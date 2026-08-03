# w47-a1 receipts — recon/eaclib/psx/eacpsxz/nfile.c (C lane, CC1PSX)

Base `ba09f774`, branch `w47-a1`, worktree `C:/Temp/nfs4-wt47-a1`.
Gate = `python tools/verify_asm.py recon/eaclib/psx/eacpsxz/nfile.c <fns>` (1 s/probe).
Full TU = 27 fns; **PASS 18 -> 20**, worklist rows 9.

## Ledger (re-gated baseline -> final; the worklist fuzzy% was wrong on every row)

| fn | worklist | RE-GATED base | final | delta |
|---|---|---|---|---|
| FILE_opstatus      | 99.55% | 2  (22/22)   | 2  | — (parked, named) |
| FILE_operror       | 72.50% | 13 (11/12)   | **3** | −10 |
| FILE_callbackop    | 93.75% | 2  (32/32)   | **PASS** | −2 |
| FILE_priorityop    | 99.81% | 6  (79/79)   | **PASS** | −6 |
| FILE_cancelop      | 98.39% | 14 (109/109) | 14 | — (split into 2 named classes) |
| FILE_completeop    | 97.34% | 28 (47/47)   | **2** | −26 |
| iFILE_ExecCommand  | 98.34% | 10 (290/290) | 10 | — (flag-axis) |
| reserveop          | 89.30% | 40 (71/71)   | 40 | — (blocker re-identified) |
| reservehandle      | 96.82% | 17 (43/44)   | **3** | −14 |

Total 132 -> 74 diffs, **+2 PASS**, zero regressions (full-TU re-gate after every landed edit).

## THE WAVE'S LEVER HERE: the zero-insn USE FENCE as a LIVE-RANGE device

`__asm__("" : : "r"(x))` on a register-resident local costs 0 insns (w45 cost profile) and does
three separable jobs.  Four of the five wins are ONE job: **hold a value live past the point where
our cc1 would otherwise clobber/kill it**, which reproduces retail's register handout exactly.

1. **FILE_operror 13 -> 3.** Split the shift into its own statement (`idx = id >> 0x18;`) so it is
   written OUT of place, + a fence on `id` after it.  `$a0` stays live across the shift (so the
   in-place `srl a0,a0,24` is illegal) and DIES at the fence, freeing `$a0` for the `%hi` base:
   `lui a0,%hi` lands in retail's register and the whole index chain becomes identical.  The fence
   also pins the frame `addiu sp,sp,-16` at ENTRY (gcc otherwise sinks the unused-frame allocation
   to the tail: 2 more diffs).
2. **FILE_completeop 28 -> 2.** A fence on `id` placed AFTER the `op` pointer's birth keeps `$a0`
   live past it, which **breaks the `$a0` copy-preference** that global.c's find_reg was honouring
   for `op` (the w32 root cause: the `freeop(op)` arg copy gives `op` a preference for `$a0`).
   `op` moves to retail's `$a1`, the whole body follows, and retail's `addu a0,a1,zero` appears in
   the `jal freeop` delay slot.  Second edit: `result = 0` written as the ELSE ARM of the status
   test (not an up-front init) puts `addu s0,zero,zero` in the `bne` delay slot (§5.0c).
   Residual 2 = the `sw s0,32(sp)` prologue save, which retail issues at insn 2 and sched sinks to
   the fence position in ours.
3. **FILE_priorityop 6 -> PASS.** Same device as (1), one line: a fence on `id` after the decls.
   Kills the w34 verdict "an EXACT local-alloc priority tie ... unreachable from C".
4. **reservehandle 17 -> 3.** A fence on `cur` placed AFTER `next = cur + 0x4C` makes the two
   walk pointers simultaneously live with DIFFERENT values, so cc1 can no longer copy-propagate
   them into one walker.  Retail's loop-head `addu v1,a1,zero` appears and the cur/next/count/sr
   web lands on retail's v1/a1/a2/a3.  **This refutes the w32/w33 verdict** "no legal C can keep
   them apart / our loop.c is weaker at SR at a non-power-of-2 stride".
5. **FILE_callbackop 2 -> PASS** (+ a CORRECTNESS fix): the `op->callback = callback` store is
   UNCONDITIONAL in retail (it sits in the status-test branch's delay slot, executing even when
   status == 0) — the recon had it inside the `if`.  Hoisting it gives reorg the simple fill it
   really did; a fence on `callback` then pins the assign_parms param copy (`addu a3,a1,zero`) at
   retail's prologue position (w46 prologue-param-copy-sink class — the sink IS blockable by a
   fence, which the w46 note did not have).

**Boundary measured here:** the fence's barrier property can cost the very insn you are chasing —
in reservehandle it stops reorg's SIMPLE fill of the `bnez` slot with the advance, so reorg
EAGER-STEALS the loop-head copy instead (45 vs 44 insns = the residual 3).  Moving the fence above
the advance restores 44/44 but the copy lands after the `beqz` and the a-band rotates (24 diffs).
=> a split-forcing device that is NOT a scheduling barrier would take reservehandle to PASS.

## reserveop 40 — the blocker is LOCAL-alloc, not the allocno order (new, quantified)

allocsim reproduces this fn 13/13 (order-vs-dump IDENTICAL) in both basins.

* retail handout: `slot=a0, off=a1, i=a2, seqMask=a3, lo_sum=t0, hicopy=t1`.
* basin A (in-tree): `slot=a0 ✔, off=a2, i=a3, lo_sum=t0, hicopy=a1, seqMask=t1`.
* basin B (drop the w35 `seq` guard-read, 46 diffs): `off=a0, slot=a1` — an EXACT 1.5000 priority
  tie that `off` wins on the lower allocno number — `i=a2 ✔, lo_sum=a3, hicopy=t0, seqMask=t1`.

🔴 `off` (p82) carries a **hard-reg-5 conflict in BOTH basins** (`;; 82 conflicts: ... 2 5 29`), so
no allocno-order dial can ever give it retail's `$a1`.  `reqdelta --want` finds NO single- or
two-dial (refs/live/calls) solution within ±60 in either basin — consistent with that.  The
conflict is manufactured by **local-alloc**, which runs first and parks the THIRD oparray-reload +
slot-address pair (p107/p108) in `$a1`; retail's local-alloc parked the same pair in `$a0`
(`lw a0,24(t0); addu a0,a1,a0`), leaving `$a1` free for the global `off`.
**NEXT ANGLE:** dial the block-local qty priorities/births in the free-slot block (w46:
QTY_CMP_PRI == allocno_compare; check next_qty against the 3-QTY LAW) so the recompute pair takes
`$a0`.  Falsified this wave, with numbers: unify the three slot addresses into one `op` variable
(48; p90 becomes refs=16/pri 3.37, allocated first, but then carries hard-3/4 conflicts and takes
`$a1` itself); all four mask constants assigned INSIDE the loop so loop.c hoists them after the
base pair (46 — this DOES fix the preheader order to retail's base-pair-before-constants, but
`off=0` then lands before the pair).

## FILE_cancelop 14 — split into two named classes (do not re-fight as one)

* (a) 2 of the 7 diff lines: `li v0,1` before the status compare and `li v0,2` in the action==2
  `bnez` delay slot — retail REMATERIALIZES a constant that is still live in a register; our cse
  copy-propagates.  Same identity as iFILE_ExecCommand's `li a1,124`.
* (b) 5 lines (10 diffs): the `gFileMgr.state--` RMW `v0/v1` swap is a LOCAL-ALLOC question — the
  RMW block holds exactly THREE block-local qtys (la address, loaded value, the `li -1` for the
  status store), and per the w46 **3-QTY LAW** blocks with next_qty ≤ 3 are hand-rolled, NOT
  priority-ordered, so retail's value-first order is unreachable by any ref/live dial.
  **NEXT ANGLE: cross the 3↔4 boundary** (add/remove one DISTINCT block-local temp in that block).
  Falsified (all 14 @109/109): split RMW via a named temp, `state = state - 1` double-eval, a
  `FileMgr *m` base local, `action = 2;` reordered before the RMW.  `op->status = -1;` ahead of the
  RMW reaches 12 but at 111/109 → rejected (count must stay exact).

## 🔬 FLAG-AXIS SUSPICION for nfile.obj (for a8/a9)

**cse copy-propagation of a still-live CONSTANT.**  Three independent instances inside this one TU:
`iFILE_ExecCommand` (`addu a1,v0,zero` vs retail `li a1,124` for `strchr(name,'|')`),
`FILE_cancelop` (`li v0,1`), `FILE_cancelop` (`li v0,2`).  In every case retail emits a fresh `li`
where our cc1 substitutes a register copy of an equal-cost live value.  This is the documented
"old-gcc no-copy-prop" per-object identity (methodology §3.25-3b: DrawOTag/_padSetActAlign/CdRead2)
— nfile.obj is now its densest single-TU sample, so it is a good fingerprinting target: a flag set
that makes the rebuilt cc1 stop the copy-prop on THESE three sites is per-module evidence.
Second (weaker) nfile fingerprint: `iFILE_ExecCommand`'s jump-table `sll v1,v1,2` scheduled before
vs after the table `lui/addiu` (sll-index-vs-base sched1 tie).

## Parked, with the angle named

| fn | residual | angle |
|---|---|---|
| FILE_opstatus | 2 | commutative `addu a0,v0,v1` operand tie; offset-first spellings DO flip it but recolor the mask/base web (18–19 diffs, 3 spellings this wave). Needs the w43 expression-vs-mutation form that flips the order WITHOUT moving the index chain. |
| FILE_operror | 3 | retail's surviving assign_parms parm copy (`addu v1,a0,zero` + in-place `srl`). combine substitutes the hard arg reg into its single use; a 2nd fence adds a ref but the copy still coalesces (a0 is unmodified between copy and uses, and the `%hi` that clobbers `$a0` in retail is still a pseudo at cse time). Per-TU flag question. |
| FILE_completeop | 2 | `sw s0,32(sp)` prologue-save issue position; the fence can't be placed before the C89 decl block without re-rotating everything (measured: splitting the decls = 32 diffs). |
| iFILE_ExecCommand | 10 | flag axis (above) + the jump-table sll tie. |
| reserveop | 40 | local-alloc hard-`$a1` conflict (above). |
| FILE_cancelop | 14 | 3-qty law (above) + flag axis. |
| reservehandle | 3 | need a non-barrier split device (above). |

## Tools/process notes

* `scratch/w47_a1_probe.py` — snippet-swap probe harness against `scratch/w47_a1_base.c` (CRLF-safe,
  1 s/probe).  ⚠️ `/tmp` is NOT shared between the Bash tool and Windows python (fired again).
* Worklist fuzzy% was wrong on all 9 rows (e.g. `FILE_operror` "72.50%" was 11/12 insns, 13 diffs;
  `reserveop` "89.30%" was count-EXACT).  Re-gate first, always.
* Disk C: hit **100% full** at wave start — the first `git worktree add` died mid-checkout
  ("No space left on device").  Re-ran once space freed; worth watching with 10 agents.

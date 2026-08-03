# WAVE-47 agent a4 — sndpsxz part B (C lane) receipts

Base ba09f774. Worktree C:/Temp/nfs4-wt47-a4, branch w47-a4.

## 0. RE-GATED BASELINES (worklist fuzzy% was wrong again — one row was already PASS)

| fn | TU | worklist% | re-gated | ours/oracle |
|---|---|---|---|---|
| iSND100hzserver | sserver.c | 99.97% | **PASS** (stale row) | 184 |
| iSNDserverremove100hzclient | sserver.c | 93.02% | 3 diffs | 44/43 |
| iSNDserverremoveclient | ssysserv.c | 93.02% | 3 diffs | 44/43 |
| iSNDpsxmemconstrain | sdmemman.c | 91.94% | 14 diffs | 31/31 |
| iSNDpsxmalloc | sdmemman.c | 79.20% | 59 diffs | 120/127 |
| iSNDplatformresolve | sdresolv.c | 99.17% | 3 diffs | 126/127 |
| iSNDmalloc | smemman.c | 91.09% | 48 diffs | 137/135 |
| iSNDdownloadbank | sbdload.c | 88.35% | 23 diffs | 85/84 |
| iSNDdmcallback | sdma.c | 99.91% | 4 diffs | 111/111 |

## 1. iSNDdmcallback (sdma.c) — 4 diffs, 111/111. PARKED, mechanism advanced.

Residual = ours `lui v0,%hi(sndpd); addiu v1,v0,%lo` (SEPARATE %hi scratch) vs oracle
`lui v1,%hi; addiu v1,v1,%lo` (SELF-TEMP).  Root cause found: `wait` is one fn-scope local doing
TWO jobs (sndpd base, then the settle-loop counter) => it is a GLOBAL allocno, and local_alloc's
`combine_regs` can only tie the `(high)` pseudo to a BLOCK-LOCAL lo_sum.  Splitting into
`hwbase` + `wait` (w46 STORAGE-SCOPE LAW) **does produce the self-temp shape** — but the two
resulting block-local qtys take the registers the other way round (ours base=$v0/rmw-temp=$v1,
oracle base=$v1/rmw-temp=$v0) and the cascade is 14 diffs vs the baseline 4.  REVERTED.
* sized asm-label view `extern u_char sndpd_s[0x800] asm("sndpd")` at that site: byte-identical
  (4 diffs) — the sized-vs-unsized %hi-scratch dial does NOT fire on an EXTERN-only symbol here.
* NEXT ANGLE (parked): from the SPLIT basin, dial the two block-local qtys with the
  QTY_CMP_PRI ref/live instruments (w45 §A0) — the split basin is 100% shape-correct and needs
  only a $v0<->$v1 flip; that is a 1-dial reqdelta problem, not a spelling problem.

## 2. iSNDpsxmemconstrain (sdmemman.c) — 14 diffs, 31/31. PARKED, W35 causal chain REFUTED.

The standing STRONG-floor note (w33/w34/w35) says the residual is (i) the two head loads issue in
the wrong order (sched1 ready-list) and (ii) a 3-way register rotation that FOLLOWS from (i).
NEW (w47): a zero-insn USE FENCE (w45/w46 sched-issue-position fixpoint) between the two loads
**does fix the order** — first time (i) has moved in three waves; all three fence spellings
(`"r"(lo)`, `"r"(size)`, bare `: : : "memory"`) give byte-identical output:
      ours   lhu v0,1306(t0) ; andi v1,v0,65535 ; slt v0,a2,v1
      oracle lhu a3,1306(t0) ; nop              ; slt v0,a2,a3
=> 16 diffs (31/31).  TWO findings:
  (a) COST: the fence sits between the HImode load and its zero_extend, so combine can no longer
      merge them into the bare `lhu` — an explicit `andi rX,rX,0xffff` appears where the oracle
      has the load-delay `nop`.  (New general boundary for the fence instrument: **never fence
      between a narrow load and its widening use.**)
  (b) 🔴 The rotation is NOT downstream of the order: with the order corrected, `lo` STILL lands
      in $v1 instead of $a3.  W35's "(ii) follows from (i)" is FALSIFIED.  The rotation is an
      independent allocno fact and must be attacked with reqdelta/allocsim, not by re-spelling.

## 3. 🏆 iSNDplatformresolve (sdresolv.c) — 3 diffs @126 → **PASS 127/127**

The w33/w34 notes named the blocker but blamed the WRONG reorg pass: it is the BACKWARD
`fill_simple_delay_slots` scan (with `cur = scan++` the advance sits *before* the compare in the
insn stream; the volatile compare load is skipped as the branch's own dependency and the scan walks
back one more and takes the advance), not the eager fill.  Three cooperating edits:
1. **advance AFTER the compare** + `found:` reads `scan->spu` (w34-a5's shape) — makes `scan`($v1)
   live-in at `found` so no fill may clobber it.  Alone: 7 diffs @126.
2. **zero-insn IDENTITY FENCE** `__asm__ ("" : "=r"(cur) : "0"(cur));` on the copy — defining `cur`
   with an opaque asm breaks cse's copy-propagation so the compare addresses through `cur`($a0)
   like retail, AND blocks the backward fill.  Measured: input-only fences (`"r"(cur)`, with or
   without a `"memory"` clobber) = 4 diffs — they block the fill but do NOT break the copy-prop;
   only the OUTPUT (identity) form does.  Zero instructions (127 == oracle), no hard reg named.
3. **statement order** `scan = cur + 1;` before `idx++;` (luid = independent-chain issue order).
Without (2): 7.  Without (3): 4.  Without (1): 3/4.  All three required.
🔴 GOVERNANCE NOTE: (2) stands in for the per-obj **old-gcc no-copy-prop identity** already recorded
for sndpsxz (methodology §3.25-3d, catalog w33 §G).  Flagged for the flag-axis lanes — if a per-TU
flag reproduces "cc1 does not copy-propagate this copy", delete the asm and the match should hold.
Honest fallback documented in-source: 7 diffs.

### NEW NAMED ANGLE: **the IDENTITY FENCE** (`"=r"(x) : "0"(x)`)
A third fence mode beyond w45/w46's input-only fence (which does live-range stretching, cross-jump
de-merging and sched-fixpoint work).  The identity form additionally **breaks cse/loop copy
propagation**: the destination becomes an asm-defined pseudo with no equivalence to its source and
no parm-copy preference.  Zero insns when the allocator ties the tied operands.  It is the direct
source-level handle on the whole documented "retail keeps a redundant copy / no-copy-prop"
per-object identity family.

## 4. 🏆 iSNDdownloadbank (sbdload.c) — 23 → 14 diffs (86 insns / oracle 84)

Residual class (c) of the standing floor note — "the oracle spends one extra `addu a0,v0,zero` at
the arm merge; ours coalesces abs straight into $a0" — is **source-reachable** after all, via
**STORE-THEN-READ-BACK**:
```
- abs = bankData + off4 + *(int *)(cur4 + 0x14);   *(int *)(cur4 + 0x14) = abs;
+ *(int *)(cur4 + 0x14) = bankData + off4 + *(int *)(cur4 + 0x14);   abs = *(int *)(cur4 + 0x14);
```
cse forwards the just-stored value as a register COPY = retail's exact `addu v0,v0,v1; sw v0,20(s1);
addu a0,v0,zero`, in BOTH arms, and it fixes the whole merge's a0/v0 colouring.
🔑 The earlier rejects (in-place `abs +=`, arg temp, per-arm abs — 46/42/37) all wrote the VALUE into
a variable; **the load-bearing detail is that the second read must come from MEMORY** (the field just
written).  Same family as the identity fence: both are source handles on the no-copy-prop identity.
RE-TESTED IN THE NEW BASIN (lever-order law): walker clear loop **31** (was 50 in the old basin);
bound-load-before-`i++` via a named local — diff-neutral (sched1 re-floats the lhu), reverted.
RESIDUAL 14 = the clear loop's `-fno-strength-reduce` degradation (+1 insn) + its `addu fp,s4,zero`
delay-slot fallout + the loop-tail lhu/addiu issue order (+1 nop) — all downstream of the SAME
per-obj SR identity (clear loop wants SR ON, patch loop wants it OFF).

## 5. The twins (iSNDserverremove100hzclient / iSNDserverremoveclient) — 3 diffs each, UNCHANGED

Both still carry the governance-blocked `volatile int cb` device (3 diffs @44; honest `int cb` = 41
@42).  W34's named mechanism is "a pseudo copied straight out of a parameter's hard reg carries a
copy PREFERENCE for that reg, and find_reg skips a reg a conflicting allocno prefers".
NEW MEASUREMENT (w47): honest `int cb` + an explicit one-insn asm copy
`__asm__ ("addu %0,%1,$0" : "=r"(target) : "r"(cb));` gives the oracle's **43/43 count** but still
42 diffs — the asm-output pseudo ALSO lands in $a0, so the parm preference is NOT the whole story;
the rotation survives removing the copy preference.  => the w34 mechanism note is INCOMPLETE.
Route: reqdelta/allocsim on {i, base, cb} rather than another spelling.

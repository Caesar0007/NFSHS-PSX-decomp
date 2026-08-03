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

# W76-A2 — psxfront font belt (`FontUpsideDownBlit__FiiPviiP12charactertbli`)

Repo `C:\Temp\nfs4-decomp`, TU `recon/frontend/psx/psxfront.cpp`, HEAD `52cd5920`.
Step-0 reads done (MIPS ISA ref, methodology, catalog §§20–24, W75 A2 receipt +
report).  All probing done on the live TU via a snapshot/restore harness
(`scratchpad/w76/A2_probe.py`, fresh snapshot == HEAD, verified byte-equal) —
the sibling-TU lane would silently drop this fn's path-keyed PER_FN_TEXT_MOVES
row and make every number incomparable with the W75 ladder; no other belt owns
psxfront.

## BASELINE (re-gated before any edit)

| item | value |
|---|---|
| `tugate recon/frontend/psx/psxfront.cpp` | **24/25 PASS** |
| `FontUpsideDownBlit` (landed lookalike) | **20 @ 82/82** |
| W75 I1 body (best true basin) re-installed | **46 @ 82/82** (reproduces exactly) |

## 1. 🏆 RESIDUAL (a) — THE yoff/mask $t3↔$t4 SERVING-ORDER INVERSION — CLOSED (46 → 34)

The brief's angle (1), executed with the instrumented cc1 as the instrument
(the W72-A8 lab reader; **lab byte-identical on the I1 body, 82/82 — the trace
is a receipt**, fidelity re-checked per basin).

### The numbers, read not guessed (`A2_i1_trace.txt`)

* `yoff`+`hoff` are **ONE qty** — `[qty_combine] pseudo 105 merged into qty 10
  of pseudo 99` (combine_regs ties the `addu hoff,height,yoff` because yoff
  dies there): refs 5, live 32, **pri 3125**.
* the `0x00ffffff` mask = **two tied constant pseudos** (p113 4 refs + p119 2
  refs): refs 6, live 60, **pri 2000**.
* Ours serves yoff first → ascending scan gives it `$t3`; mask gets `$t4`.
  Retail serves the mask first ⇒ needs mask pri > 3125 ⇒ **refs 6 → 8 crosses
  the floor_log2 rung: 3·8/60 = 4000**.  (Live-shortening is unreachable —
  the constant's def is block-head-placed and its last use is RMW2's store.)

### The lever (M3) — the w44-a2 PSXDrawTransSquare double-mask, statement level

```c
la = (uint)prim & 0xffffff;                                /* early, after the bump */
((PSXFront_PTag *)prim)->addr = pal->addr & 0xffffff;      /* RMW1: explicit re-mask */
pal->addr = la;                                            /* RMW2: masked variable */
```

A P_TAG bitfield store of a **variable** re-masks it — +1 flow ref each on the
mask constant.  combine folds the redundant `and`s away (**count stays 82**),
but flow's REG_N_REFS survive: mask qty **refs 8, pri 4000**, served first —
`lui t3,255 / lb t4 / subu t8,a1,t4 / addu t4,t6,t4 / and v0,v0,t3 /
and t3,t1,t3 / or v1,v1,t3` all **retail-exact**; the whole 9-line class gone.
Dose-response proven: named `la` alone = 7 refs, pri 2333 → still 46; both
sites = 8 refs → **34 @ 82/82** (`A2_r4_out.txt` M3; trace `A2_m3_trace_out.txt`
shows `2/123:8/60=4000`; sbs `A2_sbs_m3.txt`; body `A2_body_m3.cpp`).

## 2. M3 RESIDUAL ANATOMY (34 = 18 + 4 + 8 + 4)

* **HEAD 18 — a pure line-multiset PERMUTATION** (identical text both sides):
  ours emits the dv shift chain (slots 15-19) before the bump/RMW1/pal/y block
  (20-27); retail the reverse (14-21 then 22-27).  🔑 **The -dS dump
  (`A2_m3_psxfront.sched`) shows our POST-SCHED1 ORDER ALREADY MATCHES RETAIL'S
  FINAL** — dv shifts after the link block, y2/y3 late.  The damage is
  **sched2's hoist**, enabled by the dv LOAD's early slot (sched1 luid
  tie-break: dv = statement 3; retail's load sits after the pal load).
* **(c) 4 — the +5 carrier $v0-vs-$v1**: carrier window [52,58) overlaps
  RMW2-temp's $v1 [56,70) ⇒ ours can **never** take $v1 in this luid layout;
  retail's carrier luids sat past RMW2's window, and its late addiu@42/subu@46
  are the post-alloc sched2 echo of that $v1 anti-dep — register and position
  are one fact.
* **len/code 8 + clut 4** — source position: code-last / tpage-then-clut is
  the only order that holds the middle; retail's SLD order stays catastrophic
  here (T1 code-after-tint 78, T2 clut-before-tpage 138, T4 full-SLD 132).

## 3. MEASURED LADDER (every row re-gated; nothing landed)

| variant | gate |
|---|---|
| HEAD control / I1 control | 20 / 46 |
| r1: named-mask + launder ×1/×2 after rmw2; after tint | 71 @83 / 71 @83 / 90 |
| r1: named yoff def-top | 46 |
| r2: y3-into-bottom / y2+y3-into-bottom merges | 108 @86 / 108 @86 (basin collapse, 2nd s-reg) |
| r3: named la (7 refs) alone, 3 spellings | 46 / 46 / 46 |
| **r4 M3: la + RMW1 explicit re-mask (8 refs)** | **34 @ 82/82** |
| r4: ext+la both named | 46 / 50 |
| r5: dv after pal/L1/rmw1/rmw2/laE; y-chain/y1 after rmw1 | 106/106/136@78/146/106/148@80/147@85 |
| r6 device removal: no-L1 / no-L2 / no-both / no-xyfence / none | 50 / 82@78 / 86@78 / 80 / 118@78 |
| r7 tail: T1-T7 reorders | 78 / 138 / 132 / 132 / 80 / 36 / 38 |
| r8: y2/y3 late (arg6 carrier), 6 slots | 139@83 – 108@86 |
| r10: y2/y3 late (plain local carrier) | identical 139/141/108 @83-86 — the +insns are the late move, not arg6 |
| r9: srcw-copy + pal/prim-input tied-launder dv-dependence | 144-152 @80-81 (copy alone: 34, free) |
| per-fn flag splice (vprobe W75_FN_FLAG): -fno-schedule-insns2 / -fno-schedule-insns / -fno-expensive-optimizations | 69 @83 / 115 @79 / 89 @79 — **retail used DEFAULT scheduling, re-confirmed in this basin** |

**34 > 20 ⇒ nothing landed; the fn body stays byte-identical to HEAD.**

## 4. SIBLING-CORPUS CHECK (brief angle 2)

`C:\Temp\ps1-decomp-refs` swept for upside-down/flip blit constructs: only
CTR-in-C DecalFont, glover, VandalHearts-PC hits — none is a PSX gcc-2.8
straight-line FT4 packet builder, and the M3 residual is scheduler EMISSION
order, not a loop/idiom spelling a matched sibling could hand us.  Negative.

## 5. PIN VERDICT (brief angle 3 — last resort NOT met)

A `register T x asm("rN")` pin binds a value to a register; every remaining M3
cluster is emission ORDER (HEAD permutation, len/code, clut store slot) or a
live-window overlap ((c): no binding gives the carrier $v1 while its window
overlaps RMW2's temp — reload would just spill).  A pin cannot produce PASS in
any basin (the 20 basin is store-order-capped, W74-proven), so no pin was
landed.  **0 PIN-SEALED items.**

## 6. STATE AT CLOSE

* **Code: NO functional change.**  The only tracked-file edit is the
  comment-only W76-A2 receipt appended to the fn's receipt chain in
  `recon/frontend/psx/psxfront.cpp` (ASCII-only, CRLF-preserved, byte-mode
  write: 0 NUL, 0 bare-LF added, non-ASCII count unchanged).
* `tugate` re-run TWICE after the edit: **24/25 PASS, Font 20 — identical to
  baseline, ZERO PASS→FAIL.**  No slotcheck needed (no asm/272/RAW40 wiring
  landed).  No git add/commit.  `tools/build.py` untouched (its uncommitted
  foreign hunks preserved by not editing it at all).
* Harness (all UNTRACKED, `scratchpad/w76/`): `A2_probe.py` (snapshot
  install/gate/restore), `A2_r1..r10.py` + `_out.txt`s, `A2_trace1.py` +
  `A2_i1_trace.txt` (I1 qty trace), `A2_m3_trace_out.txt`, `A2_sbs_m3.txt`,
  `A2_body_m3.cpp` (the 34 body), `A2_m3_psxfront.{sched,lreg,s}` (protected
  -dS/-dl dumps), `A2_posmis_{m3,dvpal}.txt`, `A2_sbs_dvpal.txt`,
  `A2_r2A_asm.txt`.
* **NEW LAWS for the catalog** (candidates, cited above): (i) a bitfield
  store of a VARIABLE is a +1 mask-constant ref-step that combine erases from
  the byte stream but not from flow's ref counts — the statement-level form of
  w44-a2's double-mask, and the first measured 2-step ref dial crossing a
  floor_log2 rung (6→8 = pri ×2); (ii) a launder on a CONSTANT pseudo costs a
  real insn (multi-set demotes it out of const-sharing); (iii) the y2/y3-late
  blowup is carrier-independent (arg6 vs local identical) — it is the
  statement move itself.

## 7. NEXT (named, in order)

1. **HEAD 18**: one sched2 stale-order tie fed by the dv load's luid — run an
   instrumented **sched2** trace on the M3 body (lab is byte-identical; the
   existing GCC_TRACE_ALLOC covers alloc only) and find which ready-list tie
   flips the dv chain; the post-sched1 order is already retail.
2. **(c) 4**: any shape that pushes the carrier's BIRTH past luid 70 without
   moving the y2/y3 statements (every statement/carrier form measured costs
   +1..+4 insns).
3. len/code 8 + clut 4 fall out of the same sched2 emission question.
   With 1-3 closed the M3 basin is byte-exact — it already reproduces
   retail's frame, store order, link cluster, tint interleave AND the full
   t-band register handout.

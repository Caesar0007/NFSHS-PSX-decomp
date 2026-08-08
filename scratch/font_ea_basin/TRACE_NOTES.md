# Font 8004efb4 — instrumented-cc1 trace run on the EA-natural basin (2026-08-05)

Ordered by user: "run the instrumented-cc1 [qty_order]/[find_free_reg] trace targeting e3/e4".
Instrument: C:/Temp/nfs4-instr-cc1/cc1plus-ecoff.exe (w46-a10 build), recipe scratch/w46_a10_receipts.md.
Inputs: mine/psxfront_e3.i / _e5.i (gate-identical preprocessing, bodies from scratch/font_ea_basin/).
Flags: -quiet -O2 -G4 -mgas -msplit-addresses -funsigned-char -fno-exceptions -fno-rtti.
Traces: C:/Temp/nfs4-instr-cc1/trace_e3.txt / trace_e5.txt (Font section ~80 lines each).

## FIDELITY: 100%
Lab cc1plus output for Font on e3 == real CC1PLPSX byte-for-byte (79/79 insns, 0 mismatches).
The traces are RECEIPTS for the gate compilation, not illustrations.

## THE ALLOCATION, DECODED (regs: 2=v0 3=v1 4=a0 5=a1 6=a2 7=a3 8..15=t0..t7 24=t8 16=s0)

e3 (param-mutation body): PASS 1 (suggested) allocates u(qty24)->a3, src(15)->a2, x(0)->a0,
**y(qty10/pseudo81, refs10, sg=1 COPY-sugg) -> a1**. Pass 2 then: prim(qty6/87, refs26,
pri 7536)->t0, the mega-CSE qty16/150(refs17)->v1, tpage-load qty23->a2(after src dies), etc.
Everything downstream of y-on-a1 rotates one reg off retail.

e5 (fresh `ytop` var, y single-read): the COPY-sugg dies (only 3 [qty_sugg] lines) BUT
qty10 is now pseudo 91 (the ytop chain) and STILL allocates in pass 1 with sugg 1 -> a1:
combine substituted hard a1 into the subu, and the OPERAND-TIE suggestion (qty_phys_sugg)
re-created the a1 bond. e3 and e5 emit BYTE-IDENTICAL Font asm.

## 🔴 LAW (trace-proven): the ytop-chain/a1 tie is SPELLING-INVARIANT in this basin.
Whether the chain head is a mutated param (copy-sugg) or a fresh var consuming the arrival
reg (operand-tie sugg), local-alloc's SUGGESTED PASS hands it a1 BEFORE any ordinary qty
competes. No source spelling of `first = y - yoff` escapes both channels.

## RETAIL'S ALLOCATION, REVERSE-ENGINEERED (consistent with every window in the trace)
Retail needs ytop's pass-1 a1 attempt to FAIL (or the qty to be unsuggested), so that:
1. p128 (2nd src+0xc read, pri ~2592, window ~[84,138)) allocates first in pass 2,
   scan 2/3/4 blocked -> takes a1  (retail `lw a1,12(a2)` — the old p128 razor).
2. ytop (pri ~1093, window ~[28,154)) then scans: a1 blocked by p128-inside-window,
   a2/a3 blocked (src/u live into the window), t0-t7 blocked (dv/prim/pal/masks/yoff/
   height/width) -> first free = reg 24 = **t8**. Exactly retail.

## REMAINING UNKNOWN (the one question left)
What condition makes the pass-1 suggested try fail/not exist in retail's compile of the
SAME chain-head insn (`subu t8,a1,t4` — src1 IS the dying a1 there too). Candidates to
settle by READING the patched local-alloc.c (scratch/instr, branch w46-a10):
- exact qty_phys_sugg recording conditions (when is the operand-tie NOT recorded);
- find_free_reg(just_try_suggested) window semantics at the birth luid (born==death
  boundary parity — could retail's ytop window OVERLAP the hard-a1 range [0,born)?);
- qty_combine effects on the chain qty's birth (a merge that widens the window into
  the hard-a1 live range would block the pass-1 try and produce EXACTLY retail);
- scheduling (sched1 runs before local-alloc; luid layout differences move windows).
NOT candidates any more: every source-level spelling dial (falsified across e1..e5 +
the 48-basin's full receipt).

## STATE
e3/e4 stay the SYM/SLD-true reference bodies at 124@82 (gate), shipping 48-body unchanged.
Next concrete step: local-alloc.c condition read + a targeted instrument print at the
just_try_suggested rejection site, then re-run this exact lane (fidelity is proven, the
loop is minutes per iteration).

## ROUND 2 (2026-08-05, "next"): THE LOCAL-ALLOC.C CONDITION — FOUND AND NAMED
Source read (gcc-2.8.1 tarball /c/Temp/gcc-2.8.1-src/gcc281.tar.gz: local-alloc.c + config/mips/mips.h):
1. MIPS defines NO REG_ALLOC_ORDER => find_free_reg scans regnos SEQUENTIALLY 0..31
   (v0,v1,a0..a3,t0..t7,s0..s7,t8,t9). s0(16) precedes t8(24).
2. find_free_reg does NOT exclude callee-saved regs for no-call qtys (used = fixed_reg_set
   + window liveness only). So a pass-2 local qty that fails 2..15 takes s0/s1 NEXT —
   local-alloc can NEVER produce retail's ytop@t8-while-only-s0-is-saved.
3. Eligibility (local-alloc.c:472): a pseudo is local-allocatable iff
   REG_BASIC_BLOCK>=0 && REG_N_DEATHS==1. Otherwise it falls to GLOBAL.c — which DOES
   prefer call-used regs (save/restore cost) => t8 before s1.
🏆 => RETAIL'S ytop PSEUDO WAS ALLOCATED BY GLOBAL.C: its live range is SPLIT (2 deaths).
And retail's asm shows the split explicitly: `addiu v1,t8,5` READS y (death #1, the
unfolded +5 intermediate in v1), `subu t8,v1,t4` REBIRTHS y (death #2 at last sh).
THE THREE SYMPTOMS ARE ONE MECHANISM: +5-unfold == live-range split == t8-not-a1.
p128->a1 stays a plain local pass-2 outcome once ytop is out of the local pool.

## ROUND-2 FALSIFICATIONS (all gated 132@82 == the folded E2 basin; e11 .s verified
identical chain `subu $5,$5,$10` — no addiu+5 survives):
- (int)/(long)/(unsigned) casts around (y+5)  [STRIP_NOPS]
- (int)((char *)y + 5) pointer-arith barrier
- GNU statement-expression ({ y + 5; })
MECHANISM OF FLATTENING: tree-level fold reassociates statement-granular (w45 §C), and
whatever expand splits, COMBINE re-merges single-use chains and simplify_plus_minus
re-associates. An intermediate survives ONLY if fold can't see through it AND combine
refuses the merge.

## NEXT ROUND (focused, fresh context):
1. Read fold-const.c reassociation (split_tree/associate) EXACT conditions for
   MINUS(PLUS(y,5), B) — find the tree shape it skips.
2. Read combine.c can_combine_p/subst — when is the (plus y 5) temp NOT merged
   (hard-reg refs? multi-use? volatile? mode games?).
3. Candidate probes after the read: SAVE_EXPR routes (a construct using (y+5) twice
   that cse collapses back to one), C-vs-C++ frontend fold differences, forcing
   REG_N_DEATHS=2 by any other legal shape (the death-split is the GOAL; the +5 temp
   is just its visible footprint).
4. Verify with GCC_TRACE_ALLOC: success == ytop qty ABSENT from local trace (global)
   + y@t8 in .s; then re-gate (expect a collapse toward 0) and only then port the
   spelling into the shipping body.

## ROUND 3 (2026-08-05, "continue"): THE SPLIT IS SOURCE-REACHABLE — combine claim FALSIFIED
fold-const.c read: our y-(B-5) is EXACTLY associate's "VAR +- (ARG1 +- CON)" output
(fold-const.c:4325); split_tree strips only MODE-PRESERVING conversions (so int/long/ptr
casts are transparent — why e8-e11 failed at TREE level) and needs the node to be
PLUS/MINUS (SAVE_EXPR/complex wrappers block it). Association CANNOT cross statements
through a DIFFERENT variable.
🏆 E15 (font_e15_arg6.cpp): `y = y - yoff; arg6 = y + 5; y = arg6 - (height + yoff);`
REAL CC1PLPSX OUTPUT KEEPS THE CHAIN:
    subu $9,$5,$10 / addu $10,$14,$10 / addu $5,$9,5 / subu $9,$5,$10
== retail's subu t8 / addu t4 / addiu v1,5 / subu t8 SHAPE (registers rotated).
=> ROUND-2's "combine re-merges single-use chains" is FALSIFIED — e8-e11 died at tree
level only. The +5-split (and thus the live-range split) IS source-reachable.
Gate still 132@82: y-chain lands $9=t1, arg6 temp $5=a1 — the REST of the fill rotated
(prim t0-vs-t1, etc). The remaining work is the LOCAL FILL ORDER (dv/prim/pal/masks/
yoff/height/width -> t0..t7 in retail's exact order) on top of the split — bounded
E-basin search with the trace lane as oracle.
OPEN QUESTIONS for round 4: (1) is E15's y-chain actually 2-death/global now? (trace it:
GCC_TRACE_ALLOC on psxfront_e15.i, check y qty ABSENT from local + which pass gave t1);
(2) retail's local fill starts dv@t0 BEFORE prim@t1 despite prim's higher priority —
check whether prim (or another) is ALSO global in retail, or whether dv's refs/live in
the true source (the -1-in-UV dial, e4) flip the order; (3) the arg6 spelling contradicts
SYM (arg6 has NO ARG record — likely unnamed param in EA source) — find the equivalent
legal carrier for the +5 statement (candidates: one of the 4 locals if any is dead in
that window — NONE currently — or the SAVE_EXPR-generating construct, or accept that
the SYM omits a 5th short-lived REG local under some stabs condition and probe a named
`ytop` variant e5+split = `ytop = y - yoff; ??? = ytop + 5; ...`).
Files: mine/psxfront_e15.{i,s} in C:/Temp/nfs4-instr-cc1.

## ROUND 4 (2026-08-05): GLOBAL.C CONFIRMED LIVE — [find_reg] allocno for the y-chain
trace_e15.txt: `[find_reg] allocno 0 pseudo 81 refs 8 live 51 calls 0 ... -> reg 9` —
the y-chain is a GLOBAL allocno in e15 (the arg6 split produced the 2-death pseudo;
y's copy-sugg is gone from pass 1: only x/src/u remain). MECHANISM FULLY CONFIRMED:
split -> 2 deaths -> global.c. It lands t1 (not t8) ONLY because our local fill leaves
t1 open.
E15 LOCAL FILL (decoded): tiny temps timeshare v0/v1; prim(7647)->t0; qty10(6666)->t1;
dv-cluster qty22(10refs/58life,5172)->A1 (+arg6 +5 temp shares a1, disjoint windows);
p128 qty23(2592)->a2; masks/etc t2..t7; v(250)->s0. Global y -> first free = t1.
RETAIL FILL, NOW FULLY DERIVED: dv's BIRTH (lw @EFFC) PRECEDES the y-arrival read
(subu @F004) => dv's window OVERLAPS the hard-a1 live range [0,subu) => a1 BLOCKED for
dv => dv->t0 (v0=ch,v1=temps,a0=x also blocked); prim then ->t1, pal->t2, m1->t3,
yoff->t4, m2->t5, height->t6, width->t7; p128 (late, 2592) -> a1 (free after hard range
ends); v->s0; ch->v0; global y: t0..t7+v0/v1/a0..a3+s0 ALL conflict -> reg 24 = T8.
EVERY RETAIL REGISTER IS NOW EXPLAINED by priority order + window overlaps.
REMAINING DELTAS (ours-e15 vs retail), all fill-order artifacts:
 (a) our dv window starts AFTER the hard-a1 death (sched1 placement) -> dv steals a1;
     retail needs dv born BEFORE the subu (source order has it; our sched1 moved it);
 (b) our 8 tiny temps all pile on v0 (retail leaves v0 for ch);
 (c) prim t0-vs-t1 follows automatically from (a).
NEXT (round 5 / focused session or wave): guided search over the small source dials
(dv/tpage/clut statement positions, the -1-in-UV dial to reshape dv's qty, +5-carrier
variants) x gate, reading each result's trace — the search is now DIRECTED: success
criterion per probe = dv@t0 in the local fill, then y-global lands t8 by construction.
Also still open: the SYM-LEGAL +5 carrier (arg6 has no ARG record in SYM = unnamed
param in EA source; candidates: a named short-lived local the stabs might omit, a
SAVE_EXPR construct, or an EA macro).

## ROUND 5 (2026-08-05, "continue round 5"): 124 -> 82, FOURTEEN OF SIXTEEN REGISTERS RETAIL-EXACT
Matrix (all on the e15 arg6-split base): V1 (-1-in-UV, old position) 132 · V2/V3 (dv stmt
hoisted before prim) 110 · V4 (y-chain after addPrim) 116 · V5 (after font_tint) 120 ·
🏆 V7 (FULL SLD ORDER: width, height, dv, y-chain, prim, bump, addPrim, tint, 9, 2c,
clut, tpage, UV, XY) = 82@82 · V8 (V7 + -1-in-UV) = 82 identical asm.
V7 REGISTER MAP vs retail: MATCHED = pktptr-addr v1 lui-pair, m1 0xFFFFFF @t3,
m2 0xFF000000 @t5, ch @v0, yoff @t4, palette-value @t2, height @t6, width @t7, v @s0,
x/src/u @a0/a2/a3, p128 @a1, +5 temp @v1, **y @t8** — the whole crown chain.
REMAINING = ONE SWAP: prim@t0/dv@t1 (retail dv@t0/prim@t1); their ~36 refs touch nearly
every insn = the whole 82.
SWAP MECHANICS (from priorities + windows): prim (26 refs, pri ~7647) legitimately beats
dv (~10-15 refs, pri ~5200) EVEN IN RETAIL — so retail's prim@t1 means t0 was blocked at
prim's turn by one of the HIGHER-pri tiny temps (the 10000/8947-pri v0/v1 timesharers).
In ours all five tiny temps take v0 and the 8947 mega-temp takes v1, leaving t0 for prim.
In retail ONE tiny temp must sit on v1 (v0 blocked in its window by ch's [10,28) range or
a neighbor), pushing the 8947 mega-temp (whose window overlaps hard-a1, src, u, x => 
v0/v1/a0-a3 all blocked) onto T0 -> prim -> t1 -> dv -> t0 by cascade.
NEXT (round 6): seed the tiny-temp v0/v1 split — dials: positions/order of the len=9 /
code=0x2c / clut stores and the tint line (their li temps ARE the tiny qtys), the ch
field-read grouping (ch's v0 window vs temp windows), addPrim-vs-tint order. Per-probe
oracle: lab .s (prim moves to $9/t1 = success; then gate should collapse to ~0).
STILL OPEN: SYM-legal +5 carrier (arg6 is unnamed in EA source per SYM).
Files: font_v1..v8.cpp here; mine/psxfront_v7/v8.{i,s} in C:/Temp/nfs4-instr-cc1.

## ROUND 6 (2026-08-05, "continue round 6"): 82 -> 44 — V10 LANDED AS SHIPPING BODY
V7 trace decoded the swap: dv=q8 (17refs/94life, pri 7234) vs prim=q9 (26/130, 8000) —
prim wins t0 by 766. Retail's dv is born ~14 luids later (life ~78 -> pri ~8717),
OUTRANKING prim -> t0 with v0/v1/a1 all blocked over its window. Global y reads
`-> 24` (t8) directly in trace_v7. Dial = delay dv's birth (e15 position) while keeping
a v1-blocker tiny temp in its window.
Matrix: V10 (e15 order + TINT MOVED BEFORE ADDPRIM) = 🏆 44@82 — BEATS THE 48-BODY;
V11 (tint after codes) 126; V12 (clut early) 88@78; V15 (y1 hoisted) 59@85; V16 (tint
before dv) 140; V17 (bump after dv) 106.
V10 REGISTER MAP: dv@T0 ✓ prim@T1 ✓ (the swap FLIPPED — tint-early put its value temp
on v0 inside dv's window, reshaping the fill) + all of round-5's matches hold (y@t8,
+5@v1, p128@a1, pal@t2, masks t3/t5, yoff@t4, height/width/v, tint@v0) = 14/16.
REMAINING 44 = HEAD ONLY (tail from `sh t6,10` byte-exact): (a) the 0x1F800004
addr-temp ours t0-early vs retail v1; (b) ch ours v1 vs retail v0; + their position
echoes (lb t4 placement, tag-lw/pal-lw order, li 9/44 order, tint-load position).
LANDED: V10 replaced the 48-body in psxfront.cpp (banner + old receipts preserved;
old body in git @79865d5a). Gate re-verified 44; sibling DrawFlatShape still PASS.
ROUND 7: (1) flip addr-temp->v1 + ch->v0 (head statement dials: width/height read
order vs prim line; masks materialization; maybe addPrim's operand eval order);
(2) the SYM-legal +5 carrier to replace arg6.

================================================================================
ROUND 8 (2026-08-08) — the residual-28 adjudicated: WRONG SOURCE-ORDER BASIN,
retail order + mutations derived; blocked on ONE sched1 tie-break. Gate stays 28.
================================================================================
INSTRUMENT UPGRADE: -dS (sched1 dump) WORKS on the lab cc1plus and prints ready
lists + per-insn priorities + the full post-sched RTL. V21 fidelity re-proven
79/79 (mine/psxfront_v21.i.sched = a receipt).

1) THE 28 IS SOURCE-ORDER-LOCKED, NOT SCHEDULER NOISE. gcc 2.8 sched cannot
   reorder ambiguous memory ops (store prim->r0 vs loads of 0x1F800000-based
   cells = true_dependence): insns 90/92 carry (insn_list 84) deps. Emission
   order of the tint/pal cluster == SOURCE statement order. Retail's cluster
   (pal early / tint group sunk into the 2nd OT-link RMW) is UNREACHABLE from
   the V21 tint-before-link body. The V21 28-body = a lookalike basin.
2) RETAIL SOURCE ORDER PROVEN (full per-insn SLD pulled from nfs4-f-v3.txt,
   VA efb4..f0fc): decls 1434 · width 1440 · height 1441 · dv 1444 · y 1446/47
   · ALLOC+BUMP+LINK all line 1449 · tint 1452 · len=9 1455 · code 1456 ·
   clut 1460 · tpage 1461 · UV 1463 · XY 1466. Independently CONFIRMED by
   edgbla's community draft (addPrim -> setRGB0_EA -> setPolyFT4).
3) 🏆 THREE IN-PLACE MUTATIONS READ OFF THE ORACLE TAIL (new source facts):
   pos53 addu t0,t0,t6 = dv += height   (SLD 1463, inside the UV line)
   pos54 addu t6,t8,t6 = height = y + height (SLD 1466 head)
   pos55 addu t7,a0,t7 = width  = x + width  (SLD 1466 head)
   These are 1-death in-place qty extensions (NOT y-style splits: a set that
   uses its own reg emits no REG_DEAD -> stays local-alloc). They also explain
   diff blocks 7/8 (the sh t6,10 tail echo: y0-store must wait for the mutation).
4) v@s0 MECHANISM: find_free_reg's NUMERIC scan visits s0(16) BEFORE t8(24);
   v -> s0 (and the 8-byte frame) iff v0..t7 are ALL blocked over v's window at
   v's (last) fill turn. Any basin that computes dv early shortens v's window,
   drops the frame, and goes count-SHORT 78 (V35/V37).
5) PROBE LADDER (all re-gated, receipts in traces): V22r (tint after link,
   =old V22) 112 — dv falls to v1 (v1 scan-hole; the V21 12000-pri tag-merge
   blocker p115+p116 splits into 4+4-ref low-pri qtys) · V26 (full-SLD order,
   dv early) 82 — retail-shaped EMISSION, but dv born luid 22 pri 7234 < prim
   8000 -> prim steals t0 (dv/prim swap = whole 82) · V27-V31 dv-position scan:
   82/82/82/82/130 (sched1 normalizes all pre-link dv slots; dv-after-link 130)
   · V32-34 link spellings (named lk / named pal / two stmts) all 112 =
   RTL-neutral · V35/V37 (SLD order + THE MUTATIONS) 130 @ count 78 — cluster
   emission == retail, mutations present as in-place addus, but frame gone (see
   4) + head fill cascade (width/height/yoff t6/t4/t1 vs retail t7/t6/t4).
   qtytrace --want receipt (V22r): dv already OUT-RANKS prim; its v1-landing is
   a scan-hole, not an ordering problem.
6) 🔴 THE ONE REMAINING UNKNOWN: sched1's tie-break between the dv-load
   (insn 71, pri 2) and the tag-read (insn 94, pri 2). Ours emits dv first
   (dv@14, tag@21); retail emits tag@15/pal@16-17 BEFORE dv@18 — that single
   transposition sets dv's birth luid ~36 (pri ~8500 > prim) AND stretches v's
   window (frame+s0) AND cascades the whole 16-reg map. NEXT = read gcc-2.8.1
   sched.c rank_for_schedule (tarball C:/Temp/gcc-2.8.1-src/gcc281.tar.gz) for
   the exact tie rule (luid direction? ref_count?), then pick the source dial
   that flips ONLY this tie (candidate: dv expression shape / the head decl
   that changes insn luid parity; NOT position — position is sched-invariant).
   Variants banked: font_v37.cpp (SLD order + mutations, the true-basin seed).
STATUS: shipping body = V21 (28) UNCHANGED; V37 banked. Files: mine/psxfront_
v{21,22r,26,35,37}.{i,s}, trace_v{21,22r,26,37}.txt, *.sched (instr dir).

================================================================================
ROUND 9 (2026-08-08) — rank_for_schedule read + SLD −1 correction; retail-order
basin 130→96; the weave is source-order-INVARIANT; gate stays 28.
================================================================================
1) 🏆 THE TIE RULE (gcc-2.8.1 sched.c:2415 rank_for_schedule, read not guessed):
   backward list scheduler; ready-list sort = (a) INSN_PRIORITY desc; (b) class
   vs last_scheduled_insn: 3 (independent OR latency-1) > 2 (anti/output-dep)
   > 1 (data-dep w/ latency>1) — this is the LOAD-LATENCY SLOT-FILLER: the insn
   placed directly before a load's consumer is chosen from independents; (c)
   INSN_LUID (original RTL order — stability, "minimize movement"). So on a
   pure tie EMISSION ORDER == SOURCE ORDER, and retail's tag@15-before-dv@18
   requires either a pri delta or a class-rule fire that our RTL doesn't give.
2) 🏆 SLD CORRECTION (re-read of the f020 record): retail's `addiu t0,t0,-1`
   (pos 27) is tagged line 1463 = THE UV LINE, not 1444 ⇒ retail dv decl-init
   (1444) has NO -1; the -1 is an IN-PLACE `dv -= 1` (or --dv) AT the UV site,
   sitting beside the `dv += height` mutation. Corrected source model:
     int dv = ((*(int*)((int)src+0xc) << 4) >> 0x14) + v & 0xff;   // 1444
     ... link, tint, 9, 2c, clut, tpage ...
     dv -= 1;  UV stores;  dv += height;  UV stores;               // 1463
     height = y + height;  width = x + width;  XY stores;          // 1466
3) PROBE LADDER round 9 (corrected model): V38 (dv after bump) 150 ·
   V39/V40/V41/V42 (dv first / after w+h / after y1 / after y2) ALL 96 ·
   V43 (after bump) 150.  96 = best retail-order gate so far (was 130).
4) 🔴 THE WEAVE IS SOURCE-ORDER-INVARIANT: in every variant sched1 packs the
   dv init chain (incl. the -1, hoisted!) immediately after its load at the
   head (V39 lab: chain at 5-13), while retail interleaves ch/bump/tag/pal
   loads first (10-17) and sinks the dv chain to 18-27. Consequence: v's
   window stays short -> v misses s0 (numeric-scan law, round 8) -> frame gone
   -> ALL retail-order variants count 78 vs 82. No statement position reaches
   the retail weave; the divergence lives in RTL DETAIL, not statement order.
5) ROUND-10 ENTRY POINTS (ranked): (a) instrument sched.c — add a
   rank_for_schedule decision trace (print winner/loser/reason at each pick;
   scratch/instr/apply_traces.py + build_cc1.sh, ~6 min rebuild) and read WHY
   retail's weave needs which pri/class relations, then solve backward to the
   RTL shape; (b) the +5 CARRIER: arg6 (7th-param mutation) is BOTH SYM-illegal
   AND an RTL divergence candidate — enumerate legal carriers (named local is
   SYM-false too; check gcc's own temp from a paren/sequence form) with the
   trace as oracle; (c) yoffset lb: retail lb tagged 1446 (loaded AT the y
   statement); ours emits it in the ch-block — probe separating the lb.
STATUS: shipping = V21 (28) verified intact. Best-of-round banked:
mine/v39.cpp + psxfront_v39.{i,s} + trace_v39.txt.

================================================================================
ROUND 10 (2026-08-08) — sched1-vs-sched2 conflation corrected; mutation-tail
combos gated; 🏆 the A1-HARD-REG-LIFETIME law found. Gate stays 28.
================================================================================
0) CORRECTION to rounds 8-9 reasoning: the emission being matched is
   POST-SCHED2 (after RA; frame present); -dS = sched1 (pre-RA). V39's
   post-sched1 RTL confirms our sched1 already packs dv early PRE-RA.
   Crucially V21's post-sched1 layout yields BOTH the 16/16 retail RA AND
   retail-matching dv-chain emission -> the SLD-order rotations of rounds 8-9
   were over-rotated; the search moved back to the V21 head.
1) NEW COMBO GATES (all count-78 = frame lost): V44 (V21 head + tint-late +
   mutation tail) 130 · V45 (V21 + mutation tail only, tint-early) 118 ·
   V46 (V45 + split dv-=1) 128.  THE MUTATION TAIL KILLS THE FRAME IN EVERY
   BASIN: absorbing the anonymous y+height/x+width/dv+height temps into
   height/width/dv changes the graph, sched hoists the y1-subu to pos 15
   (V21: 24, retail: 20) and the fill rotates.
2) 🏆 NEW LAW — A1-HARD-REG-LIFETIME steers the pal-cell landing: the hard
   $a1 (y param) stays live until the y1-subu READS it; find_free_reg's scan
   visits a1(5) BEFORE t2(10), so pal-cell [40,68) lands on a1 whenever the
   y1-subu emits early (a1 dead -> hole), t2 only when the subu emits late
   enough to block a1 across pal's window (V21 subu@24 luid48 ✓, V45 subu@15
   luid30 ✗ -> pal→a1 -> yoff→t2 -> m2→t4 -> width→t5 -> v→t7 -> NO FRAME).
   Same scan-hole family as round-8's dv→v1; the hard-reg lifetimes are part
   of the fill inputs, steered by SCHED1 emission of the param-consuming insns.
3) SOLVER BOUNDARIES banked (qtytrace --want on V45, full retail map):
   dv beats prim with +1 ref (0.7826>0.7647) · pal beats yoff for t2 with
   +1 ref · width takes t7 iff m2 blocks t5 first · v→s0 iff t7 blocked.
   All deltas small; each fix rotates the next (N-body) — gate-only probing
   is exhausted as a method for this fn.
4) ROUND-11 ROUTE (the instruments-only path): (a) build the
   rank_for_schedule DECISION TRACE into the lab cc1plus (apply_traces.py +
   build_cc1.sh, ~6min) — per-pick winner/loser/rule readout for BOTH sched1
   and sched2; (b) drive a directed source search with per-probe LAB feedback
   (fills + weave + a1-lifetime), success = V21's 16/16 fill PLUS the
   retail cluster order; the solver boundaries above are the acceptance
   tests per probe. (c) fallback = accept 28 (park with Draw-20ce).
STATUS: shipping = V21 (28) restored + verified. New traces: trace_v45.txt
(+ v44/v46 gates), mine/psxfront_v45.{i,s}.

================================================================================
ROUND 11 (2026-08-08) — 🏆 THE SCHED DECISION-TRACE INSTRUMENT IS BUILT,
VALIDATED, AND READ. Gate stays 28; the causal chain is instrumented end-to-end.
================================================================================
1) INSTRUMENT: apply_traces.py gains patch_sched() -- [sched_pick] at
   schedule_block's ready[0] selection: pass (0=sched1/1=sched2), clock, the
   PREVIOUS last_scheduled, and per ready insn (INSN_PRIORITY, rank-class vs
   last, INSN_LUID).  Env GCC_TRACE_SCHED.  Rebuilt from tarball via
   build_cc1.sh ecoff + LANGUAGES="c c++" cc1plus (the w46 build trees had
   died with the pruned worktree; ~8 min).  New binary:
   C:/Temp/nfs4-instr-cc1/cc1plus-r11.exe.
   🏆 FIDELITY: traces-off output on psxfront_v21.i is BYTE-IDENTICAL to the
   proven lab cc1plus -> every pick line is a receipt.
2) PARSER: scratch/font_ea_basin/pickparse.py -- aligns [sched_pick] with the
   -dS RTL, labels insns (TINT/PAL*/CLUT/...), and names the DECIDING RULE per
   pick (pri | class | luid | only).  Traces: sched_v21.txt / sched_v45.txt,
   parsed picks_v21/45.txt (877/880 picks).
3) 🏆 READINGS: (a) a hidden layer -- many insns carry priority 0x7F000001 =
   the LAUNCH BOOST ("reg-killing insns launched into latency slots"), which
   dominates the pri rule; the static-priority reasoning of rounds 9-10 was
   incomplete.  (b) THE V21/V45 FIRST DIVERGENCE is at the forward HEAD (last
   backward picks): v45 picks the v-load (rule=pri) ahead of the height/width
   lbus -- the tail mutations deepen dv's chain, shift the head loads' static
   priorities, and rotate the ch-block = round-10's measured fill rotation.
   Causal chain now fully instrumented: source tail -> head-load priorities ->
   sched1 weave -> hard-reg lifetimes + windows -> RA fill -> sched2 emission.
   (c) V21's backward pick log confirms the LUID rule live (dv-vs-tint pick
   864/865, tag-slot filling) exactly as the round-9 source read predicted.
4) MUTATION RED HERRING (shape-wise): V21's ANONYMOUS `dv + height` ALREADY
   emits the in-place `addu $8,$8,$14` (combine merges the dying temp), so the
   oracle's in-place addus do NOT prove source mutations; they only perturb
   priorities (and killed the frame in every r10 probe).  Blocks 7/8 of the 28
   = pure sched2 position echoes, not a shape gap.
5) OPEN CONTRADICTION TO RESOLVE (round 12, fresh context): retail source =
   tint-after-link (SLD+emission, mem-locked in BOTH sched passes) => retail's
   post-sched1 should have the V22r v1-hole at dv's fill -- yet retail dv@t0.
   My retail window estimates are emission-derived (post-sched2) and hence
   unreliable for fills; ROUTE: reverse-fit retail's post-sched1 luid layout
   from the KNOWN retail fill (16 regs + s0 + t8) under the fill rules
   (allocsim-style inversion), constrained by the mem-lock + pick rules; then
   drive tint-late source variants with the pick-trace per probe, hunting the
   layout that closes the v1-hole (two >dv-pri tinies on v0+v1 inside dv's
   window, or dv global).  Loop cost = minutes/probe, all instruments hot.
STATUS: shipping = V21 (28) untouched this round.  Instrument + parser
committed; traces banked in the instr dir.

================================================================================
ROUND 12 (2026-08-08) -- 🏆🏆 THE +5 CARRIER SOLVED (SYM-legal, W2=28) + the
STRUCT-READ anti-dep discovery (/s sinks dv-lw to retail pos 19) + y@t8+v1
achieved WITH mutations (W10). Gate stays 28 (V21 shipping, verified).
================================================================================
1) 🏆 THE +5 CARRIER (arg6 caveat CLOSED): SLD f-block re-read: addiu+5
   (F05C) AND subu2 (F06C) both line 1447; addu h+yo (F008) 1447; subu1
   (F004) 1446 => stmt 1447 is ONE statement. fold-const.c READ (split_tree
   @980, associate @4293): any flat (y+5)-(h+yo) FOLDS to y-((h+yo)-5)
   (W1-proven: addu -5, y 1-qty a1, 70@82); casts are stripped (SImode);
   BUT `y = 5 - (height+yoff) + y;` takes the varsign=-1 branch:
   "EXPR is (CON-VAR)+ARG1 -> (CON+ARG1)-VAR" = (5+y)-(h+yo), and FOLD'S
   OWN REWRITE OUTPUT IS NEVER RE-FOLDED => survives => addiu v1,y,5 /
   subu, y dies into the temp (2-death global t8). W2 (V21 + this
   spelling) = 28 == V21 EXACTLY. SYM-legal (no local, no arg6 use).
2) 🏆 THE ANTI-DEP / STRUCT-READ LAW: our bump-store carries REG_DEP_ANTI
   on the dv src+0xc load (greg receipt) => dv-lw PINNED above the bump;
   retail emits dv-lw@19 AFTER bump-ST@15 => retail's RTL had NO such dep.
   sched.c anti_dependence (line 878): canon_rtx rewrites the store's
   address reg to its REG_EQUAL const (0x1F800004) => store = fixed+
   non-struct; the MEM_IN_STRUCT clause then kills the dep IFF the LOAD is
   mem/s (struct ref) + varying. INDIRECT_REF of a cast never gets /s or
   /u (expr.c: RTX_UNCHANGING_P = READONLY & STATIC only; const* deref
   useless - W7 = 82 unchanged). A COMPONENT_REF does: probe struct
   PSXFontHdr { u_char flags; u_char pad[11]; int vramLoc; } and
   ((PSXFontHdr*)src)->vramLoc gives mem/s => dep GONE, dv-lw sinks to
   EXACTLY retail pos 19 (W8). => EA read the font header through a
   STRUCT (edgbla's font[] instinct, as a real field).
   ALSO READ: sched.c line-note save/restore (3546/4064) is PER-INSN
   EXACT under -g => the SLD is true per-insn attribution of the
   SCHEDULED stream; retail's -1 tagged 1463 but EMITTED at pos 28 =
   a real `dv -= 1` statement at the UV line that sched1 HOISTED into
   the pal1-lw latency slot.
3) 🏆 MUTATIONS ARE REAL (r11 red-herring PARTIALLY retired): dv+height
   is stored TWICE (v2+v3) yet retail reuses t0 in place - a 2-use
   anonymous temp would get its own reg => retail spelled `dv += height`
   (same proof: height=y+height 4-use in-place t6, width=x+width 2-use
   t7). The r11 coalesce argument only covers 1-use temps.
4) PROBE LADDER (all swap-gate-restore, baseline 28 re-verified):
   W1 (flat y+5-(h+yo)) 70@82 fold-proof | W2 (5-(h+yo)+y carrier,
   tint-early) 28 == V21 | W3 (W2+tint-late) 112 | W4 (+full SLD tail)
   150@78 | W5 (SLD order+carrier+-1@UV) 90@78 | W6 (SLD order+carrier,
   -1 in init) 82@82 ZIPPER BACK (p113 1.33 v0 / p116 1.2 v1 block dv
   even tint-late; sole failure = dv/prim race: dv 17/94=.7234 < prim
   26/130=.8000) | W7 (const*) 82 no-op | W8 (struct read) 112 - dv
   SINKS (lw@19 retail-exact), dv 17/74=.9189 > prim ✓ BUT chain@43-47
   re-serialized the zipper -> dv steals v1 | W9 (W8 + -1@UV) 90@78 |
   W10 (W8 + -1@UV + MUTATIONS) 96@78 -- 🏆 y@T8 GLOBAL + +5@V1 + subu2
   retail-placed WITH tint-late+mutations (r10's unreachable), but the
   mutation-deepened dv chain hoists to the HEAD (dv@t1, v dies @9,
   frame dead).
5) STATE OF THE INVERSION (retail conditions, each achieved somewhere):
   dv-lw@19 sunk (W8/W10 via /s) | dv>prim pri (W8) | zipper v0+v1
   over dv window (W6, tint-late!) | y@t8+5@v1 (W10) | frame/v@s0
   (W6/W2) | tint-late emission (W3+) | li9/li2c overlap (NONE yet -
   the one condition never achieved; retail li9[39,42]xli2c[41,44]
   via the li9-before-sw-tint transposition).
   ROUND-13 DIALS: (a) chain-sink with mutations: the head picks take
   the dv chain because its mutated path outranks the ch/prim loads -
   find the pri/luid dial (the -1-vs-andi order, the `+ v` position,
   or the tpage-read /s变化 changing the graph); (b) the li zipper:
   ours picks each li right after its store (launch boost) - retail's
   li9 waits one slot (li2c boosted-tie won by HIGHER LUID first);
   probe: swap the 9/2c statement ORDER?? (SLD: 9=1455 2c=1456 FIXED)
   -> no; the +5's luid sits between them in retail's group - the
   carrier stmt POSITION (1447) is luid-low; retail +5@43 = boost-
   placed. Read the exact pick in sched_w6/w10 vs the boost windows.
   Files: font_w{1..10}.cpp + mine/psxfront_w{1,3,4,6,7,8,10}.{i,s} +
   trace_w{1,3,4,6,8,10}.txt, sched_w8.txt (instr dir).
6) 🏆 THE BOOST RULE, EXACT (sched.c adjust_priority@2551 + birthing_insn_p +
   schedule_insn@2604, read not guessed): when an insn's LAST consumer is
   scheduled, adjust_priority runs with n_deaths=0 ALWAYS (REG_DEAD notes are
   already stripped - the >>3/>>2/>>1 kill-deferral cases are DEAD CODE) =>
   case 0: the insn is raised to max_priority (= 0x7f000001 during the
   consumer's schedule_insn) IFF birthing_insn_p: (set (reg N) ...) with
   **REG_N_SETS(N)==1** (single-set pseudo). COROLLARIES: (a) MUTATED
   variables (dv with -1/+height = 3 sets; y = 2 sets; height/width = 2 sets)
   NEVER get the launch boost - their defining insns place by static
   pri/class/luid only; single-use temps and the li/load births DO boost.
   This asymmetry is the mechanism behind BOTH the chain-hoist (mutations
   kill dv's boosts -> the chain drifts to head/tail by static rank) and the
   li-serialization. (b) LOADS readied by their consumer are QUEUED with
   cost>1 (insn_queue), entering ready 2 clocks later - the intervening
   pick is the latency-slot filler (the class-3 rule's real face; the
   backward zipper = load-latency queuing). ROUND-13 = simulate the
   boost-aware backward pick game per candidate body (all inputs now known:
   static pri from -dS, REG_N_SETS from source spelling, boost+queue rules)
   and pick the spelling whose group weave puts li9 3 slots before ST3 /
   li2c on v1; then the chain-sink follows the same table.

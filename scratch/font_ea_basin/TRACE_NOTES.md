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

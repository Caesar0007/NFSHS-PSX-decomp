# W63-A8 RECEIPTS — libpad-B + INTR belt (2026-08-15)

Repo `C:\Temp\nfs4-decomp`, base HEAD `10e1a01b`. Gate = `tools/verify_asm.py` (`-`=ours, `+`=oracle).
build.py NEVER edited; all mechanism probing via an in-memory monkey-patch harness
(`scratchpad/w63a8/w63a8_verflag.py`). Memory dir untouched.

## 0. PER-FN LEDGER (every number re-gated by me)

| fn | TU | briefed | re-gated baseline | final | note |
|---|---|---|---|---|---|
| `_padSetActAlign_rcv` | PADCMD.c | 90.16% | **27** @51/50 | **2** @50/50, **PASS w/ splice** | 3 levers landed `2a3a0587` |
| `_padLoadActInfo_rcv` | PADCMD.c | 95.61% | **14** @155/157 | 14 (unchanged) | mechanism question answered; W62 diagnosis REFUTED |
| `_padIntRecvData` | MCXMAIN.c | 99.98% | **PASS** (223) | PASS | **STALE ROW** |
| `_padIntRecvHdr` | MCXMAIN.c | 99.71% | **PASS** (35) | PASS | **STALE ROW** |
| `_initIntr` | INTR.c | 99.63% | **6** @54/54 | 6 | dial NAMED (new), version axis CLOSED |
| `_set_intr_callback` | INTR.c | 97.17% | **25** @83/82 | 25 | re-classified: cse non-merge, not rotation |
| `_intrhand` | INTR.c | 91.37% | **30** @116/116 | 30 (26 w/ 2.6.3 splice) | corpus axis RETIRED |

Board delta: **+1 PASS pending one-line wiring**; 2 stale rows corrected to PASS.
`tu_order_audit.py` = 0 inversions. Both TUs gated 2x, zero PASS→FAIL.

## 1. SEAL — `_padSetActAlign_rcv` 27 → 2 count-EXACT (PASS under a per-fn 2.7.2 ver-splice)

Instrument-led, three cooperating levers. Commit `2a3a0587`.

**W61/W62 verdict "3-way LOCAL-QTY rotation" was wrong on two counts.**

1. **They are GLOBAL allocnos, not local qtys.** `qty272.py` puts matchcount/slot/k at global
   ranks 3/2/4 (pri 2.3448 / 3.0000 / 1.6500); the local-qty list holds only $v0 temps. So the
   14C 3-QTY LADDER LAW never applied — checked *before* spending on it. `reqdelta272` prices
   the whole 3-cycle as **ONE promotion**: `k` must clear pri 3.00, i.e. refs 11→16 across the
   `floor_log2` step (4·16/20 = 3.20). A 2-operand in-loop read-only fence buys exactly that,
   and all three registers land on retail's $a3/$v1/$a2 simultaneously: **27 → 8**.
   - Operand count IS the dial: 1 op = 26, 2/3/4 ops = 8.
   - **Fence POSITION is a separate dial (13B)**: after the if-block and *before* `k++` = 2 @50/50;
     after `k++` = 5 @51 (the asm then sits between the branch and its only eligible filler and
     `reorg.c:685 stop_search_p` aborts the backward scan → the back-edge slot stays `nop` where
     retail has `addiu $a2,$a2,1`); top-of-body = 24; before the `if` = 5 @49.

2. **Two "allocator" items were GHIDRA-INVENTED BIVs** — the same defect twice:
   - `slot` (a walking `unsigned char *`) made loop.c strength-reduce `slot[0x5d]` into its own
     address giv (`addiu $v1,$a0,93` + `sb $t3,0($v1)`). The **index form `info[k + 0x5d]`**
     (the counter already exists) makes loop.c build retail's giv exactly: `addu $a2,$a0,$zero`
     + `sb $t3,0x5D($a2)` + `addiu $a2,$a2,1`.
     ⇒ **RETIRES the w61/w62 `-fno-strength-reduce` PER_FN_FLAG_SPLICE_272 angle** — the shape is
     source-reachable and the flag splice now measures **48 @48, strictly worse**.
   - `row` (the `row += 5` accumulator) is retail's giv of `mode*5`. Inlining it puts the init in
     the giv preheader group and closes the `lbu $v0,233($a0)` hoist item for free: 8 → 5.

3. **Residual 2 = the 3.25-3b no-copy-prop identity** (`addu $t2,$t0,$zero` vs `addu $t2,$zero,$zero`
   — cse reuses the still-live 0 in `mode`'s register). A RUNG property, not a spelling.
   Falsified here: identity-launder on `row`, decl/assign split, row-before-mode (10).

**04Z, 9th+ confirmation.** Pre-landing this fn was recorded LANE-INVARIANT at 27 (970404 ==
cc1_272). Post-landing the ladder INVERTED: 2.7.2 = **PASS 50/50**, 2.6.3 = 3, 2.8.0/2.8.1 = 5,
wired 970404 = 2. → spec `spec_ver_splice_padSetActAlign_rcv.json` (merge into the EXISTING
2.7.2 key — 12F duplicate-key hazard). Whole TU with the splice: **18/19 PASS, zero regressions**
(all 19 fns gated).

## 2. THE W62 MECHANISM GAP — implemented, proven, and REFUTED as this fn's blocker

Deliverable: `spec_verflag_splice_272_MECHANISM.json` + reference impl `w63a8_verflag.py`.

**What the 272 rung drops** — `_cc1_flags_for_rung` strips `-mno-split-addresses` for
`2.6*`/`2.7*`. **The guard is CORRECT, not over-broad** — verified directly against every rung
binary with a 3-line scratch TU: 2.6.3 / 2.7.2 / 2.7.2-970404 all `rc=33 Invalid option
'no-split-addresses'`; 2.8.0 / 2.8.1 `rc=0`. `-mno-gas` likewise rejected by every 2.6/2.7 rung
⇒ **no flag on any 2.7.x rung suppresses the address split.**

**Proposed mechanism** `PER_FN_VERFLAG_SPLICE_272 = {rel: {(ver, (flags,...)): {fns}}}` — an exact
clone of `_apply_cc1_ver_splice_272` whose flag list is `_cc1_flags_for_rung(ver, cc1_flags) + extra`.
Strictly generalises the existing table (extra == () is today's behaviour). ~25 lines.

**Probed on `_padLoadActInfo_rcv`:** it WORKS and delivers exactly the predicted shape —
2.8.0 + `-mno-split-addresses` reproduces retail's `lui $at,0 / sw ,0($at)` AT-macro and the
`addiu $a0,$a0,-1` j-slot, **COUNT-EXACT 157/157** — but scores **28 vs the wired 14**.
Matrix: 970404 **14** @155 · 2.8.0 30 @155 · 2.8.0+nosplit **28 @157** · 2.8.1 30 @155 ·
2.8.1+nosplit 28 @157 · 2.7.2 25 @158 · 970404+`-fno-delayed-branch` 32 @159.

🔴 **Two corrections to the in-source receipt** (read off `build/recon/.../PADCMD.c.s`):
- The claim "cc1 emits the UNSPLIT macro forms … then (this rung being a SPLIT-address build)
  splits them itself" is wrong about **who splits and who fills**. cc1 (970404) emits the SPLIT
  pair `lui $2,%hi(_actcur) # high` / `sw $3,%lo(_actcur)($2)` directly, and **cc1's own reorg**
  puts the halves in the delay slots inside its own `.set noreorder / .set nomacro` blocks.
  GNU as never sees a macro ⇒ this is **NOT** the W51 AT-MACRO-SPLIT assembler class and no
  assembler-side mechanism (maspsx reorder option, a `.set noreorder` fence) can reach it.
- Therefore the residual is a **RUNG-BASIN CONFLICT**, not a missing mechanism: the fn needs
  970404's body basin *and* 2.8's split suppression, and no single rung offers both.

**Named next angle (NOT a floor):** the 2.8.x+nosplit basin is the ONLY count-exact basin found
(157/157) and is therefore the structurally correct one under the count bar. Its 28 diffs are
dominated by the three source devices misfiring — all three were derived *in the 970404 basin*
across w61/w62 (shared-exit ownership goto pair; zero-trip-guarded `ac = &_actcur` anchor; the
opacity fences). Re-derive them inside the 2.8.0+nosplit basin (04Z), carried by this mechanism
as a per-fn splice so the rest of the TU keeps 970404.

**Recommendation: IMPLEMENT the mechanism, WIRE NOTHING with it yet.**

## 3. INTR belt (commit `0e846cb3`, receipts only — all three keep their shipped forms)

- **`_intrhand` (30 @116/116)** — `qty272` REFUTES the w62 target statement. Both pend blocks
  carry SIX local qtys (3-qty ladder law inapplicable) and every qty ties at refs 2, so the
  handout is decided by **live length alone**: live 6→$v1, 8→$v0, 10→$a0. Inverting gives a
  **3-way LIVE-LENGTH permutation** (I_STAT ptr→10, I_MASK ptr→8, enabled→6), not the 2-way
  pointer swap w62 read off the post-sched oracle — which is exactly why all six w62 pointer
  reorder spellings measured 30 INERT.
  04Z ladder (never run): **2.6.3 = 26 @116/116** (kills the closing-test `lhu` pair at count
  parity); 2.7.2 = 30 (== the wired lane, independent re-confirmation of law 04W);
  970404 / 2.8.0 / 2.8.1 = 112 @114. Spec `spec_ver_splice_intrhand_263.json` (a **-4 partial**,
  orchestrator judgement — table debt for no board movement).

- **`_set_intr_callback` (25 @83/82)** — cluster (b) re-classified. Retail's `a2 = base-4`
  (`48($a2)`) and `a1 = base` (`44($a1)`) address the **SAME word** (base−4+0x30 == base+0x2C):
  it is a **cse NON-MERGE** (3.25-3b weaker-cse family), not a register rotation — which is why
  every allocation-side dial in the w61 list measured 25 inert. The `st` identity fence restores
  the second base but `reorg.c:685` then eats the `beqz` slot that same `addiu a2,a1,-4` fills:
  a real mutual exclusion (13B), needing a **NON-ASM anti-fold device**.
  Ladder: 970404 = 22 but @84 vs 82 — **rejected under the count-exact bar (14E)** and recorded
  so it is not re-derived as a win. 2.6.3/2.7.2 = 25; 2.8.0 = 38; 2.8.1 = 68.

- **`_initIntr` (6 @54/54)** — `qty272` names the dial and it is **neither refs nor live length**.
  All five block-4 qtys tie at refs 2 / live 4 / pri 5000, so the qsort key is degenerate and
  local-alloc falls through to its **NUMBER (birth-order) tie-break** (14C); pseudo 91 reuses $v1
  only because 89 is already dead when 91 is born. No ref-step and no live-length dial can move
  it, which is why the three w59/w61 forms all failed the same way (they lengthen 89 *across* the
  `jal`, promoting it out of the caller-saved pool instead of merely overlapping 91).
  **Untried angle (14C INTRUDER-EVICTION):** a third short-lived block-4 value holding $v1 across
  91's 4-insn window *without crossing the jal*. Version axis **CLOSED** (2.6.3/2.7.2 = 6;
  970404/2.8.0/2.8.1 = 65 @53).

## 4. CORPUS VERDICTS (orchestrator relays, both addressed)

**psyz `decomp/src/libetc/intr.c` @ `6d47e5e`** — same v1.76 lineage as ours
(`$Id: intr.c,v 1.76 1997/02/12 12:45:05 makoto Exp $`, line 84), confirming the NFS3 provenance
finding. But: `trapIntr` (= our `_intrhand`) and `setIntr` (= our `_set_intr_callback`) are BOTH
`INCLUDE_ASM` there (lines 86, 88) = **unmatched**, and its whole `intr_vb.c`/`intr_dma.c` are
100% `INCLUDE_ASM` while our INTR_VB.c is 4/4 PASS — **we are ahead of psyz on this file**.
`startIntr` (= our `_initIntr`) IS matched but is statement-for-statement equivalent to ours; the
only delta is `&stack[0x3EC]` vs our `g_intr.evcb` — the SAME VA (0x1018) by construction. No transfer.

**sotn-decomp `src/main/psxsdk/libetc/intr.c`** (fully matched, zero INCLUDE_ASM) — a genuinely
new corpus, but it is **`$Id: intr.c,v 1.73 1995/11/10` (PsyQ 3.x)** against our v1.76 (4.3), and
the shape does not survive the generation gap. All measured against the shipped **count-exact**
30 @116/116, all gated and reverted:
| angle | result |
|---|---|
| sotn no-base-pointer (drop `state` alias + fence, all fields by name) | 32 @118 |
| drop the base fence alone | 32 @118 |
| named `enabled` only (half-step) | 29 @117 |
| sotn index-form callback walk `base[i]` | 32 @116 |
| sotn post-increment timeout `(*tp)++ >= 0x801` | 39 @115 |
| PE2 `T* volatile` (pointer-volatile) on the MMIO cells | 51 @119 |

Every variant is count-OVER or worse; the shipped RR-transplant form is the only count-exact one.
⇒ **The corpus axis for `_intrhand` is RETIRED.** The birth-order residual survives the only
fully-matched body in existence for this function — a strong (not terminal) result that bounds
the remaining search to the 2.7.2 scheduler dumps (`-dS`/`-dR`, 12A) plus the live-length
permutation named above. The sotn post-increment result also **confirms the w60-a1 receipt from
the opposite direction** (it deletes the very copy retail keeps).

## 5. FILES / BACKUPS / HAZARDS

- Landed: `recon/syslib/psx/libpad/PADCMD.c` (`2a3a0587`), `recon/syslib/psx/libetc/INTR.c` (`0e846cb3`).
- Backups: `PADCMD.c.base.bak` (pre-wave), `PADCMD.c.idxform.bak`, `PADCMD.c.land1.bak`, `INTR.c.base.bak`.
- Harness: `w63a8_verflag.py` (loads verify_asm's OWN source and substitutes only the compile
  step — the 12H anti-drift pattern; never re-implements the gate's normalizers).
- Specs: `spec_ver_splice_padSetActAlign_rcv.json`, `spec_verflag_splice_272_MECHANISM.json`,
  `spec_ver_splice_intrhand_263.json`.
- All probe harnesses restore the TU in `finally:`; byte-scanned after every scripted write
  (0 NULs, LF-only preserved on both TUs); no pipes into `head`/`sed` (SIGPIPE hazard).
- No `git stash` / `checkout` outside my own files; no `tools/*.py` edit; memory dir untouched.

## 6. CATALOG-ROW CANDIDATES (for the orchestrator to harvest)

1. **§A/§B — "a Ghidra-invented walker forces loop.c to strength-reduce `p[K]` into its own
   address giv; the INDEX form off an existing counter (`base[i + K]`) reproduces retail's plain
   walker with K as the load DISPLACEMENT."** Retires a `-fno-strength-reduce` flag-splice angle.
   (`_padSetActAlign_rcv`: `addiu $v1,$a0,93`+`sb ,0($v1)` → `addu $a2,$a0,$zero`+`sb ,0x5D($a2)`.)
2. **§A — "when reqdelta prices a 3-way rotation, price it as ONE promotion first": if one pseudo
   clearing a single `floor_log2` step overtakes BOTH rivals, one fence delivers the whole cycle.**
   (27 → 8 in one edit.)
3. **§F — fence-position corollary to 13B, stated as a symptom:** *ours has an unfilled back-edge
   slot where retail has the walker increment, and a fence is already in the loop* ⇒ the fence sits
   between the branch and its only eligible filler; move it ABOVE the increment group
   (`reorg.c:685 stop_search_p`). Worth 3 diffs + count parity here (5 @51 → 2 @50).
4. **§G — the `_cc1_flags_for_rung` guard is a REAL rung capability, not a policy:** 2.6/2.7 cc1s
   reject `-mno-split-addresses` *and* `-mno-gas` outright (rc=33). ⇒ any "(rung × flag) identity"
   on a 2.6/2.7-wired TU is unreachable in principle, and a 2.8 rung carrying the flag is a
   different BODY basin — price the whole body, not just the target insns.
5. **§G/META — a fully-matched corpus body can be the WRONG SDK GENERATION.** psyz/sotn/ours are
   v1.76 / v1.73 / v1.76 of the same file; the v1.73 body loses on every one of six angles while
   the v1.76 twin has nothing our fn lacks. **Check the `$Id:` revision before porting a shape.**

/* W52-A8 2026-08-09 -- GCC-LADDER identity probe (04U lane); see the block below.
 * W52-A8 GCC-LADDER: SPCHPSXZ identity = gcc-2.8.0 + maspsx (the DEFAULT lane).
 *
 *   lane            iSPCH_GetRuleSettings
 *   default         40 (112/112)
 *   2.6.0          104 (110/112)
 *   2.6.3          104 (110/112)
 *   2.7.2-970404    40 (112/112)
 *   2.7.2          102 (114/112)
 *   2.8.0 CONTROL   40 (112/112)
 *   2.8.1           40 (112/112)
 *   2.91.66        100 (108/112)
 *   2.95.2         138 (112/112)
 *
 * READING: 2.7.2-970404 / 2.8.0 / 2.8.1 all tie the default at 40 (count-exact 112/112);
 * nothing improves.  Worth noting for the w47-a8/a9/a2 chain that closed this function's
 * `-G` question via the DECLARATION-SHAPE fix (`extern SentenceRuleTestFn
 * gSentenceRuleTest[];` + `[0]`): the compiler-VERSION axis is now closed alongside it.
 */
/* eaclib/psx/spchpsxz/spchrule.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 9/9 ***
 *   Source obj : nfs4\eaclib\psx\spchrule.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   9 fns @[0x8010B100 .. 0x8010B58C].  Sentence rule evaluation -- walk a sentence's rule list, test/apply
 *   parameter rules via the gSentenceRuleTest/gSentenceRuleSet callbacks.  Ghidra nfs4-f.exe.c (spchrule) +
 *   disasm-v3 + IDA sigs.
 *
 *   Linkage: VoxSentence_GetNumPhrases / iSPCH_GetOffset8 / iSPCH_GetOffset16 are per-TU `static` copies of
 *   the shared-header helpers (the canonical extern "C" versions live in spchdata.obj).
 *   Ghidra-isms resolved: iSPCH_GetRuleSettings' args were dropped (in_a0/a1/a2 -> sentence,values,out per
 *   IDA); iSPCH_SentenceUsesParm reads in_v0 = VoxSentence_GetNumPhrases' dropped return.
 */

extern void (*gSentenceRuleSet[])(unsigned int, unsigned int, int, int); /* sentence rule-set callback
                                               * (spchinit-owned); unsized-array decl => separate-temp
                                               * base materialization (catalog SSE #5) */
extern int (*gSentenceRuleTest[])(unsigned int, unsigned int, int); /* sentence rule-test callback;
                                               * UNSIZED-ARRAY decl for the same reason as its sibling
                                               * above (w47-a9 fingerprint: the scalar decl is <= -G4
                                               * small-data-eligible, so cc1 emits the unschedulable
                                               * assembler macro `lw $r,sym` where retail has the
                                               * %hi/%lo split -- catalog SSE #5 / IDT Ch9) */

/* ---- per-TU static copies of the shared Vox accessors (canonical versions in spchdata.obj) ---- */

static int VoxSentence_GetNumPhrases(int sentence)   /* @0x8010B100 */
{
    return (int)((unsigned int)*(unsigned char *)(sentence + 3) >> 2);
}
static int iSPCH_GetOffset8(int base, int tableBase, int index)   /* @0x8010B10C */
{
    return base + ((int)*(unsigned char *)(tableBase + index) << 2);
}
static int iSPCH_GetOffset16(int base, int tableBase, int index)  /* @0x8010B124 */
{
    return base + ((int)*(unsigned short *)(tableBase + index * 2) << 2);
}


extern int  iSPCH_GetRuleDataAddr(int sentence);                       /* @0x8010B140 */
extern int  iSPCH_SentenceUsesParm(int sentence, unsigned int paramIdx); /* @0x8010B158 */
extern unsigned int iSPCH_GetRuleID(int sentence, int index);         /* @0x8010B220 */
extern void iSPCH_RuleSet(short *sentence, int rule, int *values);    /* @0x8010B294 */
extern unsigned char iSPCH_GetRuleSettings(short *sentence, int *values, char *out); /* @0x8010B3CC */
extern unsigned int iSPCH_CheckSentenceRules(int testVal, int clearMask, int rulePtr); /* @0x8010B58C */

/* iSPCH_GetRuleDataAddr @0x8010B140 : address of a sentence's rule-data block (after its phrase table).
 * MATCH: keep the +0xc on the offset before adding sentence (delay-slot addu v0,a0,v0) */
extern int iSPCH_GetRuleDataAddr(int sentence)
{
    int off = (int)(unsigned int)*(unsigned char *)(sentence + 6) * 2 + 0xc;
    return sentence + off;
}

/* iSPCH_SentenceUsesParm @0x8010B158 : 1 if any phrase of `sentence` references parameter `paramIdx`.
 * MATCH: a phrase[2] match jumps straight to the shared exit (no more phrases scanned); a phrase[4+j]
 * match only breaks the inner j-loop and keeps scanning later phrases -- both paths funnel `found`
 * through the SAME tail (`v0=s1` in the oracle), so the phrase[2] case must NOT be an early `return`.
 * The inner loop's byte address is a genuine named pointer `p = phrase + j` (dereferenced at +4) --
 * an earlier draft reused one `p` declared *before* the loop (dead-store bug, 44 diffs) and a later
 * draft papered over it with an `spchAdd2()`/no-op-statement scheduling trick (also reached 0, but was
 * scaffolding no EA programmer would write); this per-iteration-local `p` is the honest source form
 * that reaches the same byte-exact match without either. */
extern int iSPCH_SentenceUsesParm(int sentence, unsigned int paramIdx)
{
    int numPhrases = VoxSentence_GetNumPhrases(sentence);
    int phraseIdx  = 0;
    int found      = 0;
    if (0 < numPhrases) {
        do {
            int phrase;
            phrase = iSPCH_GetOffset8(sentence, sentence + 4, phraseIdx);
            if (((unsigned int)*(unsigned char *)(phrase + 2) & 0xf) == paramIdx) {
                found = 1;
                goto done;
            }
            {
                int j = 0;
                do {
                    unsigned char *p = (unsigned char *)(phrase + j);
                    if (((unsigned int)*(p + 4) & 0xf) == paramIdx) {
                        found = 1;
                        break;
                    }
                    j = j + 1;
                } while (j < 4);
            }
            phraseIdx = phraseIdx + 1;
        } while (phraseIdx < numPhrases);
    }
done:
    return found;
}

/* iSPCH_GetRuleID @0x8010B220 : the rule-id byte at `index` (< 8) of a sentence's rule data, or 0xffffffff. */
extern unsigned int iSPCH_GetRuleID(int sentence, int index)
{
    unsigned int result = 0xffffffff;
    int ruleData = iSPCH_GetRuleDataAddr(sentence);
    if ((unsigned int)index < 8) {
        unsigned char *rule = (unsigned char *)(index * 2 + ruleData);
        unsigned int idCopy;
        volatile unsigned int id;
        volatile unsigned int param;
        volatile unsigned int type;
        idCopy = *rule;
        id     = idCopy;
        param  = *(rule + 1) & 0xf;
        type   = (unsigned int)(unsigned char)*(rule + 1) >> 4;
        result = idCopy;
    }
    return result;
}

/* iSPCH_RuleSet @0x8010B294 : for each type-0/3 rule whose parameter the (offset) sentence uses, fire the
 *   gSentenceRuleSet callback with that rule + the parameter value from val[]. */
extern void iSPCH_RuleSet(short *sentence, int rule, int *values)
{
    /* MATCH (w32-a9, 57 -> 52 diffs, insn count now EXACT 78/78):
     * (1) `values` is ADDRESSABLE in retail -- the oracle keeps it in its incoming home slot and
     *     reads it there (`sw a2,0x50(sp)` in the gate's delay slot, `lw a3,0x50(sp)` in the loop)
     *     rather than parking it in a callee-saved reg (all nine of s0-s7/fp are already spoken for).
     *     Only an ESCAPING `&values` sets TREE_ADDRESSABLE: `(void)&values;` and an inline
     *     `*(int **)&values` are both folded away before it takes effect (verified -- `values` then
     *     lands in $s2), and a *dead* `int **p = &values;` local loses the flag too.  The address
     *     must be taken into a local that is REALLY dereferenced, so it is done in the innermost
     *     block, at the point of use; cse then folds `*p` back to the direct `lw ...,0x50(sp)`
     *     and no register is spent on the slot address (an outer-block `p` burns $s7).
     * (2) gSentenceRuleSet is declared as an UNSIZED ARRAY and read as `gSentenceRuleSet[0]`
     *     (catalog SSE lever #5 / "unsized-array extern extends to ADDRESS materialization"):
     *     the scalar spelling emits the self-temp `lui v0; lw v0,0(v0)` for the gate and then a
     *     SECOND `lui/addiu` for the in-loop load (+1 insn); the array spelling emits the oracle's
     *     separate-temp `lui s1; lw v0,0(s1)` and keeps that base alive to be copied into $s7.
     * RESIDUAL now 48 = a one-step callee-saved ROTATION on the three REMAINING pseudos (ours
     * ruleSetBase/rule/i = s2/s1/s3, retail s1/s0/s2; `rd` is now s0 on BOTH sides) plus retail loading each rule byte into a CALLER-saved temp and copying it to its
     * s-reg (which also fills the lbu load-delay slot our direct-to-s-reg load has to `nop`).  Same
     * allocation-order/no-copy-prop identity signature as the rest of this obj (catalog SSG).
     *
     * w34-a10 (52 -> 48, still exact parity 78/78) -- ALLOCNO-PRIORITY LEVER, derived from the
     * cc1 -dl/-dg dumps rather than guessed.  The dumps give the 12 global allocnos with their
     * refs/live-length, and gcc-2.8's priority = floor_log2(refs)*refs/live_length reproduces the
     * allocation order exactly: paramIdx (8 refs / 20 insns = 1.2) outranked rd (11 / 42 = 0.79),
     * so paramIdx took $s0 and rd $s1 -- retail has them the other way round.  Dropping ONE ref
     * off paramIdx moves it below rd: writing the dead volatile store as its own derivation
     * (`paramStore = packed & 0xf; paramIdx = packed & 0xf;`) instead of `paramIdx = packed & 0xf;
     * paramStore = paramIdx;` takes paramIdx from 4 raw refs to 3 (weighted 8 -> 6, priority
     * 2*6/20 = 0.6 < 0.79) while emitting the IDENTICAL instruction shape (cse folds the second
     * derivation onto the first).  `rd` now lands in $s0 exactly as retail.
     * ⚠ The same swap applied to iSPCH_GetRuleSettings' `param`/`paramStore` REGRESSES it
     * (61 -> 69, and it loses insn parity 113 -> 109) -- the lever is per-function, gate it.
     *
     * w33-a10 RE-VERDICT: FLOOR HOLDS at exact insn parity 78/78; the whole 52 is register naming.
     * NEW OBSERVATION (not previously recorded): retail REUSES the `rule` parameter's register for
     * the rule-data cursor -- `addu $s0,$v0,$zero` sits in the `jal func_8010B124` delay slot and
     * captures iSPCH_GetRuleDataAddr's return into $s0, overwriting the incoming `rule` (already
     * consumed into $a2 one instruction earlier). That is the w32 PARAM-AS-CURSOR fingerprint, so
     * it was tested directly: writing `rule = iSPCH_GetRuleDataAddr(...)` after the GetOffset16
     * call and walking `rule` gives 55 diffs / 79 insns; keeping a separate `rd` but assigning it
     * from a pre-computed temp gives 49 diffs / 79 insns. BOTH lose the exact insn parity this
     * form has, so both are rejected -- retail's reuse is the ALLOCATOR coalescing two dead-at-the
     * -same-point pseudos, not a source-level reassignment.
     * Build-lane probes negative as well: -mno-split-addresses 52 -> 64, per-fn
     * -fno-delayed-branch splice 52 -> 67. PROTOTYPE AUDIT: 3 args ($a0/$a1/$a2 all read), void
     * return ($v0 is an `slt` leftover on one exit path and untouched on the other -- incoherent
     * across exits, the w32 real-void test). */
    /* w35-a4: 48 -> 14, insn parity still EXACT 78/78, and EVERY callee-saved register now matches
     * retail ($s0=rd, $s1=paramIdx, $s2=i, $s3=ruleByte, $s4=numRules, $s5=sentence, $s6=offSent,
     * $s7=ruleSetBase copy).  Three independent fixes, all derived from the cc1 -dl/-dg dumps:
     *  (1) DEFER THE rd ASSIGNMENT past the GetOffset16 argument setup.  Retail reuses ONE register
     *      for `rule` and the rule-data cursor (`addu $s0,$a1,$zero` ... `addu $a2,$s0,$zero` ...
     *      `addu $s0,$v0,$zero`), which is only possible if the two pseudos do NOT conflict -- i.e.
     *      the cursor's def sits AFTER `rule`'s last use in the RTL.  Writing
     *      `int rdRaw = iSPCH_GetRuleDataAddr(...); offSent = iSPCH_GetOffset16(...,rule);
     *       rd = (unsigned char *)rdRaw;` puts the pointer's def after the arg setup and the whole
     *      s-register file shifts down one (48 -> 30).  (w33's rejected probe assigned the CALL
     *      result after the second call, which reordered the calls and lost parity -- this keeps it.)
     *  (2) ruleByte via the TRICHOTOMY-2 double evaluation `ruleByteStore = rd[0]; ruleByte = rd[0];`
     *      (the same shape w34-a10 found for param), 30 -> 22.
     *  (3) `if (i < numRules)` instead of `if (0 < numRules)` for the zero-trip guard -- semantically
     *      identical (i is 0 there; cc1 folds the test to the same `blez $s4`) but it is one extra
     *      OUT-OF-LOOP REG_N_REF on `i`, taking it 7 -> 8 weighted.  8 is a floor_log2 step, so its
     *      priority jumps 2*7/49 = 0.286 -> 3*8/49 = 0.490 and it overtakes ruleByte (2*4/19 = 0.421):
     *      i lands in $s2 and ruleByte in $s3, exactly as retail.  22 -> 14.
     * RESIDUAL 14 = ONE cause: retail loads rd[0] once into $a0, stores it to the sp+0x10 slot and
     * COPIES it to $s3 (`addu $s3,$a0,$zero`); ours re-LOADS it (`lbu $s3,0($s0)`) because the
     * volatile store we use to model the dead decode-slot store invalidates cse's memory table.
     * That in turn leaves $a0 free in our build, so the ruleType temp takes $a0 where retail (with
     * $a0 busy) takes $a1 -- the remaining 12 diffs are that knock-on.  Falsified this wave:
     * modelling the three slots as a plain local `unsigned int decode[3]` with read-backs (49 diffs
     * / 81 insns -- the read-backs become real `lw`s, cc1 does not forward stack loads here) and
     * taking the slot's address into a local pointer (neutral, 14).  A fix needs a store form that
     * keeps a dead stack store WITHOUT killing cse's memory table -- not available from C here.
     * w47-a2: also falsified the obvious inversion `ruleByte = rd[0]; ruleByteStore = ruleByte;`
     * (22 diffs, still 78/78): it does collapse the double load, but then the byte lands directly
     * in $s3 and the whole packed/ruleType chain re-colors -- retail's shape needs the load in a
     * CALLER-saved temp AND a surviving copy into $s3, i.e. the same local-qty-vs-global-allocno
     * copy question as spchevnt's two residuals (see iSPCH_InitEventQueue's note there): the
     * producer's dest must be a distinct short-lived pseudo, which a single named assignment can
     * never give.  NEXT ANGLE (untried, needs a store form that survives DSE without a volatile):
     * an ADDRESS-TAKEN non-volatile slot (`unsigned int slotv; unsigned int *keep = &slotv;
     * *keep = rd[0];`) -- addressable so the store stays, non-volatile so cse's memory table is
     * only alias-invalidated rather than flushed. */
    if (gSentenceRuleSet[0] != 0) {
        int offSent;
        int            numRules = *(signed char *)((int)sentence + 7);
        int            i        = 0;
        unsigned char *rd;
        int            rdRaw    = iSPCH_GetRuleDataAddr((int)sentence);
        offSent = iSPCH_GetOffset16((int)sentence, (int)(sentence + 6), rule);
        rd = (unsigned char *)rdRaw;
        if (i < numRules) {
            do {
                volatile unsigned int ruleByteStore;
                volatile unsigned int paramStore;
                volatile unsigned int ruleTypeStore;
                unsigned int ruleByte;
                unsigned int packed;
                unsigned int paramIdx;
                unsigned int ruleType;
                unsigned int byteTmp;
                /* MATCH (w49-a9, 14 -> 2): the note above named the blocker exactly -- "the
                 * producer's dest must be a distinct short-lived pseudo, which a single named
                 * assignment can never give".  The w47-a1/a4/a5 OPACITY FENCE is that device:
                 * `byteTmp` is the short-lived caller-saved temp, the zero-insn fence stops
                 * cse/make_regs_eqv from making it canonical, so `ruleByte = byteTmp` survives as
                 * retail's `addu $s3,$a0,$zero` copy instead of our second `lbu`.  With one load
                 * the ruleType temp's $a0/$a1 knock-on disappears too. */
                byteTmp = rd[0];
                __asm__("" : "=r"(byteTmp) : "0"(byteTmp));
                ruleByteStore = byteTmp;
                ruleByte = byteTmp;
                packed = *(volatile unsigned char *)(rd + 1);
                paramStore = packed & 0xf;
                paramIdx = packed & 0xf;
                ruleType = (unsigned int)*(volatile unsigned char *)(rd + 1) >> 4;
                /* MATCH (w49-a9, 2 -> PASS): methodology 3.25-3c -- gcc's reorg REFUSES to slot-fill
                 * a volatile MEM, so the volatile-qualified store could never reach retail's
                 * `beqz` delay slot (`sw $a1,0x18($sp)` sits IN the slot).  Storing through a
                 * NON-volatile cast keeps the slot addressable (the store still survives DSE) while
                 * letting fill_simple_delay_slots take it.  Equivalent form measured: a block-local
                 * `unsigned int *keep = (unsigned int *)&ruleTypeStore; *keep = ruleType;` (also PASS). */
                *(unsigned int *)&ruleTypeStore = ruleType;
                switch (ruleType) {
                case 0:
                case 3:
                    if (iSPCH_SentenceUsesParm(offSent, paramIdx) != 0) {
                        int **valuesSlot = &values;
                        int *valuesNow = *valuesSlot;
                        gSentenceRuleSet[0]((unsigned short)*sentence, ruleByte,
                            valuesNow[paramIdx], (int)valuesNow);
                    }
                    break;
                case 1:
                case 2:
                case 4:
                    break;
                default:
                    break;
                }
                i  = i + 1;
                rd = rd + 2;
            } while (i < numRules);
        }
    }
}

/* iSPCH_GetRuleSettings @0x8010B3CC : evaluate rule types 1..12 of `sentence` against the gSentenceRuleTest
 *   callback (using values[] for the typed ones) and pack the pass/fail bits into *out.
 *   MATCH notes vs raw oracle (structural bugs found on first-ever pass over this fn):
 *   (1) `values` advances once per outer (ruleType) iteration for the normal v=*values path, but
 *   rule-type-4 (typeNib==4) indexes the ORIGINAL incoming values[] (valuesBase) by paramIdx directly --
 *   two distinct base pointers, and the whole typeNib==4 arm was MISSING from the prior reconstruction.
 *   (2) the real gSentenceRuleTest call is 4-arg (*sentence,ruleId,v,sentence) -- the prior draft passed
 *   6 args (2 extra: a stray *p, paramIdx) that the oracle's call site never sets up.
 *   (3) `result` is a SECOND accumulator (typeNib==4-hit + r>0 hit) returned as an unsigned byte
 *   (`andi v0,s6,0xff`); only `flags` (r<0 hits) is written to *out.  The old `void` reconstruction
 *   caused the compiler to delete the returned accumulator completely.
 *   w32-a9 (85 -> 61 diffs; frame size, spill-slot layout and the whole prologue now IDENTICAL):
 *   (4) `numRules` is an INT, not a `signed char` -- the char type re-signs on every use
 *   (`lbu; sll 24; sra 24` + a callee-saved home) where the oracle does a single `lb` into a caller-
 *   saved temp and SPILLS it (`sw a3,0x24(sp)`, reloaded at both loop tests).
 *   (5) `param` also gets a dead volatile store (the oracle stores all three decoded fields at
 *   0x10/0x14/0x18), which is what lands the local-slot layout on the oracle's.
 *   (6) `sentence` is an ADDRESSABLE parameter (oracle `sw a0,0x50(sp)` + `lw a3,0x50(sp)` at the
 *   callback): taking its address in the innermost block (same lever as iSPCH_RuleSet's `values`)
 *   frees $fp for the oracle's per-outer-iteration value pointer.  All three params end up in their
 *   incoming home slots exactly as retail.
 *   RESIDUAL 61 = the reload scratch register ($t0 ours vs $a3 retail), an i/hit $s2<->$s3 swap, and
 *   retail hoisting `lui %hi(gSentenceRuleTest)` + the ruleByte reload ABOVE the type branch (which
 *   is also our one extra insn: a load-delay `nop` retail fills).  Trying the unsized-array spelling
 *   on gSentenceRuleTest makes it worse (cse merges the two loads: 108/112, 70 diffs). */
/* iSPCH_GetRuleSettings RESIDUAL 61 diffs, ours 113 / oracle 112 (w33-a10 re-verdict).
 * PROTOTYPE AUDIT vs the raw: 3 args, and retail spills ALL THREE to their incoming home slots
 * (`sw $a0,0x50($sp)` / `sw $a1,0x54($sp)` / `sw $a2,0x58($sp)`) then reloads them -- i.e. every
 * parameter is ADDRESSABLE here, the same fact w32-a9 established for iSPCH_RuleSet's `values`.
 * Our build already reproduces all three spills, so the prototype is right and the arity is right.
 * The residual is ONE register-name choice repeated ~20 times: retail's scratch temp for the
 * phrase-count / reload chain is $a3, ours is $t0 (gcc's REG_ALLOC_ORDER puts $a3 ahead of $t0,
 * so retail is the DEFAULT choice and ours is the deviation -- something in this body keeps $a3
 * out of the pool). Shape, instruction order and stack layout otherwise line up.
 * Build-lane probes: -mno-split-addresses 61 -> 61 (no change, and it wrecks the rest of the TU),
 * per-fn -fno-delayed-branch splice 61 -> 79. No SLD exists for SPCHPSXZ (see spchevnt.c).
 *
 * w34-a10 -- THE $a3-vs-$t0 LEAD IS NOW A QUANTIFIED MECHANISM (cc1 -dl/-dg dumps), and it is
 * NOT source-reachable from this shape.  `numRules` gets NO hard register; $t0/$a3 is the RELOAD
 * register reload1 spills for it, and gcc-2.8's `order_regs_for_reload` sorts the candidate regs
 * by `hard_reg_n_uses` = the summed REG_N_REFS of the pseudos ALLOCATED to each hard reg, ties
 * broken by ascending regno.  Our lreg dump says:
 *     Register 121 used 9 times across 10 insns in block 12; ...; pointer.   -> "121 in 7" ($a3)
 * i.e. the `*sentSlot` deref at the gSentenceRuleTest call site is a real local-alloc pseudo that
 * local_alloc parks in $a3 (it has a hard preference for $a3 from `(set (reg 7) (reg 121))`).
 * That gives hard_reg_n_uses[$a3] = 9 vs hard_reg_n_uses[$t0] = 0, so $t0 sorts FIRST and becomes
 * the spill reg -- and its caller-save/spill slot 0x1C follows the register, which is the whole
 * 28(sp)-vs-36(sp) half of the diff.  Retail's $a3 carries ZERO pseudo refs (its `lw $a3,0x50($sp)`
 * is a reload that reload-inheritance then reuses for the 4th argument), so $a3 wins the tie on
 * regno and everything downstream falls out.
 * => the fix would be to stop `*sentSlot` from becoming an allocated pseudo, which cse defeats:
 * `(int)sentence` for arg 4, `(unsigned short)*sentence` for arg 1, and the mixed forms ALL gate
 * 61/113 identically (cse merges them back into one pseudo), and dropping the `&sentence`
 * addressability entirely costs a callee-saved reg + an 88-byte frame (122 diffs).
 * The oracle frame corroborates the reading: retail's locals are 0x10/0x14/0x18 (the three
 * volatile decode slots), 0x20 (ruleData's spill) and 0x24 (numRules), leaving a HOLE at 0x1C --
 * exactly the slot our build hands to numRules.
 * Also probed and rejected this wave: `hit = 0` hoisted to the top of the inner block (61, no
 * change); `testValue = 0` hoisted out of the ruleType==0xc arm (65); the iSPCH_RuleSet
 * allocno-priority swap on `param`/`paramStore` (69, and it loses insn parity). */
/* w35-a4: 61 -> 43 (insn count unchanged 113/112).  Both wins are the levers proved on
 * iSPCH_RuleSet in the same wave, and they DO transfer here even though w34 measured the second
 * one as a regression from the OLD base:
 *  (1) zero-trip guard `if (i < numRules)` instead of `if (0 < numRules)` -- semantically identical
 *      (i is 0 there, cc1 folds to the same `blez`) but one extra OUT-OF-LOOP REG_N_REF on `i`,
 *      which lifts it over `hit` across a floor_log2 step: i lands in $s2 and hit in $s3, exactly
 *      as retail (61 -> 49).
 *  (2) WITH (1) in place, the trichotomy-2 double evaluation `paramStore = packed & 0xf;
 *      param = packed & 0xf;` now WINS (49 -> 43) -- it produces retail's `andi $v1; sw $v1,0x14(sp);
 *      addu $a0,$v1,$zero` copy shape.  w34-a10 measured this same edit as 61 -> 69 from the
 *      pre-(1) base; the two edits are NOT independent, so re-test banked losers after any
 *      allocation-order change (catalog "BLOCKING REGISTER CASCADE").
 * RESIDUAL 43 = still the w34-a10 $t0-vs-$a3 reload mechanism (~14 diffs incl. the 28(sp)-vs-36(sp)
 * spill slot that follows the register) plus its knock-on scheduling, the `addu $a2,$s3,$zero`
 * vs retail's fresh `addu $a2,$zero,$zero` (our cse copies the known-zero `hit` into testValue),
 * and one `lw $a1,0x10($sp)` placement.  Probed and NEUTRAL this wave: Yoda `4 == type` (43).
 * 2026-07-27 inline: volatile-view SPLIT of the shared `*sentSlot` pseudo (so arg1/arg4 load
 * 0x50(sp) separately and pseudo-121 stops parking in $a3) FALSIFIED both ways: volatile on arg4
 * 59, volatile on arg1 59 (each drops an insn to 111/112 but rotates the web).  Also this date:
 * the whole-TU PsyQ-4.0 cc1 probe (gcc 2.7.2.SN32.3.7) is decisively wrong here too -- 92 diffs
 * at 102/112 insns (10 SHORT) -- confirming the 2.8.0 identity for spchpsxz.
 * w49-a9 re-gated at 40 (count-exact 112/112) and probed the two named leads with the OPACITY
 * FENCE (the device that cracked iSPCH_RuleSet, iSPCH_InitEventQueue and iSPCH_IterateChoice this
 * wave) -- BOTH FALSIFIED, the $t0-vs-$a3 reload core does not move:
 *   - splitting the shared `*sentSlot` pseudo with an opacity fence on the ARG-4 value (the w34-a10
 *     "stop pseudo 121 becoming an allocated pseudo" lead, cse-proof this time): 57 at 111/112;
 *   - moving `hit = 0;` below the type dispatch (to kill the `addu $a2,$s3,$zero`-vs-retail's fresh
 *     `addu $a2,$zero,$zero` cse copy): 67 at 113/112;  both together: 84.
 * This is consistent with the w34-a10 mechanism being in reload1's `order_regs_for_reload`
 * (hard_reg_n_uses tie-break), which no cse/value-numbering barrier can reach -- the fence family
 * operates on pseudos, the tie is over HARD regs after allocation.  Next angle stays a3-side:
 * make some OTHER pseudo prefer $a3 less, or give $t0 a nonzero hard_reg_n_uses.
 * w50-a9 2026-08-09 re-gated at 40 (count-exact 112/112) and PARKED per the wave brief: the
 * residual is a post-allocation HARD-REG tie in reload1's order_regs_for_reload, and this wave's
 * two productive instruments both operate on PSEUDOS -- the opacity fence (value numbering) and the
 * zero-cost do{}while(0) ref inflator (allocno/qty priority) -- so neither can reach it by
 * construction.  That boundary is now receipted from BOTH sides: the inflator family cracked
 * iSPCH_BankMemAlloc (a local-alloc qty tie) in this same cluster on the same day, and is inert
 * here.  One structural probe run and falsified: passing arg 1 as `*sentence` while arg 4 stays
 * `(int)*sentSlot` (to stop the two sharing pseudo 121, cse-proof) = 40, unchanged.
 * The angle stays as stated: a3-side, and it needs the -dl/-dg hard_reg_n_uses table, not C. */
/* W66 2026-08-12 -- 36 -> 26 at exact 112/112 after cross-checking the new separate-function
 * m2c/JEB exports and the PS1-fork scheduler cookbook.  Staging the volatile type spill through
 * nonvolatile typeArg restores retail's `li v1,4; lw v0,24(sp); lw a1,16(sp)` issue order.  Empty
 * one-trip boundaries immediately after hit=0 and after the type decode emit no instructions but
 * pin hit's zeroing after the packed-byte load and defer the param copy into the ruleType branch
 * delay slot.  The remaining 26 are the established reload1 $t0/$a3 hard-register-order cluster
 * plus its spill-slot cascade, and the independent known-zero testValue copy ($s3 vs $zero). */
/* 🏆 W61-A19 2026-08-15 -- 24 -> PASS 112/112.  The whole multi-wave "$t0-vs-$a3 reload1
 * order_regs_for_reload floor" was a PROTOTYPE BUG, not an allocator floor.
 *
 * (1) THE CALLBACK IS 3-ARG, NOT 4-ARG (correctness fix; gcc-source-cited proof).
 *     reload1.c:3894 `order_regs_for_reload`: a hard register that appears EXPLICITLY in the RTL
 *     is in `regs_explicitly_used` (== regs_ever_live at reload entry), which adds `large+1` to
 *     its use count AND -- because MIPS defines neither SMALL_REGISTER_CLASSES nor
 *     REG_ALLOC_ORDER -- sets `bad_spill_regs` for it, so it can NEVER be picked as a reload
 *     register anywhere in the function.  RETAIL USES $a3 AS THE RELOAD SCRATCH at 8 sites that
 *     have nothing to do with the callback (the numRules spill, the values/out arg reloads)
 *     ==> in retail's compilation $a3 was NOT an outgoing argument register ==> the
 *     gSentenceRuleTest call passes THREE arguments.  Corroboration: its sibling callback
 *     gSentenceRuleSet is called with exactly three ($a0/$a1/$a2, no $a3) at
 *     iSPCH_ConstantRuleSet 0x801014A0-0x801014B0.  The 4-arg reading came from reading
 *     `lw $a3,0x50($sp)` before the `jalr` as an argument set-up -- it is really the reload that
 *     supplies the ADDRESS for argument 1 (`lhu $a0,0($a3)`), the classic methodology §3.1
 *     caveat.  With arg 4 dropped and argument 1 spelled `(unsigned short)*sentence`, all 12
 *     $t0-vs-$a3 diff lines vanish at count parity: 24 -> 6.
 *     (The typedef is corrected to 3 params; the callback pointer is only ever zeroed in this
 *     image -- SPCH_Init/SPCH_Deinit -- so no callee exists to disagree.)
 *
 * (2) THE REMAINING 6 WERE THE SPILL SLOT (0x1C ours vs 0x24 retail), and retail's frame says
 *     exactly what to do: its inner block owns FOUR 4-byte memory slots 0x10/0x14/0x18/0x1C but
 *     only writes three (the volatile decode fields), and its two reload spills then land at
 *     0x20 (ruleData) and 0x24 (numRules).  Reproduced by (a) a fourth declared-but-unused
 *     volatile local in that block -- zero instructions, it only consumes 0x1C -- and (b)
 *     declaring `ruleData` before `numRules` so the two spilled pseudos get retail's regno order
 *     (`alter_reg` hands stack slots out in ascending pseudo number).  Either half alone = 10.
 *
 * Falsified in THIS basin before the prototype fix (all worse, recorded so nobody re-runs them):
 *   opacity fence on arg4 43@111 | volatile view on arg4 41@109 | on arg1 41@109 | on both
 *   41@109 | opacity fence on arg1 31@113 | plain `sentence` for both args while still 4-arg
 *   90@112.  After the fix, decl-order-only variants: ruleData-decl-first 10, +result/flags
 *   reorder 10, ruleData/ruleType/value first 10, all-split 48@108. */
extern unsigned char iSPCH_GetRuleSettings(short *sentence, int *values, char *out)
{
    unsigned char *ruleData;
    int            numRules = *(signed char *)((int)sentence + 7);
    unsigned char  result = 0;
    unsigned char  flags = 0;
    int            ruleType;
    int           *value;
    ruleData = (unsigned char *)iSPCH_GetRuleDataAddr((int)sentence);
    ruleType = 1;
    value = values + 1;
    do {
        int            i;
        int           *currentValue;
        unsigned char *p;
        i = 0;
        if (i < numRules) {
            currentValue = value;
            p = ruleData;
            do {
                volatile unsigned int ruleId;
                volatile unsigned int paramStore;
                unsigned int param;
                volatile unsigned int type;
                /* MATCH (w61-a19): retail's frame has a FOURTH 4-byte memory slot in this block
                 * at 0x1C that is NEVER written -- a declared-but-unused memory local.  Its
                 * presence pushes the two reload spills to 0x20/0x24 (retail) instead of
                 * 0x1C/0x20 (ours); with ruleData declared before numRules (below) the whole
                 * frame + spill map lands byte-exact.  Removing it costs 6 diffs. */
                volatile unsigned int spare;
                unsigned int packed;
                unsigned int bit;
                unsigned int ruleIdArg;
                unsigned int typeArg;
                unsigned char hit;
                int          testValue;
                ruleId = p[0];
                packed = *(volatile unsigned char *)(p + 1);
                hit = 0;
                do {
                } while (0);
                paramStore = packed & 0xf;
                type = (unsigned int)*(volatile unsigned char *)(p + 1) >> 4;
                do {
                } while (0);
                param = packed & 0xf;
                if (ruleType == 0xc) {
                    if (param != 0)
                        goto next_rule;
                    testValue = 0;
                } else {
                    if (param != (unsigned int)ruleType)
                        goto next_rule;
                    testValue = *currentValue;
                }
                bit = 1 << (7 - i);
                typeArg = type;
                ruleIdArg = ruleId;
                if (typeArg == 4) {
                    if (values[param] != 0)
                        hit = bit;
                } else {
                    int testResult;
                    /* MATCH: `sentence` is an ADDRESSABLE parameter in retail (`sw a0,0x50(sp)`
                     * + reloads).  After the 3-arg fix below, taking its address here is the ONLY
                     * remaining reason gcc keeps it in its incoming home slot -- dropping this
                     * decl costs a callee-saved reg + an 88-byte frame (w34-a10 receipt). */
                    short **sentSlot = &sentence;
                    if (gSentenceRuleTest[0] != 0)
                        testResult = gSentenceRuleTest[0](
                            (unsigned short)*sentence, ruleIdArg, testValue);
                    else
                        testResult = -1;
                    if (testResult == 0)
                        hit = 0;
                    else if (0 < testResult)
                        hit = bit;
                    else
                        flags |= bit;
                }
                result |= hit;
next_rule:
                p = p + 2;
            } while (++i < numRules);
        }
        ruleType = ruleType + 1;
        value = value + 1;
    } while (ruleType < 0xd);
    *out = (char)flags;
    return (unsigned char)result;
}

/* iSPCH_CheckSentenceRules @0x8010B58C : 1 if (rule[+2] ^ testVal) masked by rule[+1] and ~clearMask is 0. */
extern unsigned int iSPCH_CheckSentenceRules(int testVal, int clearMask, int rulePtr)
{
    unsigned int active = (unsigned int)*(unsigned char *)(rulePtr + 1) & ~(unsigned int)clearMask;
    unsigned int delta  = (unsigned int)*(unsigned char *)(rulePtr + 2) ^ (unsigned int)testVal;
    return (unsigned int)((delta & active) == 0);
}

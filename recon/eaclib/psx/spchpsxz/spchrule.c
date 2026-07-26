typedef int bool;
#define true 1
#define false 0
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

typedef void (*SentenceRuleSetFn)(unsigned int, unsigned int, int, int);
typedef int (*SentenceRuleTestFn)(unsigned int, unsigned int, int, int);
extern SentenceRuleSetFn gSentenceRuleSet[];  /* sentence rule-set callback (spchinit-owned); unsized-array
                                               * decl => separate-temp base materialization (catalog SSE #5) */
extern SentenceRuleTestFn gSentenceRuleTest;  /* sentence rule-test callback */

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
    if (gSentenceRuleSet[0] != 0) {
        int offSent;
        int            numRules = *(signed char *)((int)sentence + 7);
        int            i        = 0;
        unsigned char *rd       = (unsigned char *)iSPCH_GetRuleDataAddr((int)sentence);
        offSent = iSPCH_GetOffset16((int)sentence, (int)(sentence + 6), rule);
        if (0 < numRules) {
            do {
                volatile unsigned int ruleByteStore;
                volatile unsigned int paramStore;
                volatile unsigned int ruleTypeStore;
                unsigned int ruleByte;
                unsigned int packed;
                unsigned int paramIdx;
                unsigned int ruleType;
                ruleByte = rd[0];
                ruleByteStore = ruleByte;
                packed = *(volatile unsigned char *)(rd + 1);
                paramStore = packed & 0xf;
                paramIdx = packed & 0xf;
                ruleType = (unsigned int)*(volatile unsigned char *)(rd + 1) >> 4;
                ruleTypeStore = ruleType;
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
 * per-fn -fno-delayed-branch splice 61 -> 79. No SLD exists for SPCHPSXZ (see spchevnt.c). */
extern unsigned char iSPCH_GetRuleSettings(short *sentence, int *values, char *out)
{
    int            numRules = *(signed char *)((int)sentence + 7);
    unsigned int   result = 0;
    unsigned int   flags = 0;
    unsigned char *ruleData = (unsigned char *)iSPCH_GetRuleDataAddr((int)sentence);
    int            ruleType = 1;
    int           *value = values + 1;
    do {
        int            i;
        int           *currentValue;
        unsigned char *p;
        i = 0;
        if (0 < numRules) {
            currentValue = value;
            p = ruleData;
            do {
                volatile unsigned int ruleId;
                volatile unsigned int paramStore;
                unsigned int param;
                volatile unsigned int type;
                unsigned int packed;
                unsigned int bit;
                int          hit;
                int          testValue;
                ruleId = p[0];
                packed = *(volatile unsigned char *)(p + 1);
                hit = 0;
                param = packed & 0xf;
                paramStore = param;
                type = (unsigned int)*(volatile unsigned char *)(p + 1) >> 4;
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
                if (type == 4) {
                    if (values[param] != 0)
                        hit = bit;
                } else {
                    int testResult;
                    short **sentSlot = &sentence;
                    if (gSentenceRuleTest != 0)
                        testResult = gSentenceRuleTest(
                            (unsigned short)**sentSlot, ruleId, testValue, (int)*sentSlot);
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
                i = i + 1;
                p = p + 2;
            } while (i < numRules);
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

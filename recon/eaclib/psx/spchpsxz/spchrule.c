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
extern SentenceRuleSetFn gSentenceRuleSet;    /* sentence rule-set callback (spchinit-owned) */
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
extern void iSPCH_RuleSet(short *sentence, int rule, int val);        /* @0x8010B294 */
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
extern void iSPCH_RuleSet(short *sentence, int rule, int val)
{
    if (gSentenceRuleSet != 0) {
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
                paramIdx = packed & 0xf;
                paramStore = paramIdx;
                ruleType = (unsigned int)*(volatile unsigned char *)(rd + 1) >> 4;
                ruleTypeStore = ruleType;
                switch (ruleType) {
                case 0:
                case 3:
                    if (iSPCH_SentenceUsesParm(offSent, paramIdx) != 0) {
                        gSentenceRuleSet((unsigned short)*sentence, ruleByte,
                            *(int *)((int)paramIdx * 4 + val), val);
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
 *   caused the compiler to delete the returned accumulator completely. */
extern unsigned char iSPCH_GetRuleSettings(short *sentence, int *values, char *out)
{
    char           numRules = *(char *)((int)sentence + 7);
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
                    if (gSentenceRuleTest != 0)
                        testResult = gSentenceRuleTest(
                            (unsigned short)*sentence, ruleId, testValue, (int)sentence);
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

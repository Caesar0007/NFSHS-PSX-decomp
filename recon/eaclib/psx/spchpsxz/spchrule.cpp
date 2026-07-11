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

extern "C" int gSentenceRuleSet;    /* sentence rule-set callback (spchinit-owned) */
extern "C" int gSentenceRuleTest;   /* sentence rule-test callback */

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

extern "C" int  iSPCH_GetRuleDataAddr(int sentence);                       /* @0x8010B140 */
extern "C" int  iSPCH_SentenceUsesParm(int sentence, unsigned int paramIdx); /* @0x8010B158 */
extern "C" unsigned int iSPCH_GetRuleID(int sentence, int index);         /* @0x8010B220 */
extern "C" void iSPCH_RuleSet(short *sentence, int rule, int val);        /* @0x8010B294 */
extern "C" void iSPCH_GetRuleSettings(short *sentence, int *values, char *out); /* @0x8010B3CC */
extern "C" unsigned int iSPCH_CheckSentenceRules(int testVal, int clearMask, int rulePtr); /* @0x8010B58C */

/* iSPCH_GetRuleDataAddr @0x8010B140 : address of a sentence's rule-data block (after its phrase table).
 * MATCH: keep the +0xc on the offset before adding sentence (delay-slot addu v0,a0,v0) */
extern "C" int iSPCH_GetRuleDataAddr(int sentence)
{
    int off = (int)(unsigned int)*(unsigned char *)(sentence + 6) * 2 + 0xc;
    return sentence + off;
}

/* iSPCH_SentenceUsesParm @0x8010B158 : 1 if any phrase of `sentence` references parameter `paramIdx`. */
extern "C" int iSPCH_SentenceUsesParm(int sentence, unsigned int paramIdx)
{
    int numPhrases = VoxSentence_GetNumPhrases(sentence);
    int phraseIdx  = 0;
    int found      = 0;
    if (0 < numPhrases) {
        do {
            int phrase = iSPCH_GetOffset8(sentence, sentence + 4, phraseIdx);
            int j      = 0;
            int p      = phrase;
            if (((unsigned int)*(unsigned char *)(phrase + 2) & 0xf) == paramIdx)
                return 1;
            do {
                if (((unsigned int)*(unsigned char *)(p + 4) & 0xf) == paramIdx) {
                    found = 1;
                    break;
                }
                j = j + 1;
                p = phrase + j;
            } while (j < 4);
            phraseIdx = phraseIdx + 1;
        } while (phraseIdx < numPhrases);
    }
    return found;
}

/* iSPCH_GetRuleID @0x8010B220 : the rule-id byte at `index` (< 8) of a sentence's rule data, or 0xffffffff. */
extern "C" unsigned int iSPCH_GetRuleID(int sentence, int index)
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
extern "C" void iSPCH_RuleSet(short *sentence, int rule, int val)
{
    if (gSentenceRuleSet != 0) {
        char           numRules = *(char *)((int)sentence + 7);
        int            i        = 0;
        unsigned char *rd       = (unsigned char *)iSPCH_GetRuleDataAddr((int)sentence);
        int            offSent  = iSPCH_GetOffset16((int)sentence, (int)(sentence + 6), rule);
        if (0 < numRules) {
            do {
                unsigned char ruleByte = rd[0];
                unsigned int  paramIdx = (unsigned int)(rd[1] & 0xf);
                unsigned int  ruleType = (unsigned int)(unsigned char)rd[1] >> 4;
                switch (ruleType) {
                case 0:
                case 3:
                    if (iSPCH_SentenceUsesParm(offSent, paramIdx) != 0) {
                        ((void (*)(unsigned int, unsigned char, int, int))gSentenceRuleSet)
                            ((unsigned short)*sentence, ruleByte,
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
 *   callback (using values[] for the typed ones) and pack the pass/fail bits into *out. */
extern "C" void iSPCH_GetRuleSettings(short *sentence, int *values, char *out)
{
    char           numRules = *(char *)((int)sentence + 7);
    unsigned int   result   = 0;
    unsigned char *ruleData = (unsigned char *)iSPCH_GetRuleDataAddr((int)sentence);
    unsigned int   ruleType = 1;
    do {
        int            i = 0;
        unsigned char *p = ruleData;
        values = values + 1;
        if (0 < numRules) {
            do {
                volatile unsigned int ruleId0;
                volatile unsigned int paramNib;
                volatile unsigned int typeNib;
                unsigned int paramIdx;
                int          v        = 0;
                int          doTest   = 0;
                ruleId0  = p[0];
                paramNib = p[1] & 0xf;
                typeNib  = (unsigned int)(unsigned char)p[1] >> 4;
                paramIdx = paramNib;
                if (ruleType == 0xc) {
                    if (paramIdx == 0)
                        doTest = 1;
                } else if (paramIdx == ruleType) {
                    v      = *values;
                    doTest = 1;
                }
                if (doTest && (typeNib != 4)) {
                    int r;
                    if (gSentenceRuleTest == 0)
                        r = -1;
                    else
                        r = ((int (*)(int, int, int, int, int, int))gSentenceRuleTest)
                                ((int)*sentence, (int)*p, v, (int)sentence, (int)*p, (int)paramIdx);
                    if (r != 0 && r < 1)
                        result = result | (1 << (7 - i));
                }
                i = i + 1;
                p = p + 2;
            } while (i < numRules);
        }
        ruleType = ruleType + 1;
        if (0xc < (int)ruleType) {
            *out = (char)result;
            return;
        }
    } while (true);
}

/* iSPCH_CheckSentenceRules @0x8010B58C : 1 if (rule[+2] ^ testVal) masked by rule[+1] and ~clearMask is 0. */
extern "C" unsigned int iSPCH_CheckSentenceRules(int testVal, int clearMask, int rulePtr)
{
    unsigned int active = (unsigned int)*(unsigned char *)(rulePtr + 1) & ~(unsigned int)clearMask;
    unsigned int delta  = (unsigned int)*(unsigned char *)(rulePtr + 2) ^ (unsigned int)testVal;
    return (unsigned int)((delta & active) == 0);
}

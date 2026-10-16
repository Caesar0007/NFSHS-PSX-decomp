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

#include "../eaclib_types.h"
#include "spchrule.h"
#include "spchinit.h"

/* file-local functions (retail SYM: local labels) */
static VoxRule *iSPCH_GetRuleDataAddr(VoxEvent *event);

/* 2026-09-02 pseudo-array retirement: both callback slots were UNSIZED-ARRAY decls read as
 * sym[0] -- the pre--G0 device against <= -G4 small-data eligibility (w47-a9 fingerprint: the
 * scalar decl compiled to the unschedulable assembler macro `lw $r,sym` where retail has the
 * %hi/%lo split -- catalog SSE #5 / IDT Ch9).  Under the library-wide -G0 (build.py
 * PER_TU_FLAGS, 2026-08-31) the plain scalars emit the identical split pairs; 9/9 PASS. */

/* ---- per-TU static copies of the shared Vox accessors (canonical versions in spchdata.obj) ---- */

/* These three are per-TU `static` copies of the shared-header helpers (the canonical exported
   versions live in spchdata.obj) -- exactly what retail has, and `static` is all the source
   needs to say.  They used to be renamed here (asm labels, later #defines) so that the flat
   oracle/config namespace could tell the copies apart; that renaming is NOT the source's job:
   tools/verify_asm.py takes a `FUNC@VA` selector for precisely this case ("gate-only ... without
   inventing an address-suffixed identifier in reconstructed source"), so the gate says
   VoxSentence_GetNumPhrases@8010B100 and the code keeps retail's spelling. */

static int VoxSentence_GetNumPhrases(VoxSentence *sentence)   /* @0x8010B100 */
{
    return (int)((unsigned int)sentence->flags >> 2);
}
static void *iSPCH_GetOffset8(void *base, unsigned char *table, int index)   /* @0x8010B10C */
{
    return (char *)base + ((int)table[index] << 2);
}
static void *iSPCH_GetOffset16(void *base, unsigned short *table, int index)  /* @0x8010B124 */
{
    return (char *)base + ((int)table[index] << 2);
}

/* iSPCH_GetRuleDataAddr @0x8010B140 : address of an EVENT's rule-data block (right after its sentence-offset table).
 * The rules start where the sentence-offset table ends: &sentenceOffs[numSentences] (retail folds the
 * +0xc into the scaled index and adds the base last, in the jr delay slot). */
static VoxRule *iSPCH_GetRuleDataAddr(VoxEvent *event)
{
    return (VoxRule *)&event->sentenceOffs[event->numSentences];
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
int iSPCH_SentenceUsesParm(VoxSentence *sentence, unsigned int paramIdx)
{
    int numPhrases;
    int phraseIdx;
    int found;

    numPhrases = VoxSentence_GetNumPhrases(sentence);
    found = false;

    for(phraseIdx = 0; phraseIdx < numPhrases; phraseIdx++) {
        VoxPhrase *phrase;
        int j;

        phrase = iSPCH_GetOffset8(sentence, sentence->phraseOffs, phraseIdx);
        if ((phrase->modeParam & 0xf) == paramIdx) {
            found = true;
            break;
        }
        
        for(j = 0; j < 4; j++) {
            if ((phrase->nibbles[j] & 0xf) == paramIdx) {
                found = true;
                break;
            }
        }
    }
    return found;
}

/* iSPCH_GetRuleID @0x8010B220 : the rule-id byte at `index` (0..7) of an event's rule data, or -1. */
int iSPCH_GetRuleID(VoxEvent *event, int index)
{
    int result = -1;
    VoxRule *rules = iSPCH_GetRuleDataAddr(event);
    if (index >= 0 && index < 8) {   /* gcc folds the signed range check to retail's `sltiu index,8` */
        VoxRule *rule = (VoxRule *)(index * 2 + (int)rules);   /* MATCH: int-sum operand order (mult first); `rules + index` swaps the addu */
        /* Retail stores the decoded id/param/type to 0x10/0x14/0x18 and reads back only the id:
         * the source unpacked the rule into a LOCAL STRUCT (gcc 2.8 never scalarises aggregates,
         * so the three member stores stay in memory and cse forwards .id into the result).  The
         * struct also fixes the slot ORDER.  History: modelled first with `volatile` scalars, then
         * with a scratch array (W85-S9); the struct is the honest spelling, PASS 29/29 (2026-09-05).
         * FALSIFIED: plain scalars without the aggregate (the three stores vanish, the
         * `sll/addu` index chain re-colors). */
        VoxRuleDecoded d;
        d.id       = rule->id;
        d.paramIdx = rule->typeParam & 0xf;
        d.type     = rule->typeParam >> 4;
        result = d.id;
    }
    return result;
}

/* iSPCH_RuleSet @0x8010B294 : for each type-0/3 rule whose parameter the (offset) sentence uses, fire the
 *   gSentenceRuleSet callback with that rule + the parameter value from values[]. */
void iSPCH_RuleSet(VoxEvent *event, int sentenceIdx, int *values)
{
    if (gSentenceRuleSet != 0) {
        int          numRules = event->numRules;
        VoxRule     *rd;
        VoxSentence *offSent;
        int          i;

        rd = iSPCH_GetRuleDataAddr(event);
        offSent = iSPCH_GetOffset16(event, event->sentenceOffs, sentenceIdx);
        for (i = 0; i < numRules; i++) {
            VoxRuleDecoded decode;
            unsigned int   id, param;

            decode.id = rd[i].id;
            decode.paramIdx = rd[i].typeParam & 0xf;
            decode.type = rd[i].typeParam >> 4;
            id = decode.id;
            param = decode.paramIdx;
            switch (decode.type) {
            case 0:
            case 3:
                if (iSPCH_SentenceUsesParm(offSent, param) != 0)
                    gSentenceRuleSet(event->id, id, values[param]);
                break;
            case 1:
            case 2:
            case 4:
                break;
            }
        }
    }
}

/* iSPCH_GetRuleSettings @0x8010B3CC : test every rule of types 1..12 through gSentenceRuleTest
 *   (type-4 rules check values[param] directly).  Passed rules set bit (7 - i) of the return
 *   value, rules the callback rejects (< 0) set that bit in *out. */
unsigned char iSPCH_GetRuleSettings(VoxEvent *event, int *values, char *out)
{
    VoxRule       *ruleData;
    int            numRules = event->numRules;
    unsigned char  result = 0;
    unsigned char  flags = 0;
    int            ruleType, i;

    ruleData = iSPCH_GetRuleDataAddr(event);
    for (ruleType = 1; ruleType < 13; ruleType++) {
        for (i = 0; i < numRules; i++) {
            VoxRuleDecoded decode;
            unsigned int   id, param;
            unsigned int   bit;
            unsigned char  hit = 0;
            int            testValue;

            decode.id = ruleData[i].id;
            decode.paramIdx = ruleData[i].typeParam & 0xf;
            decode.type = ruleData[i].typeParam >> 4;
            param = decode.paramIdx;
            if (ruleType == 12) {
                if (param != 0)
                    continue;
                testValue = 0;
            } else {
                if (param != ruleType)
                    continue;
                testValue = values[ruleType];
            }
            bit = 1 << (7 - i);
            id = decode.id;
            if (decode.type == 4) {
                if (values[param] != 0)
                    hit = bit;
            } else {
                int r;
                if (gSentenceRuleTest != 0)
                    r = gSentenceRuleTest(event->id, id, testValue);
                else
                    r = -1;
                if (r == 0)
                    hit = 0;
                else if (r > 0)
                    hit = bit;
                else
                    flags |= bit;
            }
            result |= hit;
        }
    }
    *out = flags;
    return result;
}

/* iSPCH_CheckSentenceRules @0x8010B58C : 1 if (rule[+2] ^ testVal) masked by rule[+1] and ~clearMask is 0. */
unsigned int iSPCH_CheckSentenceRules(int testVal, int clearMask, int rulePtr)
{
    unsigned int active = (unsigned int)*(unsigned char *)(rulePtr + 1) & ~(unsigned int)clearMask;
    unsigned int delta  = (unsigned int)*(unsigned char *)(rulePtr + 2) ^ (unsigned int)testVal;
    return (unsigned int)((delta & active) == 0);
}

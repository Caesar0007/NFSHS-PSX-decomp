/* eaclib/psx/spchpsxz/spchpick.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 27/27 PASS ***
 *   Source obj : nfs4\eaclib\psx\spchpick.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   Toolchain  : gcc-2.8.0 + maspsx (the default lane), library-wide -G0 (tools/build.py PER_TU_FLAGS).
 *   27 fns @[0x8010077C .. 0x801018F4], plus the object's own static copies of the shared Vox
 *   accessors @0x80100710.. .  The sentence/sample PICKER -- the top of the speech pipeline: takes
 *   a chosen event, picks a sentence template that passes its rules, chooses matching samples per phrase,
 *   randomises/orders them, and issues sample-load requests via the gSampleRequest callback.
 *   Ghidra nfs4-f.exe.c (spchpick) + disasm-v3 (authoritative for arg flow) + IDA sigs.
 *
 *   Choice record `ispch_gChoice` = short[6] per phrase (stride 0xc): [0]bankIdx [1]subBank [2]nChosen
 *     [3]pickBase [4]curPick.  ispch_gPickSamples = byte[] of chosen sample indices.
 *   Ghidra-isms resolved: many in_v0 = dropped VoxSentence_GetNumPhrases/GetShortRule/OneChosen returns;
 *   iSPCH_MatchSample calls GetMatchValue(phraseTemplate, i), and the raw byte nibbles[i] read next
 *   to it is the live paramTable selector (lowNib), not a dead load;
 *   ChooseSamples' MatchSample call passes the bank PTR (Ghidra's (int)sVar2 cast was a mis-decode);
 *   ChooseSentence's dropped-arg calls recovered from disasm; SetPreLoadTicks' `this` is the tick value.
 *
 *   BSS run @0x8014843C (0x138 bytes, VAs past t_addr+t_size => pure zero-init, no file bytes),
 *   owned by spchpick.obj -- the sole referencer of all four objects:
 *     gSentenceChoice    @0x8014843C  64  (+ interior label DAT_80148448 @+0xC)
 *     ispch_gPickSamples @0x8014847C 100
 *     gChooseShort       @0x801484E0   4  (referenced by nothing in the recon; defined so the
 *                                          object's .bss reproduces the run instead of a hole)
 *     ispch_gChoice      @0x801484E4 144
 *   It ends exactly where spktplay.obj's sndpps begins.  Defined by the file-scope asm block
 *   below; the C views stay `extern` in spchpick.h.
 */

#include "../eaclib_types.h"
#include "spch_types.h"
#include "spchinit.h"
#include "spchpick.h"
#include "spchbank.h"
#include "spchsamp.h"
#include "spchrand.h"
#include "spchrule.h"
#include "spchevnt.h"

/* ---- spchpick.obj's own static copies of the shared Vox accessors (retail SYM: local labels 0x80100710..) ---- */
/* iSPCH_GetMatchValue @0x80100710 : matchValues[index] -- the int table right after the header. */
static int iSPCH_GetMatchValue(VoxPhrase *phrase, int index)
{
    return phrase->matchValues[index];
}

/* VoxSentence_GetShortRule @0x80100724 : low 2 bits of the sentence's flags byte (+3). */
static int VoxSentence_GetShortRule(VoxSentence *sentence)
{
    return sentence->flags & 3;
}

/* VoxSentence_GetNumPhrases @0x80100730 : upper 6 bits of the sentence's flags byte (+3). */
static int VoxSentence_GetNumPhrases(VoxSentence *sentence)
{
    return sentence->flags >> 2;
}

/* VoxEvent_GetFilterLengthFlag @0x8010073C : bit 0 of the event's flags byte (+0xa). */
static int VoxEvent_GetFilterLengthFlag(VoxEvent *event)
{
    return event->flags & 1;
}

/* iSPCH_GetOffset8 @0x80100748 : follow an 8-bit offset table -- base + (table[index] << 2). */
static void *iSPCH_GetOffset8(void *base, unsigned char *table, int index)
{
    return (char *)base + ((int)table[index] << 2);
}

/* iSPCH_GetOffset16 @0x80100760 : follow a 16-bit offset table -- base + (table[index] << 2). */
static void *iSPCH_GetOffset16(void *base, unsigned short *table, int index)
{
    return (char *)base + ((int)table[index] << 2);
}

/* W65-A6 DATA-MAT run @0x8014843C -- file-scope asm .bss definition.  ⚠️ STILL LOAD-BEARING
 * (re-measured 2026-09-04): it is the ONLY spelling that gives BOTH the right section and the
 * retail ORDER of the run.  Plain C tentative definitions land in .bss correctly but maspsx
 * re-orders them (gSentenceChoice would follow ispch_gChoice); `-fno-common` keeps declaration
 * order but moves the storage into .data (file bytes, and these VAs are pure zero-init BSS);
 * `__attribute__((section(".bss")))` is inert here.  The C views stay `extern` (spchpick.h).
 * DAT_80148448 is an interior label of the same run (gSentenceChoice+0xC) -- another thing no
 * C spelling can express as a separate symbol. */
__asm__("\t.globl\tgSentenceChoice\n\t.globl\tDAT_80148448\n\t.globl\tispch_gPickSamples\n"
        "\t.globl\tgChooseShort\n\t.globl\tispch_gChoice\n"
        "\t.section\t.bss\n\t.align\t2\n"
        "gSentenceChoice:\n\t.space\t0xc\n"
        "DAT_80148448:\n\t.space\t0x34\n"
        "ispch_gPickSamples:\n\t.space\t100\n"
        "gChooseShort:\n\t.space\t4\n"
        "ispch_gChoice:\n\t.space\t144\n\t.text");

/* The shared one-word globals are plain scalar externs in the per-TU headers (spchinit.h,
 * spchevnt.h, spchbank.h); under -G0 they compile to retail's split `lui %hi` + `lw %lo` pairs. */

/* iSPCH_MatchSample @0x8010077C : does the unpacked `sample` match the phrase template?  For every
 *   index i < count the sample's cycle bit must be set both in the template's matchValues[i] and,
 *   when nibbles[i] selects one, in that paramTable word.  `bankIdx` is unused. */
int iSPCH_MatchSample(int bankIdx, VoxSample *sample, VoxPhrase *phraseTemplate, int *paramTable)
{
    int count = phraseTemplate->count;
    int result = 1;

    if (count > 4)
        result = 0;
    else {
        int i;

        for (i = 0; i < count; i++) {
            unsigned int bit;
            unsigned int cycleByte = sample->cycle[i];
            int lowNib;

            result = 0;

            if (cycleByte > 0x1f)
                break;

            bit = 1 << cycleByte;
            lowNib = phraseTemplate->nibbles[i] & 0xf;

            if ((bit & (unsigned int)iSPCH_GetMatchValue(phraseTemplate, i)) != 0) {
                if (lowNib == 0)
                    result = 1;
                else if ((bit & (unsigned int)paramTable[lowNib]) != 0)
                    result = 1;
            }

            if (result == 0)
                break;
        }
    }

    return result;
}

/* iSPCH_GetPhraseBank @0x80100880 : resolve a phrase template's bank choice (fixed / by-param / sub-bank)
 *   into outChoice[0..1].  Returns 0 on success, nonzero (sign of ~choice) on failure. */
unsigned int iSPCH_GetPhraseBank(VoxPhrase *phraseTemplate, int *paramTable, VoxChoice *outChoice)
{
    unsigned short wanted = phraseTemplate->bankId;
    unsigned int   flags  = phraseTemplate->modeParam;
    unsigned int   mode   = flags >> 4;
    unsigned int   param  = flags & 0xf;
    int            choice;
    outChoice->subBank = -1;
    outChoice->bankId   = -1;
    if (mode == 1)
        goto byParam;
    if (mode == 0)
        goto byFind;
    if (mode == 2)
        goto bySub;
    goto done;
byFind:   /* MATCH: byFind block laid out FIRST (oracle .L8DC precedes byParam .L8EC) */
    choice = iSPCH_FindBank(wanted);
    outChoice->bankId = (short)choice;
    goto done;
byParam:
    choice = *(int *)(param * 4 + (int)paramTable); /* MATCH: keep offset-first addu operand order. */
    if (-1 < choice) {
        int voxBase = (int)gVoxBanks;   /* MATCH: separate-temp load (lui v0; lw v1) */
        if ((unsigned int)**(unsigned short **)(choice * 4 + voxBase) != (unsigned int)wanted)
            choice = -1;
    }
    outChoice->bankId = (short)choice;
    goto done;
bySub:
    {
        int *pv;
        choice = iSPCH_FindBank(wanted);
        pv = (int *)(param * 4 + (int)paramTable);
        if (iSPCH_TestSubBankBounds(choice, *pv))   /* MATCH: success = fall-through, -1 arm out-of-line */
            outChoice->subBank = (short)*pv;
        else
            choice = -1;
        outChoice->bankId = (short)choice;
    }
done:
    /* mode > 2: outChoice stays -1 */
    return (unsigned int)~(int)outChoice->bankId >> 0x1f;
}

/* iSPCH_GetBankBits @0x80100994 : address of a bank's cycle-bits array (after its sample table).
 * MATCH: in-place dead-ptr: bank+=8 forces oracle's addiu a0,a0,8; addu v0,a0,mflo */
char *iSPCH_GetBankBits(VoxBank *bank)
{
    int   stride = (bank->flags & 0xf) + 2;
    int   nSamp  = bank->numSamples;
    char *p      = (char *)(bank + 1);   /* +8: the packed sample table */
    return &p[nSamp * stride];
}

/* iSPCH_ClearCycleBit @0x801009B8 : clear cycle bit `cycle` in `bank`'s bits array; returns the byte ptr. */
unsigned char *iSPCH_ClearCycleBit(VoxBank *bank, int cycle)
{
    int r;
    int off;
    unsigned char mask;
    char *bits;
    unsigned char *p;

    r = cycle / 8;
    off = r + 1;
    mask = ~(1 << (cycle % 8));
    bits = iSPCH_GetBankBits(bank);
    p = &bits[off];
    p[0] &= mask;
    return p;
}

/* iSPCH_CheckBankBit @0x80100A1C : test cycle bit `cycle` in `bank`'s bits array. */
unsigned int iSPCH_CheckBankBit(VoxBank *bank, int cycle)
{
    int byteIdx = cycle / 8;   /* MATCH: plain signed /8 -> gcc's bgez/+7/sra COPY form (cycle stays $a1) */
    char bit = 1 << (cycle % 8);
    char *bits = iSPCH_GetBankBits(bank);
    return bits[byteIdx] & bit;
}

/* iSPCH_CheckTemplateSample @0x80100A70 : whether choice's template sample bit is set for this bank. */
unsigned int iSPCH_CheckTemplateSample(VoxChoice *choice, VoxBank *bank, int base)
{
    unsigned int result = 0;
    if (bank->subBankCount > choice->subBank)
        result = iSPCH_CheckBankBit(bank, base + bank->numSamples * choice->subBank);
    return result;
}

/* iSPCH_SampleExists @0x80100AC0 : whether sample `bank` of `choice` is present (template + cycle checks). */
unsigned int iSPCH_SampleExists(VoxChoice *choice, VoxBank *bank, int sampleIdx)
{
    unsigned int result = 1;
    if (bank->numSamples < sampleIdx) {
        result = 0;
    } else {
        if (choice->subBank != -1)
            result = iSPCH_CheckTemplateSample(choice, bank, sampleIdx);
        if ((bank->flags & 0xf0) != 0)
            result = iSPCH_CheckBankBit(bank, sampleIdx + 8);
    }
    return result;
}

/* iSPCH_ChooseSamples @0x80100B4C : collect up to `maxToPick` matching sample indices for `choice` into the
 *   pick pool, returning the count chosen. */
/* The fourth argument is the event-parameter table used by MatchSample (not an unused scalar).
 * Earlier volatile spellings of the table and phrase pointer were unnecessary; the plain typed
 * pointers below retain the byte-exact output. */
int iSPCH_ChooseSamples(VoxChoice *choice, int maxToPick, VoxPhrase *phraseTemplate, int *paramTable)
{
    int       bankIdx;
    VoxBank  *bank;
    int       nSamples;
    int       pickPos;
    int       chosen;
    int       sampleIdx;

    bankIdx  = choice->bankId;
    bank     = gVoxBanks[bankIdx];
    nSamples = bank->numSamples;
    pickPos  = choice->firstPick;
    chosen   = 0;

    for(sampleIdx = 0; sampleIdx < nSamples; sampleIdx++) {
        VoxSample tmp;

        if (iSPCH_UnPackSample(bank, sampleIdx, &tmp) &&
            iSPCH_MatchSample(bankIdx, &tmp, phraseTemplate, paramTable)) {
            if (iSPCH_SampleExists(choice, bank, (int)sampleIdx)) {
                ispch_gPickSamples[pickPos] = sampleIdx;
                pickPos++;
                
                chosen++;
                if (chosen >= maxToPick)
                    break;
            }
        }
    }

    return chosen;
}

/* iSPCH_SampleLength @0x80100C5C : sample-data length (in samples) of the current pick of `choice`. */
int iSPCH_SampleLength(VoxChoice *choice)
{
    int len;
    int sampleIdx;
    VoxBank *bank;
    VoxSample tmp;

    len = 0;
    sampleIdx = ispch_gPickSamples[choice->pick];
    bank = gVoxBanks[choice->bankId];

    if (iSPCH_UnPackSample(bank, sampleIdx, &tmp))
        len = tmp.length;
    return len;
}

/* iSPCH_ConvertTime @0x80100CC4 : convert a sample count to a time at the current data rate. */
int iSPCH_ConvertTime(int samples)
{
    int t = 0;
    if (gDataRate != 0) {
        t = (samples * 100) / gDataRate;
    }
    return t;
}

/* iSPCH_SentenceLength @0x80100D20 : total time of all phrases' current picks for `sentence`.
 * MATCH (2026-09-07): the EXPLICIT loop guard is what separates the two counters.  A plain
 * `for`/`while` leaves `total` and `i` tied at 7 refs / 13 live, so the s1/s2 pair falls to the
 * allocno-number tie-break and lands the wrong way round (8 or 12 diffs, count exact).  The
 * reason the tie exists: local-alloc's update_equiv_regs SINKS `total = 0` down to its first
 * use in the preheader, next to `i = 0`, equalising the live ranges (visible as the insn moving
 * between the .loop and .lreg dumps).  With the guard, `i` is born inside the guarded block
 * (7 refs / 10 = 1.40) while `total` keeps its pre-call birth (6 / 16 = 0.75), so `i` wins $s1
 * and `total` takes $s2 on PRIORITY -- and `i = 0` becomes retail's `addu $s1,$s2,$zero` copy of
 * total's zero.  Guarded `for`/`while` are 2 diffs at 31 insns (they emit the test twice). */
int iSPCH_SentenceLength(VoxSentence *sentence)
{
    int total = 0;
    int n = VoxSentence_GetNumPhrases(sentence);

    if (n > 0) {
        int i = 0;
        do {
            total += iSPCH_SampleLength(&ispch_gChoice[i]);
            i++;
        } while (i < n);
    }

    return iSPCH_ConvertTime(total);
}

/* iSPCH_OrderSentences @0x80100D94 : weighted-random play order of `event`'s sentences into outOrder.
 *   Each sentence's weight is the first byte of its record; sentences are drawn without replacement
 *   in proportion to weight, then the zero-weight ones are appended in table order. */
void iSPCH_OrderSentences(VoxEvent *event, unsigned char *outOrder)
{
    unsigned char  weights[104];
    unsigned char *p;
    int            n = event->numSentences;
    int            i, j;
    int            total = 0;

    for (j = 0; j < n; j++) {
        p = iSPCH_GetOffset16(event, event->sentenceOffs, j);
        weights[j] = *p;
        total += *p;
    }

    i = 0;
    while (total > 0) {
        int r = iSPCH_Rand(total);

        for (j = 0; j < n; j++) {
            r -= weights[j];
            if (r < 0)
                break;
        }

        outOrder[i++] = j;
        total -= weights[j];
        weights[j] = 0;
    }

    for (j = 0; j < n; j++) {
        p = iSPCH_GetOffset16(event, event->sentenceOffs, j);
        if (*p == 0)
            outOrder[i++] = j;
    }
}

/* iSPCH_RepeatEvent @0x80100EE0 : whether this in-game event may repeat (under its repeat limit). */
int iSPCH_RepeatEvent(VoxEvent *event)
{
    int result = 1;
    if (event->id == gVoxInGame[0] && 0 < event->repeatLimit)
        result = gVoxInGame[1] < event->repeatLimit;   /* [1] == gRepeatCount */
    return result;
}

/* iSPCH_ShortRuleStatus @0x80100F24 : evaluate a sentence's short-rule against `mode`. */
int iSPCH_ShortRuleStatus(VoxSentence *sentence, int mode)
{
    int ok = 0;
    int rule = VoxSentence_GetShortRule(sentence);
    if (rule == 1) {
        if (mode == 2) goto ok1;
    }
    if (rule == 2) {
        if (mode != rule) goto ok1;   /* rule==2 -> mode!=2 */
    }
    if (rule != 0) goto end;
ok1:
    ok = 1;
end:
    return ok;
}

/* iSPCH_SentenceGetChoices @0x80100F8C : for each phrase of `sentence`, resolve its bank and choose samples;
 *   returns 1 if a full set of choices was made, 0/-1 on failure.
 *   MATCH (re-derived vs raw, all 4 downstream call sites were mis-wired): ShortRuleStatus's 2nd arg
 *   is `filterMode` (NOT ruleByte2); CheckSentenceRules is (ruleByte1&0xff, ruleByte2&0xff, sentence)
 *   (NOT paramTable/ruleByte1); GetPhraseBank's 2nd arg is `paramTable` (NOT filterMode); and
 *   ChooseSamples' last two args are `(int)phraseTemplate, paramTable` (NOT filterMode, 0) -- the
 *   earlier recon's "0/filterMode" both came from reading the WRONG incoming register. */
int iSPCH_SentenceGetChoices(VoxSentence *sentence, int *paramTable, unsigned int ruleByte1,
                                        unsigned int ruleByte2, int filterMode)
{
    /* MATCH (w31-a4, 54->?): single result funnel (`fail:` block laid between the rule checks and
     * the loop, exactly the oracle's .L80101008) instead of separate return 0/-1 statements; the
     * -1 path stores THE RESULT VAR (`*outChoice = result`, oracle sh s4); outChoice recomputed
     * from `table` per iteration (&ispch_gChoice[table]) so loop.c reduces every access onto ONE +0-based
     * walker (pointer-walk form fabricated an &outChoice[2] anchor giv, +2 insns); result/picked
     * initialized before the GetNumPhrases call. */
    int result = 1;
    int picked = 0;
    int n = VoxSentence_GetNumPhrases(sentence);
    if (n < 0xd) {
        int table;
        if (iSPCH_ShortRuleStatus(sentence, filterMode) == 0)
            goto fail;
        if (iSPCH_CheckSentenceRules((int)(ruleByte1 & 0xff), (int)(ruleByte2 & 0xff), sentence) != 0)
            goto choose;
fail:
        result = 0;
        goto out;
choose:
        table = 0;
        if (0 < n) {
            do {
                VoxChoice *outChoice = &ispch_gChoice[table];
                int    r;
                VoxPhrase *phraseTemplate;
                outChoice->firstPick = (short)picked;
                phraseTemplate = iSPCH_GetOffset8(sentence, sentence->phraseOffs, table);
                if (iSPCH_GetPhraseBank(phraseTemplate, paramTable, outChoice) == 0) {
                    /* Start with the ordinary failure result.  The -2 bank sentinel is normalized
                     * to -1 before returning the more specific failure code. */
                    result = 0;
                    if (outChoice->bankId == -2) {
                        result = -1;
                        outChoice->bankId = -1;
                    }
                    goto out;
                }
                r = iSPCH_ChooseSamples(outChoice, 100 - picked, phraseTemplate, paramTable);
                picked = picked + r;
                if (r == 0)
                    goto fail;
                outChoice->numChosen = (short)r;
                table = table + 1;
            } while (table < n);
        }
    }
out:
    return result;
}

/* iSPCH_RandomizeSentencePicks @0x801010CC : shuffle the chosen samples of each phrase of `sentence`. */
void iSPCH_RandomizeSentencePicks(VoxSentence *sentence)
{
    int n = VoxSentence_GetNumPhrases(sentence);
    int i = 0;
    if (0 < n) {
        do {
            VoxChoice *choice = &ispch_gChoice[i];
            int   k = 0;
            int   cnt  = (int)(((unsigned int)(unsigned short)choice->numChosen) << 0x10) >> 0x10;
            int   half = cnt / 2;
            unsigned char *pickBase = ispch_gPickSamples + choice->firstPick;
            if (0 < half) {
                int halfCount = half;
                do {
                    int            swapIdx = iSPCH_Rand(cnt);
                    unsigned char *a = pickBase + k;
                    unsigned char *b = pickBase + swapIdx;
                    unsigned char  t = *a;
                    k = k + 1;
                    *a = *b;
                    *b = t;
                } while (k < halfCount);
            }
            i = i + 1;
        } while (i < n);
    }
}

/* iSPCH_IterateChoice @0x801011AC : advance to the next combination of phrase picks (odometer over choices).
 * MATCH (w31-a4, 43->4 diffs, insn count EXACT 44/44):
 *   (1) GOTO-LOOP, NOT do-while -- with do/while, gcc's loop pass (proven via cc1 -dL RTL dump)
 *       verifies `choice` as a biv, ELIMINATES it and combines every in-loop address giv onto the
 *       LAST giv in body order (anchor `addiu aN,v1,+4/+6` + all displacements rebased, +1 insn).
 *       The retail oracle keeps the plain record pointer with bare +4/+6/+8 displacements and a
 *       -12 decrement => the retail loop never went through loop.c strength-reduction, i.e. it was
 *       written label+goto (no LOOP notes).  Reverse of the catalog's while-over-goto preference.
 *   (2) limit built from NAMED temps `count = choice->numChosen; pbase = choice->firstPick; limit = pbase + count;`
 *       (loads in decl order +4,+6; addu operands [3]+[2] with dst = count's reg -- a single
 *       expression in either order gives the wrong load order or wrong addu operand order).
 *   (3) `exhausted = loopDone;` (not = 1) reproduces `addu s0,a2,zero` reusing the li 1.
 * RESIDUAL 4 diffs = position of the ispch_gChoice lui/addiu pair: retail materializes the base
 *   BEFORE the n*6 sll/addu/sll chain, our cc1 expands sym+mult canonically mult-first (verified
 *   invariant across ptr-arith / &arr[i] / 2D-row / int-cast / split-stmt forms and with
 *   -fno-schedule-insns; split-stmt forms flip la first but then mis-coalesce the addu dst with
 *   the base instead of the mult chain, 10-12 diffs).  Pure emission-order tie -- permuter target.
 * w34-a9 RE-VERDICT (8 more spellings, the split reduces to a two-basin tie):
 *   ANONYMOUS base forms -- `(short*)((int)ispch_gChoice + n*0xc)`, `(short*)(n*0xc +
 *   (int)ispch_gChoice)`, and both of those with the offset pre-computed into a named
 *   `chOff` -- ALL emit the mult chain first and the la last (4 diffs, the baseline).
 *   NAMED base forms -- `int chBase = (int)ispch_gChoice;` / `short *chBase =
 *   ispch_gChoice;` with the add spelled either way -- ALL emit the la FIRST (retail's
 *   order) but land base in $v1 and the mult chain in $v0, i.e. `addu v1,v0,v1` where
 *   retail has base in $v0 / mult in $v1 and `addu v1,v1,v0` (12 diffs).  So the la
 *   POSITION is source-controllable but the local-alloc qty pick that goes with it is
 *   not: retail needs la-first AND base->$v0, and no spelling produces that pair.
 *   Local-alloc quantity-order tie (longest-live-first among two block-0 temps),
 *   permuter target -- do not re-enumerate spellings.
 * w47-a2 QUANTIFIED (NEW NAMED ANGLE, still 4 -- do not re-enumerate spellings, attack the
 *   number): entry-block local qtys are exactly TWO -- base{high r90, lo_sum r89} and the
 *   mult chain {r93,r94,r95} (cc1 -dl, tools/rtl_dump_c.py).  next_qty==2 takes local-alloc's
 *   hand-rolled case-2 branch, which IS a priority compare, so the winner (=$v0) is decided by
 *   QTY_CMP_PRI = floor_log2(refs)*refs*size/(death-birth) with combine_regs SUMMING each qty's
 *   member refs (w46 law).  Measured: base refs 2+2=4, mult refs 2+2+2=6.
 *     la-LAST  (every anonymous spelling): base life ~4, mult life ~10 -> PRI 2.0 vs 1.2
 *       -> base wins $v0, mult $v1 = RETAIL'S REGISTERS, but the la sits after the sll chain.
 *     la-FIRST (every named-base spelling): base life ~10, mult life ~6 -> PRI 0.8 vs 2.0
 *       -> mult wins $v0 = the 12-diff role swap.
 *   So with the la emitted first the base CANNOT win at 4 refs: it needs PRI > 2.0, i.e. >= 8
 *   refs (3*8/10=2.4) -- ~6 extra uses of the base -- or the mult qty must drop to <= 2 refs
 *   (impossible: n*6 is a 3-insn sll/addu/sll chain).  => the reachable target is a form where
 *   the MULT CHAIN IS NOT A BLOCK-LOCAL QTY AT ALL (it writes straight into `choice`'s global
 *   pseudo, leaving the base as the block's ONLY local qty -> it takes $v0 unconditionally AND
 *   the la is emitted first).  Falsified for that (w47-a2, mini-TU probe scratch/w47_a2_iterate.py,
 *   15 spellings): choice_carries_mult `(short*)(n*12)` then `(char*)chBase + (int)choice`,
 *   choice_mult_then_add via a null base, mutate `choice = ispch_gChoice; choice += n*6;`,
 *   named (int, char pointer, row, deref, idx, reversed) bases, split decls, idx-first.  Flag axis CLOSED for
 *   this fn: -fno-schedule-insns (24), -fno-schedule-insns2 (10), both (28), -mno-split-addresses
 *   (15/43 insns), -G0, -G8, -fno-strength-reduce all >= the 8-probe baseline.
 * w49-a9 MATCH (4 -> PASS 44/44) -- w47-a2's OWN NUMBER, paid with the w47-a1/a4/a5 OPACITY FENCE.
 *   a2 quantified the tie exactly right and only lacked the dial: with the `la` emitted FIRST (every
 *   NAMED-base spelling) the base qty cannot win $v0 at 4 refs -- "it needs PRI > 2.0, i.e. >= 8 refs".
 *   `__asm__("" : "=r"(x) : "0"(x))` is a ZERO-INSTRUCTION value-numbering barrier that costs exactly
 *   +2 REG_N_REFS (one def + one use, output tied to input so nothing is emitted), so it is the dial
 *   a2 asked for.  Measured (cc1 -dl on the landed form, tools/rtl_dump_c.py): base lo_sum r89 =
 *   8 refs / 7 insns in block 0 => QTY_CMP_PRI floor_log2(8)*8/7 = 3.43, mult chain r93/r94/r95 =
 *   2 refs / 2 insns each (combine_regs sums: 6 refs / ~6) = 2.00 -> base takes $v0, mult $v1, and the
 *   named base keeps the `la` ahead of the sll/addu/sll chain = retail exactly.
 *   BASIN (all measured this pass, same named-base form): 0 fences 12, 1 fence 12, 2 fences 12,
 *   3 fences PASS, 4 fences PASS -- i.e. the step is between 6 and 8 refs, exactly as predicted.
 *   NOT USED (works, but this worker is barred from do/while devices): a nested `do{}while(0)` depth
 *   wrapper on the base def also PASSes (depth 1 alone = 12, depth 2 = PASS) -- the w44 ref-step dial.
 *   The 15 spellings + the flag axis a2 falsified are NOT re-enumerated; none of them touched refs.
 * Returns 1 only when every phrase has been exhausted (Ghidra void-bug -- real int return, read
 * at the epilogue: $v0 = the "ran out" flag). */
int iSPCH_IterateChoice(VoxSentence *sentence)
{
    int exhausted = 0;
    int n = VoxSentence_GetNumPhrases(sentence) - 1;
    int count, pbase, limit, loopDone, cur;
    /* SHAPE (re-measured 2026-09-05 against cc1 -dL/-dS/-dl and the gcc-2.8.0 sources):
     * 1. The label+goto below IS retail's shape, not a device.  Any real loop (do/while,
     *    while(1)+break, for(;;), goto-into-body) hands the body to loop.c, which records the
     *    six address givs (+4/+6/+8 off the walking pointer), combines them onto the LAST one
     *    recorded (the +6 of the limit re-read) and reduces it: `addiu $v1,$v1,6` anchor with
     *    displacements -2/0/2 -- 45 insns vs retail's 44 with bare 4/6/8.  Combined benefit is
     *    10 against a "not worth while" bar of lifetime*62*benefit < 24, so it is ALWAYS
     *    reduced; the indexed form `ispch_gChoice[n].f` cannot combine at all (express_from wants a
     *    CONST_INT add_val, ours carries the symbol) and yields three separate pointers (52).
     *    Retail's walk therefore never went through loop.c: its source had no loop notes.
     * 2. The wrapper below is a DEVICE, kept only because the device-free floor is 4 diffs.
     *    Device-free floor = `choice = &ispch_gChoice[n];` -> 44/44, every register right, only the
     *    `la` POSITION differs (retail: lui/addiu before the n*12 sll chain; ours: after).
     *    Mechanism: sched1 is a backward list scheduler; single-set ("birthing") insns get
     *    LAUNCH priority, ties fall to LUID = emission order, and `&ispch_gChoice[n]` emits the la
     *    AFTER the chain (expand_binop forces the symbol into a reg after op0).  A named base
     *    emits it first, but then local-alloc's QTY_CMP_PRI = floor_log2(refs)*refs/life gives
     *    the base {high,lo_sum} 4 refs over 11 half-insns (0.73) against the tied mult chain
     *    {t1,t2,t3} 6 refs over 7 (1.71): the chain is allocated first and takes $v0 (12 diffs).
     *    The base wins only at >= 8 refs; refs are loop-depth weighted in flow.c, and that is
     *    exactly what this depth-2 `do{}while(0)` buys (measured: depth 1 -> 7 refs, still
     *    loses; depth 2 -> 10 refs, PASS).  No hard-reg suggestion path exists (the preheader
     *    holds only $v0, the call's return).  Chains accumulated through `choice` itself lose
     *    the launch bonus (multi-set) and drop the la between the two halves.
     *    Falsified this pass (all 44/44 unless noted): anonymous &ispch_gChoice[n]/&sym[n*6]/byte-cast/
     *    int-cast/named-offset (4), named int / short-pointer / const base (12), choice=sym;choice+=n*6
     *    (10), chain-into-choice with anon/named base (4-6), n3=n*3 split (4-6), limit as
     *    scratch (6), depth-1 wrapper (12), for(;;){la;break;} (4), and 8 real-loop forms
     *    (19..58 diffs at 45..53 insns). */
    int chBase;
    VoxChoice *choice;
    do { do { chBase = (int)ispch_gChoice; } while (0); } while (0);
    choice = (VoxChoice *)chBase + n;
    count = choice->numChosen;
    pbase = choice->firstPick;
    limit = pbase + count;
    loopDone = exhausted;
top:
    cur = (unsigned short)choice->pick + 1;
    choice->pick = cur;
    if ((short)cur < limit) {
        loopDone = 1;
    } else {
        choice->pick = choice->firstPick;
        n = n - 1;
        choice--;
        if (n < 0) {
            loopDone  = 1;
            exhausted = loopDone;
        }
        count = choice->numChosen;
        pbase = choice->firstPick;
        limit = pbase + count;
    }
    if (!loopDone) goto top;
    return exhausted;
}

/* iSPCH_ChooseShortSentence @0x8010125C : pick a short sentence variant that fits the filter length. */
int iSPCH_ChooseShortSentence(VoxSentence *sentence)
{
    int done = 0;
    int n = VoxSentence_GetNumPhrases(sentence);
    int i = 0;
    int found = 0;
    if (0 < n) {
        do {
            VoxChoice *choice = &ispch_gChoice[i];
            choice->pick = choice->firstPick;
            i = i + 1;
        } while (i < n);
    }
    if (done == 0 && found == 0)
    do {
        int len    = iSPCH_SentenceLength(sentence);
        int filter = GetFilterLength();
        if (len < filter) {
            found = 1;
            done  = 1;
        } else {
            done = iSPCH_IterateChoice(sentence);
        }
    } while (done == 0 && found == 0);
    return found;
}

/* iSPCH_SentenceMakeChoice @0x80101310 : finalise the per-phrase pick (random or short-fit).
 * ✅ SEALED DEVICE-FREE (2026-09-04): plain `for` over &ispch_gChoice[i], no goto loop and no
 * do{}while(0) ref dial -- both are retired.  They existed together because the older
 * WALKER spelling (`sentence` reused as a byte cursor, bumped by 0xc) made loop.c strength-
 * reduce the three in-loop accesses onto one giv anchor (+1 insn, displacements rebased to
 * -4/-2/0 instead of retail's bare 4/6/8); the goto loop killed the anchor but then cost the
 * $s2<->$s3 rotation of `ok`/`n`, which the phony-loop wrapper had to dial back.  Recomputing
 * the record from the counter each iteration removes the biv entirely, so there is nothing to
 * reduce and nothing to re-weight: 43/43 byte-exact.  (Measured this pass: this form PASS;
 * typed walker + goto + dial also PASS but keeps both devices; a `for` over a walking pointer
 * without them is 9 diffs @44/43 -- the anchor is back.  An earlier note filed the indexed form as
 * "does not work, 36 diffs" -- that verdict was basin-relative and is now superseded.) */
int iSPCH_SentenceMakeChoice(VoxSentence *sentence, int mode)
{
    int ok = 0;
    if (mode == 1) {
        iSPCH_RandomizeSentencePicks(sentence);
        ok = iSPCH_ChooseShortSentence(sentence);
    } else {
        int n = VoxSentence_GetNumPhrases(sentence);
        int i = 0;
        if (ok < n) {
            ok = 1;
            for (i = 0; i < n; i++) {
                VoxChoice *choice = &ispch_gChoice[i];
                int r = iSPCH_Rand(choice->numChosen);

                choice->pick = choice->firstPick + (short)r;
            }
        }
    }
    return ok;
}

/* iSPCH_ConstantRuleSet @0x801013BC : fire gSentenceRuleSet for each phrase's constant (type != 0xf) rules.
 * The callback takes THREE arguments (spchinit.h): retail's `li $a3,1` is just the register the
 * shift constant lands in (`sllv $a2,$a3,$a2` in the jalr delay slot), not a fourth argument. */
void iSPCH_ConstantRuleSet(VoxEvent *event, VoxSentence *sentence)
{
    int n;
    int table;

    if (!gSentenceRuleSet)
        return;

    n = VoxSentence_GetNumPhrases(sentence);

    for (table = 0; table < n; table++) {
        VoxChoice *choice;
        VoxPhrase *phrase;
        int j;

        choice = &ispch_gChoice[table];
        phrase = iSPCH_GetOffset8(sentence, sentence->phraseOffs, table);

        for (j = 0; j < 4; j++) {
            int ruleType = phrase->nibbles[j] >> 4;
            if (ruleType != 0xf) {
                int rid;
                VoxBank *bank;
                int sampleIdx;
                VoxSample tmp;

                rid = iSPCH_GetRuleID(event, ruleType);
                bank = gVoxBanks[choice->bankId];
                sampleIdx = ispch_gPickSamples[choice->pick];

                if (iSPCH_UnPackSample(bank, sampleIdx, &tmp)) {
                    unsigned int bit;
                    bit = 1 << tmp.cycle[j];
                    gSentenceRuleSet(event->id, rid, bit);
                }
            }
        }
    }
}

/* iSPCH_MakeSampleRequests @0x80101508 : issue gSampleRequest for each chosen sample; returns total time. */
int iSPCH_MakeSampleRequests(VoxSentence *sentence, int eventId)
{
    int samples = 0;
    int n = VoxSentence_GetNumPhrases(sentence);
    int i = 0;
    if (0 < n) {
        do {
            VoxChoice    *choice = &ispch_gChoice[i];
            VoxBank      *bank = gVoxBanks[choice->bankId];
            unsigned int  idx  = ispch_gPickSamples[choice->pick];
            VoxSample     tmp;
            /* MATCH: the ClearCycleBit call is gated on BOTH bank[2]&0xf0 AND the separate global
             * gClearCycle != 0 -- the earlier recon only had the bank-flags half of the gate. */
            if ((bank->flags & 0xf0) != 0 && gClearCycle != 0)
                iSPCH_ClearCycleBit(bank, idx);
            if (iSPCH_UnPackSample(bank, idx, &tmp) != 0) {
                /* MATCH: stride computed UNCONDITIONALLY before the -1 test (oracle lhu+sll precede
                 * the beq; the mult starts in the branch delay slot) and choice->subBank read ONCE into a
                 * named local -- the old double subBank read made loop.c fabricate a second
                 * &choice->subBank giv (addiu s3,s2,2 anchor, +2 insns). */
                int spuAddr = tmp.startOff;
                int sub     = (int)choice->subBank;
                int stride  = (int)bank->dataSize256 << 8;
                if (sub != -1)
                    spuAddr = spuAddr + sub * stride;
                samples = samples + tmp.length;
                gSampleRequest((int)choice->bankId, spuAddr, tmp.length, eventId);
                /* MATCH (w32-a9, 23 -> 3 diffs): the -dL "savings-1 lone lui not desirable"
                 * verdict was a CONSEQUENCE of the then-current gp-relative SCALAR form, not a
                 * cost-model identity.  The unsized-array device (catalog SSE / SSE#5) made cc1
                 * materialize the base in a SEPARATE temp, which loop.c then happily hoists into
                 * $s6 exactly as retail, leaving `lw v0,0(s6)` in the loop; under the library-wide
                 * -G0 the plain scalar call compiles to the identical split/hoisted form
                 * (re-verified PASS 2026-09-02).  RESIDUAL 3 (83/82) = reorg fills the `beqz` guarding the ClearCycleBit
                 * call by STEALING (duplicating) the `addu a0,s0,zero` from the join block, where
                 * retail fills it with the following `lui %hi(gClearCycle)`; nested-if vs && makes
                 * no difference -- a delay-slot-filler preference, not a source shape. */
            }
            i = i + 1;
        } while (i < n);
    }
    return iSPCH_ConvertTime(samples);
}

/* iSPCH_ClearChosen @0x80101650 : mark "nothing chosen". */
void iSPCH_ClearChosen(void)
{
    gSentenceChoice.chosen = 0;
}

/* iSPCH_SaveChosenSentence @0x8010165C : record the winning event, its chosen sentence + index, and the 12 eventArgs.  Returns 1. */
int iSPCH_SaveChosenSentence(VoxEvent *event, VoxSentence *sentence, int sentenceIdx, int *eventArgs)
{
    /* gSentenceChoice[0..2] = DAT_8014843C/40/44 (one contiguous block); [4..15] = the 12 eventArgs.
     * The original reaches all three head fields + the loop off a single shared base. */
    int i;

    gSentenceChoice.event = event;    /* DAT_8014843C (via %hi reg) */
    gSentenceChoice.sentence = sentence; /* DAT_80148440 */
    gSentenceChoice.sentenceIdx = sentenceIdx;   /* DAT_80148444 */

    for(i = 0; i < 12; i++) {
        gSentenceChoice.eventArgs[i] = eventArgs[i];
    }

    gSentenceChoice.chosen = 1;
    return 1;
}

/* iSPCH_OneChosen @0x801016A4 : the "one chosen" flag. */
int iSPCH_OneChosen(void)
{
    return gSentenceChoice.chosen;
}

/* iSPCH_PlayChosen @0x801016B4 : apply rules and issue the sample requests for the chosen sentence. */
void iSPCH_PlayChosen(void)
{
    if (iSPCH_OneChosen()) {
        int eventId;

        eventId = gSentenceChoice.eventArgs[0];

        iSPCH_RuleSet(gSentenceChoice.event, gSentenceChoice.sentenceIdx, gSentenceChoice.eventArgs);
        iSPCH_ConstantRuleSet(gSentenceChoice.event, gSentenceChoice.sentence);
        iSPCH_MakeSampleRequests(gSentenceChoice.sentence, eventId);

        {
            int *inGame = gVoxInGame;
            int newRepeatCount;   /* MATCH: gVoxInGame[1] == gRepeatCount; a SHARED store after the
                                    * if/else (not one store per branch) is what tail-merges into the
                                    * oracle's single `sw v0,4(a0)` at the branches' join point. */
            if (eventId == inGame[0]) {
                newRepeatCount = inGame[1] + 1;
            } else {
                newRepeatCount = 1;
                inGame[0] = eventId;
            }
            inGame[1] = newRepeatCount;
        }
    }
    iSPCH_ClearChosen();
}

/* iSPCH_ChooseSentence @0x80101754 : top-level -- for the event in `eventArgs`, find a sentence template that
 *   passes its rules, choose samples for it, and save the result.  Returns the chosen-sentence index or -1. */
int iSPCH_ChooseSentence(unsigned int *eventArgs)
{
    /* Retail has no local debug names here. The callees and uses identify
     * sentenceOrder as the ordered sentence-index buffer and ruleTestFlags
     * as GetRuleSettings' byte out-parameter, not their literal spellings. */
    unsigned char sentenceOrder[104];
    char          ruleTestFlags = 0;
    int           idx = 0;
    VoxEvent     *event = iSPCH_FindEvent(*eventArgs);
    int           result = 0;
    if (event != 0) {
        if (iSPCH_RepeatEvent(event) != 0) {
            unsigned int filterMode;
            unsigned int filterFlag;

            iSPCH_ClearChosen();
            filterFlag = 1;
            filterMode = (unsigned int)gFilterSetting;
            if (gVoxEvents.dFlag == 1) {
                filterMode = (unsigned int)(gFilterSetting + 1);
                filterFlag = (unsigned int)((int)filterMode < 3);
                if (filterFlag == 0)
                    filterMode = 2;
            }
            {
                unsigned int  useLen = (unsigned int)VoxEvent_GetFilterLengthFlag(event);
                unsigned char ruleBits;
                /* @0x801017F4-808: gate is (useLen & 0xFF) != 0 && filterMode == 1 -- $v0 tested at
                 * 0x801017F8 is the VoxEvent_GetFilterLengthFlag return (&0xFF), NOT filterFlag. The
                 * recon gated on filterFlag (a distinct var from the DAT_80148064 branch) (M09). */
                if ((useLen & 0xff) != 0 && filterMode == 1)
                    filterMode = 0;
                /* REAL BUG (w33-a9): ruleByte1 is iSPCH_GetRuleSettings' RETURN, not useLen.
                 * The oracle saves $v0 into $fp in the OrderSentences jal delay slot
                 * (@0x8010182C `addu fp,v0,zero`), i.e. AFTER the GetRuleSettings call --
                 * so the value later masked `andi a2,fp,0xff` and passed as the 3rd arg of
                 * iSPCH_SentenceGetChoices is the rule-settings byte.  useLen (the
                 * VoxEvent_GetFilterLengthFlag return) is consumed ONLY by the filterMode
                 * gate above -- the oracle never saves it (bare `andi v0,v0,0xff; beqz`).
                 * The old recon reused useLen for both, which both mis-typed the argument
                 * and pinned useLen into a callee-saved reg for the whole function. */
                ruleBits = iSPCH_GetRuleSettings(event, (int *)eventArgs, &ruleTestFlags);
                iSPCH_OrderSentences(event, sentenceOrder);
                {
                    unsigned int n = event->numSentences;
                    result = -1;
                    if (0 < (int)n) {
                        result = 0;
                        do {
                            int table;   /* MATCH: read UNSIGNED (oracle: lbu) -- sentenceOrder[] holds
                                          * 0..n-1 always, so `table < 0` below is dead/vestigial code
                                          * (never true at runtime) but the oracle still emits the bltz
                                          * guard for it (a `(signed char)` cast would wrongly emit `lb`
                                          * here; this compiler only emits `lb` for an EXPLICIT signed
                                          * cast, never implicitly -- see reference_asm_pattern_catalog
                                          * §C "char IS UNSIGNED on this build"). */
                            VoxSentence *sentence;
                            int          r;
                            /* MATCH (w33-a9): the three range guards leave via `goto out`
                             * (ONE shared `return result`), not three textual `return result;`.
                             * gcc's cross-jump pass merges the three `move v0,result` copies
                             * only AFTER register allocation, so the textual form makes
                             * REG_N_REFS(result) 16 instead of 13 -- and 16 crosses a
                             * floor_log2 step, so local-alloc's priority
                             * (floor_log2(refs)*refs/live_length) jumps 1.20 -> 1.49 and
                             * result outranks `table` (10 refs / 25 insns = 1.20), taking $s1
                             * and pushing table to $s2.  Retail has table in $s1 and result in
                             * $s2, i.e. the shared-exit form.  (cc1 -dl/-dg dumps: allocation
                             * order 107 85 83 ... -> 107 83 85 ...; whole-fn 28 diffs -> 0.) */
                            if ((int)n <= idx)
                                goto out;
                            table = (int)sentenceOrder[idx];
                            if (table < 0)
                                goto out;
                            if ((int)n <= table)
                                goto out;
                            sentence = iSPCH_GetOffset16(event, event->sentenceOffs, (int)table);
                            r = iSPCH_SentenceGetChoices(sentence, (int *)eventArgs, ruleBits,
                                                         (unsigned int)(unsigned char)ruleTestFlags, (int)filterMode);
                            if (0 < r) {
                                result = iSPCH_SentenceMakeChoice(sentence, (int)filterMode);
                                if (result != 0)
                                    iSPCH_SaveChosenSentence(event, sentence, (int)table, (int *)eventArgs);
                            }
                            idx = idx + 1;
                        } while (result == 0);
                    }
                }
            }
        }
    }
out:
    return result;
}

/* SPCH_SetPreLoadTicks @0x801018F4 : set the speech pre-load tick offset. */
void SPCH_SetPreLoadTicks(int ticks)
{
    gPreLoadTicks = ticks;
}

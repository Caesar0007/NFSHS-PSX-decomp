/* eaclib/psx/spchpsxz/spchpick.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 16/27 PASS ***
 *   (w22-a3, 2026-07-20: header was stale at "27/27" -- corrected after a verify_asm_full survey found
 *    11 real FAILs. Current FAILs by diff size: iSPCH_OrderSentences(64,85/83) iSPCH_ChooseSentence(58,104=104)
 *    iSPCH_SentenceGetChoices(54,84/80) iSPCH_MakeSampleRequests(51,85/82) iSPCH_MatchSample(34,67/65)
 *    iSPCH_IterateChoice(43,45/44) iSPCH_ConstantRuleSet(20,83=83) iSPCH_SampleLength(16,26=26)
 *    iSPCH_SentenceMakeChoice(9,44/43,documented biv-elim floor) iSPCH_RandomizeSentencePicks(7,57/56)
 *    iSPCH_ChooseShortSentence(7,46/45) iSPCH_PlayChosen(7,41/40). See per-fn comments for what's been tried.)
 *   Source obj : nfs4\eaclib\psx\spchpick.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   27 fns @[0x8010077C .. 0x801018F4].  The sentence/sample PICKER -- the top of the speech pipeline: takes
 *   a chosen event, picks a sentence template that passes its rules, chooses matching samples per phrase,
 *   randomises/orders them, and issues sample-load requests via the gSampleRequest callback.
 *   Ghidra nfs4-f.exe.c (spchpick) + disasm-v3 (authoritative for arg flow) + IDA sigs.
 *
 *   Choice record `ispch_gChoice` = short[6] per phrase (stride 0xc): [0]bankIdx [1]subBank [2]nChosen
 *     [3]pickBase [4]curPick.  ispch_gPickSamples = byte[] of chosen sample indices.
 *   Ghidra-isms resolved: many in_v0 = dropped VoxSentence_GetNumPhrases/GetShortRule/OneChosen returns;
 *   iSPCH_MatchSample's `GetMatchValue(sample,i)` return is the match value (its raw-byte read is dead);
 *   ChooseSamples' MatchSample call passes the bank PTR (Ghidra's (int)sVar2 cast was a mis-decode);
 *   ChooseSentence's dropped-arg calls recovered from disasm; SetPreLoadTicks' `this` is the tick value.
 */

extern "C" short          ispch_gChoice[];     /* short[6]/phrase choice records */
extern "C" unsigned char  ispch_gPickSamples[]; /* chosen sample-index pool; MATCH: unsized-array -> separate-temp addr load */
extern "C" int            gSentenceChoice[];   /* @0x8014843C saved chosen sentence ptr; [0..2]=choice/40/44 (== old
                                                 * DAT_80148440/44), [4..15]=eventArgs (== old DAT_8014844c) --
                                                 * read via gSentenceChoice[N] everywhere so it shares gSentenceChoice[0]'s
                                                 * already-materialized base, matching the oracle (see PlayChosen). */
extern "C" int            DAT_80148448[];      /* "one chosen" flag */

extern "C" int  gVoxBanks[];      /* spchbank (array decl -> separate-temp loads) */
extern "C" int  gDataRate[];      /* spchinit */
extern "C" int  gSampleRequest;   /* spchinit (callback) */
extern "C" int  gSentenceRuleSet; /* spchinit (callback) */
extern "C" int  gVoxInGame[];     /* spchinit; [1] aliases gRepeatCount@+4 */
extern "C" int  gRepeatCount;     /* spchinit (== gVoxInGame[1]) */
extern "C" int  gFilterSetting;   /* spchevnt-shared */
extern "C" int  DAT_80148064;     /* spchevnt "kept 'd' event" flag */
extern "C" int  gPreLoadTicks[];  /* spchevnt-shared */
extern "C" int  gClearCycle;      /* @0x801370BC "cycle-bit clearing enabled" flag (init val 1);
                                    * data-materialized right next to gNumBanks in the spchbank data
                                    * block but not yet given a home TU -- HEADER WISH: belongs in
                                    * spchbank.c or spchinit.c alongside its neighbors, out of this
                                    * file's scope. */

extern "C" int  iSPCH_GetMatchValue(int base, int index);                 /* spchdata */
extern "C" int  VoxSentence_GetNumPhrases(int sentence);                  /* spchdata */
extern "C" int  VoxSentence_GetShortRule(int sentence);                   /* spchdata */
extern "C" int  iSPCH_GetOffset8(int base, int tableBase, int index);     /* spchdata */
extern "C" int  iSPCH_GetOffset16(int base, int tableBase, int index);    /* spchdata */
extern "C" int  VoxEvent_GetFilterLengthFlag(int e);                      /* spchdata */
extern "C" int  iSPCH_FindBank(int key);                                  /* spchbank (returns bank index) */
extern "C" unsigned int iSPCH_TestSubBankBounds(int bankIdx, int subIdx); /* spchbank */
extern "C" int  iSPCH_UnPackSample(int bank, unsigned int sampleIdx, int *out); /* spchsamp */
extern "C" int  iSPCH_Rand(int n);                                        /* spchrand */
extern "C" unsigned int iSPCH_GetRuleID(int sentence, int index);         /* spchrule */
extern "C" void iSPCH_RuleSet(short *sentence, int rule, int val);        /* spchrule */
extern "C" unsigned int iSPCH_CheckSentenceRules(int a, int b, int c);    /* spchrule */
extern "C" void iSPCH_GetRuleSettings(short *sentence, int *values, char *out); /* spchrule */
extern "C" int  iSPCH_FindEvent(unsigned int eventID);                    /* spchevnt */
extern "C" int  GetFilterLength(void);                                    /* spchevnt */
extern "C" void trap(unsigned int code);

extern "C" int  iSPCH_MatchSample(int bankIdx, int sample, int phraseTemplate, int paramTable); /* @0x8010077C : bankIdx UNUSED */
extern "C" unsigned int iSPCH_GetPhraseBank(short *phraseTemplate, int paramTable, short *outChoice); /* @0x80100880 */
extern "C" int  iSPCH_GetBankBits(int bank);                              /* @0x80100994 */
extern "C" unsigned char *iSPCH_ClearCycleBit(int bank, int cycle);      /* @0x801009B8 */
extern "C" unsigned int iSPCH_CheckBankBit(int bank, int cycle);         /* @0x80100A1C */
extern "C" unsigned int iSPCH_CheckTemplateSample(int choice, int bank, int base); /* @0x80100A70 */
extern "C" unsigned int iSPCH_SampleExists(int choice, int bankPtr, int bank); /* @0x80100AC0 */
extern "C" int  iSPCH_ChooseSamples(short *choice, int maxToPick, int phraseTemplate, int unused); /* @0x80100B4C */
extern "C" int  iSPCH_SampleLength(short *choice);                        /* @0x80100C5C */
extern "C" int  iSPCH_ConvertTime(int samples);                          /* @0x80100CC4 */
extern "C" int  iSPCH_SentenceLength(int sentence);                      /* @0x80100D20 */
extern "C" unsigned char *iSPCH_OrderSentences(int event, int outOrder); /* @0x80100D94 */
extern "C" unsigned int iSPCH_RepeatEvent(unsigned short *eventArgs);    /* @0x80100EE0 */
extern "C" int  iSPCH_ShortRuleStatus(int sentence, int mode);           /* @0x80100F24 */
extern "C" int  iSPCH_SentenceGetChoices(int sentence, int paramTable, unsigned int ruleByte1, unsigned int ruleByte2, int filterMode); /* @0x80100F8C */
extern "C" void iSPCH_RandomizeSentencePicks(int sentence);             /* @0x801010CC */
extern "C" int  iSPCH_IterateChoice(int sentence);                      /* @0x801011AC : returns 1 if the odometer is exhausted (Ghidra void-bug: real return, read at epilogue) */
extern "C" int  iSPCH_ChooseShortSentence(int sentence);               /* @0x8010125C */
extern "C" int  iSPCH_SentenceMakeChoice(int sentence, int mode);      /* @0x80101310 */
extern "C" void iSPCH_ConstantRuleSet(short *sentence, int rule, int val); /* @0x801013BC */
extern "C" int  iSPCH_MakeSampleRequests(int sentence, int paramTable); /* @0x80101508 */
extern "C" void iSPCH_ClearChosen(void);                               /* @0x80101650 */
extern "C" int  iSPCH_SaveChosenSentence(int sentence, int paramTable, int ruleCtx, int *eventArgs); /* @0x8010165C */
extern "C" int  iSPCH_OneChosen(void);                                 /* @0x801016A4 */
extern "C" void iSPCH_PlayChosen(void);                                /* @0x801016B4 */
extern "C" int  iSPCH_ChooseSentence(unsigned int *eventArgs);         /* @0x80101754 */
extern "C" void SPCH_SetPreLoadTicks(int ticks);                       /* @0x801018F4 */

#define CHOICE(n)  (ispch_gChoice + (n) * 6)
#define PICK(i)    (ispch_gPickSamples[i])

/* iSPCH_MatchSample @0x8010077C : does the unpacked `sample`'s cycle byte at each index match the
 *   phraseTemplate's per-index match value / paramTable-looked-up nibble?  `bankIdx` (a0) is a
 *   genuinely UNUSED first argument (confirmed vs raw: MatchSample never saves/reads a0 anywhere;
 *   the real registers are a1=sample a2=phraseTemplate a3=paramTable -- see iSPCH_ChooseSamples'
 *   call site, which passes (bankIdx, &tmp, phraseTemplate, paramTable), and iSPCH_GetPhraseBank's
 *   `paramTable` param for the shared nibble-lookup-table semantics).  MATCH: lowNib is a RAW BYTE
 *   read *(phraseTemplate+i+4), computed and ANDed in the GetMatchValue jal's delay slot (so it's the
 *   PRE-CALL value, not derived from the call's return -- the earlier recon wrongly took lowNib from
 *   matchVal's low nibble AND wrongly read count/cycleByte off the swapped bank/sample roles). */
extern "C" int iSPCH_MatchSample(int bankIdx, int sample, int phraseTemplate, int paramTable)
{
    int count = (int)*(signed char *)(phraseTemplate + 3);
    int result = 1;
    (void)bankIdx;
    if (count < 5) {
        if (0 < count) {
            int i = 0;
            do {
                unsigned int cycleByte = *(unsigned char *)(sample + i + 0xc);
                result = 0;
                if (0x1f < cycleByte)
                    break;
                {
                    unsigned int bit      = 1u << (cycleByte);
                    int          lowNib   = (int)*(unsigned char *)(phraseTemplate + i + 4) & 0xf;
                    int          matchVal = iSPCH_GetMatchValue(phraseTemplate, i);
                    if ((bit & (unsigned int)matchVal) != 0 &&
                        (lowNib == 0 ||
                         (bit & (unsigned int)*(int *)(lowNib * 4 + paramTable)) != 0))
                        result = 1;
                }
                if (result == 0)
                    return 0;
                i = i + 1;
            } while (i < count);
        }
        return result;
    }
    return 0;
}

/* iSPCH_GetPhraseBank @0x80100880 : resolve a phrase template's bank choice (fixed / by-param / sub-bank)
 *   into outChoice[0..1].  Returns 0 on success, nonzero (sign of ~choice) on failure. */
extern "C" unsigned int iSPCH_GetPhraseBank(short *phraseTemplate, int paramTable, short *outChoice)
{
    unsigned short wanted = *(unsigned short *)phraseTemplate;
    unsigned int   flags  = *(unsigned char *)(phraseTemplate + 1);
    unsigned int   mode   = flags >> 4;
    unsigned int   param  = flags & 0xf;
    int            choice;
    outChoice[1] = -1;
    *outChoice   = -1;
    if (mode == 1)
        goto byParam;
    if (mode == 0)
        goto byFind;
    if (mode == 2)
        goto bySub;
    goto done;
byFind:   /* MATCH: byFind block laid out FIRST (oracle .L8DC precedes byParam .L8EC) */
    choice = iSPCH_FindBank((unsigned int)wanted);
    *outChoice = (short)choice;
    goto done;
byParam:
    choice = *(int *)(param * 4 + paramTable);
    if (-1 < choice) {
        int voxBase = gVoxBanks[0];   /* MATCH: array decl -> separate-temp load (lui v0; lw v1) */
        if ((unsigned int)**(unsigned short **)(choice * 4 + voxBase) != (unsigned int)wanted)
            choice = -1;
    }
    *outChoice = (short)choice;
    goto done;
bySub:
    {
        int *pv;
        choice = iSPCH_FindBank((unsigned int)wanted);
        pv = (int *)(param * 4 + paramTable);
        if (iSPCH_TestSubBankBounds(choice, *pv) != 0)   /* MATCH: success = fall-through, -1 arm out-of-line */
            outChoice[1] = (short)*pv;
        else
            choice = -1;
        *outChoice = (short)choice;
    }
done:
    /* mode > 2: outChoice stays -1 */
    return (unsigned int)~(int)*outChoice >> 0x1f;
}

/* iSPCH_GetBankBits @0x80100994 : address of a bank's cycle-bits array (after its sample table).
 * MATCH: in-place dead-ptr: bank+=8 forces oracle's addiu a0,a0,8; addu v0,a0,mflo */
extern "C" int iSPCH_GetBankBits(int bank)
{
    int stride = ((int)*(unsigned char *)(bank + 2) & 0xf) + 2;
    int nSamp  = (int)(unsigned int)*(unsigned char *)(bank + 3);
    bank += 8;
    return bank + nSamp * stride;
}

/* iSPCH_ClearCycleBit @0x801009B8 : clear cycle bit `cycle` in `bank`'s bits array; returns the byte ptr. */
extern "C" unsigned char *iSPCH_ClearCycleBit(int bank, int cycle)
{
    int            r = cycle;
    int            off;
    unsigned int   mask;
    unsigned char *bits;
    unsigned char *p;
    if (cycle < 0)
        r = cycle + 7;
    r = r >> 3;
    off = r + 1;
    mask = ~(1 << (cycle - (r << 3)));
    bits = (unsigned char *)iSPCH_GetBankBits(bank);
    p = bits + off;
    *p = (unsigned char)(*p & mask);
    return p;
}

/* iSPCH_CheckBankBit @0x80100A1C : test cycle bit `cycle` in `bank`'s bits array. */
extern "C" unsigned int iSPCH_CheckBankBit(int bank, int cycle)
{
    int byteIdx = cycle / 8;   /* MATCH: plain signed /8 -> gcc's bgez/+7/sra COPY form (cycle stays $a1) */
    unsigned int bit = 1 << (cycle - (byteIdx << 3));
    unsigned char *bits = (unsigned char *)iSPCH_GetBankBits(bank);
    return (unsigned int)*(unsigned char *)(bits + byteIdx) & bit;
}

/* iSPCH_CheckTemplateSample @0x80100A70 : whether choice's template sample bit is set for this bank. */
extern "C" unsigned int iSPCH_CheckTemplateSample(int choice, int bank, int base)
{
    unsigned int result = 0;
    if ((int)(unsigned int)*(unsigned short *)(bank + 6) > (int)*(short *)(choice + 2))
        result = iSPCH_CheckBankBit(bank, base + (int)(unsigned int)*(unsigned char *)(bank + 3) *
                                                   (int)*(short *)(choice + 2));
    return result;
}

/* iSPCH_SampleExists @0x80100AC0 : whether sample `bank` of `choice` is present (template + cycle checks). */
extern "C" unsigned int iSPCH_SampleExists(int choice, int bankPtr, int bank)
{
    unsigned int result = 1;
    if ((int)(unsigned int)*(unsigned char *)(bankPtr + 3) < bank) {
        result = 0;
    } else {
        if (*(short *)(choice + 2) != -1)
            result = iSPCH_CheckTemplateSample(choice, bankPtr, bank);
        if ((*(unsigned char *)(bankPtr + 2) & 0xf0) != 0)
            result = iSPCH_CheckBankBit(bankPtr, bank + 8);
    }
    return result;
}

/* iSPCH_ChooseSamples @0x80100B4C : collect up to `maxToPick` matching sample indices for `choice` into the
 *   pick pool, returning the count chosen. */
extern "C" int iSPCH_ChooseSamples(short *choice, int maxToPick, volatile int phraseTemplate, volatile int unused)
{
    int           sampleIdx = 0;
    int           bankIdx   = *choice;
    int           bank      = *(int *)(bankIdx * 4 + gVoxBanks[0]);
    unsigned int  nSamples  = *(unsigned char *)(bank + 3);
    int           pickPos   = (int)choice[3];
    int           chosen    = 0;
    int           tmp[4];
    if (nSamples != 0) {
        do {
            int r = iSPCH_UnPackSample(bank, sampleIdx, tmp);
            if (r != 0 &&
                iSPCH_MatchSample(bankIdx, (int)tmp, phraseTemplate, unused) != 0) {
                if (iSPCH_SampleExists((int)choice, bank, (int)sampleIdx) != 0) {
                    PICK(pickPos) = (unsigned char)sampleIdx;
                    chosen  = chosen + 1;
                    pickPos = pickPos + 1;
                    if (maxToPick <= chosen)
                        return chosen;
                }
            }
            sampleIdx = sampleIdx + 1;
        } while (sampleIdx < (int)nSamples);
    }
    return chosen;
}

/* iSPCH_SampleLength @0x80100C5C : sample-data length (in samples) of the current pick of `choice`. */
extern "C" int iSPCH_SampleLength(short *choice)
{
    int tmp[4];
    /* residual 10: ours colors the pick-byte chain base->a1/idx->v0 (la lands in the lbu-arg reg),
     * oracle idx->a1/base->v0; fresh-sum/inline/anonymous-chain reshapes all score worse (14/16/22) */
    unsigned char *pickAddr = ispch_gPickSamples;
    int voxBase = gVoxBanks[0];
    int len = 0;
    pickAddr = pickAddr + choice[4];
    int bank = *(int *)(*choice * 4 + voxBase);
    int r = iSPCH_UnPackSample(bank, (unsigned int)*pickAddr, tmp);
    if (r != 0)
        len = tmp[0];
    return len;
}

/* iSPCH_ConvertTime @0x80100CC4 : convert a sample count to a time at the current data rate. */
extern "C" int iSPCH_ConvertTime(int samples)
{
    int t = 0;
    if (gDataRate[0] != 0) {
        t = (samples * 100) / gDataRate[0];
    }
    return t;
}

/* iSPCH_SentenceLength @0x80100D20 : total time of all phrases' current picks for `sentence`. */
extern "C" int iSPCH_SentenceLength(int sentence)
{
    int total = 0;
    int n = VoxSentence_GetNumPhrases(sentence);
    int i = 0;
    if (0 < n) {
        short *choice = ispch_gChoice;
        do {
            total = total + iSPCH_SampleLength(choice);
            i = i + 1;
            choice = choice + 6;
        } while (i < n);
    }
    return iSPCH_ConvertTime(total);
}

/* iSPCH_OrderSentences @0x80100D94 : produce a weighted-random play order of `event`'s phrases into outOrder. */
extern "C" unsigned char *iSPCH_OrderSentences(int event, int outOrder)
{
    unsigned char  weights[104];
    unsigned char *last = (unsigned char *)0;
    unsigned int   n = (unsigned int)*(unsigned char *)(event + 6);
    int            total = 0;
    int            i = 0;
    if (n != 0) {
        do {
            unsigned char *p = (unsigned char *)iSPCH_GetOffset16(event, event + 0xc, i);
            weights[i] = *p;
            i = i + 1;
            total = total + (int)(unsigned int)*p;
        } while (i < (int)n);
    }
    i = 0;
    if (0 < total) {
        do {
            int            r = iSPCH_Rand(total);
            int            j = 0;
            if (n != 0) {
                for (;;) {
                    unsigned char *p = weights + j;
                    r = r - (int)(unsigned int)*p;
                    if (r < 0)
                        break;
                    j = j + 1;
                    if ((int)n <= j)
                        break;
                }
            }
            *(char *)(outOrder + i) = (char)j;
            last = weights + j;
            i = i + 1;
            total = total - (int)(unsigned int)*last;
            *last = 0;
        } while (0 < total);
    }
    i = 0;
    {
        int k = 0;
        if (n != 0) {
            do {
                char *p = (char *)iSPCH_GetOffset16(event, event + 0xc, k);
                if (*p == '\0') {
                    *(char *)(outOrder + i) = (char)k;
                    i = i + 1;
                }
                k = k + 1;
                last = (unsigned char *)0;
            } while (k < (int)n);
        }
    }
    return last;
}

/* iSPCH_RepeatEvent @0x80100EE0 : whether this in-game event may repeat (under its repeat limit). */
extern "C" unsigned int iSPCH_RepeatEvent(unsigned short *eventArgs)
{
    unsigned int result = 1;
    if ((unsigned int)*eventArgs == (unsigned int)gVoxInGame[0] && 0 < (signed char)eventArgs[4])
        result = (unsigned int)(gVoxInGame[1] < (signed char)eventArgs[4]);   /* [1] == gRepeatCount */
    return result;
}

/* iSPCH_ShortRuleStatus @0x80100F24 : evaluate a sentence's short-rule against `mode`. */
extern "C" int iSPCH_ShortRuleStatus(int sentence, int mode)
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
extern "C" int iSPCH_SentenceGetChoices(int sentence, int paramTable, unsigned int ruleByte1,
                                        unsigned int ruleByte2, int filterMode)
{
    int picked = 0;
    int n = VoxSentence_GetNumPhrases(sentence);
    int result = 1;
    if (n < 0xd) {
        if (iSPCH_ShortRuleStatus(sentence, filterMode) == 0) {
            result = 0;
        } else if (iSPCH_CheckSentenceRules((int)(ruleByte1 & 0xff), (int)(ruleByte2 & 0xff), sentence) == 0) {
            result = 0;
        } else {
            int    table = 0;
            short *outChoice = ispch_gChoice;
            if (0 < n) {
                do {
                    int    r;
                    short *phraseTemplate;
                    outChoice[3] = (short)picked;
                    phraseTemplate = (short *)iSPCH_GetOffset8(sentence, sentence + 4, table);
                    if (iSPCH_GetPhraseBank(phraseTemplate, paramTable, outChoice) == 0) {
                        if (*outChoice != -2)
                            return 0;
                        *outChoice = -1;
                        return -1;
                    }
                    r = iSPCH_ChooseSamples(outChoice, 100 - picked, (int)phraseTemplate, paramTable);
                    picked = picked + r;
                    if (r == 0)
                        return 0;
                    outChoice[2] = (short)r;
                    table = table + 1;
                    outChoice = outChoice + 6;
                } while (table < n);
            }
        }
    }
    return result;
}

/* iSPCH_RandomizeSentencePicks @0x801010CC : shuffle the chosen samples of each phrase of `sentence`. */
extern "C" void iSPCH_RandomizeSentencePicks(int sentence)
{
    int n = VoxSentence_GetNumPhrases(sentence);
    int i = 0;
    if (0 < n) {
        short *choice = ispch_gChoice;
        do {
            int   k = 0;
            int   cnt  = (int)(((unsigned int)(unsigned short)choice[2]) << 0x10) >> 0x10;
            int   half = cnt / 2;
            unsigned char *pickBase = ispch_gPickSamples + choice[3];
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
            choice = choice + 6;
        } while (i < n);
    }
}

/* iSPCH_IterateChoice @0x801011AC : advance to the next combination of phrase picks (odometer over choices).
 * MATCH: `limit` = choice[3]+choice[2] of the CURRENT record (not a fixed DAT_ address -- earlier
 * recon mis-materialized this as a snapshot; the oracle reads it relative to the runtime `choice`
 * pointer both initially and after each odometer carry).  Returns 1 only when every phrase has been
 * exhausted (Ghidra void-bug -- real int return, read at the epilogue: $v0 = the "ran out" flag). */
extern "C" int iSPCH_IterateChoice(int sentence)
{
    int exhausted = 0;
    int n = VoxSentence_GetNumPhrases(sentence) - 1;
    short *choice = ispch_gChoice + n * 6;
    int limit = (int)choice[2] + (int)choice[3];
    int loopDone = exhausted;
    do {
        unsigned int cur = (unsigned int)(unsigned short)choice[4] + 1;
        choice[4] = (short)cur;
        if ((int)(short)cur < limit) {
            loopDone = 1;
        } else {
            n = n - 1;
            choice[4] = choice[3];
            choice = choice - 6;
            if (n < 0) {
                loopDone  = 1;
                exhausted = 1;
            }
            limit = (int)choice[2] + (int)choice[3];   /* choice[-3]/[-4] relative to old ptr */
        }
    } while (!loopDone);
    return exhausted;
}

/* iSPCH_ChooseShortSentence @0x8010125C : pick a short sentence variant that fits the filter length. */
extern "C" int iSPCH_ChooseShortSentence(int sentence)
{
    int done = 0;
    int n = VoxSentence_GetNumPhrases(sentence);
    int i = 0;
    int found = 0;
    if (0 < n) {
        short *choice = ispch_gChoice;
        do {
            choice[4] = choice[3];
            i = i + 1;
            choice = choice + 6;
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

/* iSPCH_SentenceMakeChoice @0x80101310 : finalise the per-phrase pick (random or short-fit). */
extern "C" int iSPCH_SentenceMakeChoice(int sentence, int mode)
{
    int ok = 0;
    if (mode == 1) {
        iSPCH_RandomizeSentencePicks(sentence);
        ok = iSPCH_ChooseShortSentence(sentence);
    } else {
        int n = VoxSentence_GetNumPhrases(sentence);
        int i = 0;
        if (ok < n) {
            short *choice = ispch_gChoice;
            ok = 1;
            do {   /* residual 9: gcc biv-eliminates `choice` into a +8-biased giv (2-insn init,
                    * offsets -4/-2/0) where the oracle keeps the plain base (+4/+6/+8); index-form,
                    * alias, and statement-order levers all leave the bias -- allocator floor */
                int r = iSPCH_Rand((int)choice[2]);
                i = i + 1;
                choice[4] = choice[3] + (short)r;
                choice = choice + 6;
            } while (i < n);
        }
    }
    return ok;
}

/* iSPCH_ConstantRuleSet @0x801013BC : fire gSentenceRuleSet for each phrase's constant (type != 0xf) rules. */
extern "C" void iSPCH_ConstantRuleSet(short *sentence, int rule, int val)
{
    (void)val;
    if (gSentenceRuleSet != 0) {
        int n = VoxSentence_GetNumPhrases(rule);
        int table = 0;
        if (0 < n) {
            short *choice = ispch_gChoice;
            do {
                int ruleEntry = iSPCH_GetOffset8(rule, rule + 4, table);
                int p = ruleEntry;
                int j = 0;
                do {
                    unsigned int ruleType = (unsigned int)(*(unsigned char *)(p + 4) >> 4);
                    if (ruleType != 0xf) {
                        unsigned int rid = iSPCH_GetRuleID((int)sentence, (int)ruleType);
                        int tmp[4];   /* MATCH: was int[3] (too small -- oracle's frame reserves the
                                       * full 16 bytes and reads byte [0xc+j], i.e. tmp[3]'s bytes,
                                       * the same "cycle byte array" field iSPCH_MatchSample reads at
                                       * sample+i+0xc). */
                        int r = iSPCH_UnPackSample(*(int *)(*choice * 4 + gVoxBanks[0]),
                                                   (unsigned int)PICK(choice[4]), tmp);
                        if (r != 0)
                            ((void (*)(int, int, int))gSentenceRuleSet)
                                ((int)(unsigned int)*(unsigned short *)sentence, (int)rid,
                                 1 << ((unsigned char *)tmp)[0xc + j]);
                    }
                    j = j + 1;
                    p = ruleEntry + j;
                } while (j < 4);
                table = table + 1;
                choice = choice + 6;
            } while (table < n);
        }
    }
}

/* iSPCH_MakeSampleRequests @0x80101508 : issue gSampleRequest for each chosen sample; returns total time. */
extern "C" int iSPCH_MakeSampleRequests(int sentence, int paramTable)
{
    int samples = 0;
    int n = VoxSentence_GetNumPhrases(sentence);
    int i = 0;
    if (0 < n) {
        short *choice = ispch_gChoice;
        do {
            int           bank = *(int *)(*choice * 4 + gVoxBanks[0]);
            unsigned char idx  = PICK(choice[4]);
            int           tmp[4];
            /* MATCH: the ClearCycleBit call is gated on BOTH bank[2]&0xf0 AND the separate global
             * gClearCycle != 0 -- the earlier recon only had the bank-flags half of the gate. */
            if ((*(unsigned char *)(bank + 2) & 0xf0) != 0 && gClearCycle != 0)
                iSPCH_ClearCycleBit(bank, idx);
            if (iSPCH_UnPackSample(bank, idx, tmp) != 0) {
                int spuAddr = tmp[1];
                if (choice[1] != -1)
                    spuAddr = tmp[1] + (int)choice[1] *
                              ((int)(unsigned int)*(unsigned short *)(bank + 4) << 8);
                samples = samples + tmp[0];
                ((void (*)(int, int, int, int))gSampleRequest)
                    ((int)*choice, spuAddr, tmp[0], paramTable);
            }
            i = i + 1;
            choice = choice + 6;
        } while (i < n);
    }
    return iSPCH_ConvertTime(samples);
}

/* iSPCH_ClearChosen @0x80101650 : mark "nothing chosen". */
extern "C" void iSPCH_ClearChosen(void)
{
    DAT_80148448[0] = 0;
}

/* iSPCH_SaveChosenSentence @0x8010165C : record the chosen sentence + its 12 eventArgs.  Returns 1. */
extern "C" int iSPCH_SaveChosenSentence(int sentence, int paramTable, int ruleCtx, int *eventArgs)
{
    /* gSentenceChoice[0..2] = DAT_8014843C/40/44 (one contiguous block); [4..15] = the 12 eventArgs.
     * The original reaches all three head fields + the loop off a single shared base. */
    int  i = 0;
    int *p;
    gSentenceChoice[0] = sentence;      /* DAT_8014843C (via %hi reg) */
    gSentenceChoice[1] = paramTable;    /* DAT_80148440 */
    gSentenceChoice[2] = ruleCtx;       /* DAT_80148444 */
    p = gSentenceChoice;
    do {
        p[4] = *eventArgs;
        eventArgs = eventArgs + 1;
        i = i + 1;
        p = p + 1;
    } while (i < 0xc);
    DAT_80148448[0] = 1;
    return 1;
}

/* iSPCH_OneChosen @0x801016A4 : the "one chosen" flag. */
extern "C" int iSPCH_OneChosen(void)
{
    return DAT_80148448[0];
}

/* iSPCH_PlayChosen @0x801016B4 : apply rules and issue the sample requests for the chosen sentence. */
extern "C" void iSPCH_PlayChosen(void)
{
    if (iSPCH_OneChosen() != 0) {
        /* MATCH: gSentenceChoice[1/2/4] read relative to the base gcc already materializes for
         * gSentenceChoice[0] -- NOT via the aliasing DAT_80148440/44/4c symbols (their own %hi/%lo
         * would re-materialize the same address twice).  eventId = gSentenceChoice[4] is loaded
         * ONCE here (oracle: `lw s2,0x10(s1)` right before the RuleSet call) and kept alive in a
         * persistent register across both rule-set calls, reused for MakeSampleRequests' 2nd arg
         * and both compares below -- the earlier recon re-indexed gSentenceChoice[4] fresh at each
         * use.  Also: iSPCH_ConstantRuleSet's call site sets up NO 3rd argument at all (oracle has
         * a bare `nop` in the jal's delay slot, a2 untouched) -- `val` is genuinely dead in the
         * callee (already `(void)val`) AND the caller never materializes it; cast the call through
         * a 2-arg fn-ptr type so the compiler doesn't force an a2 setup here (§D dropped-arg lever). */
        int eventId = gSentenceChoice[4];
        iSPCH_RuleSet((short *)gSentenceChoice[0], gSentenceChoice[2], (int)&gSentenceChoice[4]);
        ((void (*)(short *, int))iSPCH_ConstantRuleSet)((short *)gSentenceChoice[0], gSentenceChoice[1]);
        iSPCH_MakeSampleRequests(gSentenceChoice[1], eventId);
        {
            int newRepeatCount;   /* MATCH: gVoxInGame[1] == gRepeatCount; a SHARED store after the
                                    * if/else (not one store per branch) is what tail-merges into the
                                    * oracle's single `sw v0,4(a0)` at the branches' join point. */
            if (eventId == gVoxInGame[0]) {
                newRepeatCount = gVoxInGame[1] + 1;
            } else {
                gVoxInGame[0] = eventId;
                newRepeatCount = 1;
            }
            gVoxInGame[1] = newRepeatCount;
        }
    }
    iSPCH_ClearChosen();
}

/* iSPCH_ChooseSentence @0x80101754 : top-level -- for the event in `eventArgs`, find a sentence template that
 *   passes its rules, choose samples for it, and save the result.  Returns the chosen-sentence index or -1. */
extern "C" int iSPCH_ChooseSentence(unsigned int *eventArgs)
{
    unsigned char local_order[104];
    char          local_30 = 0;
    int           idx = 0;
    int           event = iSPCH_FindEvent(*eventArgs);
    int           result = 0;
    if (event != 0) {
        if (iSPCH_RepeatEvent((unsigned short *)event) != 0) {
            unsigned int filterMode, filterFlag;
            iSPCH_ClearChosen();
            filterFlag = 1;
            filterMode = (unsigned int)gFilterSetting;
            if (DAT_80148064 == 1) {
                filterMode = (unsigned int)(gFilterSetting + 1);
                filterFlag = (unsigned int)((int)filterMode < 3);
                if (filterFlag == 0)
                    filterMode = 2;
            }
            {
                unsigned int useLen = (unsigned int)VoxEvent_GetFilterLengthFlag(event);
                /* @0x801017F4-808: gate is (useLen & 0xFF) != 0 && filterMode == 1 -- $v0 tested at
                 * 0x801017F8 is the VoxEvent_GetFilterLengthFlag return (&0xFF), NOT filterFlag. The
                 * recon gated on filterFlag (a distinct var from the DAT_80148064 branch) (M09). */
                if ((useLen & 0xff) != 0 && filterMode == 1)
                    filterMode = 0;
                iSPCH_GetRuleSettings((short *)event, (int *)eventArgs, &local_30);
                iSPCH_OrderSentences(event, (int)local_order);
                {
                    unsigned int n = (unsigned int)*(unsigned char *)(event + 6);
                    result = -1;
                    if (0 < (int)n) {
                        result = 0;
                        do {
                            int table;   /* MATCH: read UNSIGNED (oracle: lbu) -- local_order[] holds
                                          * 0..n-1 always, so `table < 0` below is dead/vestigial code
                                          * (never true at runtime) but the oracle still emits the bltz
                                          * guard for it (a `(signed char)` cast would wrongly emit `lb`
                                          * here; this compiler only emits `lb` for an EXPLICIT signed
                                          * cast, never implicitly -- see reference_asm_pattern_catalog
                                          * §C "char IS UNSIGNED on this build"). */
                            int          sentence;
                            int          r;
                            if ((int)n <= idx)
                                return result;
                            table = (int)local_order[idx];
                            if (table < 0)
                                return result;
                            if ((int)n <= table)
                                return result;
                            sentence = iSPCH_GetOffset16(event, event + 0xc, (int)table);
                            r = iSPCH_SentenceGetChoices(sentence, (int)eventArgs, useLen & 0xff,
                                                         (unsigned int)(unsigned char)local_30, (int)filterMode);
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
    return result;
}

/* SPCH_SetPreLoadTicks @0x801018F4 : set the speech pre-load tick offset. */
extern "C" void SPCH_SetPreLoadTicks(int ticks)
{
    gPreLoadTicks[0] = ticks;
}

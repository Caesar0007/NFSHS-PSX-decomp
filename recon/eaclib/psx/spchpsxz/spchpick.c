/* eaclib/psx/spchpsxz/spchpick.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 18/27 PASS ***
 *   Full detailed survey: remaining FAILs are iSPCH_OrderSentences(64,85/83),
 *   iSPCH_ChooseSentence(58,104/104), iSPCH_SentenceGetChoices(54,84/80),
 *   iSPCH_MakeSampleRequests(49,85/82), iSPCH_IterateChoice(43,45/44),
 *   iSPCH_MatchSample(28,67/65), iSPCH_SampleLength(14,26/26),
 *   iSPCH_ConstantRuleSet(10,83/83), and iSPCH_SentenceMakeChoice(7,44/43).
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

extern short          ispch_gChoice[];     /* short[6]/phrase choice records */
extern unsigned char  ispch_gPickSamples[]; /* chosen sample-index pool; MATCH: unsized-array -> separate-temp addr load */
extern int            gSentenceChoice[];   /* @0x8014843C saved chosen sentence ptr; [0..2]=choice/40/44 (== old
                                                 * DAT_80148440/44), [4..15]=eventArgs (== old DAT_8014844c) --
                                                 * read via gSentenceChoice[N] everywhere so it shares gSentenceChoice[0]'s
                                                 * already-materialized base, matching the oracle (see PlayChosen). */
extern int            DAT_80148448[];      /* "one chosen" flag */

extern int  gVoxBanks[];      /* spchbank (array decl -> separate-temp loads) */
extern int  gDataRate[];      /* spchinit */
typedef void (*SampleRequestFn)(int, int, int, int);
extern SampleRequestFn gSampleRequest[]; /* spchinit (callback) */
typedef void (*SentenceRuleSetFn)(int, int, int);
extern SentenceRuleSetFn gSentenceRuleSet; /* spchinit (callback) */
extern int  gVoxInGame[];     /* spchinit; [1] aliases gRepeatCount@+4 */
extern int  gRepeatCount;     /* spchinit (== gVoxInGame[1]) */
extern int  gFilterSetting;   /* spchevnt-shared */
extern int  DAT_80148064;     /* spchevnt "kept 'd' event" flag */
extern int  gPreLoadTicks[];  /* spchevnt-shared */
extern int  gClearCycle[];    /* @0x801370BC "cycle-bit clearing enabled" flag (init val 1);
                                    * UNSIZED ARRAY (not a scalar): a scalar extern compiles to the
                                    * single ASSEMBLER MACRO `lw $2,gClearCycle`, which is INELIGIBLE
                                    * for a branch delay slot (.set nomacro), so gcc's dbr pass skips
                                    * it and steals the next insn instead; the array form makes cc1
                                    * emit the real `lui %hi` + `lw %lo` pair and the `lui` becomes
                                    * the delay-slot filler exactly as retail (see MakeSampleRequests).
                                    * data-materialized right next to gNumBanks in the spchbank data
                                    * block but not yet given a home TU -- HEADER WISH: belongs in
                                    * spchbank.c or spchinit.c alongside its neighbors, out of this
                                    * file's scope. */

extern int  iSPCH_GetMatchValue(int base, int index);                 /* spchdata */
extern int  VoxSentence_GetNumPhrases(int sentence);                  /* spchdata */
extern int  VoxSentence_GetShortRule(int sentence);                   /* spchdata */
extern int  iSPCH_GetOffset8(int base, int tableBase, int index);     /* spchdata */
extern int  iSPCH_GetOffset16(int base, int tableBase, int index);    /* spchdata */
extern int  VoxEvent_GetFilterLengthFlag(int e);                      /* spchdata */
extern int  iSPCH_FindBank(int key);                                  /* spchbank (returns bank index) */
extern unsigned int iSPCH_TestSubBankBounds(int bankIdx, int subIdx); /* spchbank */
extern int  iSPCH_UnPackSample(int bank, int sampleIdx, int *out); /* spchsamp */
extern int  iSPCH_Rand(int n);                                        /* spchrand */
extern unsigned int iSPCH_GetRuleID(int sentence, int index);         /* spchrule */
extern void iSPCH_RuleSet(short *sentence, int rule, int *values);    /* spchrule */
extern unsigned int iSPCH_CheckSentenceRules(int a, int b, int c);    /* spchrule */
extern unsigned char iSPCH_GetRuleSettings(short *sentence, int *values, char *out); /* spchrule */
extern int  iSPCH_FindEvent(unsigned int eventID);                    /* spchevnt */
extern int  GetFilterLength(void);                                    /* spchevnt */
extern void trap(unsigned int code);

extern int  iSPCH_MatchSample(int bankIdx, int sample, int phraseTemplate, int paramTable); /* @0x8010077C : bankIdx UNUSED */
extern unsigned int iSPCH_GetPhraseBank(short *phraseTemplate, int paramTable, short *outChoice); /* @0x80100880 */
extern int  iSPCH_GetBankBits(int bank);                              /* @0x80100994 */
extern unsigned char *iSPCH_ClearCycleBit(int bank, int cycle);      /* @0x801009B8 */
extern unsigned int iSPCH_CheckBankBit(int bank, int cycle);         /* @0x80100A1C */
extern unsigned int iSPCH_CheckTemplateSample(int choice, int bank, int base); /* @0x80100A70 */
extern unsigned int iSPCH_SampleExists(int choice, int bankPtr, int bank); /* @0x80100AC0 */
extern int  iSPCH_ChooseSamples(short *choice, int maxToPick, int phraseTemplate, int unused); /* @0x80100B4C */
extern int  iSPCH_SampleLength(short *choice);                        /* @0x80100C5C */
extern int  iSPCH_ConvertTime(int samples);                          /* @0x80100CC4 */
extern int  iSPCH_SentenceLength(int sentence);                      /* @0x80100D20 */
extern void iSPCH_OrderSentences(int event, int outOrder); /* @0x80100D94 */
extern unsigned int iSPCH_RepeatEvent(unsigned short *eventArgs);    /* @0x80100EE0 */
extern int  iSPCH_ShortRuleStatus(int sentence, int mode);           /* @0x80100F24 */
extern int  iSPCH_SentenceGetChoices(int sentence, int paramTable, unsigned int ruleByte1, unsigned int ruleByte2, int filterMode); /* @0x80100F8C */
extern void iSPCH_RandomizeSentencePicks(int sentence);             /* @0x801010CC */
extern int  iSPCH_IterateChoice(int sentence);                      /* @0x801011AC : returns 1 if the odometer is exhausted (Ghidra void-bug: real return, read at epilogue) */
extern int  iSPCH_ChooseShortSentence(int sentence);               /* @0x8010125C */
extern int  iSPCH_SentenceMakeChoice(int sentence, int mode);      /* @0x80101310 */
extern void iSPCH_ConstantRuleSet(short *sentence, int rule); /* @0x801013BC */
extern int  iSPCH_MakeSampleRequests(int sentence, int paramTable); /* @0x80101508 */
extern void iSPCH_ClearChosen(void);                               /* @0x80101650 */
extern int  iSPCH_SaveChosenSentence(int sentence, int paramTable, int ruleCtx, int *eventArgs); /* @0x8010165C */
extern int  iSPCH_OneChosen(void);                                 /* @0x801016A4 */
extern void iSPCH_PlayChosen(void);                                /* @0x801016B4 */
extern int  iSPCH_ChooseSentence(unsigned int *eventArgs);         /* @0x80101754 */
extern void SPCH_SetPreLoadTicks(int ticks);                       /* @0x801018F4 */

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
/* MATCH (w32-a9, 28 -> 22 diffs): the IDA register annotation for sub_8010077C names retail's
 * locals and exposes a SIXTH one our recon had inlined: `v10 // $v0` = a plain int cursor
 * initialised to `sample + i` and RE-COMPUTED at the BOTTOM of the loop (`v10 = a2 + v9`), with
 * the cycle byte read as `*(v10 + 12)`.  Spelling that cursor out (instead of addressing
 * `sample + i + 0xc` at the top) lands sample/phraseTemplate/paramTable in retail's s6/s5/s7 and
 * fixes the whole address-forming block.  Retail's other four are {lowNib:s0, i:s1, bit:s2,
 * result:s3, count:s4}.
 * RESIDUAL 22 (67/65) = ours' loop pass still hoists the shift constant `1` of `bit = 1u <<
 * cycleByte` into a NINTH callee-saved register ($s7 here), which pushes paramTable into $fp and
 * adds the fp save/restore pair (the 2-insn gap); retail rematerializes `li v1,1` per iteration
 * and gets by on s0-s7.  Same move_movables class as iSPCH_SentenceGetChoices' `li -2`, but here
 * there is no compare to fold the constant into.  Levers tried and rejected: a label+goto loop
 * DOES kill the hoist and reach exact 65/65 parity, but re-rotates the five block locals (40-42
 * diffs, worse); `(matchVal >> cycleByte) & 1` avoids the constant but switches cc1 to a
 * srlv/andi bit test the oracle does not use; a named `one` local and re-assignment per
 * iteration are still recognised as invariant. */
extern int iSPCH_MatchSample(int bankIdx, int sample, int phraseTemplate, int paramTable)
{
    /* w31-a4 NOTE (kept at baseline per strict-drop seal law; findings for a future wave):
     * a GOTO-loop body (label `loop:` + `if (i<count) goto loop;` instead of do-while) reaches
     * EXACT insn parity 65/65 -- it stops gcc's loop pass from hoisting the shift constant `1`
     * out of the loop (`li s6,1` + a 9th saved reg fp in the do-while form; the oracle
     * rematerializes `li v1,1` per iteration) and lands sample->s6/template->s5/paramTable->s7
     * exactly.  The residual is then a pure 5-local allocno rotation: ours
     * {i:s0,result:s1,lowNib:s2,count:s3,bit:s4} vs oracle {lowNib:s0,i:s1,bit:s2,result:s3,
     * count:s4}.  cc1 -dl data: i 7refs/27len(.52) > result 6/31(.39) > lowNib 3/8(.375) >
     * count 4/32(.25) >= bit 3/12(.25) reproduces ours exactly (priority ~ floor_log2(refs)*
     * refs/len); the oracle order needs lowNib ~4refs and bit len ~7 -- no faithful source
     * shape found that moves those counts (bit two-stmt split self-shifts s0,s0 vs oracle's
     * li v1,1;sllv s2,v1,a0 temp split; lowNib &=-split would self-andi s0,s0 vs oracle
     * andi s0,v0).  Diff counts: goto form 42, baseline 28 (alignment luck) -> reverted. */
    int count = (int)*(signed char *)(phraseTemplate + 3);
    int result = 1;
    (void)bankIdx;
    if (count < 5)
        goto valid_count;
    result = 0;
    goto done;
valid_count:
    if (0 < count) {
        int i = 0;
        int p = sample + i;
        do {
            unsigned int cycleByte = *(unsigned char *)(p + 0xc);
            result = 0;
            if (0x1f < cycleByte)
                goto done;
            {
                unsigned int bit    = 1u << (cycleByte);
                int          lowNib = (int)*(unsigned char *)(phraseTemplate + i + 4) & 0xf;
                if ((bit & (unsigned int)iSPCH_GetMatchValue(phraseTemplate, i)) != 0 &&
                    (lowNib == 0 ||
                     (bit & (unsigned int)*(int *)(lowNib * 4 + paramTable)) != 0))
                    result = 1;
            }
            i = i + 1;
            if (result == 0)
                goto done;
            p = sample + i;
        } while (i < count);
    }
done:
    return result;
}

/* iSPCH_GetPhraseBank @0x80100880 : resolve a phrase template's bank choice (fixed / by-param / sub-bank)
 *   into outChoice[0..1].  Returns 0 on success, nonzero (sign of ~choice) on failure. */
extern unsigned int iSPCH_GetPhraseBank(short *phraseTemplate, int paramTable, short *outChoice)
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
extern int iSPCH_GetBankBits(int bank)
{
    int stride = ((int)*(unsigned char *)(bank + 2) & 0xf) + 2;
    int nSamp  = (int)(unsigned int)*(unsigned char *)(bank + 3);
    bank += 8;
    return bank + nSamp * stride;
}

/* iSPCH_ClearCycleBit @0x801009B8 : clear cycle bit `cycle` in `bank`'s bits array; returns the byte ptr. */
extern unsigned char *iSPCH_ClearCycleBit(int bank, int cycle)
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
extern unsigned int iSPCH_CheckBankBit(int bank, int cycle)
{
    int byteIdx = cycle / 8;   /* MATCH: plain signed /8 -> gcc's bgez/+7/sra COPY form (cycle stays $a1) */
    unsigned int bit = 1 << (cycle - (byteIdx << 3));
    unsigned char *bits = (unsigned char *)iSPCH_GetBankBits(bank);
    return (unsigned int)*(unsigned char *)(bits + byteIdx) & bit;
}

/* iSPCH_CheckTemplateSample @0x80100A70 : whether choice's template sample bit is set for this bank. */
extern unsigned int iSPCH_CheckTemplateSample(int choice, int bank, int base)
{
    unsigned int result = 0;
    if ((int)(unsigned int)*(unsigned short *)(bank + 6) > (int)*(short *)(choice + 2))
        result = iSPCH_CheckBankBit(bank, base + (int)(unsigned int)*(unsigned char *)(bank + 3) *
                                                   (int)*(short *)(choice + 2));
    return result;
}

/* iSPCH_SampleExists @0x80100AC0 : whether sample `bank` of `choice` is present (template + cycle checks). */
extern unsigned int iSPCH_SampleExists(int choice, int bankPtr, int bank)
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
extern int iSPCH_ChooseSamples(short *choice, int maxToPick, volatile int phraseTemplate, volatile int unused)
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
            int r;
            r = iSPCH_UnPackSample(bank, sampleIdx, tmp);
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
extern int iSPCH_SampleLength(short *choice)
{
    int bank;
    int r;
    int tmp[4];
    /* residual 14: ours colors the pick-byte chain base->a1/idx->v0 (la lands in the lbu-arg reg),
     * oracle idx->a1/base->v0; fresh-sum/inline/anonymous-chain reshapes all score worse (14/16/22) */
    int len = 0;
    unsigned char *pickAddr = ispch_gPickSamples;
    int voxBase = gVoxBanks[0];
    pickAddr = pickAddr + choice[4];
    bank = *(int *)(*choice * 4 + voxBase);
    r = iSPCH_UnPackSample(bank, (unsigned int)*pickAddr, tmp);
    if (r != 0)
        len = tmp[0];
    return len;
}

/* iSPCH_ConvertTime @0x80100CC4 : convert a sample count to a time at the current data rate. */
extern int iSPCH_ConvertTime(int samples)
{
    int t = 0;
    if (gDataRate[0] != 0) {
        t = (samples * 100) / gDataRate[0];
    }
    return t;
}

/* iSPCH_SentenceLength @0x80100D20 : total time of all phrases' current picks for `sentence`. */
extern int iSPCH_SentenceLength(int sentence)
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
extern void iSPCH_OrderSentences(int event, int outOrder)
{
    /* MATCH + CORRECTNESS (w31-a4): (1) VOID -- the oracle epilogue never sets $v0 and the sole
     * caller (ChooseSentence) ignores it; the old `unsigned char *last` return chain was invented
     * (+2 insns, phantom stores).  (2) REAL BUG FIXED: phase 3 (append zero-weight entries) must
     * CONTINUE `i` -- the oracle keeps appending at outOrder+s1 after the weighted picks; the old
     * recon reset i=0 and overwrote the ordered list.  (3) weights[j] accessed directly (oracle
     * recomputes the weights+j address per use; no pointer temp).  (4) one function-scope j reused
     * as the PHASE-1 counter, phase-2 scan index and phase-3 loop counter (oracle reuses s0 for
     * all three; `i` is born at phase 2).  (5) phase-2 scan = while(j<n){...break;...} -- do-while
     * and for(;;) shapes get header-peeled (+4).
     * residual 12 (85/83): (a) phase-1 `p` coalesces with $v0 (oracle copies it to a0, addu
     * a0,v0,zero, because its sb-address temp takes v0) -- ours-1-shorter receiver-reuse class;
     * (b) the scan while-rotation guard slt/beqz survives (oracle enters the loop straight off
     * the n!=0 test; unprovable j<n for signed compare, and unsigned-compare or do-while forms
     * diverge more).  Permuter targets.  w32-a9 re-tested (b): do-while 48 diffs/87 insns (loop.c
     * PEELS the first iteration, +4) and a label+goto scan 50/81 -- both far worse than the
     * `while` guard; the guard stands. */
    unsigned char  weights[104];
    unsigned int   n = (unsigned int)*(unsigned char *)(event + 6);
    int            total = 0;
    int            j = 0;
    int            i;
    if (n != 0) {
        do {
            unsigned char *p;
            p = (unsigned char *)iSPCH_GetOffset16(event, event + 0xc, j);
            weights[j] = *p;
            j = j + 1;
            total = total + (int)(unsigned int)*p;
        } while (j < (int)n);
    }
    i = 0;
    if (0 < total) {
        do {
            int r = iSPCH_Rand(total);
            j = 0;
            if (n != 0) {
                while (j < (int)n) {
                    r = r - (int)(unsigned int)weights[j];
                    if (r < 0)
                        break;
                    j = j + 1;
                }
            }
            *(char *)(outOrder + i) = (char)j;
            i = i + 1;
            total = total - (int)(unsigned int)weights[j];
            weights[j] = 0;
        } while (0 < total);
    }
    j = 0;
    if (n != 0) {
        do {
            char *p;
            p = (char *)iSPCH_GetOffset16(event, event + 0xc, j);
            if (*p == '\0') {
                *(char *)(outOrder + i) = (char)j;
                i = i + 1;
            }
            j = j + 1;
        } while (j < (int)n);
    }
}

/* iSPCH_RepeatEvent @0x80100EE0 : whether this in-game event may repeat (under its repeat limit). */
extern unsigned int iSPCH_RepeatEvent(unsigned short *eventArgs)
{
    unsigned int result = 1;
    if ((unsigned int)*eventArgs == (unsigned int)gVoxInGame[0] && 0 < (signed char)eventArgs[4])
        result = (unsigned int)(gVoxInGame[1] < (signed char)eventArgs[4]);   /* [1] == gRepeatCount */
    return result;
}

/* iSPCH_ShortRuleStatus @0x80100F24 : evaluate a sentence's short-rule against `mode`. */
extern int iSPCH_ShortRuleStatus(int sentence, int mode)
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
extern int iSPCH_SentenceGetChoices(int sentence, int paramTable, unsigned int ruleByte1,
                                        unsigned int ruleByte2, int filterMode)
{
    /* MATCH (w31-a4, 54->?): single result funnel (`fail:` block laid between the rule checks and
     * the loop, exactly the oracle's .L80101008) instead of separate return 0/-1 statements; the
     * -1 path stores THE RESULT VAR (`*outChoice = result`, oracle sh s4); outChoice recomputed
     * from `table` per iteration (CHOICE(table)) so loop.c reduces every access onto ONE +0-based
     * walker (pointer-walk form fabricated an &outChoice[2] anchor giv, +2 insns); result/picked
     * initialized before the GetNumPhrases call. */
    int picked = 0;
    int result = 1;
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
                short *outChoice = CHOICE(table);
                int    r;
                short *phraseTemplate;
                outChoice[3] = (short)picked;
                phraseTemplate = (short *)iSPCH_GetOffset8(sentence, sentence + 4, table);
                if (iSPCH_GetPhraseBank(phraseTemplate, paramTable, outChoice) == 0) {
                    /* MATCH (w32-a9, 17 -> 11 diffs, 83 -> 81 insns): the fail test is written
                     * `*outChoice + 2 != 0` rather than `*outChoice != -2`.  Retail's compare IS
                     * `lh v1; li v0,-2; bne v1,v0` (the li also filling the lh load-delay slot),
                     * but as a plain loop-invariant constant our cc1's move_movables hoists that
                     * `li -2` into a NINTH callee-saved register ($fp): +li, +fp save/restore, and
                     * a knock-on reschedule of the `li s4,1` result init (retail gets by on s0-s7).
                     * `(int)` casts, Yoda order and a named load temp all leave the motion in
                     * place; folding the constant into the compare removes the movable entirely.
                     * RESIDUAL 11 = one `nop` where retail's in-block `li v0,-2` fills the lh
                     * delay, plus the `li s4,1` placement that follows from it. */
                    if (*outChoice + 2 != 0) {
                        result = 0;
                        goto out;
                    }
                    result = -1;
                    *outChoice = (short)result;
                    goto out;
                }
                r = iSPCH_ChooseSamples(outChoice, 100 - picked, (int)phraseTemplate, paramTable);
                picked = picked + r;
                if (r == 0)
                    goto fail;
                outChoice[2] = (short)r;
                table = table + 1;
            } while (table < n);
        }
    }
out:
    return result;
}

/* iSPCH_RandomizeSentencePicks @0x801010CC : shuffle the chosen samples of each phrase of `sentence`. */
extern void iSPCH_RandomizeSentencePicks(int sentence)
{
    int n = VoxSentence_GetNumPhrases(sentence);
    int i = 0;
    if (0 < n) {
        do {
            short *choice = ispch_gChoice + i * 6;
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
 *   (2) limit built from NAMED temps `count = choice[2]; pbase = choice[3]; limit = pbase + count;`
 *       (loads in decl order +4,+6; addu operands [3]+[2] with dst = count's reg -- a single
 *       expression in either order gives the wrong load order or wrong addu operand order).
 *   (3) `exhausted = loopDone;` (not = 1) reproduces `addu s0,a2,zero` reusing the li 1.
 * RESIDUAL 4 diffs = position of the ispch_gChoice lui/addiu pair: retail materializes the base
 *   BEFORE the n*6 sll/addu/sll chain, our cc1 expands sym+mult canonically mult-first (verified
 *   invariant across ptr-arith / &arr[i] / 2D-row / int-cast / split-stmt forms and with
 *   -fno-schedule-insns; split-stmt forms flip la first but then mis-coalesce the addu dst with
 *   the base instead of the mult chain, 10-12 diffs).  Pure emission-order tie -- permuter target.
 * Returns 1 only when every phrase has been exhausted (Ghidra void-bug -- real int return, read
 * at the epilogue: $v0 = the "ran out" flag). */
extern int iSPCH_IterateChoice(int sentence)
{
    int exhausted = 0;
    int n = VoxSentence_GetNumPhrases(sentence) - 1;
    int count, pbase, limit, loopDone, cur;
    short *choice = ((short (*)[6])ispch_gChoice)[n];
    count = choice[2];
    pbase = choice[3];
    limit = pbase + count;
    loopDone = exhausted;
top:
    cur = (unsigned short)choice[4] + 1;
    choice[4] = cur;
    if ((short)cur < limit) {
        loopDone = 1;
    } else {
        choice[4] = choice[3];
        n = n - 1;
        choice = choice - 6;
        if (n < 0) {
            loopDone  = 1;
            exhausted = loopDone;
        }
        count = choice[2];
        pbase = choice[3];
        limit = pbase + count;
    }
    if (!loopDone) goto top;
    return exhausted;
}

/* iSPCH_ChooseShortSentence @0x8010125C : pick a short sentence variant that fits the filter length. */
extern int iSPCH_ChooseShortSentence(int sentence)
{
    int done = 0;
    int n = VoxSentence_GetNumPhrases(sentence);
    int i = 0;
    int found = 0;
    if (0 < n) {
        do {
            short *choice = ispch_gChoice + i * 6;
            choice[4] = choice[3];
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

/* iSPCH_SentenceMakeChoice @0x80101310 : finalise the per-phrase pick (random or short-fit). */
extern int iSPCH_SentenceMakeChoice(int sentence, int mode)
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
            sentence = (int)ispch_gChoice + i * 0xc;
            /* residual 7 (44/43): genuine base-anchor FLOOR (catalog §3.12-style) -- ours
             * folds the store's +8 field offset into the persistent record pointer once at
             * loop entry (extra `addiu s0,s0,8`, reads become -4/-2), oracle keeps the
             * pointer at the record base and uses bare +4/+6/+8 displacements throughout.
             * Tried: named-field temp for the +6 read, short*-indexed CHOICE-style rewrite
             * (both score EQUAL or WORSE, 7/9), statement-order swap of i++ (no change).
             * gcc CSE-vs-strength-reduction granularity; accept, do not chase further with
             * magic-offset pointer math. */
            do {
                int r = iSPCH_Rand((int)*(short *)(sentence + 4));
                i = i + 1;
                *(short *)(sentence + 8) = *(unsigned short *)(sentence + 6) + (short)r;
                sentence = sentence + 0xc;
            } while (i < n);
        }
    }
    return ok;
}

/* iSPCH_ConstantRuleSet @0x801013BC : fire gSentenceRuleSet for each phrase's constant (type != 0xf) rules.
 * ARITY (w32-a10 prototype audit, R3): TWO args, not three.  The sole call site (iSPCH_PlayChosen
 * @0x801016F4) sets a0/a1 only and leaves a bare `nop` in the jal delay slot; the callee never reads an
 * incoming $a2.  The old 3rd param `val` was a decompiler phantom kept alive by a `(void)val;` plus a
 * 2-arg fn-ptr cast at the call site -- both removed.  Diff-neutral (10 before and after), PlayChosen
 * still PASS. */
extern void iSPCH_ConstantRuleSet(short *sentence, int rule)
{
    if (gSentenceRuleSet != 0) {
        int n = VoxSentence_GetNumPhrases(rule);
        int table = 0;
        if (0 < n) {
            unsigned char *pickBase = ispch_gPickSamples;
            short *choice = ispch_gChoice;
            do {
                int j;
                int ruleEntry;
                ruleEntry = iSPCH_GetOffset8(rule, rule + 4, table);
                j = 0;
                do {
                    unsigned int ruleType =
                        (unsigned int)(*(unsigned char *)(ruleEntry + j + 4) >> 4);
                    if (ruleType != 0xf) {
                        int tmp[4];
                        int r;
                        unsigned int rid;
                        rid = iSPCH_GetRuleID((int)sentence, (int)ruleType);
   /* MATCH: was int[3] (too small -- oracle's frame reserves the
                                       * full 16 bytes and reads byte [0xc+j], i.e. tmp[3]'s bytes,
                                       * the same "cycle byte array" field iSPCH_MatchSample reads at
                                       * sample+i+0xc). */
                        r = iSPCH_UnPackSample(*(int *)(*choice * 4 + gVoxBanks[0]),
                                                   (unsigned int)*(unsigned char *)
                                                       ((int)choice[4] + (int)pickBase), tmp);
                        /* residual 10 (83/83, exact insn parity): register-pair coloring wall.
                         * ours colors tmp-byte-addr->v0 then reuses v0 for the reloaded
                         * gSentenceRuleSet callee address, shift-constant 1->v1; oracle colors
                         * tmp-byte-addr->v1 (leaving v0 free to materialize the callee address
                         * EARLY) and shift-constant 1->a3. Tried: named locals for the shift
                         * value, the callee fn ptr, and the byte address (each alone and
                         * combined), decl-order swap of tmp/r/rid -- all no-change or worse
                         * (16/29). No ABI anchor differs (call uses a0/a1/a2 only, a3 free in
                         * both); pure gcc CSE/coloring granularity -- accept. */
                        if (r != 0)
                            gSentenceRuleSet(
                                (int)(unsigned int)*(unsigned short *)sentence, (int)rid,
                                1 << ((unsigned char *)tmp)[0xc + j]);
                    }
                    j = j + 1;
                } while (j < 4);
                table = table + 1;
                choice = choice + 6;
            } while (table < n);
        }
    }
}

/* iSPCH_MakeSampleRequests @0x80101508 : issue gSampleRequest for each chosen sample; returns total time. */
extern int iSPCH_MakeSampleRequests(int sentence, int paramTable)
{
    int samples = 0;
    int n = VoxSentence_GetNumPhrases(sentence);
    int i = 0;
    if (0 < n) {
        do {
            short        *choice = CHOICE(i);
            int           bank = *(int *)(*choice * 4 + gVoxBanks[0]);
            unsigned int  idx  = (unsigned int)PICK(choice[4]);
            int           tmp[4];
            /* MATCH: the ClearCycleBit call is gated on BOTH bank[2]&0xf0 AND the separate global
             * gClearCycle != 0 -- the earlier recon only had the bank-flags half of the gate. */
            if ((*(unsigned char *)(bank + 2) & 0xf0) != 0 && gClearCycle[0] != 0)
                iSPCH_ClearCycleBit(bank, idx);
            if (iSPCH_UnPackSample(bank, idx, tmp) != 0) {
                /* MATCH: stride computed UNCONDITIONALLY before the -1 test (oracle lhu+sll precede
                 * the beq; the mult starts in the branch delay slot) and choice[1] read ONCE into a
                 * named local -- the old double choice[1] read made loop.c fabricate a second
                 * &choice[1] giv (addiu s3,s2,2 anchor, +2 insns). */
                int spuAddr = tmp[1];
                int sub     = (int)choice[1];
                int stride  = (int)(unsigned int)*(unsigned short *)(bank + 4) << 8;
                if (sub != -1)
                    spuAddr = spuAddr + sub * stride;
                samples = samples + tmp[0];
                gSampleRequest[0]((int)*choice, spuAddr, tmp[0], paramTable);
                /* MATCH (w32-a9, 23 -> 3 diffs): the -dL "savings-1 lone lui not desirable"
                 * verdict was a CONSEQUENCE of the SCALAR declaration, not a cost-model identity.
                 * Declaring gSampleRequest as an UNSIZED ARRAY and calling `gSampleRequest[0](...)`
                 * (catalog SSE / SSE#5) makes cc1 materialize the base in a SEPARATE temp, which
                 * loop.c then happily hoists into $s6 exactly as retail, leaving `lw v0,0(s6)` in
                 * the loop.  RESIDUAL 3 (83/82) = reorg fills the `beqz` guarding the ClearCycleBit
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
extern void iSPCH_ClearChosen(void)
{
    DAT_80148448[0] = 0;
}

/* iSPCH_SaveChosenSentence @0x8010165C : record the chosen sentence + its 12 eventArgs.  Returns 1. */
extern int iSPCH_SaveChosenSentence(int sentence, int paramTable, int ruleCtx, int *eventArgs)
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
extern int iSPCH_OneChosen(void)
{
    return DAT_80148448[0];
}

/* iSPCH_PlayChosen @0x801016B4 : apply rules and issue the sample requests for the chosen sentence. */
extern void iSPCH_PlayChosen(void)
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
        iSPCH_RuleSet((short *)gSentenceChoice[0], gSentenceChoice[2], &gSentenceChoice[4]);
        iSPCH_ConstantRuleSet((short *)gSentenceChoice[0], gSentenceChoice[1]);
        iSPCH_MakeSampleRequests(gSentenceChoice[1], eventId);
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
extern int iSPCH_ChooseSentence(unsigned int *eventArgs)
{
    unsigned char local_order[104];
    char          local_30 = 0;
    int           idx = 0;
    int           event = iSPCH_FindEvent(*eventArgs);
    int           result = 0;
    if (event != 0) {
        if (iSPCH_RepeatEvent((unsigned short *)event) != 0) {
            unsigned int filterMode;
            unsigned int filterFlag;

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
extern void SPCH_SetPreLoadTicks(int ticks)
{
    gPreLoadTicks[0] = ticks;
}

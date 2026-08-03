/* eaclib/psx/spchpsxz/spchpick.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 21/27 PASS ***
 *   Remaining FAILs after wave 33: iSPCH_MatchSample(22,67/65),
 *   iSPCH_ConstantRuleSet(10,83/83), iSPCH_OrderSentences(9,82/83),
 *   iSPCH_SentenceGetChoices(7,81/80), iSPCH_SentenceMakeChoice(7,44/43),
 *   iSPCH_IterateChoice(4,44/44).
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
extern int  gFilterSetting[]; /* spchevnt-shared; UNSIZED ARRAY -> separate-temp lui/lw pair */
extern int  DAT_80148064[];   /* spchevnt "kept 'd' event" flag; UNSIZED ARRAY -> separate-temp lui/lw pair */
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
 * there is no compare to fold the constant into.
 * w33-a9 NEW RESULT -- the hoist IS source-killable without a goto loop: splitting the shift into
 * two statements over the SAME variable (`bit = 1; bit = bit << cycleByte;`) makes `bit` a pseudo
 * that is MODIFIED in the loop, so move_movables has no invariant to move.  That form reaches
 * EXACT 65/65 parity with the prologue, the whole param set (sample s6 / phraseTemplate s5 /
 * paramTable s7) and the epilogue BYTE-IDENTICAL -- no fp, no extra li.  NOT KEPT: the split
 * doubles bit's ref count, and the only residual becomes a 3-way rotation of the block locals,
 * 32 diffs vs the baseline's 22.  cc1 -dg/-dl numbers for the split form (priority =
 * floor_log2(refs)*refs/live_length): bit 10/15 = 2.00 -> s0, lowNib 6/8 = 1.50 -> s1,
 * i 13/28 = 1.39 -> s2, result 9/32 = 0.84 -> s3, count 5/33 = 0.30 -> s4; retail needs
 * lowNib > i > bit > result > count, i.e. bit's priority must land inside (0.84, 1.39) --
 * 7 refs at length 15, or 10 refs at length 22-35.  Falsified attempts at that: bit defined
 * before the cycleByte range guard, bit declared after lowNib, the shift hoisted out of the
 * inner block (all 32/65).  This is now a 1-parameter permuter target on the SPLIT form, not
 * the 40-diff goto form banked in w31.
 * w34-a9 NEW DATA on the SPLIT form (still 32 diffs / EXACT 65 insns, not kept):
 * hoisting the `bit = 1u;` half to the TOP of the loop body (before the cycleByte
 * load, shift left where it was) lengthens bit's live range 15 -> 19 insns at the
 * same 10 refs -- prio 3*10/19 = 1.58, still above i's 1.39.  Measured cc1 -dl/-dg
 * for that form: bit(r91) 10/19 -> $s0, lowNib(r94) 6/8 = 1.50 -> $s1, i(r89) 13/28
 * = 1.39 -> $s2, result(r87) 9/31 = 0.87 -> $s3, count(r84) 5/33 = 0.30 -> $s4;
 * retail needs lowNib > i > bit > result > count, i.e. bit's prio in (0.87, 1.39)
 * => at 10 refs its live length must reach 22-35 (we now have 19, need +3 more), or
 * its refs must drop to 6-7 (2*7/15 = 0.93; every ref is in-loop so they move in
 * steps of 2 and 6 refs at length 15 gives 0.80, just under).  Also falsified this
 * wave: `bit = (unsigned)(result + 1) << cycleByte` (cc1 const-folds result==0 there,
 * 22/67 unsplit and 32/65 split -- identical to the plain literal), and a shared
 * `one` variable carrying BOTH the shift base and `result = 1` (set twice in the
 * loop, the lever that cracked iSPCH_SentenceGetChoices) -- cse folds the second
 * `one = 1` away so the movable comes back, 38 diffs / 67 insns with $fp.  Also falsified this wave: `1u << (cycleByte & 0x1f)`
 * (23/68), lowNib declared first (38/67), a named `one` local (22/67, still hoisted),
 * `(result + 1) << cycleByte` (22/67, cc1 folds result to 0).
 * 🏆 w47-a2 SEALED 6 -> PASS (65/65) -- the residual `p` web was NOT toolchain identity.
 * NEW ANGLE "REORG EAGER-STEAL DUPLICATE MASQUERADES AS A PREHEADER INIT": the oracle's
 * `addu $v0,$s6,$s1` at 0x801007D4 (before the loop label) and the identical insn in the
 * back-branch delay slot at 0x8010084C are ONE source statement -- reorg stole the loop's
 * FIRST insn into the back branch's slot, retargeted the loop label past it and left the
 * loop-entry copy in the preheader.  So retail computes the cursor at the TOP OF THE LOOP
 * BODY (`int p = sample + i;` as the body's first declaration), NOT as a pre-loop init plus
 * a bottom update: with the pre-loop init cc1 const-props the just-assigned `i = 0` and
 * emits `addu $v1,$s6,$zero` (the 6-diff residual, plus the $v1-vs-$v0 coloring that
 * followed from it).  RULE: when the SAME insn appears in the preheader and in the
 * back-branch delay slot, it is one loop-top statement, not two. */
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
    {
        int i = 0;
    if (0 < count) {
        /* MATCH (w34-a9, 22 -> 15 diffs, 67 -> 66 insns): `bit` is a LOOP-CARRIED
         * pseudo re-armed to 1 at the bottom of every iteration instead of a fresh
         * `1u << cycleByte` per iteration.  Two effects, both needed:
         *  (1) it is SET TWICE inside the loop (here and by the shift), so loop.c's
         *      move_movables has no invariant `li 1` to hoist -- the hoist is what
         *      burned a NINTH callee-saved register ($fp) and the +2-insn save/restore
         *      pair in the old form;
         *  (2) the re-arm sits BEFORE the `i` increment, which stretches bit's live
         *      range across the back edge to 25 insns at 11 refs -- allocno priority
         *      floor_log2(11)*11/25 = 1.320, which finally drops bit BELOW `i` (1.345)
         *      and above `result` (0.844).  That reproduces retail's whole callee-saved
         *      assignment exactly: lowNib $s0, i $s1, bit $s2, result $s3, count $s4
         *      (the 5-way rotation w31/w33 filed as an allocno_compare identity).
         * The re-arm is written `bit = (unsigned int)result` rather than `bit = 1u`
         * on purpose: on the only path that reaches it `result` IS 1 (result == 0
         * exits on the next line), but cc1 cannot prove that, so it does not fold the
         * value into the following `i = i + 1` -- spelling the literal there makes gcc
         * emit `addu s1,s1,s2` (i += bit) instead of retail's `addiu s1,s1,1` and
         * costs 2 diffs (17 instead of 15).  Same family as the catalog's `^ zero`
         * runtime-zero device: value-preserving, purely a codegen fence.
         * RESIDUAL 15 (66/65): (a) the one extra insn is the pre-loop re-arm -- retail
         * simply never hoisted the constant, so it needs no carried copy at all; and
         * (b) the loop-head `p` init folds to `addu v1,s6,zero` for us because cc1
         * const-propagates the just-assigned `i = 0`, where retail keeps
         * `addu v0,s6,s1`.  Both are the toolchain-identity residue, not shape.
         * Falsified: re-arm after the increment (24-insn range, prio 1.375, 27 diffs);
         * re-arm between the guard and the `p` update (27); re-arm at the loop TOP
         * (= the w33 split form, range 19, prio 1.58/2.00, 32 diffs at exact 65/65);
         * `(result + 1)` and a shared `one` variable for both `1` constants (both
         * const-folded, hoist returns).
         * w35-a4 NEW BEST CHARACTERISATION (measured, NOT kept -- 32 diffs vs this form's 15):
         * the w35 DEAD-SET CARRIER kills the `li 1` hoist cleanly and reaches EXACT 65/65 with
         * retail's instruction stream, leaving ONE allocno swap.  Form:
         *     unsigned int one = 1;            (at the top of the loop body)
         *     ... unsigned int bit = one << cycleByte; ...
         *     one = 0;                         (dead; loop.c sees set_in_loop != 1 so it cannot
         *                                       hoist the `li 1`, and flow deletes the store free)
         * cc1 -dl/-dg for it: i(r89) 13 refs/28 = 3*13/28 = 1.393 -> $s0, lowNib(r94) 6/9 =
         * 2*6/9 = 1.333 -> $s1, bit $s2, result 9/33 = 0.818 -> $s3, count 5/33 = 0.303 -> $s4.
         * Retail is lowNib $s0 / i $s1 with the other three ALREADY correct, so the whole 32 is
         * ONE adjacent pair: lowNib's priority must exceed 1.393 (6 refs at live length <= 8, or
         * 7-8 refs at 9).  Falsified for that: hoisting `int i = 0;` to function scope to
         * lengthen i's range (27 diffs but 66 insns -- the early `move` costs an instruction),
         * and sinking lowNib's def inside the GetMatchValue guard to shorten its range (74/63 --
         * the byte load moves out of the jal delay slot entirely).  This is now a 1-parameter
         * permuter target on the DEAD-SET form (a strictly better base than the w33 split form,
         * which needed the same window but also had bit mis-ranked).
         * 2026-07-27 inline (15 -> 6 @65/65 EXACT): the dead-set form IS the winner once TWO
         * ordering levers land on top of it: (1) `bit = one << cycleByte` computed BEFORE
         * lowNib's def (shaves the one insn out of lowNib's live range that the w35 analysis
         * said it needed -- lowNib now outranks i and takes $s0); (2) `one = 1` declared
         * INSIDE the inner block, after the cycleByte guard (matches retail's li-after-beqz
         * and gives cycleByte the earlier caller-saved reg: sllv $s2,$v1,$a0 exact).  The
         * loop-carried re-arm `bit = result` is GONE -- the carrier replaces it.
         * RESIDUAL 6 = ONE web: the pre-loop `p = sample + i` folds (cc1 const-props i=0 ->
         * `addu v1,s6,zero`; retail keeps `addu v0,s6,s1`) and p colors $v1-vs-$v0 at both
         * its sites.  i=0 hoisted to fn top: 13 @66 (prologue move) -- reverted.  The
         * freechan EBB-boundary lever does not reach it (the use is an addu, not a compare,
         * and the branch distance is too short for cse's path limit). */
        do {
            int p = sample + i;
            unsigned int bit;
            unsigned int cycleByte = *(unsigned char *)(p + 0xc);
            result = 0;
            if (0x1f < cycleByte)
                goto done;
            {
                int lowNib;
                unsigned int one = 1;
                bit = one << cycleByte;
                lowNib = (int)*(unsigned char *)(phraseTemplate + i + 4) & 0xf;
                one = 0;
                if ((bit & (unsigned int)iSPCH_GetMatchValue(phraseTemplate, i)) != 0 &&
                    (lowNib == 0 ||
                     (bit & (unsigned int)*(int *)(lowNib * 4 + paramTable)) != 0))
                    result = 1;
            }
            i = i + 1;
            if (result == 0)
                goto done;
        } while (i < count);
    }
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
    /* MATCH (w33-a9, 14 -> 0): the pick address must be accumulated INTO the INDEX
     * variable, not into the base pointer.  The oracle loads choice[4] into $a1 and
     * adds the pick-pool base to it in place (`lh a1,8(a0); addu a1,a1,v0; lbu
     * a1,0(a1)`), so the index's register is the addu DESTINATION and ends up being
     * the 2nd call argument; writing `pickBase = pickBase + choice[4]` makes the
     * BASE the mutated variable, which colors the la into the lbu/arg register and
     * pushes gVoxBanks' load into $a0 (separate-temp `lui a1; lw a0,0(a1)` instead of
     * retail's self-temp `lui v1; lw v1,0(v1)`).  Catalog lever #14 (in-place
     * dead-pointer store) read the other way round: mutate the INDEX, not the base. */
    int            len      = 0;
    unsigned char *pickBase = ispch_gPickSamples;
    int            voxBase  = gVoxBanks[0];
    int            pick     = choice[4];
    pick = (int)(pickBase + pick);
    bank = *(int *)(*choice * 4 + voxBase);
    r = iSPCH_UnPackSample(bank, (unsigned int)*(unsigned char *)pick, tmp);
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
     * (b) SOLVED in w33-a9 -- see the scan loop below.
     * RESIDUAL 9 (82/83) is (a) alone: retail copies GetOffset16's return into $a0
     * (`addu a0,v0,zero`) and addresses both `*p` reads off $a0, while ours reuses $v0
     * directly and is 1 insn SHORTER.  That is the catalog's "ours-1-shorter receiver/
     * base-reg reuse" class = PERMUTER multi-basin, NOT a floor.  Source levers falsified
     * in w33-a9 (all 9 diffs / 82 insns, no movement): j++ before vs after the total
     * accumulation, a named byte temp for the first read, the p[0] index form, an
     * int-typed address local, and p hoisted to function scope.
     * w34-a9: three more falsified (all 9 diffs / 82 insns, byte-identical output) --
     * a second named alias `q = p` used for the store read (the catalog's cse
     * double-evaluation shape), the `p[0]` index form on BOTH reads, and moving
     * `j = j + 1` after the total accumulation.  The oracle's `addu a0,v0,zero` is a
     * genuine local-alloc rotation (retail {p:$a0, byte:$v1, addr:$v0} vs ours
     * {p:$v0, byte:$a0, addr:$v1}), not a missing evaluation. */
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
                /* MATCH (w33-a9, 12 -> 9): the scan is an INFINITE loop with TWO in-body
                 * breaks -- `while (1) { ...; if (r<0) break; j++; if (!(j<n)) break; }`.
                 * `while (j<n)` emits a rotation guard (slt/beqz, +3 insns) because cc1
                 * cannot prove 0<(int)n from n!=0; `for(;;)` with the bound test written
                 * as `j>=n` / `n<=j` makes loop.c PEEL the first iteration (+5, 87 insns).
                 * Only the negated `!(j < n)` bottom test reproduces the oracle's
                 * straight-in body with the exit at the back edge -- the whole scan block
                 * is now byte-identical. */
                while (1) {
                    r = r - (int)(unsigned int)weights[j];
                    if (r < 0)
                        break;
                    j = j + 1;
                    if (!(j < (int)n))
                        break;
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
                short *outChoice = CHOICE(table);
                int    r;
                short *phraseTemplate;
                outChoice[3] = (short)picked;
                phraseTemplate = (short *)iSPCH_GetOffset8(sentence, sentence + 4, table);
                if (iSPCH_GetPhraseBank(phraseTemplate, paramTable, outChoice) == 0) {
                    /* MATCH (w34-a9, 7 -> 1 diff): the compare constant is carried by a
                     * loop-body local `mark` that is SET TWICE in the loop (-2 for the test,
                     * then -1 for the failure store).  Two sets => loop.c's set_in_loop != 1
                     * => the `li -2` is NOT a movable, so it stays in the loop and fills the
                     * `lh`'s load-delay slot exactly like retail (`lh v1,0(s0); li v0,-2;
                     * bne v1,v0`).  This is the general cure for the move_movables constant
                     * hoist when the cost model (threshold*savings*lifetime >= insn_count)
                     * cannot be beaten: give the constant a VARIABLE that the loop rewrites.
                     * A single-set named local, a volatile local, `(int)` casts and Yoda order
                     * all leave the hoist in place (all 13 diffs / 83 insns, +fp save/restore).
                     * RESIDUAL 1 (79/80): gcc cross-jumps our mismatch tail (`result = 0;
                     * goto out;`) into the `fail:` block, so the `bne` targets .L80101008 with
                     * `li s4,-1` in its delay slot instead of retail's direct
                     * `bne ... .L8010109C` + duplicated `addu s4,zero,zero` in the slot.
                     * That is the known eaclib "retail never merges identical tails" identity
                     * (catalog wave-6 "no reliable anti-merge lever").  Falsified here:
                     * `return 0;` and `result = 0; return result;` (both 3 diffs / 81 insns,
                     * the block lands in $v0 not $s4); inverting the test so the -1 arm is the
                     * if-body (31 diffs).
                     * HISTORY (w32-a9, 17 -> 11 diffs, 83 -> 81 insns): the fail test was written
                     * `*outChoice + 2 != 0` rather than `*outChoice != -2`.  Retail's compare IS
                     * `lh v1; li v0,-2; bne v1,v0` (the li also filling the lh load-delay slot),
                     * but as a plain loop-invariant constant our cc1's move_movables hoists that
                     * `li -2` into a NINTH callee-saved register ($fp): +li, +fp save/restore, and
                     * a knock-on reschedule of the `li s4,1` result init (retail gets by on s0-s7).
                     * `(int)` casts, Yoda order and a named load temp all leave the motion in
                     * place; folding the constant into the compare removes the movable entirely.
                     * RESIDUAL 7 (81/80) = this compare alone: ours `lh v0; nop; addiu v0,v0,2;
                     * bnez` (4) vs retail `lh v1; li v0,-2; bne v1,v0` (3, the li filling the lh
                     * load-delay slot).  w33-a9 also tried the catalog's cure A: a label+goto loop
                     * DOES kill move_movables, and goto-loop + `!= -2` reaches EXACT 80/80 parity
                     * -- but at 34 diffs (the un-strength-reduced walker re-colors the whole body),
                     * so it is not kept.  What is still missing is a source form that keeps the
                     * reduced loop AND leaves the `li -2` in the block.
                     * 🏆 w47-a2 SEALED 1 -> PASS (80/80).  NEW ANGLE "PRE-SET THE DEFAULT BEFORE
                     * THE TEST": the residual was NOT the eaclib never-merges-tails identity.  The
                     * early-out arm (`if (mismatch) { result = 0; goto out; }`) is a BLOCK whose
                     * body is byte-identical to the `fail:` block, so jump.c cross-jumps it away,
                     * the bne then targets `fail:` -- and because that shared block re-sets s4,
                     * reorg is free to fill the slot from the FALL-THROUGH (`li s4,-1`) instead.
                     * Writing the default assignment BEFORE the test (`result = 0; if (match)
                     * { result = -1; *outChoice = result; } goto out;`) leaves NO arm to merge: the
                     * `result = 0` insn simply PRECEDES the branch, so fill_simple_delay_slots'
                     * backward scan (which skips over -- but does not stop at -- the conflicting
                     * `lh`/`li -2` compare feeders) moves it into the bne's delay slot and the
                     * branch goes straight to the shared epilogue, +1 insn = retail's 80.
                     * RULE: an oracle branch whose delay slot holds a store the fall-through
                     * immediately overwrites is a DEFAULT ASSIGNED BEFORE THE TEST, never an
                     * early-out arm. */
                    int mark = -2;
                    result = 0;
                    if (*outChoice == (short)mark) {
                        mark = -1;
                        result = mark;
                        *outChoice = (short)result;
                    }
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
/* residual 7 (44/43): the +1 insn is the giv anchor -- loop.c combines all
             * three in-loop address givs onto the LAST one (the +8 store), so ours folds
             * +8 into the record pointer at loop entry (`addiu s0,s0,8`) and the reads
             * become -4/-2, while retail keeps the pointer at the record base with bare
             * +4/+6/+8.
             * w33-a9 RE-VERDICT (was filed a "base-anchor FLOOR"): it IS the catalog's
             * giv-anchor class, and cure A (label+goto loop => no LOOP notes => no
             * strength reduction) DOES fix it -- the goto form reaches EXACT 43/43 parity
             * with the whole loop body byte-identical (lh 4(s0) / lhu 6(s0) / sh 8(s0) /
             * addiu s0,s0,12).  NOT KEPT because its residual is an 18-diff s2<->s3
             * rotation of `ok` and `n`, and that is the allocno_compare LIVE-LENGTH
             * identity, not a source shape: cc1 -dl gives ok = 5 refs / 24 insns
             * (priority .417) vs n = 3 refs / 15 insns (.200) under
             * floor_log2(refs)*refs/live_length, so psq43 cc1 allocates ok first; retail
             * allocates n first, which needs len(ok)/len(n) > 3.33 (ours is 1.6).  Same
             * >3.4x weighting exhibit as iSPCH_InitEventQueue (hub w32 identity core (b)).
             * Cure B (recompute the record pointer from the counter each iteration --
             * CHOICE(i) or an inline i*0xc) does NOT work here: 36 diffs / 45 insns,
             * loop.c re-derives the same anchor.  Restore the goto form when the cc1
             * snapshot question is settled.
             * w34-a9 RE-MEASURED the goto form directly from cc1 -dl/-dg (it is EXACT
             * 43/43 with the whole loop byte-identical; the 18 diffs are the $s2<->$s3
             * swap only).  Allocation there: walker(r80) 10 refs/17 insns = 1.765 ->
             * $s0, i(r85) 4/16 = 0.500 -> $s1, ok(r82) 5/24 = 0.417 -> $s2, n(r84)
             * 3/15 = 0.200 -> $s3; retail wants walker > i > n > ok.  The flip needs
             * EITHER n's priority inside (0.417, 0.500) -- 4 refs at live length 17-19,
             * because 4 refs at the present length 15 gives 0.533 and overshoots i --
             * OR ok down to <= 3 refs (1*3/24 = 0.125).  All FIVE ok refs exist in the
             * retail oracle itself (addu s3,zero,zero / addu s3,v0,zero / slt v0,s3,s2
             * / addiu s3,zero,1 / addu v0,s3,zero), and n's 3 refs are unweighted
             * precisely BECAUSE a goto loop carries no LOOP notes -- so no spelling
             * reaches the window without re-introducing loop notes (which brings back
             * the giv anchor this form exists to kill) or deleting an instruction
             * retail has.  Also falsified on the do-while form: a `volatile` store to
             * break combine_givs (51 diffs / 46 insns).  allocno_compare live-length
             * identity; the goto form is the permuter seed. */
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
                         * both); pure gcc CSE/coloring granularity -- accept.
                         * w34-a9 MECHANISM (new, still not source-reachable): the
                         * coloring is DOWNSTREAM of WHEN the gSentenceRuleSet
                         * fn-pointer address is materialized.  Retail emits
                         * `lui $v0,%hi(gSentenceRuleSet)` BEFORE the tmp-byte `lbu`,
                         * so the callee-address pseudo's live range OVERLAPS the
                         * byte-address temp and three distinct registers are needed
                         * ($v1 addr / $a3 one / $v0 callee).  Ours emits the `lui`
                         * AFTER the `lbu`, so the callee pseudo is born after the
                         * addr temp dies and both reuse $v0, freeing $v1 for the
                         * shift constant.  Falsified attempts to move the
                         * materialization earlier: declaring gSentenceRuleSet as an
                         * unsized array + `gSentenceRuleSet[0](...)` (26 diffs -- it
                         * also breaks the function's ENTRY gate, which retail loads
                         * with the SCALAR self-temp `lui v0; lw v0,0(v0)`), and an
                         * `extern ... gSentenceRuleSet_v[] asm("gSentenceRuleSet")`
                         * array VIEW used only at the call site (18 diffs). */
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
            filterMode = (unsigned int)gFilterSetting[0];
            if (DAT_80148064[0] == 1) {
                filterMode = (unsigned int)(gFilterSetting[0] + 1);
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
                ruleBits = iSPCH_GetRuleSettings((short *)event, (int *)eventArgs, &local_30);
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
                            table = (int)local_order[idx];
                            if (table < 0)
                                goto out;
                            if ((int)n <= table)
                                goto out;
                            sentence = iSPCH_GetOffset16(event, event + 0xc, (int)table);
                            r = iSPCH_SentenceGetChoices(sentence, (int)eventArgs, ruleBits,
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
out:
    return result;
}

/* SPCH_SetPreLoadTicks @0x801018F4 : set the speech pre-load tick offset. */
extern void SPCH_SetPreLoadTicks(int ticks)
{
    gPreLoadTicks[0] = ticks;
}

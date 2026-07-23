/* eaclib/psx/spchpsxz/spchinit.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 6 PASS + 1 NEAR ***
 *   Source obj : nfs4\eaclib\psx\spchinit.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   7 fns @[0x800EB5A4 .. 0x800EB748].  Speech subsystem init/deinit + the user-supplied alloc/free callback
 *   wrappers + the sample data-rate helper.  Ghidra nfs4-f.exe.c (spchinit) + disasm-v3 + IDA sigs.
 *
 *   Ghidra-ism note: SPCH_InitBankMem's params were mis-named by Ghidra (this/memAlloc/memFree) -- they are
 *   really (memAllocFn, memFreeFn, numBanks); SPCH_GetSampleDataRate's `this` is the sample count.
 *   gSPCH_Initialized[0]'s "live" sentinel is 0x1789a34.  spch state globals resolved by data-mat #75.
 */

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
 int gRepeatCount; 

extern int gMemAlloc[];        /* user alloc callback (fn ptr stored as int) */
extern int gMemFree[];         /* user free callback (fn ptr stored as int; array decl -> explicit lui+%lo store like gMemAlloc) */
extern int gSPCH_Initialized[];/* 0x1789a34 when initialised (array decl -> explicit lui+%lo, shared %hi) */
extern int gSampleRequest[];   /* sample-request callback */
extern int gSentenceRuleTest[];/* current sentence rule-test fn/state */
extern int gSentenceRuleSet[]; /* current sentence rule-set fn/state  */
extern int gVoxInGame[];       /* in-game speech enable (-1 = on); [1] aliases gRepeatCount@+4 */
extern int gRepeatCount;       /* repeated-event counter */
extern int gGameNum[];         /* current game/race number (shared w/ spchbank cycle-bit hash) */
extern int gDataRate[];        /* sample data rate */
extern int gFilterSetting[];   /* active filter setting */

extern void iSPCH_DisposeBanks(void);                      /* spchbank */
extern void iSPCH_InitBanks(void);                         /* spchbank */
extern int  iSPCH_BankMemAlloc(unsigned int numBanks);     /* spchbank */
extern void iSPCH_InitEventDat(void);                      /* spchevnt */
extern void iSPCH_InitEventQueue(void);                    /* spchevnt */
extern int *iSPCH_EACseedrandom(unsigned int seed);        /* spchrand */
extern void iSPCH_ClearChosen(void);                       /* spchpick */
extern int  SPCH_SetPreLoadTicks(int ticks);              /* spchpick */

extern int  iSPCH_MemAlloc(int numBytes, const char *tag);              /* @0x800EB5A4 */
extern void iSPCH_MemFree(void);                                        /* @0x800EB5D4 */
extern void SPCH_Deinit(void);                                          /* @0x800EB600 */
extern void iSPCH_InitInGame(void);                                     /* @0x800EB654 */
extern int  SPCH_GetSampleDataRate(int numSamples, int rate, int channels); /* @0x800EB66C */
extern int  SPCH_InitBankMem(int memAllocFn, int memFreeFn, int numBanks);  /* @0x800EB6F0 */
extern int  SPCH_Init(int sampleRequestCb, unsigned int gameNum, int dataRate); /* @0x800EB748 */

/* iSPCH_MemAlloc @0x800EB5A4 : invoke the user's allocation callback (which fills gVoxBanks); returns
 *   the callback's result, or 0 if no callback is registered.  `numBytes`/`tag` are passed through to
 *   the callback (a debug-tagging alloc convention -- e.g. "spch banks") but this wrapper itself never
 *   reads them (its own oracle body takes no args -- classic nullsub-still-takes-real-args). */
extern int iSPCH_MemAlloc(int numBytes, const char *tag)
{
    int result = 0;
    if (gMemAlloc[0] != 0)
        result = ((int (*)(int, const char *))gMemAlloc[0])(numBytes, tag);
    return result;
}

/* iSPCH_MemFree @0x800EB5D4 : invoke the user's free callback. */
extern void iSPCH_MemFree(void)
{
    if (gMemFree[0] != 0)
        ((void (*)(void))gMemFree[0])();
}

/* SPCH_Deinit @0x800EB600 : tear down the speech system (only if it was initialised). */
extern void SPCH_Deinit(void)
{
    if (gSPCH_Initialized[0] == 0x1789a34) {
        gSampleRequest[0]    = 0;
        gSentenceRuleTest[0] = 0;
        gSPCH_Initialized[0] = 0;
        gSentenceRuleSet[0]  = 0;
        iSPCH_DisposeBanks();
        iSPCH_InitEventDat();
    }
}

/* iSPCH_InitInGame @0x800EB654 : reset the in-game speech state.  (Residual = the original shared the
 *   %hi base for gVoxInGame + the adjacent gRepeatCount@+4 and put the 2nd store in the jr delay slot;
 *   maspsx always emits a nop after jr, so the delay-slot store can't be reproduced -- jr-slot floor.) */
extern void iSPCH_InitInGame(void)
{
    /* gRepeatCount sits at gVoxInGame+4; the original wrote both through the shared %hi base
     * (gcc materializes &gVoxInGame once, stores -1 at [0], and slots the [1]=0 store into the
     * jr delay slot).  Model gVoxInGame as the 2-word array it is so the base is shared. */
    gVoxInGame[0] = -1;
    gVoxInGame[1] = 0;   /* == gRepeatCount */
}

/* SPCH_GetSampleDataRate @0x800EB66C : bytes/sec for `numSamples` at `rate`, scaled by channel mode
 *   (1 = /10, 2 = *2/7).  The (x+7)>>3 is a round-toward-zero divide-by-8. */
extern int SPCH_GetSampleDataRate(int numSamples, int rate, int channels)
{
    int raw = numSamples * rate;
    int v;
    if (raw < 0)
        raw = raw + 7;
    v = raw >> 3;
    if (channels == 1)
        goto div10;
    if (channels == 0)
        goto done;
    if (channels == 2)
        goto mul27;
    goto done;
div10:
    v = v / 10;
    goto done;
mul27:
    v = (v * 2) / 7;
done:
    return v;
}

/* SPCH_InitBankMem @0x800EB6F0 : register the alloc/free callbacks and allocate `numBanks` bank slots.
 *   Returns the bank array (gVoxBanks) or 0 if not initialised / no alloc callback. */
extern int SPCH_InitBankMem(int memAllocFn, int memFreeFn, int numBanks)
{
    int result = 0;
    if (gSPCH_Initialized[0] == 0x1789a34 && memAllocFn != 0 && memFreeFn != 0) {
        gMemAlloc[0] = memAllocFn;
        gMemFree[0] = memFreeFn;
        result    = iSPCH_BankMemAlloc((unsigned int)numBanks);
    }
    return result;
}

/* SPCH_Init @0x800EB748 : initialise the speech system for game `gameNum` -- seed the PRNG, clear the
 *   pick/event/bank state, and mark it live.  Returns 1. */
extern int SPCH_Init(int sampleRequestCb, unsigned int gameNum, int dataRate)
{
    gSampleRequest[0]    = sampleRequestCb;
    gGameNum[0]       = gameNum;
    gDataRate[0]      = dataRate;
    gMemAlloc[0]      = 0;
    gMemFree[0]       = 0;
    gSentenceRuleTest[0] = 0;
    gSentenceRuleSet[0]  = 0;
    iSPCH_EACseedrandom(gameNum);
    iSPCH_ClearChosen();
    SPCH_SetPreLoadTicks(0);
    gFilterSetting[0] = 0;
    iSPCH_InitEventDat();
    iSPCH_InitInGame();
    iSPCH_InitBanks();
    /* Near match (10->3 diffs, 40/39 insns): the one-shot loop gives the oracle's v1 constant and
     * v0 global-base coloring.  The sole residual is gcc restoring ra at the epilogue and inserting
     * its load-delay nop instead of scheduling that restore between the constant and base setup. */
    do {
        iSPCH_InitEventQueue();
        gSPCH_Initialized[0] = 0x1789a34;
    } while (0);
    return 1;
}

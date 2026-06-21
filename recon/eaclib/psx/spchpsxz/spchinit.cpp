/* eaclib/psx/spchpsxz/spchinit.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 7/7 ***
 *   Source obj : nfs4\eaclib\psx\spchinit.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   7 fns @[0x800EB5A4 .. 0x800EB748].  Speech subsystem init/deinit + the user-supplied alloc/free callback
 *   wrappers + the sample data-rate helper.  Ghidra nfs4-f.exe.c (spchinit) + disasm-v3 + IDA sigs.
 *
 *   Ghidra-ism note: SPCH_InitBankMem's params were mis-named by Ghidra (this/memAlloc/memFree) -- they are
 *   really (memAllocFn, memFreeFn, numBanks); SPCH_GetSampleDataRate's `this` is the sample count.
 *   gSPCH_Initialized's "live" sentinel is 0x1789a34.  spch state globals resolved by data-mat #75.
 */

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
extern "C" { int gRepeatCount; }

extern "C" int gMemAlloc[];        /* user alloc callback (fn ptr stored as int) */
extern "C" int gMemFree;           /* user free callback  */
extern "C" int gSPCH_Initialized;  /* 0x1789a34 when initialised */
extern "C" int gSampleRequest;     /* sample-request callback */
extern "C" int gSentenceRuleTest;  /* current sentence rule-test fn/state */
extern "C" int gSentenceRuleSet;   /* current sentence rule-set fn/state  */
extern "C" int gVoxInGame;         /* in-game speech enable (-1 = on) */
extern "C" int gRepeatCount;       /* repeated-event counter */
extern "C" int gGameNum;           /* current game/race number (shared w/ spchbank cycle-bit hash) */
extern "C" int gDataRate;          /* sample data rate */
extern "C" int gFilterSetting;     /* active filter setting */

extern "C" void iSPCH_DisposeBanks(void);                      /* spchbank */
extern "C" void iSPCH_InitBanks(void);                         /* spchbank */
extern "C" int  iSPCH_BankMemAlloc(unsigned int numBanks);     /* spchbank */
extern "C" void iSPCH_InitEventDat(void);                      /* spchevnt */
extern "C" void iSPCH_InitEventQueue(void);                    /* spchevnt */
extern "C" int *iSPCH_EACseedrandom(unsigned int seed);        /* spchrand */
extern "C" void iSPCH_ClearChosen(void);                       /* spchpick */
extern "C" int  SPCH_SetPreLoadTicks(int ticks);              /* spchpick */

extern "C" int  iSPCH_MemAlloc(void);                                       /* @0x800EB5A4 */
extern "C" void iSPCH_MemFree(void);                                        /* @0x800EB5D4 */
extern "C" void SPCH_Deinit(void);                                          /* @0x800EB600 */
extern "C" void iSPCH_InitInGame(void);                                     /* @0x800EB654 */
extern "C" int  SPCH_GetSampleDataRate(int numSamples, int rate, int channels); /* @0x800EB66C */
extern "C" int  SPCH_InitBankMem(int memAllocFn, int memFreeFn, int numBanks);  /* @0x800EB6F0 */
extern "C" int  SPCH_Init(int sampleRequestCb, unsigned int gameNum, int dataRate); /* @0x800EB748 */

/* iSPCH_MemAlloc @0x800EB5A4 : invoke the user's allocation callback (which fills gVoxBanks); returns
 *   the callback's result, or 0 if no callback is registered. */
extern "C" int iSPCH_MemAlloc(void)
{
    int result = 0;
    if (gMemAlloc[0] != 0)
        result = ((int (*)(void))gMemAlloc[0])();
    return result;
}

/* iSPCH_MemFree @0x800EB5D4 : invoke the user's free callback. */
extern "C" void iSPCH_MemFree(void)
{
    if (gMemFree != 0)
        ((void (*)(void))gMemFree)();
}

/* SPCH_Deinit @0x800EB600 : tear down the speech system (only if it was initialised). */
extern "C" void SPCH_Deinit(void)
{
    if (gSPCH_Initialized == 0x1789a34) {
        gSampleRequest    = 0;
        gSentenceRuleTest = 0;
        gSPCH_Initialized = 0;
        gSentenceRuleSet  = 0;
        iSPCH_DisposeBanks();
        iSPCH_InitEventDat();
    }
}

/* iSPCH_InitInGame @0x800EB654 : reset the in-game speech state.  (Residual = the original shared the
 *   %hi base for gVoxInGame + the adjacent gRepeatCount@+4 and put the 2nd store in the jr delay slot;
 *   maspsx always emits a nop after jr, so the delay-slot store can't be reproduced -- jr-slot floor.) */
extern "C" void iSPCH_InitInGame(void)
{
    gVoxInGame   = -1;
    gRepeatCount = 0;
}

/* SPCH_GetSampleDataRate @0x800EB66C : bytes/sec for `numSamples` at `rate`, scaled by channel mode
 *   (1 = /10, 2 = *2/7).  The (x+7)>>3 is a round-toward-zero divide-by-8. */
extern "C" int SPCH_GetSampleDataRate(int numSamples, int rate, int channels)
{
    int v = numSamples * rate;
    if (v < 0)
        v = v + 7;
    v = v >> 3;
    if (channels == 1)
        v = v / 10;
    else if (channels == 2)
        v = (v * 2) / 7;
    return v;
}

/* SPCH_InitBankMem @0x800EB6F0 : register the alloc/free callbacks and allocate `numBanks` bank slots.
 *   Returns the bank array (gVoxBanks) or 0 if not initialised / no alloc callback. */
extern "C" int SPCH_InitBankMem(int memAllocFn, int memFreeFn, int numBanks)
{
    int result = 0;
    if (gSPCH_Initialized == 0x1789a34 && memAllocFn != 0 && memFreeFn != 0) {
        gMemAlloc[0] = memAllocFn;
        gMemFree  = memFreeFn;
        result    = iSPCH_BankMemAlloc((unsigned int)numBanks);
    }
    return result;
}

/* SPCH_Init @0x800EB748 : initialise the speech system for game `gameNum` -- seed the PRNG, clear the
 *   pick/event/bank state, and mark it live.  Returns 1. */
extern "C" int SPCH_Init(int sampleRequestCb, unsigned int gameNum, int dataRate)
{
    gMemAlloc[0]      = 0;
    gMemFree          = 0;
    gSentenceRuleTest = 0;
    gSentenceRuleSet  = 0;
    gSampleRequest    = sampleRequestCb;
    gGameNum          = (int)gameNum;
    gDataRate         = dataRate;
    iSPCH_EACseedrandom(gameNum);
    iSPCH_ClearChosen();
    SPCH_SetPreLoadTicks(0);
    gFilterSetting = 0;
    iSPCH_InitEventDat();
    iSPCH_InitInGame();
    iSPCH_InitBanks();
    iSPCH_InitEventQueue();
    gSPCH_Initialized = 0x1789a34;
    return 1;
}

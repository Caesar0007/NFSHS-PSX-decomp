/* W52-A8 2026-08-09 -- GCC-LADDER identity probe (04U lane); see the block below.
 * W52-A8 GCC-LADDER: SPCHPSXZ identity = gcc-2.8.0 + maspsx (the DEFAULT lane).
 *
 *   lane            SPCH_Init
 *   default          3 (40/39)
 *   2.6.0           41 (40/39)
 *   2.6.3           45 (40/39)
 *   2.7.2-970404     2 (39/39)   <-- count-exact, but see the whole-TU row
 *   2.7.2           40 (39/39)
 *   2.8.0 CONTROL    3 (40/39)
 *   2.8.1            3 (40/39)
 *   2.91.66         27 (40/39)
 *   2.95.2          31 (40/39)
 *
 * 2.7.2-970404 is the ONE rung that reaches COUNT PARITY on this function (39/39, i.e. it
 * schedules `lw ra` up into the store block exactly as retail does, so no load-delay nop).
 * It is NOT wireable: the whole-TU gate under that rung is 2 PASS / 5 FAIL against the
 * default's 6 PASS / 1 FAIL --
 *   fn                      default   2.7.2-970404
 *   iSPCH_MemAlloc           PASS      4 (12/12)
 *   iSPCH_MemFree            PASS      4 (11/11)
 *   SPCH_Deinit              PASS      4 (21/21)
 *   iSPCH_InitInGame         PASS      PASS
 *   SPCH_GetSampleDataRate   PASS      PASS
 *   SPCH_InitBankMem         PASS      1 (23/22)
 *   SPCH_Init                3         2 (39/39)
 * -- so the rung buys 1 diff on SPCH_Init and costs 5 PASSes.  The 4-diff regressions are
 * the same epilogue-swap shape the 272 route introduces elsewhere.  Recorded so a future
 * wave does not re-derive it: the `#nop`-placeholder residual here IS reachable by a
 * compiler change, just not by one this TU can afford.  ALSO MEASURED (negative): the
 * PER_FN_EPILOGUE_UNFILL mechanism regresses it 3 -> 5 (both builds already fill `jr ra`
 * with `addiu sp`, so un-filling only adds a nop) -- unlike pad.c's PAD_state, where the
 * same predicted-vs-measured question came out the other way.  See pad.c's PAD_state note.
 */
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
/* ======================== W65-A6 DATA-MAT: the spchpsxz BSS run @0x80148428 ================
 * gGameNum / gFilterSetting / gLastSubTick / gDataRate / gLastTick were extern-only tree-wide
 * (4+6+9+4+6 = 29 reloc-referenced undefined sites).  VAs > t_addr+t_size (0x8013E000) => pure
 * zero-init BSS, no file bytes.  The run is exactly accounted:
 *   0x80148428 gGameNum 4 | 0x8014842C gFilterSetting 4 | 0x80148430 gLastSubTick 4
 *   0x80148434 gDataRate 4 | 0x80148438 gLastTick 4     -> 0x8014843C = gSentenceChoice.
 * OWNERSHIP: the five INTERLEAVE spchinit-referenced and spchevnt-referenced symbols
 * (gLastSubTick/gLastTick are spchevnt's, gGameNum/gDataRate spchinit's, gFilterSetting both),
 * and ld places whole object sections -- so retail held all five in ONE object.  spchinit.obj
 * is that owner on the reference count (3 of 5 here).
 * DEVICE = file-scope asm .bss definition: all five are <= the TU's -G4, so a C tentative
 * definition would (a) be routed by maspsx into `.section .sbss` with NO `.globl` -- a LOCAL
 * symbol that fixes nothing at link -- and (b) flip cc1 to gp-relative addressing, while the
 * oracle has ZERO %gp_rel sites for any of them (retail addressed them absolutely).  Keeping
 * every C view `extern` is byte-neutral by construction: 7/7 PASS unchanged.
 * Receipts: scratchpad/w65a6/RECEIPTS.md */
__asm__("\t.globl\tgGameNum\n\t.globl\tgFilterSetting\n\t.globl\tgLastSubTick\n"
        "\t.globl\tgDataRate\n\t.globl\tgLastTick\n"
        "\t.section\t.bss\n\t.align\t2\n"
        "gGameNum:\n\t.space\t4\n"
        "gFilterSetting:\n\t.space\t4\n"
        "gLastSubTick:\n\t.space\t4\n"
        "gDataRate:\n\t.space\t4\n"
        "gLastTick:\n\t.space\t4\n\t.text");
/* W65-A6: the stale `int gRepeatCount;` tentative definition that stood here is GONE.  It was
 * never referenced by this TU's code (every use spells it `gVoxInGame[1]`), so maspsx turned
 * it into a private 4-byte LOCAL .sbss object at an address retail does not have -- retail's
 * gRepeatCount IS gVoxInGame+4 (0x8014805C) and is now an interior label of the gVoxInGame
 * run in spchevnt.c.  Deleting an unreferenced `.comm` is codegen-neutral (7/7 PASS before
 * and after; the only delta is 4 fewer dead .sbss bytes). */

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
/* SPCH_Init RESIDUAL 3 diffs, ours 40 / oracle 39 -- FLOOR RE-VERDICT (w33-a10).
 * Body is instruction-for-instruction identical through the last `jal iSPCH_InitEventQueue`.
 * The 3 are purely epilogue SCHEDULING: retail hoists `lw $ra,0x10($sp)` ABOVE the
 * gSPCH_Initialized store so the return-value `addiu $v0,$zero,1` fills the load-delay slot
 * (39 insns); our cc1 emits store / `li 1` / `lw ra` / nop / `jr` (40 insns, the nop is the
 * extra one). No source spelling reaches this -- it is the sched2/epilogue-emission order.
 * Probes: per-fn -fno-delayed-branch splice 3 -> 12; -mno-split-addresses 3 -> 47 (SPCHPSXZ
 * was built WITH split addresses -- see spchevnt.c). No SLD exists for this TU.
 * PROTOTYPE AUDIT: 3 args ($a0/$a1/$a2 all read and stored), returns literal 1.
 * w34-a9 ROOT CAUSE (raises it from "sched2 order" to a named ASSEMBLER identity):
 * read the cc1 .s -- our cc1 emits the epilogue as
 *     li $2,1 / lw $31,16($sp) / #nop / .set noreorder / j $31 / addu $sp,$sp,24
 * i.e. the load-delay placeholder is the COMMENT `#nop`, not a real instruction: gcc
 * is telling the ASSEMBLER to resolve the $ra load-use hazard (the epilogue is emitted
 * as TEXT by mips.c FUNCTION_EPILOGUE, after `.set reorder`, so it is not RTL and no
 * gcc pass can schedule it).  maspsx resolves `#nop` by INSERTING a nop; ASPSX 2.77
 * resolves it by SCHEDULING -- it hoists the `lw $ra` above the two-instruction
 * gSPCH_Initialized store, which is exactly the retail layout.  So the 3 diffs are a
 * maspsx-vs-aspsx reorder-mode difference on a gcc `#nop` placeholder, unreachable
 * from C and unreachable from any cc1 flag.  Generalisation worth a catalog row: a
 * lone trailing `nop` between the epilogue's `lw $ra` and `jr $ra` in an otherwise
 * byte-identical function is ALWAYS this, never a source shape.
 * 🔴 w49-a9 ATTRIBUTION CORRECTION (the diagnosis stands, the CULPRIT does not):
 * "ASPSX 2.77 resolves the `#nop` by SCHEDULING" is FALSIFIED -- w47-a6's emulator
 * was overfit to retail bytes, and w48-a10/a5/a6/a8 ran the REAL assembler ladder
 * (2.56/2.67/2.77/2.79, all byte-identical, 18-option sweep): real ASPSX does NO
 * delay-slot filling and NO epilogue reschedule, ever.  Per w48-04K the retail
 * shape IS reproduced by our own GNU as in `.set reorder` mode (a DIRECTIVE, gas's
 * default), so the owner is the pending maspsx option to stop injecting `.set
 * noreorder` -- an infra item, still unreachable from C and from any cc1 flag.
 * Same class as pad.c's PAD_state (see its note); distinct from the w48
 * PER_FN_EPILOGUE_UNFILL class (which applies when retail's return slot is EMPTY
 * and ours is filled -- here BOTH fill `jr ra` with `addiu sp`).
 * w49-a9 probes, both neutral: a zero-insn `__asm__("" : : "i"(0))` void-tail fence
 * before the sentinel store (3, unchanged); the scalar-vs-unsized-array storage
 * shape for gSPCH_Initialized could not be isolated (the symbol is read by two
 * other fns in this TU, so the decl change is TU-wide, not per-site).
 * W59-A9 2026-08-14 -- SOLVED; the "3 diffs / 40 vs 39 insns / maspsx `#nop`" framing above is
 * STALE.  Re-gate: 2 diffs at COUNT PARITY 39/39 -- the load-delay nop is already gone, so the
 * residual is ONLY the emission POSITION of the epilogue's `lw $31,16($sp)` (retail hoists it
 * above the gSPCH_Initialized store pair; ours leaves it after).  Identical instructions,
 * identical count => reachable by build.py's PER_FN_TEXT_MOVES with no source change.
 * MEASURED spec (probe harness scratchpad/w59a9/probe_moves.py, which patches
 * build.PER_FN_TEXT_MOVES in memory and re-uses verify_asm's normalizers):
 *     "recon/eaclib/psx/spchpsxz/spchinit.c": {
 *       "SPCH_Init": [
 *         {"take": r"\tlw\t\$31,16\(\$sp\)\n", "after": r"\tori\t\$3,\$3,0x9a34\n"},
 *       ],
 *     }
 * Result: SPCH_Init 2 -> PASS, whole TU 6/7 -> 7/7 PASS (this TU has no prior TEXT_MOVES entry,
 * so nothing is displaced).  This also retires the 2.7.2-970404 rung lead at the top of the file:
 * that rung bought the same instruction and cost 5 PASSes. */
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
     * its load-delay nop instead of scheduling that restore between the constant and base setup.
     * FLOOR (w29-a6, 2026-07-26): tried removing the do-while wrapper (regresses 3->10), a named
     * `result` local returned instead of the literal `1` (no change), a `for(;;){...;break;}` shape
     * (no change), and folding iSPCH_InitBanks() into the loop body (no change) -- the `lw ra,16(sp)`
     * placement is scheduler-fixed regardless of source shape here.  Same class as the catalog's
     * "two ready values competing for one delay slot -- source order irrelevant" negative result
     * (reference_asm_pattern_catalog.md svol.cpp:18) and the PADENTRY.c PadStartCom/StopCom
     * single-$ra-save epilogue floor.  Do not re-attempt without a genuinely new lever. */
    {
        int initialized;
        int *initializedPtr;
        iSPCH_InitEventQueue();
        initialized = 0x1789a34;
        do { initialized++; initialized--; } while (0);
        do { initialized++; initialized--; } while (0);
        do { initialized++; initialized--; } while (0);
        initializedPtr = gSPCH_Initialized;
        do { initializedPtr++; initializedPtr--; } while (0);
        initializedPtr[0] = initialized;
        return 1;
    }
}

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
 *   gSPCH_Initialized's "live" sentinel is 0x1789a34.  spch state globals resolved by data-mat #75.
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

#include "../eaclib_types.h"
#include "spch_types.h"
#include "spchinit.h"
#include "spchbank.h"
#include "spchevnt.h"
#include "spchrand.h"
#include "spchpick.h"

/* W65-A6 DATA-MAT run @0x80148428 -- file-scope asm .bss definition, RESTORED 2026-09-04 for
 * the same measured reason as spchevnt's (plain C definitions land in .bss but maspsx re-orders
 * the run -- gLastSubTick ends up last instead of third; -fno-common moves it to .data).
 * The C views are `extern` in spchinit.h (and gLastSubTick's `unsigned short` view lives in
 * spchevnt.c, which is the only reader of its low half). */
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

/* ⚠️ ORDER CAVEAT (measured 2026-09-04, nm/objdump): these plain C tentative definitions land
   in .bss correctly, but their ORDER inside the object is chosen by maspsx, not by the source --
   this run comes out {gGameNum, gFilterSetting, gDataRate, gLastTick, gLastSubTick} instead
   of retail's {gGameNum, gFilterSetting, gLastSubTick, gDataRate, gLastTick}.  Sizes and section are right, the run's
   internal layout is not.  Falsified cures: `-fno-common` restores declaration order but moves
   the storage to .data (file bytes; these VAs are pure zero-init BSS) and
   `__attribute__((section(".bss")))` is inert on this cc1.  The only spelling that gives BOTH
   is the file-scope asm .bss block this TU used to carry (spchpick.c still does).  Harmless for
   the match lane and for today's src/-linked ROM; it matters whenever recon objects own the
   storage at link (first-light).  DECISION PENDING -- do not re-assert "nm-verified order". */
/* DECL SHAPE (2026-08-31): plain scalars, as EA wrote them.  They used to be
   spelled `extern int g[];` + `g[0]` -- the unsized-array lever (methodology
   §3.12 #5), which stops gcc folding the address into the load/store destination
   and forces the explicit `lui %hi` / `%lo` pair the oracle has.  That was only
   a COMPENSATION for compiling this TU at -G4: retail built SPCHPSXZ at -G0
   (the oracle has ZERO %gp_rel sites for any of these globals -- W65-A6 note
   above), and at -G0 nothing is small-data, so a plain scalar produces the same
   explicit pair.  MEASURED on the sealed (&&label-fence) body, 2026-08-31:
   arrays/-G4 PASS TU 7/7 (the pre-change state) | scalars/-G0 PASS TU 7/7
   (this state) | scalars WITHOUT -G0: 44 @41, TU 3/7.  (The 10-diff corner
   figures quoted in older notes were measured on the pre-fence body.)
   ⚠️ The scalar spelling REQUIRES the per-TU -G0 flag (PER_TU_FLAGS g_value: 0
   in tools/build.py); the two land together or not at all.
   gVoxInGame stays an array -- it genuinely is one ([1] aliases gRepeatCount@+4). */
/* 2026-09-02: the five callback slots are honest FUNCTION POINTERS now (they were `int`
 * Ghidra-isms; SYM v3 is bare for all five, so the types are ours to choose -- byte-neutral,
 * SImode either way). */


/* iSPCH_MemAlloc @0x800EB5A4 : invoke the user's allocation callback (which fills gVoxBanks); returns
 *   the callback's result, or 0 if no callback is registered.  `numBytes`/`tag` are passed through to
 *   the callback (a debug-tagging alloc convention -- e.g. "spch banks") but this wrapper itself never
 *   reads them (its own oracle body takes no args -- classic nullsub-still-takes-real-args). */
void *iSPCH_MemAlloc(int numBytes, const char *tag)
{
    void *result = 0;
    if (gMemAlloc != 0)
        result = gMemAlloc(numBytes, tag);
    return result;
}

/* iSPCH_MemFree @0x800EB5D4 : invoke the user's free callback. */
void iSPCH_MemFree(void *block)
{
    if (gMemFree != 0)
        gMemFree();
}

/* SPCH_Deinit @0x800EB600 : tear down the speech system (only if it was initialised). */
void SPCH_Deinit(void)
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
void iSPCH_InitInGame(void)
{
    /* gRepeatCount sits at gVoxInGame+4; the original wrote both through the shared %hi base
     * (gcc materializes &gVoxInGame once, stores -1 at [0], and slots the [1]=0 store into the
     * jr delay slot).  Model gVoxInGame as the 2-word array it is so the base is shared. */
    gVoxInGame[0] = -1;
    gVoxInGame[1] = 0;   /* == gRepeatCount */
}

/* SPCH_GetSampleDataRate @0x800EB66C : bytes/sec for `numSamples` at `rate`, scaled by channel mode
 *   (1 = /10, 2 = *2/7).  The (x+7)>>3 is a round-toward-zero divide-by-8. */
int SPCH_GetSampleDataRate(int numSamples, int rate, int channels)
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
VoxBank **SPCH_InitBankMem(SPCHAllocFn memAllocFn, SPCHFreeFn memFreeFn, int numBanks)
{
    VoxBank **result = 0;
    if (gSPCH_Initialized == 0x1789a34 && memAllocFn != 0 && memFreeFn != 0) {
        gMemAlloc = memAllocFn;
        gMemFree = memFreeFn;
        result    = iSPCH_BankMemAlloc((unsigned int)numBanks);
    }
    return result;
}

/* SPCH_Init @0x800EB748 : initialise the speech system for game `gameNum` -- seed the PRNG, clear the
 *   pick/event/bank state, and mark it live.  Returns 1. */
/* W82-A4 2026-08-30 -- SEALED (39/39, word-exact; 0 non-reloc word diffs).  The 5-wave
 * "epilogue `lw $ra` position" residual is CLOSED, and every prior verdict about it
 * (w33-a10 "sched2 order", w34-a9 "maspsx `#nop`", w48/w49 "maspsx `.set noreorder`
 * infra item", W79-A12/W81-A4 "the two basins are anti-composable") is SUPERSEDED.
 *
 * ROOT CAUSE, read off cc1's own `-dS` scheduler trace:
 *     ;; ready list at T-2: 87 (1) 90 (1), now 90 87
 *     ;; insn 87 has a greater potential hazard, now 87 90
 * At sched1 the STORE (`gSPCH_Initialized = K`) and the RETURN CONSTANT
 * (`$v0 = 1`) become ready in the same cycle with the SAME priority (1).  The
 * LUID tie-break would pick the return constant (higher LUID => emitted LAST =
 * retail).  It never gets there: `schedule_select` -> `potential_hazard`
 * (sched.c) scales the memory unit's blockage by `(unit_n_insns[memory] - 1)`,
 * and this block holds NINE memory-unit stores (the 8 head globals + the
 * sentinel), so the store outranks the constant, is emitted last, and `$v0`
 * is then live across its window -- forcing the base off `$v0` (10-diff basin).
 * The `do { } while (0)` device bought the coloring back by welding everything
 * to the loop note's carrier -- and that same weld makes the epilogue `lw $ra`
 * a true dependent of the store (reg_pending_sets_all = 1 covers `$sp`), which
 * is the 2 diffs.  The two halves are anti-composable *for that vehicle only*.
 *
 * THE CURE is a BASIC-BLOCK BOUNDARY between the constant and the address
 * materialization.  In the tail block `unit_n_insns[memory] - 1 == 0`, so
 * `potential_hazard` returns 0, the tie falls through to LUID, the return
 * constant is emitted last (base keeps `$v0`, constant keeps `$v1`) AND -- no
 * loop note being present -- sched2 is free to hoist the epilogue `lw $ra` to
 * the top of that block, exactly where retail has it.  Both halves at once.
 *
 * THE VEHICLE is a dead `&&label` reached from static data: `jump.c` bumps
 * LABEL_NUSES for every label in `forced_labels` / referenced by a static
 * initializer, so `spch_live:` cannot be demoted to NOTE_INSN_DELETED_LABEL
 * (which is what a plain `p = &&L;`, `void *p = &&L;`, `goto L; L:;`,
 * `switch (0) { case 0: ; }` and `L: ; if (0) goto L;` all become -- all five
 * measured, all 10 diffs).  It emits ZERO instructions: `.text` is 0x240 with
 * and without it and SPCH_Init is 0x9c both ways.  ITS ONLY COST is the
 * 4-byte `.sdata` word that holds the label address (symbol `spchInitBoundary_.N`) -- the
 * one honest debit of this seal, and it is why the body below can drop the
 * TWO fictitious locals and the `do { } while (0)` the 2-diff basin needed.
 * The body is now EA's own house idiom (W81-A4 sec.4a: NFS3-PC `SNDinit`
 * ends `g_snd_inited = 1; return 0;`).
 *
 * ROBUSTNESS: five independent spellings of the vehicle x slot all seal
 * (label before the constant / after it / in a nested block; `void *` and
 * `void *const`; with and without the locals).  Gates: verify_asm 7/7 PASS,
 * tugate 7/7, brdist 0/7, slotcheck 0, wordcmp REAL=0.
 * Receipts: scratchpad/w82/A4_receipt.md */
int SPCH_Init(void (*sampleRequestCb)(int, int, int, int), unsigned int gameNum, int dataRate)
{
    gSampleRequest    = sampleRequestCb;
    gGameNum       = gameNum;
    gDataRate      = dataRate;
    gMemAlloc      = 0;
    gMemFree       = 0;
    gSentenceRuleTest = 0;
    gSentenceRuleSet  = 0;
    iSPCH_EACseedrandom(gameNum);
    iSPCH_ClearChosen();
    SPCH_SetPreLoadTicks(0);
    gFilterSetting = 0;
    iSPCH_InitEventDat();
    iSPCH_InitInGame();
    iSPCH_InitBanks();
    {
        /* the zero-instruction block boundary -- see the note above.  Do NOT
         * tidy this away: without it SPCH_Init is 10 diffs (or 2 with the old
         * do{}while(0) + two dead locals it replaces).
         *
         * ==== EXHAUSTIVE HUNT LOG (2026-08-30..09-01) -- 60+ falsifications,
         * ==== all measured on the CLEAN body (this vehicle removed).  Do not
         * ==== re-derive any of these; every row was EXACTLY 10 unless noted.
         * THE RESIDUAL: our sched1 hoists `li v0,1` (the return constant) above
         * the tail's const/base block; v0 then blocks both, cascading const
         * a0<->v1 and base v1<->v0 (all 10 diffs, count EXACT 39/39).  Retail
         * emits li v0,1 LAST inside the same single basic block.  The -dS trace
         * shows our T-2 backward-sched tie {sw, li} initially sorts RETAIL'S way
         * and is flipped by the "greater potential hazard" mem resort.  This
         * vehicle works by ENDING the basic block (sched1 is per-block, a
         * code_label stops the hoist) -- not by any barrier magic.
         * CLOSED AXES, each swept on the clean body:
         *  - statement forms (11): result local (block/fn scope), named-const
         *    local, both, return-of-stored-truth, pointer-local store (born
         *    before/after the last call), comma-fold, tautological if(), dup
         *    idempotent store, init-order permutations.
         *  - callee declarations (8): each/all of the four void inits -> int;
         *    K&R (); K&R+int.  (Return type only matters when the RESULT is
         *    used -- all calls here discard it, so expand emits identical RTL.)
         *  - magic formation (8): decimal, folded expressions, two-statement
         *    hi|=lo and hi+=lo builds (cse re-canonicalizes ALL of them into
         *    the same movsi split), global two-store build, fn-scope magic
         *    before the last call (16 -- worse).  NOTE 0x1789A34 == 24681012
         *    decimal == the digits 2,4,6,8,10,12 -- EA's source almost surely
         *    spelled it in decimal as the joke; codegen-neutral either way.
         *  - inline wrappers (5): magic from static inline; inline void doing
         *    the store; inline int doing store+return-1 (semantically THIS
         *    tail, still 10 -- gcc-2.8's RTL inliner leaves no boundary that
         *    survives to sched1); result-via-local variants.
         *  - asm-formed magic (3): lui/ori insert (volatile and not), ori-half
         *    insert.  An asm is NOT a scheduling boundary -- the li hoists
         *    around it.
         *  - own parameter list (7): unused 4th / 4th+5th params (gcc-2.8
         *    allocates NO pseudo for an unread param, so numbering does not
         *    shift), int/unsigned swaps, cb as fn-pointer, K&R definition.
         *    Oracle callers set exactly a0..a2 -- no real 4th arg either.
         *  - compiler flags (~20): -fno-schedule-insns{,2} (10/13 AND wreck the
         *    TU to 1/7 -- the lib was built with sched ON), -fno-delayed-branch
         *    20, -fforce-addr 31 on the InitEventQueue twin, -fno-thread-jumps /
         *    -fno-peephole / -fforce-mem / -fno-function-cse / -fcaller-saves /
         *    -fno-defer-pop / -fno-cse-follow-jumps / -fno-cse-skip-blocks /
         *    -fno-strength-reduce / -fno-rerun-cse-after-loop all neutral,
         *    -fno-expensive-optimizations 12; -G0 vs -G4 neutral here.
         *  - compiler versions: full FSF ladder (2.6.0..2.95.2) -- every 2.8.x
         *    and 2.7.2-970404 give the same 10; SN builds psq40 (2.7.2.SN32.3.7
         *    Build 0001) and psq41 (cygnus-2.7.2-970404 SN32.3.7.0004) behave
         *    IDENTICALLY to their FSF twins.  UNTESTED: psq42's cc1 (a 2.8.0 SN
         *    with a build number other than psq43's 4.0.0007) -- the LAST
         *    remaining compiler candidate.
         *  - file position: +0..+14 blank lines before the fn -- no effect.
         * PERMUTER (950 iters): only found the banned do{}while(0) barrier (70)
         * and a semantically WRONG order (60, store moved after return).
         * => same cc1 + same dep graph is deterministic, so retail's tail graph
         * differed in some way not covered above, OR psq42's sched tie-break
         * differs.  If psq42 ever turns up, test it first. */
        static void *spchInitBoundary_ = &&spch_live;
        iSPCH_InitEventQueue();
spch_live: ;
        gSPCH_Initialized = 0x1789a34;
        return 1;
    }
}

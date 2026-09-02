/* eaclib/psx/spchpsxz/spchbank.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 8/8 ***
 *   Source obj : nfs4\eaclib\psx\spchbank.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   8 fns @[0x800EB1E0 .. 0x800EB520].  The speech bank table -- allocate/free the gVoxBanks[] pointer array,
 *   find a free or matching slot, test sub-bank bounds, and assign cycle bits for a game/race number.
 *   Ghidra nfs4-f.exe.c (spchbank) + disasm-v3 + IDA sigs.
 *
 *   Ghidra-isms resolved: iSPCH_GetFreeBank / iSPCH_FindBank were void-typed but RETURN an int index (their
 *   callers read v0; FindBank's return = the loop index set in the branch delay slot, -1 if no match;
 *   FindBank's `this` is the search key).  SetCycleBits' 2nd param and SPCH_AddBank's `in_a1` are a phantom
 *   uninitialised register (IDA: SetCycleBits is 1-arg) -> dropped.
 */

#include "../eaclib_types.h"

extern int *gVoxBanks;  /* @~0x801370B4 : the bank-handle array (int[gNumBanks]) -- a real array, heap-allocated
                         * by iSPCH_BankMemAlloc; this one word holds its base (honest pointer type, 2026-09-02) */
extern int gNumBanks;  /* @0x801370B8  : number of bank slots */
extern int gGameNum;   /* spchinit @0x80148428 : current game/race number (cycle-bit hash key) */

extern int *iSPCH_MemAlloc(int numBytes, const char *tag); /* spchinit; returns the allocated ptr (0 = failed) */
extern void iSPCH_MemFree(int *block);     /* spchinit; release body ignores the arg but call sites
                                            * still pass the freed block (nullsub-takes-real-args) */
extern char *iSPCH_GetBankBits(char *bank);   /* spchpick (returns the bank's cycle-bits array) */
//extern void trap(unsigned int code);
extern void  iSPCH_InitBanks(void);                         /* @0x800EB1E0 */
extern void  iSPCH_DisposeBanks(void);                      /* @0x800EB1F4 */
extern int  *iSPCH_BankMemAlloc(int numBanks);              /* @0x800EB234 : returns gVoxBanks */
extern int   iSPCH_GetFreeBank(void);                       /* @0x800EB2B8 */
extern int   iSPCH_FindBank(unsigned short key);                       /* @0x800EB310 */
extern bool iSPCH_TestSubBankBounds(int bankIdx, int subIdx); /* @0x800EB37C */
extern void  iSPCH_SetCycleBits(char *p);                   /* @0x800EB3C8 */
extern int   SPCH_AddBank(char *bank);                        /* @0x800EB520 */

/* iSPCH_InitBanks @0x800EB1E0 : clear the bank table (no allocation yet). */
extern void iSPCH_InitBanks(void)
{
    gVoxBanks = 0;
    gNumBanks = 0;
}

/* iSPCH_DisposeBanks @0x800EB1F4 : free the bank array (if any) and clear the table. */
extern void iSPCH_DisposeBanks(void)
{
    if(gVoxBanks)
        iSPCH_MemFree(gVoxBanks);

    gVoxBanks = 0;
    gNumBanks = 0;
}

/* iSPCH_BankMemAlloc @0x800EB234 : allocate gVoxBanks[numBanks] (once) and zero it.  Returns gVoxBanks.
 * FLOOR (w29-a6, 2026-07-26; 4 diffs, 33/33 exact insn parity): oracle schedules `sw ra,24(sp)` BEFORE
 * the `bnez v0,T` test and fills the branch's delay slot with `sw s1,20(sp)` (nb's callee-save); ours
 * has the two swapped (s1-save before the branch, ra-save in the delay slot) -- same 33 insns, same
 * s0=vb/s1=nb coloring, just the two saves trade places around the branch.  Tried+reverted: moving
 * `int *nb = gNumBanks;` inside the `if` (its true point of first use) and dropping it in favor of
 * direct `gNumBanks[0]` indexing both regress to 16 diffs (flips s0<->s1 across the WHOLE function --
 * the top-level vb/nb declaration order+scope is load-bearing for the coloring, not for this tie);
 * swapping vb/nb declaration order likewise regresses to 16; `nb[0]=` vs `*nb=` is a no-op. Two ready,
 * independent callee-saves competing for one delay slot -- same negative-result class as
 * reference_asm_pattern_catalog.md's svol.cpp:18 ("source order irrelevant"). Do not re-attempt
 * without a genuinely new lever. */
/* iSPCH_BankMemAlloc RESIDUAL 4 diffs at exact insn parity 33/33 -- FLOOR RE-VERDICT (w33-a10).
 * Every instruction matches except the ORDER of three prologue register saves around the first
 * branch: retail `sw $ra,0x18($sp); bnez $v0; sw $s1,0x14($sp)(delay); lui $s1,%hi(gNumBanks)`
 * vs ours `sw s1; lui s1; bnez; sw ra(delay)`. Same instructions, different slot assignment --
 * prologue-store scheduling, not a source shape. Probes: per-fn -fno-delayed-branch 4 -> 23;
 * -mno-split-addresses 4 -> 13. No SLD exists for this TU (see spchevnt.c).
 * PROTOTYPE AUDIT: 1 arg ($a0 = bank count, stored to gNumBanks); returns gVoxBanks re-loaded
 * at the shared exit, so the non-void return is real and shared by all four exit paths.
 * w34-a9: one more falsified lever -- SPLITTING the declaration from the initialiser
 * (`int *nb;` at the top, `nb = gNumBanks;` inside the `if`, so the pseudo is created in
 * the same order but the `lui %hi(gNumBanks)` sinks into the if-body where retail has it)
 * gives the SAME 16-diff whole-function $s0<->$s1 flip as moving the whole declaration
 * in: the flip is driven by the INIT position (which sets the live length), not by the
 * declaration position.  Mechanism restated: retail's `lui $s1,%hi(gNumBanks)` sits AFTER
 * the branch, so `sw $s1,0x14($sp)` is the last insn before it and dbr takes THAT for the
 * delay slot; ours materialises the address before the branch, so `sw $ra` is the nearest
 * fillable insn.  Any spelling that sinks the lui also shortens nb's live range and hands
 * it $s0.  Unchanged verdict: 4 diffs at exact 33/33 parity.
 * w49-a9: the w47 OPACITY FENCE was aimed straight at w34-a9's mechanism ("sink
 * the lui WITHOUT shortening nb's live range") -- FALSIFIED, all measured:
 *   - `int *nb;` at top + `nb = gNumBanks;` inside the `if` (the lui sinks, as
 *     designed) + N zero-insn opacity fences on `nb` to buy back its allocno
 *     priority: N=0 -> 16 (the known $s0<->$s1 flip), N=1..4 -> 17 at 34 insns
 *     (the fence forces a real copy on a cross-block allocno, +1 insn);
 *   - same sunk-lui form with the fences on `vb` instead (dial the RIVAL, w46
 *     RAZOR-ON-THE-RIVAL): N=1..3 -> 7 diffs BUT 36 insns -- the fence splits
 *     the `lui/lw` self-temp into `lui; addiu; lw` (+3).  Lower diff count,
 *     LOST insn parity => rejected under the floor bar (count must stay exact).
 * So the fence family reaches the flip but never at parity; the tie stays a
 * dbr "two ready callee-saves competing for one slot".
 * ✅ w50-a9 2026-08-09: SOLVED -- PASS 33/33, and the whole floor above is retired.  The w49 note
 * had the mechanism exactly right and only the INSTRUMENT wrong: it needed a priority buy-back on
 * the RIVAL that costs ZERO instructions, and the fence family cannot do that (every fence form
 * either mints a copy on a cross-block allocno, +1 insn, or splits a lui/lw self-temp, +3).  The
 * catalog w44 inflator #3 -- the `do{}while(0)` DEPTH WRAPPER -- is exactly that instrument:
 *   1. split `nb`'s declaration from its initialiser so the `lui %hi(gNumBanks)` sinks BELOW the
 *      branch (w34-a9's mechanism; alone this is the known 16-diff $s0<->$s1 whole-fn flip), and
 *   2. wrap the RIVAL `vb`'s store `do { *vb = allocated; } while (0);` -- zero insns, but the
 *      loop-depth weighting lifts vb's refs back over nb's and the pair lands retail's way.
 * Depths 1, 2 and 3 all PASS (33 insns each); depth 1 is kept as the minimal form.  Falsified on
 * the way (all at 33/33): the same wrapper on nb's uses at depth 1/2/3 = 16 (it lifts the LOSER),
 * and `return vb[0];` as a cheap vb-ref inflator = 10 diffs at 35 insns (it also removes retail's
 * epilogue re-load of gVoxBanks).  LESSON for the sibling floors in this cluster: when a receipt
 * says "the fence reaches the goal but never at parity", the missing piece is a ZERO-COST ref
 * inflator, and the rival is usually the right side to dial. */
extern int *iSPCH_BankMemAlloc(int numBanks)
{
    int **vb = &gVoxBanks;
    int  *nb;
    if (*vb == 0) {
        int *allocated;
        /* MATCH (w50-a9): nb's `lui %hi(gNumBanks)` must sink BELOW the branch so `sw $s1`
         * is dbr's nearest fillable insn (w34-a9's mechanism) -- hence the SPLIT declaration
         * (init here, at nb's first use).  On its own that flips $s0<->$s1 across the whole
         * function (16 diffs); the zero-insn do{}while(0) DEPTH WRAPPER on the RIVAL `vb`'s
         * store (catalog w44 inflator #3, w46 razor-on-the-rival) buys vb back its allocno
         * priority at ZERO instructions -- where the w49 opacity fences reached 7 diffs but
         * cost +3 insns (lui/addiu/lw split) and lost parity.  Depth 1/2/3 all PASS; depth 1
         * kept as the minimal form.  DO NOT delete the wrapper or re-fuse the declaration. */
        nb = &gNumBanks;
        *nb = numBanks;
        allocated = iSPCH_MemAlloc(numBanks * 4, "spch banks");
        do { *vb = allocated; } while (0);   /* MATCH: unconditional store -> beqz delay slot */
        if (allocated) {
            int i = 0;
            numBanks = *nb;   /* MATCH: reload reuses the dead param reg ($a0) */
            if (numBanks > 0) {
                int bound = numBanks;
                numBanks = allocated;   /* reuse the dead numBanks/$a0 reg as the walking pointer */
                do {
                    *(int *)numBanks = 0;
                    i++;
                    numBanks += 4;
                } while (i < bound);
            }
        }
    }
    return gVoxBanks;
}

/* iSPCH_GetFreeBank @0x800EB2B8 : index of the first empty (NULL) bank slot, or -1 if none/no table. */
extern int iSPCH_GetFreeBank(void)
{
    int result = -1;
    int i;
    
    for(i = 0; i < gNumBanks; i++) {
        if(gVoxBanks[i] == NULL) {
            result = i;
            break;
        }
    }

    return result;
}

/* iSPCH_FindBank @0x800EB310 : index of the bank whose id (first u16 of its data) matches `key & 0xffff`,
 *   or -1 if not found. */
extern int iSPCH_FindBank(unsigned short key)
{
    int i;

    if(gVoxBanks) {
        for(i = 0; i < gNumBanks; i++) {
            if(gVoxBanks[i] && *(unsigned short *)gVoxBanks[i] == key)
                return i;
        }
    }

    return -1;
}

/* iSPCH_TestSubBankBounds @0x800EB37C : 1 if sub-index `subIdx` is in range [0, count) for bank `bankIdx`
 *   (where count = the bank's u16 at +6, and != 0xffff), else 0. */
extern bool iSPCH_TestSubBankBounds(int bankIdx, int subIdx)
{
    bool result = false;

    if (gVoxBanks) {
        if (bankIdx >= 0) {
            unsigned short *bank;

            bank = gVoxBanks[bankIdx];
            if (bank[3] != 0xffff) {
                if (subIdx >= 0) {
                    result = subIdx < bank[3];
                }
            }
        }
    }

    return result;
}

/* iSPCH_SetCycleBits @0x800EB3C8 : for bank `p`, set the run of cycle bits that this game number (gGameNum)
 *   maps to within the bank's GetBankBits() array.  The (n==0)/(n==-1 && dividend==INT_MIN) checks are the
 *   compiler's signed-division traps.  True contract is void (matching eaclib.h and all callers).
 *   MATCH (86/86): under the library-wide -G0 (build.py PER_TU_FLAGS) the plain scalar gGameNum gets the
 *   split lui/lw address pair, whose `lui` fills the initial `blez` delay slot -- the old unsized-array
 *   declaration was only a -G4 workaround for the same effect (retired 2026-09-02). */
extern void iSPCH_SetCycleBits(char *p)
{
    char *bits;
    int   nGroups;
    int   startBit, count, byteIdx, bitInByte;
    int   t1, t2, t3, i;

    bits    = iSPCH_GetBankBits(p);
    nGroups = *bits;
    if (nGroups > 0) {
        t1       = (gGameNum % nGroups) * p[3];
        startBit = t1 / nGroups;
        t2       = (gGameNum % nGroups + 1) * p[3];
        count    = t2 / nGroups - startBit;
        t3       = startBit;
        if (startBit < 0)
            t3 = startBit + 7;
        {
            int shifted = t3 >> 3;
            byteIdx   = shifted + 1;
            bitInByte = startBit + shifted * -8;
        }

        for(i = 0; i < count; i++) {
            unsigned char mask = 1u << bitInByte;
            bitInByte++;
            bits[byteIdx] |= mask;
            if (bitInByte == 8) {
                bitInByte = 0;
                byteIdx++;
             }
        }
    }
}

/* SPCH_AddBank @0x800EB520 : place bank `bank` into the first free slot (setting its cycle bits first if the
 *   bank's flags byte +2 has any high nibble).  Returns the slot index, or -1 if the table is full/uninit. */
//extern int SPCH_AddBank(int bank)
extern int SPCH_AddBank(char *bank)
{
    int slot = -1;

    if (gVoxBanks) {
        slot = iSPCH_GetFreeBank();
        if (slot > -1) {
            if (bank[2] & 0xf0)
                iSPCH_SetCycleBits(bank);
            gVoxBanks[slot] = bank;
        }
    }
    
    return slot;
}

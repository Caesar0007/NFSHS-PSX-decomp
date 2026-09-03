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
#include "spch_types.h"

extern VoxBank **gVoxBanks; /* @~0x801370B4 : heap array of gNumBanks VoxBank pointers, allocated by
                             * iSPCH_BankMemAlloc (fully typed 2026-09-04) */
extern int gNumBanks;  /* @0x801370B8  : number of bank slots */
extern int gGameNum;   /* spchinit @0x80148428 : current game/race number (cycle-bit hash key) */

extern void *iSPCH_MemAlloc(int numBytes, const char *tag); /* spchinit; returns the allocated ptr (0 = failed) */
extern void iSPCH_MemFree(void *block);    /* spchinit; release body ignores the arg but call sites
                                            * still pass the freed block (nullsub-takes-real-args) */
extern char *iSPCH_GetBankBits(VoxBank *bank); /* spchpick (returns the bank's cycle-bits array) */
extern void  iSPCH_InitBanks(void);                         /* @0x800EB1E0 */
extern void  iSPCH_DisposeBanks(void);                      /* @0x800EB1F4 */
extern VoxBank **iSPCH_BankMemAlloc(int numBanks);          /* @0x800EB234 : returns gVoxBanks */
extern int   iSPCH_GetFreeBank(void);                       /* @0x800EB2B8 */
extern int   iSPCH_FindBank(unsigned short key);                       /* @0x800EB310 */
extern bool iSPCH_TestSubBankBounds(int bankIdx, int subIdx); /* @0x800EB37C */
extern void  iSPCH_SetCycleBits(VoxBank *bank);             /* @0x800EB3C8 */
extern int   SPCH_AddBank(VoxBank *bank);                     /* @0x800EB520 */

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
 * ✅ SEALED SOURCE-ONLY (2026-09-04, user's hand-written form): PASS 33/33 as plain textbook C.
 * DIRECT GLOBAL ACCESS is the lever (same family as spchevnt's indexed-addressing seal): the
 * `gNumBanks * 4` argument re-reads the global (retail's reload), the indexed `gVoxBanks[i] =
 * NULL` walk gives loop.c its own giv walker, and no pointer carriers exist for REG_EQUIV /
 * combine_regs to eat.  This retires the ENTIRE w29..w50 device stack (split nb declaration,
 * depth-1 do{}while(0) wrapper on the rival store, dead-param-reg walker, &gVoxBanks carriers)
 * -- all of it was compensation for the carrier-pointer spelling; see git history of this
 * comment for the full floor archaeology. */
extern VoxBank **iSPCH_BankMemAlloc(int numBanks)
{
    if(!gVoxBanks) {
        gNumBanks = numBanks;
        gVoxBanks = iSPCH_MemAlloc(gNumBanks * sizeof(VoxBank *), "spch banks");
        if (gVoxBanks) {
            int i;
            for(i = 0; i < gNumBanks; i++) {
                gVoxBanks[i] = NULL;
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
            if(gVoxBanks[i] && gVoxBanks[i]->id == key)
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
            VoxBank *bank;

            bank = gVoxBanks[bankIdx];
            if (bank->subBankCount != 0xffff) {
                if (subIdx >= 0) {
                    result = subIdx < bank->subBankCount;
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
extern void iSPCH_SetCycleBits(VoxBank *bank)
{
    char *bits;
    int   nGroups;
    
    bits    = iSPCH_GetBankBits(bank);
    nGroups = *bits;
    if (nGroups > 0) {
        int startBit, count, shifted, byteIdx, bitInByte;
        int i;

        startBit  = (gGameNum % nGroups) * bank->numSamples / nGroups;
        count     = (gGameNum % nGroups + 1) * bank->numSamples / nGroups - startBit;
        shifted   = startBit / 8;
        byteIdx   = shifted + 1;
        bitInByte = startBit % 8;

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
extern int SPCH_AddBank(VoxBank *bank)
{
    int slot = -1;

    if (gVoxBanks) {
        slot = iSPCH_GetFreeBank();
        if (slot > -1) {
            if (bank->flags & 0xf0)
                iSPCH_SetCycleBits(bank);
            gVoxBanks[slot] = bank;
        }
    }
    
    return slot;
}

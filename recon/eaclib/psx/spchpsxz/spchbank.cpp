/* eaclib/psx/spchpsxz/spchbank.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 8/8 ***
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

extern "C" int gVoxBanks[]; /* @~0x801370B4 : base of the bank pointer array (int[gNumBanks]) */
extern "C" int gNumBanks[]; /* @0x801370B8  : number of bank slots */
extern "C" int gGameNum;    /* shared game global : current game/race number (cycle-bit hash key) */
extern "C" int DAT_80150000;/* @0x80150000  : SetCycleBits default-return placeholder */

extern "C" int  iSPCH_MemAlloc(int numBytes, const char *tag); /* spchinit; returns the allocated ptr (0 = failed) */
extern "C" void iSPCH_MemFree(void);           /* spchinit */
extern "C" int  iSPCH_GetBankBits(int bank);   /* spchpick (returns the bank's cycle-bits array) */
extern "C" void trap(unsigned int code);

extern "C" void  iSPCH_InitBanks(void);                         /* @0x800EB1E0 */
extern "C" void  iSPCH_DisposeBanks(void);                      /* @0x800EB1F4 */
extern "C" int   iSPCH_BankMemAlloc(unsigned int numBanks);     /* @0x800EB234 */
extern "C" int   iSPCH_GetFreeBank(void);                       /* @0x800EB2B8 */
extern "C" int   iSPCH_FindBank(int key);                       /* @0x800EB310 */
extern "C" unsigned int iSPCH_TestSubBankBounds(int bankIdx, int subIdx); /* @0x800EB37C */
extern "C" int  *iSPCH_SetCycleBits(int *p);                    /* @0x800EB3C8 */
extern "C" int   SPCH_AddBank(int bank);                        /* @0x800EB520 */

/* iSPCH_InitBanks @0x800EB1E0 : clear the bank table (no allocation yet). */
extern "C" void iSPCH_InitBanks(void)
{
    gVoxBanks[0] = 0;
    gNumBanks[0] = 0;
}

/* iSPCH_DisposeBanks @0x800EB1F4 : free the bank array (if any) and clear the table. */
extern "C" void iSPCH_DisposeBanks(void)
{
    int *banks = gVoxBanks;   /* hold base across the MemFree call (oracle keeps &gVoxBanks in s0) */
    if (banks[0] != 0)
        iSPCH_MemFree();
    banks[0] = 0;
    gNumBanks[0] = 0;
}

/* iSPCH_BankMemAlloc @0x800EB234 : allocate gVoxBanks[numBanks] (once) and zero it.  Returns gVoxBanks. */
extern "C" int iSPCH_BankMemAlloc(unsigned int numBanks)
{
    if (gVoxBanks[0] == 0) {
        int allocated;
        gNumBanks[0] = numBanks;
        allocated = iSPCH_MemAlloc(numBanks << 2, "spch banks");
        if (allocated != 0) {
            gVoxBanks[0] = allocated;
            if (0 < gNumBanks[0]) {
                int i = 0;
                int *p = (int *)allocated;
                int n = gNumBanks[0];
                do {
                    *p = 0;
                    i++;
                    p++;
                } while (i < n);
            }
        }
    }
    return gVoxBanks[0];
}

/* iSPCH_GetFreeBank @0x800EB2B8 : index of the first empty (NULL) bank slot, or -1 if none/no table. */
extern "C" int iSPCH_GetFreeBank(void)
{
    int result = -1;
    if (0 < gNumBanks[0]) {
        int count = gNumBanks[0];
        int  i = 0;
        int *p = (int *)gVoxBanks[0];
        do {
            if (*p == 0) {
                result = i;
                goto done;
            }
            i++;
            p++;
        } while (i < count);
    }
done:
    return result;
}

/* iSPCH_FindBank @0x800EB310 : index of the bank whose id (first u16 of its data) matches `key & 0xffff`,
 *   or -1 if not found. */
extern "C" int iSPCH_FindBank(int key)
{
    if (gVoxBanks[0] != 0 && 0 < gNumBanks[0]) {
        int  i = 0;
        int *p = (int *)gVoxBanks[0];
        key = key & 0xffff;
        do {
            int bankPtr = *p;
            if (bankPtr != 0 && (unsigned int)*(unsigned short *)bankPtr == (unsigned int)key)
                return i;
            i++;
            p++;
        } while (i < gNumBanks[0]);
    }
    return -1;
}

/* iSPCH_TestSubBankBounds @0x800EB37C : 1 if sub-index `subIdx` is in range [0, count) for bank `bankIdx`
 *   (where count = the bank's u16 at +6, and != 0xffff), else 0. */
extern "C" unsigned int iSPCH_TestSubBankBounds(int bankIdx, int subIdx)
{
    int          base = gVoxBanks[0];
    unsigned int result = 0;
    unsigned int count;
    if (base == 0)         goto ret;
    if (bankIdx < 0)       goto ret;
    count = *(unsigned short *)(*(int *)(bankIdx * 4 + base) + 6);
    if (count == 0xffff)   goto ret;
    if (subIdx < 0)        goto ret;
    result = (unsigned int)(subIdx < (int)count);
ret:
    return result;
}

/* iSPCH_SetCycleBits @0x800EB3C8 : for bank `p`, set the run of cycle bits that this game number (gGameNum)
 *   maps to within the bank's GetBankBits() array.  The (n==0)/(n==-1 && dividend==INT_MIN) checks are the
 *   compiler's signed-division traps.  Return value is a leftover pointer (callers ignore it). */
extern "C" int *iSPCH_SetCycleBits(int *p)
{
    unsigned char *bits;
    int           *ret;
    unsigned int   nGroups;
    int            startBit, count, byteIdx, bitInByte;
    int            t, i;

    bits    = (unsigned char *)iSPCH_GetBankBits((int)p);
    nGroups = (unsigned int)*bits;
    ret     = (int *)&DAT_80150000;
    if (nGroups != 0) {
        t        = ((int)gGameNum % (int)nGroups) * (int)(unsigned int)*(unsigned char *)((int)p + 3);
        startBit = t / (int)nGroups;
        t = ((int)gGameNum % (int)nGroups + 1) * (int)(unsigned int)*(unsigned char *)((int)p + 3);
        count   = t / (int)nGroups - startBit;
        t       = startBit;
        if (startBit < 0)
            t = startBit + 7;
        t        = t >> 3;
        byteIdx  = t + 1;
        ret      = (int *)(t * 8);
        bitInByte = startBit + t * -8;
        i = 0;
        if (0 < count) {
            do {
                unsigned int b = (unsigned int)bitInByte & 0x1f;
                bitInByte = bitInByte + 1;
                bits[byteIdx] = bits[byteIdx] | (unsigned char)(1 << b);
                if (bitInByte == 8) {
                    bitInByte = 0;
                    byteIdx = byteIdx + 1;
                }
                i = i + 1;
                ret = (int *)0x0;
            } while (i < count);
        }
    }
    return ret;
}

/* SPCH_AddBank @0x800EB520 : place bank `bank` into the first free slot (setting its cycle bits first if the
 *   bank's flags byte +2 has any high nibble).  Returns the slot index, or -1 if the table is full/uninit. */
extern "C" int SPCH_AddBank(int bank)
{
    int slot = -1;
    if (gVoxBanks[0] != 0) {
        slot = iSPCH_GetFreeBank();
        if (-1 < slot) {
            if ((*(unsigned char *)(bank + 2) & 0xf0) != 0)
                iSPCH_SetCycleBits((int *)bank);
            *(int *)(slot * 4 + gVoxBanks[0]) = bank;
        }
    }
    return slot;
}

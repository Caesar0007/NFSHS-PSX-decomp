/* eaclib/psx/sndpsxz/sbadd.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbadd.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7DEC.  SNDbankadd -- register a new sound bank: allocate a slot, record its data pointer
 *   in the bank table, install the exit-time bank-remove hook, and download it to SPU.
 *   Ghidra nfs4-f.exe.c (sbadd) + disasm: a2 is the bank DATA pointer (passed twice to iSNDdownloadbank),
 *   a1 is the output slot pointer; iSNDbankalloc returns the slot (Ghidra void-typed it).
 */

extern int sndgs[];
extern int  iSNDbankalloc(void);                  /* sballoc */
extern void SNDbankremove(void);                  /* sbremove (the @0x80147860[0x1f] exit hook) */
extern int  iSNDdownloadbank(int bankData, int bankData2);   /* sbdload */

extern int SNDbankadd(int *bank_out, int bankData);   /* @0x800E7DEC */

/* SNDbankadd @0x800E7DEC : add the bank at `bankData`, writing its slot id to *bank_out.  Returns the
 *   download result, or -10 if audio is down. */
extern int SNDbankadd(int *bank_out, int bankData)
{
    int  slot;
    int *e;
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    slot = iSNDbankalloc();
    *bank_out = slot;
    e = (int *)(sndgs[0x26] + slot * 0xc);
    e[0] = bankData;
    e[1] = bankData;
    sndgs[0x1f] = (int)SNDbankremove;
    return iSNDdownloadbank(bankData, bankData);
}

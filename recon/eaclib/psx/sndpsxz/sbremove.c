/* eaclib/psx/sndpsxz/sbremove.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   Source obj : nfs4\eaclib\psx\sbremove.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   3 fns @[0x800E65F8 .. 0x800E6694].  Unload sound banks: stop their voices, release SPU data, clear the
 *   bank table.  Ghidra nfs4-f.exe.c (sbremove) + IDA sigs (`this` is the bank id).
 */

extern int sndgs[];
extern int  iSNDvalidbank(int bankId);                 /* sbvalid  */
extern int  SNDstop(unsigned int tag);                 /* sstop    */
extern void iSNDbankremovepat(int bank, int idx, int *scratch);  /* sbirmpat */
extern void iSNDplatformfree(void *p);                 /* sdata    */

extern int  iSNDremovepatches(int bank, int count);    /* @0x800E65F8 */
extern void SNDbankremove(int bankId);                 /* @0x800E6674 */
extern void cSNDbankremove(int bankId, int recurse);   /* @0x800E6694 ; a1 always 0 at every call */

/* iSNDremovepatches @0x800E65F8 : release each of a bank's `count` resolved patches (de-dup via a local
 *   scratch table seeded to -1). */
extern int iSNDremovepatches(int bank, int count)
{
    int scratch[512];
    int *p;
    int i;
    int neg1 = -1;
    i = 0xFF;
    p = &scratch[510];
    do {                                 /* seed the {id} slots to -1, back to front */
        *p = neg1;
        i--;
        p -= 2;
    } while (i >= 0);
    for (i = 0; i < count; i++)
        iSNDbankremovepat(bank, i, scratch);
    return 0;
}

/* cSNDbankremove @0x800E6694 : unload bank `bankId` (or all banks when bankId == -1) -- stop its playing
 *   voices, free its patches/SPU data, and clear its bank-table entry. */
extern void cSNDbankremove(int bankId, int recurse)
{
    (void)recurse;
    if ((char)sndgs[0xf] == 0)
        return;
    if (bankId == -1) {                  /* unload every bank */
        int b;
        for (b = 0; b < (int)(unsigned)(unsigned short)sndgs[3]; b++)
            cSNDbankremove(b, 0);
        return;
    }
    if (iSNDvalidbank(bankId) == 0) {
        int data = *(int *)(bankId * 0xc + sndgs[0x26]);
        int i = 0, off, e;
        if (((unsigned char *)sndgs)[0x11] != 0) {     /* stop voices owned by this bank */
            off = 0;
            do {
                if ((int)*(char *)(sndgs[0x25] + off + 10) == bankId)
                    SNDstop(*(unsigned int *)(sndgs[0x25] + off));
                i++;
                off += 100;
            } while (i < (int)(unsigned)((unsigned char *)sndgs)[0x11]);
        }
        e = bankId * 0xc + sndgs[0x26];
        if (*(char *)(e + 9) == 0)
            iSNDremovepatches(bankId, (int)(unsigned)*(unsigned short *)(data + 6));
        else {
            iSNDplatformfree(*(void **)(e + 4));
            *(unsigned char *)(bankId * 0xc + sndgs[0x26] + 9) = 0;
        }
        *(int *)(bankId * 0xc + sndgs[0x26]) = 0;
        *(unsigned char *)(bankId * 0xc + sndgs[0x26] + 8) = 0;
    }
}

/* SNDbankremove @0x800E6674 : the exit-time hook (sndgs[0x1f]); unloads bank `bankId`. */
extern void SNDbankremove(int bankId)
{
    cSNDbankremove(bankId, 0);
}

/* eaclib/psx/sndpsxz/sbremove.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   Source obj : nfs4\eaclib\psx\sbremove.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   3 fns @[0x800E65F8 .. 0x800E6694].  Unload sound banks: stop their voices, release SPU data, clear the
 *   bank table.  Ghidra nfs4-f.exe.c (sbremove) + IDA sigs (`this` is the bank id).
 */

extern "C" int sndgs[];
extern "C" int  iSNDvalidbank(int bankId);                 /* sbvalid  */
extern "C" int  SNDstop(unsigned int tag);                 /* sstop    */
extern "C" void iSNDbankremovepat(int bank, int idx, int *scratch);  /* sbirmpat */
extern "C" void iSNDplatformfree(void *p);                 /* sdata    */

extern "C" int  iSNDremovepatches(int bank, int count);    /* @0x800E65F8 */
extern "C" void SNDbankremove(int bankId);                 /* @0x800E6674 */
extern "C" void cSNDbankremove(int bankId);                /* @0x800E6694 */

/* iSNDremovepatches @0x800E65F8 : release each of a bank's `count` resolved patches (de-dup via a local
 *   scratch table seeded to -1). */
extern "C" int iSNDremovepatches(int bank, int count)
{
    int scratch[512];
    int i;
    for (i = 0; i < 512; i += 2)         /* seed the {id} slots to -1 */
        scratch[i] = -1;
    for (i = 0; i < count; i++)
        iSNDbankremovepat(bank, i, scratch);
    return 0;
}

/* cSNDbankremove @0x800E6694 : unload bank `bankId` (or all banks when bankId == -1) -- stop its playing
 *   voices, free its patches/SPU data, and clear its bank-table entry. */
extern "C" void cSNDbankremove(int bankId)
{
    if ((char)sndgs[0xf] == 0)
        return;
    if (bankId == -1) {                  /* unload every bank */
        int b;
        for (b = 0; b < (int)(unsigned)(unsigned short)sndgs[3]; b++)
            cSNDbankremove(b);
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
extern "C" void SNDbankremove(int bankId)
{
    cSNDbankremove(bankId);
}

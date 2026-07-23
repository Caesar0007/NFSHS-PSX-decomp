/* eaclib/psx/sndpsxz/sbremove.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   Source obj : nfs4\eaclib\psx\sbremove.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   3 fns @[0x800E65F8 .. 0x800E6694].  Unload sound banks: stop their voices, release SPU data, clear the
 *   bank table.  Ghidra nfs4-f.exe.c (sbremove) + IDA sigs (`this` is the bank id).
 */

struct SNDGlobals {
    char pad0[0x0c];
    unsigned short bank_count;
    char pad0e[3];
    unsigned char channel_count;
    char pad12[0x2a];
    signed char initialized;
    char pad3d[0x57];
    int play_records;
    int bank_table;
};
struct SNDBankEntry {
    int data;
    void *platform_data;
    unsigned char loaded;
    signed char platform_allocated;
    char pad[2];
};
extern struct SNDGlobals sndgs;
extern int  iSNDvalidbank(int bankId);                 /* sbvalid  */
extern int  SNDstop(unsigned int tag);                 /* sstop    */
extern void iSNDbankremovepat(int bank, int idx, int *scratch);  /* sbirmpat */
extern void iSNDplatformfree(void *p);                 /* sdata    */

extern int  iSNDremovepatches(int bank, int count);    /* @0x800E65F8 */
extern void SNDbankremove(int bankId);                 /* @0x800E6674 */
extern int  cSNDbankremove(int bankId, int recurse);   /* @0x800E6694 ; a1 always 0 at every call */

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
extern int cSNDbankremove(int bankId, int recurse)
{
    struct SNDGlobals *base = &sndgs;
    int i;

    if (base->initialized == 0)
        return -10;
    if (bankId == -1) {                  /* unload every bank */
        for (i = 0; i < (int)(unsigned)base->bank_count; i++)
            cSNDbankremove(i, 0);
        return 0;
    }
    if (iSNDvalidbank(bankId) != 0)
        return -8;
    {
        int data = *(int *)(bankId * 0xc + base->bank_table);
        int off;
        struct SNDBankEntry *entry;
        struct SNDGlobals *base2;
        i = 0;
        if (base->channel_count != 0) {     /* stop voices owned by this bank */
            struct SNDGlobals *loopbase = base;
            off = 0;
            do {
                if ((int)*(signed char *)(loopbase->play_records + off + 10) == bankId)
                    SNDstop(*(unsigned int *)(loopbase->play_records + off));
                off += 100;
            } while ((int)(unsigned)loopbase->channel_count > ++i);
        }
        base2 = &sndgs;
        entry = (struct SNDBankEntry *)(bankId * 0xc +
            *(volatile int *)&base2->bank_table);
        if (entry->platform_allocated != 0) {
            iSNDplatformfree(entry->platform_data);
            *(unsigned char *)(bankId * 0xc + sndgs.bank_table + 9) = 0;
        } else
            iSNDremovepatches(bankId, (int)(unsigned)*(unsigned short *)(data + 6));
        *(int *)(bankId * 0xc + sndgs.bank_table) = 0;
        *(unsigned char *)(bankId * 0xc + sndgs.bank_table + 8) = 0;
    }
    return 0;
}

/* SNDbankremove @0x800E6674 : the exit-time hook (sndgs[0x1f]); unloads bank `bankId`. */
extern void SNDbankremove(int bankId)
{
    cSNDbankremove(bankId, 0);
}

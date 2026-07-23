/* eaclib/psx/sndpsxz/sbdload.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbdload.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010266C.  iSNDdownloadbank -- resolve (DMA to SPU) every patch in a bank, rebasing each
 *   patch's self-relative pointer to an absolute address.  Ghidra nfs4-f.exe.c (sbdload).
 *
 *   Patch ptrs are stored as offsets relative to their own field (+0x14 for bank type 4, else +0xc):
 *   abs = fieldAddr + offset.
 */

extern int iSNDresolvetaggedpatch(int bank, int patch_idx, int scratch);   /* stagpat */

extern int iSNDdownloadbank(int bankData, int patchData);   /* @0x8010266C */

/* iSNDdownloadbank @0x8010266C : rebase + resolve all patches of the bank at `bankData`.  Returns 7 (all
 *   ok) or 8 (a patch failed). */
extern int iSNDdownloadbank(int bankData, int patchData)
{
    int *ptr2, *ptr4;
    int scratch[512];
    int i;
    int ret = 7;
    int anchor, type4, off2, off4;

    i = 0xff;
    do {
        scratch[i * 2] = -1;
        i--;
    } while (i >= 0);

    anchor = bankData;
    if (*(unsigned short *)(bankData + 6) != 0) {
        ptr2 = (int *)bankData;
        i = 0;
        type4 = 4;
        off2 = 0xc;
        off4 = 0x14;
        ptr4 = (int *)bankData;
        do {
            int fieldAddr, off;

            if (*(unsigned char *)(bankData + 4) == type4)
                off = ptr4[5];
            else
                off = ptr2[3];
            if (off != 0) {
                if (*(unsigned char *)(bankData + 4) == type4) {
                    fieldAddr = bankData + off4;
                    off = ptr4[5];
                    off += fieldAddr;
                    ptr4[5] = off;
                } else {
                    fieldAddr = anchor + off2;
                    off = ptr2[3];
                    off += fieldAddr;
                    ptr2[3] = off;
                }
                if (iSNDresolvetaggedpatch(off, patchData, (int)scratch) != 7)
                    ret = 8;
            }
            off2 += 4;
            ptr2++;
            off4 += 4;
            i++;
            ptr4++;
        } while (i < (int)(unsigned)*(unsigned short *)(bankData + 6));
    }
    return ret;
}

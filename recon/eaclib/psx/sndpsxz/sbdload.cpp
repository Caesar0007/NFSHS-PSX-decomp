/* eaclib/psx/sndpsxz/sbdload.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbdload.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010266C.  iSNDdownloadbank -- resolve (DMA to SPU) every patch in a bank, rebasing each
 *   patch's self-relative pointer to an absolute address.  Ghidra nfs4-f.exe.c (sbdload).
 *
 *   Patch ptrs are stored as offsets relative to their own field (+0x14 for bank type 4, else +0xc):
 *   abs = fieldAddr + offset.
 */

extern "C" int iSNDresolvetaggedpatch(int bank, int patch_idx, int scratch);   /* stagpat */

extern "C" int iSNDdownloadbank(int bankData, int patchData);   /* @0x8010266C */

/* iSNDdownloadbank @0x8010266C : rebase + resolve all patches of the bank at `bankData`.  Returns 7 (all
 *   ok) or 8 (a patch failed). */
extern "C" int iSNDdownloadbank(int bankData, int patchData)
{
    int scratch[512];
    int i, ret = 7;
    int type4 = (*(char *)(bankData + 4) == 4);

    for (i = 0; i < 512; i += 2)
        scratch[i] = -1;
    if (*(short *)(bankData + 6) != 0) {
        i = 0;
        do {
            int fieldAddr = bankData + i * 4 + (type4 ? 0x14 : 0xc);
            int off = *(int *)fieldAddr;
            if (off != 0) {
                int bank = fieldAddr + off;
                *(int *)fieldAddr = bank;
                if (iSNDresolvetaggedpatch(bank, patchData, (int)scratch) != 7)
                    ret = 8;
            }
            i++;
        } while (i < (int)(unsigned)*(unsigned short *)(bankData + 6));
    }
    return ret;
}

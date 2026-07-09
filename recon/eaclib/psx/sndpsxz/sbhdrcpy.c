/* eaclib/psx/sndpsxz/sbhdrcpy.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbhdrcpy.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7BA8.  SNDbankheadercopy -- copy a loaded bank's header into `dst` and rebase its patch
 *   pointers to the new buffer, repointing the bank table at the copy.  Ghidra nfs4-f.exe.c (sbhdrcpy).
 */

extern int sndgs[];
extern int SNDbankheadersize(int bankId);          /* sbhdrsze */
extern void *memcpy(void *dst, const void *src, int n);   /* C42 (BIOS thunk) */

extern int SNDbankheadercopy(unsigned char *dst, int bankId);   /* @0x800E7BA8 */

/* SNDbankheadercopy @0x800E7BA8 : memcpy the bank header to `dst`, relocate each patch pointer (+0x14 for
 *   bank type 4, else +0xc) relative to `dst`, then point the bank table entry at `dst`. */
extern int SNDbankheadercopy(unsigned char *dst, int bankId)
{
    int size, bankData, i;

    if ((char)sndgs[0xf] == 0)
        return -10;
    size = SNDbankheadersize(bankId);
    if (size < 0)
        return size;
    bankData = *(int *)(bankId * 0xc + sndgs[0x26]);
    memcpy(dst, (unsigned char *)bankData, size);
    if (*(short *)(bankData + 6) != 0) {
        i = 0;
        do {
            if (*(char *)(bankData + 4) == 4) {
                int sp = *(int *)(bankData + i * 4 + 0x14);
                if (sp != 0)
                    *(int *)((int)dst + i * 4 + 0x14) = (int)dst + (sp - bankData);
            } else {
                int sp = *(int *)(bankData + i * 4 + 0xc);
                if (sp != 0)
                    *(int *)((int)dst + i * 4 + 0xc) = (int)dst + (sp - bankData);
            }
            i++;
        } while (i < (int)(unsigned)*(unsigned short *)(bankData + 6));
    }
    *(int *)(bankId * 0xc + sndgs[0x26]) = (int)dst;
    return 0;
}

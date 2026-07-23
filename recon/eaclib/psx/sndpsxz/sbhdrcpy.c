/* eaclib/psx/sndpsxz/sbhdrcpy.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbhdrcpy.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7BA8.  SNDbankheadercopy -- copy a loaded bank's header into `dst` and rebase its patch
 *   pointers to the new buffer, repointing the bank table at the copy.  Ghidra nfs4-f.exe.c (sbhdrcpy).
 */

struct SNDGlobals {
    char pad0[0x3c];
    signed char initialized;
    char pad3d[0x5b];
    int bank_table;
};
extern struct SNDGlobals sndgs;
extern int SNDbankheadersize(int bankId);          /* sbhdrsze */
extern void *memcpy(void *dst, const void *src, int n);   /* C42 (BIOS thunk) */

extern int SNDbankheadercopy(void *dst, int bankId);   /* @0x800E7BA8 */

/* SNDbankheadercopy @0x800E7BA8 : memcpy the bank header to `dst`, relocate each patch pointer (+0x14 for
 *   bank type 4, else +0xc) relative to `dst`, then point the bank table entry at `dst`. */
extern int SNDbankheadercopy(void *dst, int bankId)
{
    unsigned char *dest = (unsigned char *)dst;
    struct SNDGlobals *base = &sndgs;
    int size;
    unsigned char *bankData;

    if (base->initialized == 0)
        return -10;
    size = SNDbankheadersize(bankId);
    if (size < 0)
        return size;
    memcpy(dest, *(unsigned char **)(bankId * 0xc + base->bank_table), size);
    bankData = *(unsigned char **)(bankId * 0xc + base->bank_table);
    {
        unsigned char *origin;
        int type4;
        unsigned char *dst12;
        unsigned char *src12;
        unsigned char *dst20;
        unsigned char *src20;
        int i;

        if (*(unsigned short *)(bankData + 6) != 0) {
            origin = bankData;
            type4 = 4;
            dst12 = dest;
            src12 = bankData;
            dst20 = dest;
            src20 = bankData;
            i = 0;
        do {
            if (*(unsigned char *)(bankData + 4) == type4) {
                int sp = *(int *)(src20 + 0x14);
                if (sp != 0)
                    *(int *)(dst20 + 0x14) = (int)dest + (sp - (int)origin);
            } else {
                int sp = *(int *)(src12 + 0xc);
                if (sp != 0)
                    *(int *)(dst12 + 0xc) = (int)dest + (sp - (int)bankData);
            }
            dst12 += 4;
            src12 += 4;
            dst20 += 4;
            src20 += 4;
            i++;
        } while (i < (int)(unsigned)*(unsigned short *)(bankData + 6));
        }
    }
    *(int *)(bankId * 0xc + sndgs.bank_table) = (int)dest;
    return 0;
}

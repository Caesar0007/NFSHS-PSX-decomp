/* eaclib/psx/sndpsxz/sbirmpat.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbirmpat.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800FE5B4.  iSNDbankremovepat -- unload one patch of a bank (release its resolved SPU samples
 *   and null its pointer).  Ghidra nfs4-f.exe.c (sbirmpat) + IDA sig (Hex-Rays cross-checked, identical).
 *   NOTE: VA 0x800FE5B4 ALSO appears as a size-0 phantom FILE record under `sdasync.obj`(iSNDsync_func) in
 *   the SYM/xlsx -- a PSYLINK ghost aliasing this very code.  sdasync contributes no unique function; this
 *   IS that code.  SNDPSXZ is therefore code-complete (sdasync needs no separate .cpp).
 */

extern "C" int sndgs[];
extern "C" int iSNDvalidbank(int bankId);                       /* sbvalid */
extern "C" int iSNDremovetaggedpatch(int bank, int *patch);     /* stagpat */

extern "C" int iSNDbankremovepat(int bank, int patch_idx, int *scratch);   /* @0x800FE5B4 */

/* iSNDbankremovepat @0x800FE5B4 : free patch `patch_idx` of bank `bank` (its tagged SPU data), clearing the
 *   patch pointer (+0x14 for bank type 4, else +0xc).  Returns 0 / -8. */
extern "C" int iSNDbankremovepat(int bank, int patch_idx, int *scratch)
{
    int data = *(int *)(bank * 0xc + sndgs[0x26]);
    int base = (*(char *)(data + 4) == 4) ? data : 0;
    int pp;

    if (iSNDvalidbank(bank) != 0)
        return -8;
    if (patch_idx < 0 || patch_idx >= (int)(unsigned)*(unsigned short *)(data + 6))
        return -8;
    /* MATCH: group `base + (patch_idx<<2)` so the base is addu operand 1 (oracle `addu v0,s1,v0`), NOT
     * the index-first order `addu v0,v0,s1` that `base + patch_idx*4 + 0x14` produced. */
    if (*(char *)(data + 4) == 4)
        pp = *(int *)((base + (patch_idx << 2)) + 0x14);
    else
        pp = *(int *)((data + (patch_idx << 2)) + 0xc);
    if (pp == 0)
        return -8;
    iSNDremovetaggedpatch(pp, scratch);
    if (*(char *)(data + 4) == 4)
        *(int *)((base + (patch_idx << 2)) + 0x14) = 0;
    else
        *(int *)((data + (patch_idx << 2)) + 0xc) = 0;
    return 0;
}

/* eaclib/psx/sndpsxz/sdcdvol.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdcdvol.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x801094EC.  iSNDplatformcdpanvol -- push a CD pan/volume to the SPU CD-input volume registers.
 *   Ghidra nfs4-f.exe.c (sdcdvol) + IDA sig.  Ghidra-ism: void(void) typing dropped both args -- IDA shows
 *   2 (pan, vol), passed in $a0/$a1 from SNDcdvol.
 */
extern int iSNDpvtolrv(int pan, int level, int *out_l, int *out_r);   /* spvtolrv */
extern unsigned char sndpd[];   /* EA sound-driver state base @0x80147918 */

extern int iSNDplatformcdpanvol(int pan, int vol);   /* @0x801094EC */

/* iSNDplatformcdpanvol @0x801094EC : derive CD L/R from (pan, vol) and write SPU_CD_VOL_L/R (base+0x1b0/2),
 *   scaling each by 0x102 and clamping to 15-bit. */
extern int iSNDplatformcdpanvol(int pan, int vol)
{
    int outL, outR;
    unsigned char *pd;
    iSNDpvtolrv(pan, vol, &outL, &outR);
    pd = sndpd;
    *(unsigned short *)(*(int *)(pd + 0x514) + 0x1b0) = (unsigned short)(outL * 0x102 & 0x7fff);
    *(unsigned short *)(*(int *)(pd + 0x514) + 0x1b2) = (unsigned short)(outR * 0x102 & 0x7fff);
    /* Near-match floor: 17 diffs (ours 24 / oracle 25). GCC folds `sndpd+0x514` into one absolute
     * relocation and CSEs the control-pointer load; explicit/volatile pd-relative variants preserve
     * the oracle's base+offset loads but regress to 23-32 diffs. Roughly 740 permuter candidates did
     * not beat this source form. */
    return 0;
}

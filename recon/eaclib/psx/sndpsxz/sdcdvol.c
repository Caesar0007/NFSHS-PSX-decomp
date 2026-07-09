/* eaclib/psx/sndpsxz/sdcdvol.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdcdvol.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x801094EC.  iSNDplatformcdpanvol -- push a CD pan/volume to the SPU CD-input volume registers.
 *   Ghidra nfs4-f.exe.c (sdcdvol) + IDA sig.  Ghidra-ism: void(void) typing dropped both args -- IDA shows
 *   2 (pan, vol), passed in $a0/$a1 from SNDcdvol.
 */
extern int iSNDpvtolrv(int pan, int level, int *out_l, int *out_r);   /* spvtolrv */
extern int DAT_80147e2c;   /* SPU control register base (address) */

extern void iSNDplatformcdpanvol(int pan, int vol);   /* @0x801094EC */

/* iSNDplatformcdpanvol @0x801094EC : derive CD L/R from (pan, vol) and write SPU_CD_VOL_L/R (base+0x1b0/2),
 *   scaling each by 0x102 and clamping to 15-bit. */
extern void iSNDplatformcdpanvol(int pan, int vol)
{
    int outL = 0, outR = 0;
    iSNDpvtolrv(pan, vol, &outL, &outR);
    *(unsigned short *)(DAT_80147e2c + 0x1b0) = (unsigned short)(outL * 0x102 & 0x7fff);
    *(unsigned short *)(DAT_80147e2c + 0x1b2) = (unsigned short)(outR * 0x102 & 0x7fff);
}

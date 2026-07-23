/* eaclib/psx/sndpsxz/s3dpos.c -- RECONSTRUCTED. NOT original.  *** 1/1 PASS ***  obj s3dpos.obj @0x800FEE30 */
/*   iSNDplatform3dpos -- set a voice's pan angle and re-derive its SPU L/R (the low-level half of SND3dpos).
 *   Ghidra nfs4-f.exe.c (s3dpos) -- same dropped-arg pattern as sdriver's iSNDvol: iSNDatolrv is 4-arg,
 *   iSNDatodlrv 6-arg, iSNDsetvol 3-arg (restored). */

extern int sndgs[];
extern unsigned char sndpd[];
extern unsigned char DAT_80147a08, DAT_80147a0c, DAT_80147a0e, DAT_80147a14, DAT_80147a15;
extern void iSNDatolrv(unsigned int pan, int level, int *outL, int *outR);                 /* saetolrv */
extern void iSNDatodlrv(unsigned int pan, int level, int *outL, int *outR, int pL, int pR);/* saetodv  */
extern unsigned int iSNDsetvol(int chan, int left, int right);                             /* spatkey  */

extern int iSNDplatform3dpos(int chan, int x);   /* @0x800FEE30 */

/* iSNDplatform3dpos @0x800FEE30 : store pan angle `x` (+0x18) and, if the voice is playing, recompute its
 *   SPU L/R from the routing mode and push it. MATCH: the voice fields are one volatile sndpd+0xd8 record;
 *   the explicit non-playing return supplies the oracle's zero-valued branch delay slot. */
extern int iSNDplatform3dpos(int chan, int x)
{
    int vt = chan * 0x2c;
    volatile unsigned char *slot = sndpd + 0xd8 + vt;
    int outL, outR;

    *(volatile short *)(slot + 0x18) = (short)x;
    if (slot[0x1c] != 2)
        return 0;
    if (slot[0x1e] == 1)
        iSNDatodlrv((unsigned int)x, (int)*(signed char *)(chan * 100 + sndgs[0x25] + 0x2d),
                    &outL, &outR, (int)(signed char)slot[0x24], (int)(signed char)slot[0x25]);
    else if (slot[0x1e] == 0)
        iSNDatolrv((unsigned int)x, (int)*(signed char *)(chan * 100 + sndgs[0x25] + 0x2d),
                   &outL, &outR);
    slot[0x24] = (unsigned char)outL;
    slot[0x25] = (unsigned char)outR;
    iSNDsetvol(chan, outL, outR);
    return 0;
}

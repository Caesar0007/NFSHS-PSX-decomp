/* eaclib/psx/sndpsxz/s3dpos.cpp -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj s3dpos.obj @0x800FEE30 */
/*   iSNDplatform3dpos -- set a voice's pan angle and re-derive its SPU L/R (the low-level half of SND3dpos).
 *   Ghidra nfs4-f.exe.c (s3dpos) -- same dropped-arg pattern as sdriver's iSNDvol: iSNDatolrv is 4-arg,
 *   iSNDatodlrv 6-arg, iSNDsetvol 3-arg (restored). */

extern "C" int sndgs[];
extern "C" unsigned char DAT_80147a08, DAT_80147a0c, DAT_80147a0e, DAT_80147a14, DAT_80147a15;
extern "C" void iSNDatolrv(unsigned int pan, int level, int *outL, int *outR);                 /* saetolrv */
extern "C" void iSNDatodlrv(unsigned int pan, int level, int *outL, int *outR, int pL, int pR);/* saetodv  */
extern "C" unsigned int iSNDsetvol(int chan, int left, int right);                             /* spatkey  */

extern "C" int iSNDplatform3dpos(int chan, int x);   /* @0x800FEE30 */

/* iSNDplatform3dpos @0x800FEE30 : store pan angle `x` (+0x18) and, if the voice is playing, recompute its
 *   SPU L/R from the routing mode and push it. */
extern "C" int iSNDplatform3dpos(int chan, int x)
{
    int vt = chan * 0x2c;
    int outL = 0, outR = 0;
    *(short *)(&DAT_80147a08 + vt) = (short)x;
    if ((&DAT_80147a0c)[vt] == 2) {
        if ((&DAT_80147a0e)[vt] == 1)
            iSNDatodlrv((unsigned int)x, (int)*(char *)(chan * 100 + sndgs[0x25] + 0x2d), &outL, &outR,
                        (int)(signed char)(&DAT_80147a14)[vt], (int)(signed char)(&DAT_80147a15)[vt]);
        else if ((&DAT_80147a0e)[vt] == 0)
            iSNDatolrv((unsigned int)x, (int)*(char *)(chan * 100 + sndgs[0x25] + 0x2d), &outL, &outR);
        (&DAT_80147a14)[vt] = (unsigned char)outL;
        (&DAT_80147a15)[vt] = (unsigned char)outR;
        iSNDsetvol(chan, outL, outR);
    }
    return 0;
}

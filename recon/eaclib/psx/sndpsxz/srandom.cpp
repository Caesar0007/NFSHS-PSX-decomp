/* eaclib/psx/sndpsxz/srandom.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\srandom.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010BE80.  iSNDrandom -- a 160-bit additive lagged-Fibonacci PRNG (5 state words + carry into
 *   sndseed); returns the accumulated seed.  Ghidra nfs4-f.exe.c (srandom) + IDA (returns int; Ghidra void).
 */

extern "C" unsigned int sndseed;
extern "C" unsigned int DAT_8013c2f4, DAT_8013c2f8, DAT_8013c2fc, DAT_8013c300, DAT_8013c304;

extern "C" int iSNDrandom(void);   /* @0x8010BE80 */

/* iSNDrandom @0x8010BE80 : step the additive generator (with carry propagation) and return the new seed. */
extern "C" int iSNDrandom(void)
{
    unsigned int u1, u2, u3, u4;
    int carry = 0;
    u1 = DAT_8013c304 + DAT_8013c300;
    if (u1 < DAT_8013c304 || u1 < DAT_8013c300)
        carry = 1;
    u2 = u1 + DAT_8013c2fc + carry;
    u3 = u2 + DAT_8013c2f8 + (unsigned int)(u2 < DAT_8013c2fc);
    u4 = u3 + DAT_8013c2f4 + (unsigned int)(u3 < DAT_8013c2f8);
    sndseed = u4 + sndseed + (unsigned int)(u4 < DAT_8013c2f4);
    DAT_8013c304 = DAT_8013c304 + 1;
    DAT_8013c2f4 = u4;
    DAT_8013c2f8 = u3;
    DAT_8013c2fc = u2;
    DAT_8013c300 = u1;
    if (DAT_8013c304 == 0 && (DAT_8013c300 = u1 + 1, DAT_8013c300 == 0) &&
        (DAT_8013c2fc = u2 + 1, DAT_8013c2fc == 0) &&
        (DAT_8013c2f8 = u3 + 1, DAT_8013c2f8 == 0) &&
        (DAT_8013c2f4 = u4 + 1, DAT_8013c2f4 == 0))
        sndseed = sndseed + 1;
    return (int)sndseed;
}

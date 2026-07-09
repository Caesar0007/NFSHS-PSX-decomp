/* eaclib/psx/sndpsxz/srrange.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\srrange.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010BCF4.  randrange -- a centred random offset in +/- range/4 (a 15-bit random, biased to
 *   [-0x4000,0x3fff], scaled by the clamped range, >>14).  Ghidra nfs4-f.exe.c (srrange) -- 🔴 Ghidra lost
 *   iSNDrandom's return (reused the clamp flag uVar1); restored from IDA (iSNDrandom returns int).
 */

extern int iSNDrandom(void);   /* srandom */

extern int randrange(int range);   /* @0x8010BCF4 */

/* randrange @0x8010BCF4 : return a signed random in roughly [-range/4, +range/4]. */
extern int randrange(int range)
{
    if (0x10000 < range) range = 0x10000;
    else if (range < 0)  range = 0;
    return (int)((((int)(iSNDrandom() & 0x7fff)) - 0x4000) * range) >> 0xe;
}

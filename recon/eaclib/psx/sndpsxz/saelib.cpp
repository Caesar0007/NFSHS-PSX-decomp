/* eaclib/psx/sndpsxz/saelib.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\saelib.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010C894.  iSNDlibatodlrv -- the shared sine pan law (angle -> L/R gains, clamped 0..0x7f),
 *   used by saetolrv/saetodv.  Ghidra nfs4-f.exe.c (saelib) + IDA sig (4-arg; Ghidra __thiscall).
 */

extern "C" int iSNDsin(int phase);     /* ssine */

extern "C" int iSNDlibatodlrv(int angle, int level, int *out_l, int *out_r);   /* @0x8010C894 */

/* iSNDlibatodlrv @0x8010C894 : split `level` into left/right gains for pan `angle` via a quarter-wave sine
 *   crossfade (angle>>6 indexes the sine table), each clamped to 0..0x7f. */
extern "C" int iSNDlibatodlrv(int angle, int level, int *out_l, int *out_r)
{
    unsigned int s = (unsigned int)iSNDsin(angle >> 6);
    unsigned int l = (unsigned int)(level * (int)(0x10000 - s)) >> 0x10;
    *out_l = (int)l;
    if (0x7f < l)
        *out_l = 0x7f;
    unsigned int r = (unsigned int)(level * (int)(s + 0x10000)) >> 0x10;
    *out_r = (int)r;
    if (0x7f < r)
        *out_r = 0x7f;
    return 0x7f;
}

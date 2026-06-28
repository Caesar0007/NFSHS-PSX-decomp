/* eaclib/psx/sndpsxz/sdtimrem.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdtimrem.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x801049A8.  iSNDtimeremaining -- samples left to play on a voice = (loopEnd - servedPos) / pitch.
 *   Ghidra nfs4-f.exe.c (sdtimrem) + IDA sig.  Voice table @0x801479F0 (0x2c byte / 0xb int stride per voice).
 */
extern "C" int           DAT_801479f8;   /* +0x08 hw pitch/rate (int view: [chan*0xb])    */
extern "C" unsigned char DAT_801479fc;   /* +0x0c served byte position (int via &+chan*0x2c) */
extern "C" unsigned char DAT_80147a04;   /* +0x14 loop-end byte position                  */
extern "C" void trap(unsigned int code);

extern "C" unsigned int iSNDtimeremaining(int chan);   /* @0x801049A8 */

/* iSNDtimeremaining @0x801049A8 : remaining samples for voice `chan`; 0x7fffffff if the voice has no pitch
 *   (stopped/infinite).  The pitch==0 retest is the compiler's divide-by-zero guard. */
extern "C" unsigned int iSNDtimeremaining(int chan)
{
    if ((&DAT_801479f8)[chan * 0xb] != 0) {
        return (unsigned int)(*(int *)(&DAT_80147a04 + chan * 0x2c) -
                              *(int *)(&DAT_801479fc + chan * 0x2c)) /
               (unsigned int)(&DAT_801479f8)[chan * 0xb];
    }
    return 0x7fffffff;
}

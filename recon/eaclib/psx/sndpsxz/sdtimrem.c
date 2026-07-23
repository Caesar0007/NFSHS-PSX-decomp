/* eaclib/psx/sndpsxz/sdtimrem.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdtimrem.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x801049A8.  iSNDtimeremaining -- samples left to play on a voice = (loopEnd - servedPos) / pitch.
 *   Ghidra nfs4-f.exe.c (sdtimrem) + IDA sig.  Voice table @0x801479F0 (0x2c byte / 0xb int stride per voice).
 */
extern int           DAT_801479f8;   /* +0x08 hw pitch/rate (int view: [chan*0xb])    */
extern unsigned char DAT_801479fc;   /* +0x0c served byte position (int via &+chan*0x2c) */
extern unsigned char DAT_80147a04;   /* +0x14 loop-end byte position                  */
extern unsigned char D_801479F0[];   /* exact voice-table base, supplied by linker */
extern void trap(unsigned int code);

extern unsigned int iSNDtimeremaining(int chan);   /* @0x801049A8 */

/* iSNDtimeremaining @0x801049A8 : remaining samples for voice `chan`; 0x7fffffff if the voice has no pitch
 *   (stopped/infinite).  The pitch==0 retest is the compiler's divide-by-zero guard. */
extern unsigned int iSNDtimeremaining(int chan)
{
    unsigned char *voice = D_801479F0 + chan * 0x2c;
    if (*(volatile unsigned int *)(voice + 8) == 0)
        return 0x7fffffff;
    return (unsigned int)(*(int *)(voice + 0x14) - *(int *)(voice + 0xc)) /
           *(volatile unsigned int *)(voice + 8);
}

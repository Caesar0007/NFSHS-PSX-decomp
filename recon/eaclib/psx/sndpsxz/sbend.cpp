/* eaclib/psx/sndpsxz/sbend.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\sbend.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x800E78F8 .. 0x800E79D0].  SNDpitchbend -- retune the voices of a playing sound.
 *   Ghidra nfs4-f.exe.c (sbend) + IDA sigs.
 */

extern "C" int sndgs[];
extern "C" int  iSNDgetchan(unsigned int tag);            /* salloc   */
extern "C" int  iSNDpatchkey(int chan, int tag);          /* spatkey  */
extern "C" int  iSNDcalcpitch(int note);                  /* sclcptch */
extern "C" int  iSNDplatformpitch(int chan, int pitch);   /* sdriver  */
extern "C" void iSNDenteraudio(void);                     /* sserver  */
extern "C" void iSNDleaveaudio(void);

extern "C" int iSNDunsafebend(unsigned int tag, unsigned int chan);   /* @0x800E78F8 */
extern "C" int SNDpitchbend(unsigned int tag, int bend);              /* @0x800E79D0 */

/* iSNDunsafebend @0x800E78F8 : set the detune (+0x2f) on every voice of `tag`, recomputing SPU pitch. */
extern "C" int iSNDunsafebend(unsigned int tag, unsigned int chan)
{
    int chanIdx = iSNDgetchan(tag);
    int cur[2];
    if (-1 < chanIdx) {
        cur[0] = -1;
        while (iSNDpatchkey(chanIdx, (int)cur) != 0) {
            int v = sndgs[0x25] + cur[0] * 100;
            if ((int)*(char *)(v + 0x2f) == (int)chan)
                return 0;
            if (*(short *)(v + 0x5a) == 0)
                return 0;
            *(char *)(v + 0x2f) = (char)chan;
            *(short *)(v + 0x5e) = 0;
            iSNDcalcpitch(cur[0]);
            iSNDplatformpitch(cur[0], (int)(unsigned)*(unsigned short *)(v + 0x62));
        }
    }
    return chanIdx;
}

/* SNDpitchbend @0x800E79D0 : audio-locked wrapper around iSNDunsafebend. */
extern "C" int SNDpitchbend(unsigned int tag, int bend)
{
    int r;
    if ((char)sndgs[0xf] == 0)
        return -10;
    iSNDenteraudio();
    r = iSNDunsafebend(tag, (unsigned int)bend);
    iSNDleaveaudio();
    return r;
}

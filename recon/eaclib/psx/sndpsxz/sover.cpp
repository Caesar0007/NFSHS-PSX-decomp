/* eaclib/psx/sndpsxz/sover.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sover.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7B14.  SNDover -- has the sound keyed on `tag` finished?  Ghidra nfs4-f.exe.c (sover)
 *   + disasm-v3 L<800E7B14>.
 */

extern "C" int  sndgs[];
extern "C" void iSNDenteraudio(void);                 /* sserver */
extern "C" void iSNDleaveaudio(void);
extern "C" int  iSNDgetchan(unsigned int tag);        /* salloc  */

extern "C" unsigned int SNDover(unsigned int tag);    /* @0x800E7B14 */

/* SNDover @0x800E7B14 : report whether `tag` still owns a live channel.  iSNDgetchan returns a negative
 *   error once the tag has been reclaimed/stopped, so `(unsigned)result >> 31` yields 1 when the sound is
 *   "over" (channel gone) and 0 while it still plays.  Returns -10 if the audio system is uninitialised. */
extern "C" unsigned int SNDover(unsigned int tag)
{
    unsigned int r;
    if ((char)sndgs[0xf] == 0)
        return 0xfffffff6;                            /* -10 : audio not initialised */
    iSNDenteraudio();
    r = (unsigned int)iSNDgetchan(tag) >> 0x1f;       /* 1 == finished, 0 == still playing */
    iSNDleaveaudio();
    return r;
}

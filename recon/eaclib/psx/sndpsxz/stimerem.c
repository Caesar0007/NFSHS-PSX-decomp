/* eaclib/psx/sndpsxz/stimerem.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\stimerem.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800ED338.  SNDtimeremaining -- public: longest remaining time across all voices of sound `tag`.
 *   Ghidra nfs4-f.exe.c (stimerem) + IDA sig.
 */
extern int  sndgs[];
extern void iSNDenteraudio(void);                          /* sserver */
extern void iSNDleaveaudio(void);                          /* sserver */
extern int  iSNDgetchan(unsigned int tag);                 /* salloc  */
extern int  iSNDpatchkey(int chan, int outChan);           /* spatkey (iterates voices of a sound) */
extern unsigned int iSNDtimeremaining(int chan);           /* sdtimrem */

extern int SNDtimeremaining(unsigned int tag);             /* @0x800ED338 */

/* SNDtimeremaining @0x800ED338 : -10 if audio uninitialised, -8 if `tag` not playing, else the maximum of
 *   iSNDtimeremaining over every voice the sound owns. */
extern int SNDtimeremaining(unsigned int tag)
{
    unsigned int best = 0xfffffc00;   /* init EARLY -> held in a callee-saved reg (s0) across the calls,
                                       * matching the oracle's `li s0,-1024` in the prologue */
    int          chan;
    int          voice[2];
    if ((signed char)sndgs[0xf] == '\0')
        return -10;
    iSNDenteraudio();
    chan = iSNDgetchan(tag);
    if (chan < 0) {
        iSNDleaveaudio();
        return -8;
    }
    voice[0] = -1;
    while (iSNDpatchkey(chan, (int)voice) != 0) {
        unsigned int rem = iSNDtimeremaining(voice[0]);
        if ((int)best < (int)rem)
            best = rem;
    }
    iSNDleaveaudio();
    return (int)best;
}

/* eaclib/psx/sndpsxz/spitch.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\spitch.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7F08.  SNDpitchmult -- set the pitch-multiplier word (+0x60) on a sound's voices.
 *   Ghidra nfs4-f.exe.c (spitch) + IDA sig (this=tag).
 */

extern int sndgs[];
extern int  iSNDgetchan(unsigned int tag);            /* salloc   */
extern int  iSNDpatchkey(int chan, int tag);          /* spatkey  */
extern int  iSNDcalcpitch(int note);                  /* sclcptch */
extern int  iSNDplatformpitch(int chan, int pitch);   /* sdriver  */
extern void iSNDenteraudio(void);                     /* sserver  */
extern void iSNDleaveaudio(void);

extern int SNDpitchmult(unsigned int tag, unsigned int mult);     /* @0x800E7F08 */

/* SNDpitchmult @0x800E7F08 : set the pitch-multiplier (+0x60) on each voice of `tag` and recompute pitch. */
extern int SNDpitchmult(unsigned int tag, unsigned int mult)
{
    int chanIdx;
    int cur[2];
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    iSNDenteraudio();
    chanIdx = iSNDgetchan(tag);
    if (-1 < chanIdx) {
        cur[0] = -1;
        while (iSNDpatchkey(chanIdx, (int)cur) != 0) {
            /* MATCH: keeping this value live only through iSNDcalcpitch selects a0 for the
             * multiply and lets the pitch-multiplier store fill that call's delay slot. */
            int note = cur[0];
            int v = sndgs[0x25] + note * 100;
            if (*(unsigned short *)(v + 0x60) == mult)
                break;
            *(short *)(v + 0x60) = (short)mult;
            iSNDcalcpitch(note);
            iSNDplatformpitch(cur[0], (int)(unsigned)*(unsigned short *)(v + 0x62));
        }
    }
    iSNDleaveaudio();
    return chanIdx;
}

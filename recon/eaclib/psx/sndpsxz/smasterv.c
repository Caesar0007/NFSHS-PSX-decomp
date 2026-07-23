/* eaclib/psx/sndpsxz/smasterv.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\smasterv.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7FF0.  SNDmastervol -- set the global master volume and re-derive every voice's SPU volume.
 *   Ghidra nfs4-f.exe.c (smasterv).
 */

extern int sndgs[];
struct SNDMasterState {
    unsigned char pad0[0x11];
    unsigned char channel_count;
    unsigned char pad1[0x82];
    int play_records;
};
#define SNDMASTER_STATE (*(struct SNDMasterState *)sndgs)
extern unsigned int iSNDcalcvol(int chan);    /* spatkey */
extern int  iSNDvol(int chan, int level);     /* sdriver */
extern void iSNDenteraudio(void);             /* sserver */
extern void iSNDleaveaudio(void);

extern int SNDmastervol(int vol);             /* @0x800E7FF0 */

/* SNDmastervol @0x800E7FF0 : store the master volume (sndgs[0xf]._1_1_) and refresh all held voices. */
extern int SNDmastervol(int vol)
{
    int chan;
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    iSNDenteraudio();
    ((char *)sndgs)[0x3d] = (char)vol;             /* sndgs[0xf]._1_1_ : master volume */
    chan = 0;
    if (((unsigned char *)sndgs)[0x11] != 0) {
        do {
            int *slot = (int *)(SNDMASTER_STATE.play_records + chan * 100);
            if (*(signed char *)((int)slot + 0xb) == 1 && -1 < *slot) {
                iSNDcalcvol(chan);
                iSNDvol(chan, (int)*(signed char *)((int)slot + 0x2d));
            }
            chan++;
        } while (chan < (int)(unsigned)SNDMASTER_STATE.channel_count);
    }
    iSNDleaveaudio();
    return 0;
}

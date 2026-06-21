/* eaclib/psx/sndpsxz/smasterv.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\smasterv.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7FF0.  SNDmastervol -- set the global master volume and re-derive every voice's SPU volume.
 *   Ghidra nfs4-f.exe.c (smasterv).
 */

extern "C" int sndgs[];
extern "C" unsigned int iSNDcalcvol(int chan);    /* spatkey */
extern "C" int  iSNDvol(int chan, int level);     /* sdriver */
extern "C" void iSNDenteraudio(void);             /* sserver */
extern "C" void iSNDleaveaudio(void);

extern "C" int SNDmastervol(int vol);             /* @0x800E7FF0 */

/* SNDmastervol @0x800E7FF0 : store the master volume (sndgs[0xf]._1_1_) and refresh all held voices. */
extern "C" int SNDmastervol(int vol)
{
    int chan, off;
    if ((char)sndgs[0xf] == 0)
        return -10;
    iSNDenteraudio();
    ((char *)sndgs)[0x3d] = (char)vol;             /* sndgs[0xf]._1_1_ : master volume */
    chan = 0;
    if (((unsigned char *)sndgs)[0x11] != 0) {
        off = 0;
        do {
            int *slot = (int *)(sndgs[0x25] + off);
            if (*(char *)((int)slot + 0xb) == 1 && -1 < *slot) {
                iSNDcalcvol(chan);
                iSNDvol(chan, (int)*(char *)((int)slot + 0x2d));
            }
            chan++;
            off += 100;
        } while (chan < (int)(unsigned)((unsigned char *)sndgs)[0x11]);
    }
    iSNDleaveaudio();
    return 0;
}

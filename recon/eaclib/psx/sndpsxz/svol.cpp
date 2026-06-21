/* eaclib/psx/sndpsxz/svol.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\svol.obj (SNDPSXZ.LIB).  2 fns: iSNDunsafevol@0x800E69D0,
 *   SNDvol@0x800E6A94.  FULL reconstruction (disasm-v3 MIPS); NOT stubs.  Uses lib/snd.h.
 *
 *   Set the volume of every voice of `handle`: store the 16.16 level (vol<<16) into voice@+0x1C,
 *   recompute (iSNDcalcvol), clear the ramp accumulator @+0x14, and poke the SPU (iSNDvol) with
 *   the voice's left base volume @+0x2D.  SNDvol is the locked public wrapper (-10 when disabled).
 */
#include "../../../lib/snd.h"

extern "C" int iSNDunsafevol(int handle, int vol)   /* @0x800E69D0 */
{
    int chan = iSNDgetchan(handle);
    if (chan < 0)
        return chan;
    int iter = -1;
    int level = vol << 16;
    while (iSNDpatchkey(chan, &iter)) {
        SndVoice *v = &SND->voices[iter];
        if (v->f1C == level)
            break;                          /* already this level -> done */
        v->f1C = level;
        iSNDcalcvol(iter);
        v->f14 = 0;
        iSNDvol(iter, v->vol_l);
    }
    return chan;
}

extern "C" int SNDvol(int handle, int vol)   /* @0x800E6A94 */
{
    if (SND->enabled == 0)
        return -10;
    iSNDenteraudio();
    int r = iSNDunsafevol(handle, vol);
    iSNDleaveaudio();
    return r;
}

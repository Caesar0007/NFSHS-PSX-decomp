/* eaclib/psx/sndpsxz/span.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\span.obj (SNDPSXZ.LIB).  1 fn @0x800E6884 : SNDpan.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  Uses the shared SND types in lib/snd.h.
 *
 *   Set the stereo pan of every voice belonging to `handle`.  Walks the handle's voice chain
 *   (iSNDpatchkey), applies the per-voice pan offset/scale (voice.pan @+0x2E, mode @+0x33,
 *   current @+0x3D) optionally remapped through a per-voice pan curve (@+0x48), clamps to
 *   [0,0x7F], and pokes the SPU via iSNDplatform3dpos.  Returns the channel index (or -10 off).
 */
#include "../../../lib/snd.h"

extern "C" int SNDpan(int handle, int pan)   /* @0x800E6884 */
{
    if (SND->enabled == 0)
        return -10;

    iSNDenteraudio();
    int chan = iSNDgetchan(handle);
    if (chan >= 0) {
        int iter = -1;
        while (iSNDpatchkey(chan, &iter)) {
            SndVoice *v = &SND->voices[iter];
            if (v->pan_cur == (signed char)pan)
                break;                                   /* already at target -> done */
            int p = pan;
            if (v->f33 != 1) {
                v->pan_cur = (signed char)pan;
                p = (pan - 0x40) * v->f33 + 0x40;        /* scale about centre */
            }
            p = v->pan + p - 0x40;
            if (p >= 0x80) p = 0x7F;
            if (p < 0)     p = 0;
            if (v->pancurve != 0)
                p = ((signed char *)v->pancurve)[p];     /* pan curve remap */
            iSNDplatform3dpos(iter, ((p - 0x40) << 8) & 0xFF00, 0);
        }
    }
    iSNDleaveaudio();
    return chan;
}

/* eaclib/psx/sndpsxz/span.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 PASS ***
 *   Source obj : nfs4\eaclib\psx\span.obj (SNDPSXZ.LIB).  1 fn @0x800E6884 : SNDpan.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  Uses the shared SND types in lib/snd.h.
 *
 *   Set the stereo pan of every voice belonging to `handle`.  Walks the handle's voice chain
 *   (iSNDpatchkey), applies the per-voice pan offset/scale (voice.pan @+0x2E, mode @+0x33,
 *   current @+0x3D) optionally remapped through a per-voice pan curve (@+0x48), clamps to
 *   [0,0x7F], and pokes the SPU via iSNDplatform3dpos.  Returns the channel index (or -10 off).
 */
#include "span.h"
#include "sndchpriv.h"
#include "../../../lib/snd.h"

int SNDpan(int handle, int pan)   /* @0x800E6884 */
{
    int chan;
    if (!SND->enabled)
        return -10;

    iSNDenteraudio();
    chan = iSNDgetchan(handle);
    if (chan >= 0) {
        int iter = -1;
        while (iSNDpatchkey(chan, &iter)) {
            int voiceIndex;
            int angle;
            int p;
            SndChannel *v = (SndChannel *)&SND->voices[iter];
            if (v->current_pan == pan)
                break;                                   /* already at target -> done */
            v->current_pan = (signed char)pan;
            p = pan;
            if (v->pan_scale != 1) {
                p = (pan - 0x40) * v->pan_scale + 0x40;  /* scale about centre */
            }
            p = v->pan + p - 0x40;
            if (p >= 0x80) p = 0x7F;
            else if (p < 0) p = 0;
            if (v->pan_curve)
                p = ((signed char *)v->pan_curve)[p];    /* pan curve remap */
            angle = ((p - 0x40) << 8) & 0xFF00;
            voiceIndex = *(volatile int *)&iter;
            iSNDplatform3dpos(voiceIndex, angle, 0);
        }
    }
    iSNDleaveaudio();
    return chan;
}

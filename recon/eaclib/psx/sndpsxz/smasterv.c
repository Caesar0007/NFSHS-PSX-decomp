/* eaclib/psx/sndpsxz/smasterv.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\smasterv.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7FF0.  SNDmastervol -- set the global master volume and re-derive every voice's SPU volume.
 *   Ghidra nfs4-f.exe.c (smasterv).
 */
#include "sdata.h"
#include "sndchpriv.h"
#include "sndserverpriv.h"
#include "sdriver.h"
#include "slib.h"
#include "snd_state.h"
#include "smasterv.h"
#include "sserver.h"

/* SNDmastervol @0x800E7FF0 : store the master volume (sndgs[0xf]._1_1_) and refresh all held voices. */
int SNDmastervol(int vol)
{
    int chan;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    iSNDenteraudio();
    ((struct SndGlobalServerStateView *)sndgs)->master_volume = (signed char)vol;             /* sndgs[0xf]._1_1_ : master volume */
    chan = 0;
    if (((struct SndGlobalServerStateView *)sndgs)->channel_count) {
        do {
            SndChannel *pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
            SndChannel *slot = &pool[chan];
            if (slot->state == 1 && -1 < (int)slot->owner_tag) {
                iSNDcalcvol(chan);
                iSNDvol(chan, slot->volume);
            }
            chan++;
        } while (chan < ((struct SndGlobalServerStateView *)sndgs)->channel_count);
    }
    iSNDleaveaudio();
    return 0;
}

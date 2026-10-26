/* eaclib/psx/sndpsxz/spitch.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\spitch.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7F08.  SNDpitchmult -- set the pitch-multiplier word (+0x60) on a sound's voices.
 *   Ghidra nfs4-f.exe.c (spitch) + IDA sig (this=tag).
 */
#include "salloc.h"
#include "sclcptch.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndchpriv.h"
#include "sdriver.h"
#include "spatkey.h"
#include "spitch.h"
#include "sserver.h"

/* SNDpitchmult @0x800E7F08 : set the pitch-multiplier (+0x60) on each voice of `tag` and recompute pitch. */
int SNDpitchmult(unsigned int tag, unsigned int mult)
{
    int chanIdx;
    int cur[2];
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    iSNDenteraudio();
    chanIdx = iSNDgetchan(tag);
    if (chanIdx > -1) {
        cur[0] = -1;
        while (iSNDpatchkey(chanIdx, cur)) {
            /* MATCH: keeping this value live only through iSNDcalcpitch selects a0 for the
             * multiply and lets the pitch-multiplier store fill that call's delay slot. */
            int note = cur[0];
            SndChannel *pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
            SndChannel *v = &pool[note];
            if (v->base_pitch == mult)
                break;
            v->base_pitch = (short)mult;
            iSNDcalcpitch(note);
            iSNDplatformpitch(cur[0], v->spu_pitch);
        }
    }
    iSNDleaveaudio();
    return chanIdx;
}

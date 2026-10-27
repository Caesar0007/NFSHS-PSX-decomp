/* eaclib/psx/sndpsxz/sbend.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\sbend.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x800E78F8 .. 0x800E79D0].  SNDpitchbend -- retune the voices of a playing sound.
 *   Ghidra nfs4-f.exe.c (sbend) + IDA sigs.
 */
#include "salloc.h"
#include "sbend.h"
#include "sclcptch.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndchpriv.h"
#include "sdriver.h"
#include "spatkey.h"
#include "sserver.h"

/* iSNDunsafebend @0x800E78F8 : set the detune (+0x2f) on every voice of `tag`, recomputing SPU pitch. */
int iSNDunsafebend(unsigned int tag, unsigned int chan)
{
    int chanIdx = iSNDgetchan(tag);
    int cur[2];
    if (chanIdx > -1) {
        cur[0] = -1;
        while (iSNDpatchkey(chanIdx, cur)) {
            SndChannel *pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
            SndChannel *v = &pool[cur[0]];
            if (v->bend == (int)chan)   /* signed +0x2f detune read (lb) */
                return 0;
            if (!v->envelope_detune_depth)
                return 0;
            v->bend = (char)chan;
            {
                /* MATCH: naming the already-loaded channel before the store lets gcc sink the store
                 * into iSNDcalcpitch's jal delay slot; either statement alone leaves a nop there. */
                int c = cur[0];
                v->linear_pitch_cache = 0;
                iSNDcalcpitch(c);
            }
            iSNDplatformpitch(cur[0], v->spu_pitch);
        }
    }
    return chanIdx;
}

/* SNDpitchbend @0x800E79D0 : audio-locked wrapper around iSNDunsafebend. */
int SNDpitchbend(unsigned int tag, int bend)
{
    int r;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    iSNDenteraudio();
    r = iSNDunsafebend(tag, bend);
    iSNDleaveaudio();
    return r;
}

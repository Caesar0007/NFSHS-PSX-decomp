/* eaclib/psx/sndpsxz/s3dpos.c -- RECONSTRUCTED. NOT original.  *** 1/1 PASS ***  obj s3dpos.obj @0x800FEE30 */
/*   iSNDplatform3dpos -- set a voice's pan angle and re-derive its SPU L/R (the low-level half of SND3dpos).
 *   Callers pass a third `y` value, but the callee never reads $a2. The original C formal count is not recoverable
 *   from this binary alone; keep the unused parameter here to match the three-argument caller interface. */
#include "s3dpos.h"
#include "saetodv.h"
#include "saetolrv.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndchpriv.h"
#include "sndpacketpriv.h"
#include "slib.h"
#include "snd_state.h"

/* iSNDplatform3dpos @0x800FEE30 : store pan angle `x` (+0x18) and, if the voice is playing, recompute its
 *   SPU L/R from the routing mode and push it. MATCH: the voice fields are one volatile sndpd+0xd8 record;
 *   the explicit non-playing return supplies the oracle's zero-valued branch delay slot. */
int iSNDplatform3dpos(int chan, int x, int y)
{
    int vt = chan * (int)sizeof(SndPacketVoiceState);
    volatile SndPacketVoiceState *slot = (volatile SndPacketVoiceState *)(sndpd + 0xd8 + vt);
    int outL, outR;

    slot->volume_angle = (short)x;
    if (slot->play_state != 2)
        return 0;
    if (slot->route == 1) {
        SndChannel *pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
        iSNDatodlrv(x, pool[chan].volume, &outL, &outR,
                    (signed char)slot->pan_left_cache, (signed char)slot->pan_right_cache);
    } else if (!slot->route) {
        SndChannel *pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
        iSNDatolrv(x, pool[chan].volume, &outL, &outR);
    }
    slot->pan_left_cache = (unsigned char)outL;
    slot->pan_right_cache = (unsigned char)outR;
    iSNDsetvol(chan, outL, outR);
    return 0;
}

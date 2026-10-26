/* eaclib/psx/sndpsxz/sstvol.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sstvol.obj @0x800EA0D8 */
#include "sdata.h"
#include "sndserverpriv.h"
#include "sst.h"
#include "sstpriv.h"
#include "sstvol.h"
#include "svol.h"

/* SNDSTRM_vol : set a stream's volume (cached at +0x54) and apply it.
 * MATCH: the play-handle read is volatile, so an invalid stream cannot speculate a null-based load
 * into the `beqz` delay slot; this also reproduces the oracle's protective nop. */
int SNDSTRM_vol(int tag, int vol)
{
    SndStream *sp;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized) return -10;
    sp = iSNDstreamgetstreamptr(tag);
    if (!sp) return -8;
    sp->start_params.vol = (char)vol;
    SNDvol(*(volatile unsigned int *)&sp->start_result, vol);
    return 0;
}

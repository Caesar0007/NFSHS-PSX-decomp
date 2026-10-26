/* eaclib/psx/sndpsxz/sstautov.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sstautov.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800E9DE8.  SNDSTRM_autovol -- set a stream's auto-volume ramp.  Ghidra nfs4-f.exe.c + IDA sig
 *   (`this` is the stream tag).
 */
#include "sdata.h"
#include "sndserverpriv.h"
#include "sst.h"
#include "sstpriv.h"
#include "sstautov.h"
#include "sautovol.h"

/* SNDSTRM_autovol @0x800E9DE8 : store the target vol (+0x54) and start an auto-volume ramp over steps/10. */
int SNDSTRM_autovol(int tag, int steps, int vol)
{
    SndStream *s;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    s = iSNDstreamgetstreamptr(tag);
    if (!s)
        return -8;
    s->start_params.vol = (char)vol;
    SNDautovol(s->start_result, steps / 10, vol);
    return 0;
}

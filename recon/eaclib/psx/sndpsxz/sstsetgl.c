/* eaclib/psx/sndpsxz/sstsetgl.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sstsetgl.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800E9D30.  SNDSTRM_setgreedylevel -- forward a stream's greedy-prefetch level to the STREAM layer.
 *   Ghidra nfs4-f.exe.c + IDA sig (`this` is the stream tag).
 */
#include "../eacpsxz/stream.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sst.h"
#include "sstpriv.h"
#include "sstsetgl.h"

/* SNDSTRM_setgreedylevel @0x800E9D30 : -10 if uninit, -8 if no such stream, else set its greedy level. */
int SNDSTRM_setgreedylevel(int tag, int s)
{
    SndStream *p;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    p = iSNDstreamgetstreamptr(tag);
    if (!p)
        return -8;
    STREAM_setgreedylevel(p->stream_handle, s);
    return 0;
}

/* eaclib/psx/sndpsxz/sstsetgs.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sstsetgs.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800E9D8C.  SNDSTRM_setgreedystate -- forward a stream's greedy on/off state to the STREAM layer.
 *   Ghidra nfs4-f.exe.c + IDA sig (`this` is the stream tag).
 */
#include "../eacpsxz/stream.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sst.h"
#include "sstpriv.h"
#include "sstsetgs.h"

/* SNDSTRM_setgreedystate @0x800E9D8C : -10 if uninit, -8 if no such stream, else set its greedy state. */
int SNDSTRM_setgreedystate(int tag, int s)
{
    SndStream *p;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    p = iSNDstreamgetstreamptr(tag);
    if (!p)
        return -8;
    STREAM_setgreedystate(p->stream_handle, s);
    return 0;
}

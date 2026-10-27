/* eaclib/psx/sndpsxz/sstsetpr.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\sstsetpr.obj (SNDPSXZ.LIB).  1 fn @0x800E6CF0 : SNDSTRM_setpriority.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  EA SND streaming-audio (SNDSTRM_*) layer.
 *
 *   Look up the stream object for `streamid`; if found, forward its underlying handle (stream@+4)
 *   to the platform STREAM_setpriority.  Returns -10 if sound is disabled, -8 if the stream is
 *   unknown, else 0.
 */
#include "../eacpsxz/stream.h"
#include "sst.h"
#include "sstpriv.h"
#include "sstsetpr.h"
#include "../../../lib/snd.h"

int SNDSTRM_setpriority(int streamid, int prio, int a3)   /* @0x800E6CF0 */
{
    SndStream *strm;
    if (!SND->enabled)
        return -10;
    strm = iSNDstreamgetstreamptr(streamid);
    if (!strm)
        return -8;
    STREAM_setpriority(strm->stream_handle, prio, a3);
    return 0;
}

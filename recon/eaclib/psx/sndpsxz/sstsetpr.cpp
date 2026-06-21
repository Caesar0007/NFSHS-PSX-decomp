/* eaclib/psx/sndpsxz/sstsetpr.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\sstsetpr.obj (SNDPSXZ.LIB).  1 fn @0x800E6CF0 : SNDSTRM_setpriority.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  EA SND streaming-audio (SNDSTRM_*) layer.
 *
 *   Look up the stream object for `streamid`; if found, forward its underlying handle (stream@+4)
 *   to the platform STREAM_setpriority.  Returns -10 if sound is disabled, -8 if the stream is
 *   unknown, else 0.
 */
#include "../../../lib/snd.h"

extern "C" void *iSNDstreamgetstreamptr(int streamid);          /* @0x800E8C48 (sst.obj) */
extern "C" int   STREAM_setpriority(int handle, int prio, int a3); /* @0x800FD1F8 platform */

extern "C" int SNDSTRM_setpriority(int streamid, int prio, int a3)   /* @0x800E6CF0 */
{
    if (SND->enabled == 0)
        return -10;
    char *strm = (char *)iSNDstreamgetstreamptr(streamid);
    if (strm == 0)
        return -8;
    STREAM_setpriority(*(int *)(strm + 4), prio, a3);
    return 0;
}

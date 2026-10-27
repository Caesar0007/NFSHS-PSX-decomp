/* eaclib/psx/sndpsxz/spvoices.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
 *   Source obj : nfs4\eaclib\psx\spvoices.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   4 fns @[0x800E9B44 .. 0x800E9C58].  The PUBLIC SNDSTRM_* streaming-voice API -- a thin wrapper over
 *   the sst.obj internals (iSNDstream*).  Dual-source: Ghidra nfs4-f.exe.c L146576..146684 + disasm-v3
 *   L300275+ (for the dropped forwarder args).
 */

/* ---- sst.obj internals (the layer below) + stream/pktplay/ssysserv backends ---- */
#include "../eacpsxz/stream.h"
#include "spktplay.h"
#include "ssysserv.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "spvoices.h"
#include "sst.h"
#include "sstpriv.h"
#include "sndcrtpriv.h"

                      /* @0x8013EA80 stream slot ptr array */
                      /* (signed char)sndgs[0xf] = init flag, sndgs[0x22] = destroyall hook */


/* SNDSTRM_create @0x800E9B44 : create a streaming voice with its OWN ring (extHandle/extFlag forced 0).
 *   Returns the stream slot or a negative error. */
int SNDSTRM_create(struct SNDPLAYOPTS *priority, int numReq, int pktArg, char *objbuf, int memsize)
{
    return iSNDstreamcreate(priority, numReq, pktArg, objbuf, memsize, 0, 0);
}

/* SNDSTRM_destroy @0x800E9B70 : purge and tear down a streaming voice; when the last one goes, unhook the
 *   audio-server service callback.  Frees the packet player and (if owned) the ring. */
int SNDSTRM_destroy(int s)
{
    SndStream *S;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    S = iSNDstreamgetstreamptr(s);
    if (!S)
        return -8;

    SNDSTRM_purge(s);
    if (iSNDstreamnumcreated() == 1) {                  /* this is the last live stream */
        iSNDserverremoveclient(iSNDstreamservice);
        ((struct SndGlobalLifecycleHookView *)sndgs)->stream_destroy_all_hook = 0;
    }
    SNDPKTPLAY_destroy(S->packet_player);
    if (!S->external_stream)                         /* owns its ring */
        STREAM_destroy(S->stream_handle);
    sndss[s] = 0;
    return 0;
}

/* SNDSTRM_queuefile @0x800E9C38 : queue a sound from a file (mode 0). */
int SNDSTRM_queuefile(unsigned int s, int name, char *filename, int off)
{
    return iSNDstreamqueue(s, name, filename, off, 0);
}

/* SNDSTRM_purge @0x800E9C58 : stop playback, flush the ring, and reset the voice to an empty idle state
 *   (counters, parse index, and both format slots cleared) -- ready to be re-queued.
 *   MATCH: volatile byte clears preserve the oracle's 0x16/0x17/0x14 store order and make gcc
 *   prepare memset's size before them, leaving the call delay slot as the oracle's nop. */
int SNDSTRM_purge(int s)
{
    SndStream *S;
    int stopped;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    S = iSNDstreamgetstreamptr(s);
    if (!S)
        return -8;
    if (S->start_result < 0) {
        stopped = -1;
    } else {
        SNDPKTPLAY_stop(S->packet_player);               /* a play handle is active */
        stopped = -1;
    }
    ((volatile SndStream *)S)->start_result = stopped;
    if (!((volatile SndStream *)S)->external_stream)
        STREAM_kill(S->stream_handle);
    ((volatile SndStream *)S)->current_count = 0;        /* curReqCount */
    ((volatile SndStream *)S)->parse_index = 0;          /* parseIdx */
    ((volatile SndStream *)S)->state = 0;
    memset(&S->locked_rate, 0, sizeof(SNDSAMPLEFORMAT)); /* locked rate */
    memset(&S->current_rate, 0, sizeof(SNDSAMPLEFORMAT)); /* current rate */
    memset(&S->locked_header, 0, sizeof(SndPatchAttributes)); /* locked header */
    memset(&S->current_header, 0, sizeof(SndPatchAttributes)); /* current header */
    return 0;
}

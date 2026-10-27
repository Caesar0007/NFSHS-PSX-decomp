/* eaclib/psx/sndpsxz/sststat.c -- RECONSTRUCTED. NOT original.  *** 1/1 PASS ***  obj sststat.obj @0x800E86D8 */
#include "sdata.h"
#include "../../../shared/SNDSTREAMSTATUS.h"
#include "sndserverpriv.h"
#include "spktplay.h"
#include "sserver.h"
#include "sst.h"
#include "sstpriv.h"
#include "sststat.h"

/* SNDSTRM_status : fill the 3-int status block `status` for stream `tag`. */
int SNDSTRM_status(int tag, struct SNDSTREAMSTATUS *status)
{
    SndStream *sp;
    unsigned int frames, outstanding;
    status->timebuffered = 0;
    status->currentrequest = 0;
    status->outstandingrequests = 0;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized) return -10;
    sp = iSNDstreamgetstreamptr(tag);
    if (!sp) return -8;
    iSNDenteraudio();
    status->outstandingrequests = ((int)((unsigned)((volatile SndStream *)sp)->current_count << 24)) >> 24;
    if (sp->current_count) {
        status->currentrequest = sp->requests->request_id;
        frames = sp->locked_rate.samplerate;
        if (frames) {
            outstanding = SNDPKTPLAY_unsafeframesoutstanding(sp->packet_player);
            status->timebuffered =
                outstanding * 1000 / sp->locked_rate.samplerate;
        }
    }
    iSNDleaveaudio();
    return 0;
}

/* eaclib/psx/sndpsxz/sstrstat.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sstrstat.obj @0x800E87D0 */
#include "sdata.h"
#include "../../../shared/SNDREQUESTSTATUS.h"
#include "sndserverpriv.h"
#include "sserver.h"
#include "sst.h"
#include "sstpriv.h"
#include "sstgetrp.h"
#include "sstrstat.h"
#include "smath64.h"

/* SNDSTRM_requeststatus : fill the 4-int request-status block `status` (state, played, remaining, permille). */
int SNDSTRM_requeststatus(unsigned int reqTag, struct SNDREQUESTSTATUS *status)
{
    SndStream *sp;
    SndStreamReq *rp;
    unsigned int div;
    struct SNDu64Value q;
    status->state = 0;
    status->currenttime = 0;
    status->timetoend = 0;
    status->timebuffered = 0;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized) return -10;
    if (-1 >= (int)reqTag) return -8;
    sp = iSNDstreamgetstreamptr(reqTag & 0xff);
    if (!sp) return -8;
    iSNDenteraudio();
    rp = iSNDstreamgetrequestptr(reqTag);
    if (rp) {
        if (rp->firstqid < 0) {
            status->state = 0;
        } else {
            if (sp->requests == rp) { status->state = 2; div = sp->locked_rate.samplerate; }
            else                    { status->state = 1; div = sp->current_rate.samplerate; }
            (void)iSNDmulu64(&q, rp->bytes_consumed, 1000);
            status->currenttime = iSNDdivu64(q, div);
            (void)iSNDmulu64(&q, rp->total_size - rp->bytes_consumed, 1000);
            status->timetoend = iSNDdivu64(q, div);
            status->timebuffered = rp->remaining_bytes * 1000 / div;
        }
    } else {
        status->state = 3;
    }
    iSNDleaveaudio();
    return 0;
}

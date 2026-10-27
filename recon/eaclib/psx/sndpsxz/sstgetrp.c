/* eaclib/psx/sndpsxz/sstgetrp.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sstgetrp.obj @0x80103508 */
#include "sst.h"
#include "sstpriv.h"
#include "sstgetrp.h"

/* iSNDstreamgetrequestptr @0x80103508 : resolve a stream-request tag to its request struct -- find the
 *   stream (idx low byte), then scan its request array (0x2c stride, +4 == tag) for a match.  Returns the
 *   request ptr, or 0.
 * MATCH: (1) FLAT early-returns (`if(!cond) return 0;`) for all three exits instead of a nested
 * `if(sp!=0){...}` reproduces the oracle's basic-block layout/branch polarity for the idx/sp guards
 * (15->11 diffs). (2) the loop bound's count re-read (+0x16) needs the LITERAL oracle shift-chain
 * `((u8<<24)>>24)` via a `volatile` byte deref -- a plain `*(char*)` cast lets gcc cache/re-derive the
 * comparison from the earlier guard read instead of reloading+sign-extending fresh every iteration
 * (11->0; same lever as iSNDstreamparsenumchunks/sst.cpp). */
SndStreamReq *iSNDstreamgetrequestptr(unsigned int idx)
{
    SndStream *sp;
    SndStreamReq *rq;
    int i;
    if (-1 >= (int)idx)
        return 0;
    sp = iSNDstreamgetstreamptr((int)(idx & 0xff));
    if (!sp)
        return 0;
    if (!(0 < (int)((unsigned)sp->current_count << 0x18)))   /* (signed char) count > 0 */
        return 0;
    rq = sp->requests;
    i = 0;
    do {
        if (rq->request_id == idx)
            return rq;
        rq++;
        i++;
    } while (i < (((int)((volatile SndStream *)sp)->current_count << 24) >> 24));
    return 0;
}

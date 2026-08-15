/* eaclib/psx/sndpsxz/sstgetrp.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sstgetrp.obj @0x80103508 */
extern int iSNDstreamgetstreamptr(int tag);   /* sst */

extern int iSNDstreamgetrequestptr(unsigned int idx);   /* @0x80103508 */

/* iSNDstreamgetrequestptr @0x80103508 : resolve a stream-request tag to its request struct -- find the
 *   stream (idx low byte), then scan its request array (0x2c stride, +4 == tag) for a match.  Returns the
 *   request ptr, or 0.
 * MATCH: (1) FLAT early-returns (`if(!cond) return 0;`) for all three exits instead of a nested
 * `if(sp!=0){...}` reproduces the oracle's basic-block layout/branch polarity for the idx/sp guards
 * (15->11 diffs). (2) the loop bound's count re-read (+0x16) needs the LITERAL oracle shift-chain
 * `((u8<<24)>>24)` via a `volatile` byte deref -- a plain `*(char*)` cast lets gcc cache/re-derive the
 * comparison from the earlier guard read instead of reloading+sign-extending fresh every iteration
 * (11->0; same lever as iSNDstreamparsenumchunks/sst.cpp). */
extern int iSNDstreamgetrequestptr(unsigned int idx)
{
    int *sp;
    int  rq, i;
    if (-1 >= (int)idx)
        return 0;
    sp = (int *)iSNDstreamgetstreamptr((int)(idx & 0xff));
    if (sp == 0)
        return 0;
    if (!(0 < (int)((unsigned)*(unsigned char *)((int)sp + 0x16) << 0x18)))   /* (signed char) count > 0 */
        return 0;
    rq = *sp;
    i = 0;
    do {
        if (*(unsigned int *)(rq + 4) == idx)
            return rq;
        rq += 0x2c;
        i++;
    } while (i < (((int)(*(volatile unsigned char *)((int)sp + 0x16)) << 24) >> 24));
    return 0;
}

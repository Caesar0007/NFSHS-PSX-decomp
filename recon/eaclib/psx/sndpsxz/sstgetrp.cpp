/* eaclib/psx/sndpsxz/sstgetrp.cpp -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sstgetrp.obj @0x80103508 */
extern "C" int iSNDstreamgetstreamptr(int tag);   /* sst */

extern "C" int iSNDstreamgetrequestptr(unsigned int idx);   /* @0x80103508 */

/* iSNDstreamgetrequestptr @0x80103508 : resolve a stream-request tag to its request struct -- find the
 *   stream (idx low byte), then scan its request array (0x2c stride, +4 == tag) for a match.  Returns the
 *   request ptr, or 0. */
extern "C" int iSNDstreamgetrequestptr(unsigned int idx)
{
    int *sp;
    int  rq, i;
    if (-1 >= (int)idx)
        return 0;
    sp = (int *)iSNDstreamgetstreamptr((int)(idx & 0xff));
    if (sp == 0)
        return 0;
    i = 0;
    /* near-miss (15 diffs): the three `return 0`/`return rq` exits are laid out differently by gcc-2.8.0's
     * basic-block ordering vs the oracle's shared-tail funnel (`beqz a1` to the final `addu v0,zero,zero`);
     * an `if(sp!=0)`-nest re-broke the idx check's polarity instead. Permuter multi-basin candidate. */
    if (0 < (int)((unsigned)*(unsigned char *)((int)sp + 0x16) << 0x18)) {   /* (signed char) count > 0 */
        rq = *sp;
        do {
            if (*(unsigned int *)(rq + 4) == idx)
                return rq;
            rq += 0x2c;
            i++;
        } while (i < (int)*(char *)((int)sp + 0x16));
    }
    return 0;
}

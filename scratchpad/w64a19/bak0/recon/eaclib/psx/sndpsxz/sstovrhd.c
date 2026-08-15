/* eaclib/psx/sndpsxz/sstovrhd.c -- RECONSTRUCTED. NOT original.  *** 2/2 ***  obj sstovrhd.obj @[0x800EA054..0x800EA094] */
extern int SNDPKTPLAY_overhead(int numReq);          /* spktplay */
extern int STREAM_overhead(int numReq, int a, int b);/* stream   */
extern int SNDSTRM_overheadtap(int numConsumers, int numReq);  /* @0x800EA054 */
extern int SNDSTRM_overhead(int numConsumers, int numReq);     /* @0x800EA094 */
/* SNDSTRM_overheadtap : per-consumer + packet-player byte overhead.  (Ghidra dropped SNDPKTPLAY_overhead's
   return into in_v0; restored here.) */
extern int SNDSTRM_overheadtap(int numConsumers, int numReq)
{
    int oh = numConsumers * 0x2c + 0x60;   /* compute the per-consumer overhead BEFORE the call so it is
                                            * held in a callee-saved reg (s0) across it (§3.12 #16) */
    return oh + SNDPKTPLAY_overhead(numReq);
}
/* SNDSTRM_overhead : total stream-object byte overhead. */
extern int SNDSTRM_overhead(int numConsumers, int numReq)
{
    /* MATCH (NFS4 sound overhead map + disasm-v4 trace, 18->0 diffs): accumulate into `oh`
     * before returning.  This keeps `oh` and numConsumers simultaneously live across the second
     * call, recovering the oracle's s0/s1 pair and 32-byte frame. */
    int oh = SNDSTRM_overheadtap(numConsumers, numReq);
    oh += STREAM_overhead(numConsumers + 1, 1, 1);
    return oh;
}

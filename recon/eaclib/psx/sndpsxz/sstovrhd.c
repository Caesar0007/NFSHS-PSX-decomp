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
    return SNDSTRM_overheadtap(numConsumers, numReq) + STREAM_overhead(numConsumers + 1, 1, 1);
}

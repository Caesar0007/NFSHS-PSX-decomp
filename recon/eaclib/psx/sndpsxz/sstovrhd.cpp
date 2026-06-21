/* eaclib/psx/sndpsxz/sstovrhd.cpp -- RECONSTRUCTED. NOT original.  *** 2/2 ***  obj sstovrhd.obj @[0x800EA054..0x800EA094] */
extern "C" int SNDPKTPLAY_overhead(int numReq);          /* spktplay */
extern "C" int STREAM_overhead(int numReq, int a, int b);/* stream   */
extern "C" int SNDSTRM_overheadtap(int numConsumers, int numReq);  /* @0x800EA054 */
extern "C" int SNDSTRM_overhead(int numConsumers, int numReq);     /* @0x800EA094 */
/* SNDSTRM_overheadtap : per-consumer + packet-player byte overhead.  (Ghidra dropped SNDPKTPLAY_overhead's
   return into in_v0; restored here.) */
extern "C" int SNDSTRM_overheadtap(int numConsumers, int numReq)
{
    return numConsumers * 0x2c + 0x60 + SNDPKTPLAY_overhead(numReq);
}
/* SNDSTRM_overhead : total stream-object byte overhead. */
extern "C" int SNDSTRM_overhead(int numConsumers, int numReq)
{
    return SNDSTRM_overheadtap(numConsumers, numReq) + STREAM_overhead(numConsumers + 1, 1, 1);
}

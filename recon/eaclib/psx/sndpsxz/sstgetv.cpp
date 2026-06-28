/* eaclib/psx/sndpsxz/sstgetv.cpp -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sstgetv.obj @0x800E83EC */
extern "C" int sndgs[];
extern "C" int iSNDstreamgetstreamptr(int tag);   /* sst     */
extern "C" int SNDgetvol(unsigned int tag);       /* sgetvol */
extern "C" void SNDSTRM_getvol(int tag);          /* @0x800E83EC */
/* SNDSTRM_getvol : query a stream's current volume. */
extern "C" void SNDSTRM_getvol(int tag)
{
    int sp;
    if ((signed char)sndgs[0xf] != 0 && (sp = iSNDstreamgetstreamptr(tag)) != 0)
        SNDgetvol(*(unsigned int *)(sp + 8));
}

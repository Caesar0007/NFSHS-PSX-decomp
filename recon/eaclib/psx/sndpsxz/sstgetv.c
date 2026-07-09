/* eaclib/psx/sndpsxz/sstgetv.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sstgetv.obj @0x800E83EC */
extern int sndgs[];
extern int iSNDstreamgetstreamptr(int tag);   /* sst     */
extern int SNDgetvol(unsigned int tag);       /* sgetvol */
extern void SNDSTRM_getvol(int tag);          /* @0x800E83EC */
/* SNDSTRM_getvol : query a stream's current volume. */
extern void SNDSTRM_getvol(int tag)
{
    int sp;
    if ((signed char)sndgs[0xf] != 0 && (sp = iSNDstreamgetstreamptr(tag)) != 0)
        SNDgetvol(*(unsigned int *)(sp + 8));
}

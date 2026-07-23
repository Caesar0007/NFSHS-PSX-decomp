/* eaclib/psx/sndpsxz/sstgetv.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sstgetv.obj @0x800E83EC */
extern int sndgs[];
extern int iSNDstreamgetstreamptr(int tag);   /* sst     */
extern int SNDgetvol(unsigned int tag);       /* sgetvol */
extern int SNDSTRM_getvol(int tag);           /* @0x800E83EC */
/* SNDSTRM_getvol : query a stream's current volume. */
extern int SNDSTRM_getvol(int tag)
{
    int sp, vol;
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    sp = iSNDstreamgetstreamptr(tag);
    if (sp == 0)
        return -8;
    vol = SNDgetvol(*(unsigned int *)(sp + 8));
    if (vol < 0)
        vol = *(signed char *)(sp + 0x54);
    return vol;
}

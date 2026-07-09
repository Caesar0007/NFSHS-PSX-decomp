/* eaclib/psx/sndpsxz/sststat.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sststat.obj @0x800E86D8 */
extern int sndgs[];
extern int  iSNDstreamgetstreamptr(int tag);                       /* sst      */
extern int  SNDPKTPLAY_unsafeframesoutstanding(int player);        /* spktplay */
extern void iSNDenteraudio(void);                                  /* sserver  */
extern void iSNDleaveaudio(void);
extern void trap(unsigned int code);
extern int  SNDSTRM_status(int tag, int s);   /* @0x800E86D8 */
/* SNDSTRM_status : fill the 3-int status block `s` (active, bytes, permille) for stream `tag`. */
extern int SNDSTRM_status(int tag, int s)
{
    int *sp;
    unsigned int frames;
    *(int *)(s + 8) = 0;
    *(int *)(s + 4) = 0;
    *(int *)s = 0;
    if ((signed char)sndgs[0xf] == 0) return -10;
    sp = (int *)iSNDstreamgetstreamptr(tag);
    if (sp == 0) return -8;
    iSNDenteraudio();
    *(int *)s = (int)*(char *)((int)sp + 0x16);
    if (*(char *)((int)sp + 0x16) != 0) {
        *(int *)(s + 4) = *(int *)(*sp + 4);
        frames = (unsigned int)*(unsigned short *)(sp + 7);
        if (frames != 0) {
            SNDPKTPLAY_unsafeframesoutstanding(sp[3]);
            *(unsigned int *)(s + 8) = (frames * 1000) / (unsigned int)*(unsigned short *)(sp + 7);
        }
    }
    iSNDleaveaudio();
    return 0;
}

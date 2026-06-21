/* eaclib/psx/sndpsxz/sststat.cpp -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sststat.obj @0x800E86D8 */
extern "C" int sndgs[];
extern "C" int  iSNDstreamgetstreamptr(int tag);                       /* sst      */
extern "C" int  SNDPKTPLAY_unsafeframesoutstanding(int player);        /* spktplay */
extern "C" void iSNDenteraudio(void);                                  /* sserver  */
extern "C" void iSNDleaveaudio(void);
extern "C" void trap(unsigned int code);
extern "C" int  SNDSTRM_status(int tag, int s);   /* @0x800E86D8 */
/* SNDSTRM_status : fill the 3-int status block `s` (active, bytes, permille) for stream `tag`. */
extern "C" int SNDSTRM_status(int tag, int s)
{
    int *sp;
    unsigned int frames;
    *(int *)(s + 8) = 0;
    *(int *)(s + 4) = 0;
    *(int *)s = 0;
    if ((char)sndgs[0xf] == 0) return -10;
    sp = (int *)iSNDstreamgetstreamptr(tag);
    if (sp == 0) return -8;
    iSNDenteraudio();
    *(int *)s = (int)*(char *)((int)sp + 0x16);
    if (*(char *)((int)sp + 0x16) != 0) {
        *(int *)(s + 4) = *(int *)(*sp + 4);
        frames = (unsigned int)*(unsigned short *)(sp + 7);
        if (frames != 0) {
            SNDPKTPLAY_unsafeframesoutstanding(sp[3]);
            if (*(unsigned short *)(sp + 7) == 0) trap(0x1c00);
            *(unsigned int *)(s + 8) = (frames * 1000) / (unsigned int)*(unsigned short *)(sp + 7);
        }
    }
    iSNDleaveaudio();
    return 0;
}

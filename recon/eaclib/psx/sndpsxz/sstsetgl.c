/* eaclib/psx/sndpsxz/sstsetgl.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sstsetgl.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800E9D30.  SNDSTRM_setgreedylevel -- forward a stream's greedy-prefetch level to the STREAM layer.
 *   Ghidra nfs4-f.exe.c + IDA sig (`this` is the stream tag).
 */
extern int  sndgs[];
extern int  iSNDstreamgetstreamptr(int tag);            /* sst */
extern void STREAM_setgreedylevel(int stream, int s);   /* eacpsxz stream.obj */

extern int SNDSTRM_setgreedylevel(int tag, int s);      /* @0x800E9D30 */

/* SNDSTRM_setgreedylevel @0x800E9D30 : -10 if uninit, -8 if no such stream, else set its greedy level. */
extern int SNDSTRM_setgreedylevel(int tag, int s)
{
    int p;
    if ((signed char)sndgs[0xf] == '\0')
        return -10;
    p = iSNDstreamgetstreamptr(tag);
    if (p == 0)
        return -8;
    STREAM_setgreedylevel(*(int *)(p + 4), s);
    return 0;
}

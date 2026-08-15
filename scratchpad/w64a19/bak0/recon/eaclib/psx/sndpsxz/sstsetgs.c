/* eaclib/psx/sndpsxz/sstsetgs.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sstsetgs.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800E9D8C.  SNDSTRM_setgreedystate -- forward a stream's greedy on/off state to the STREAM layer.
 *   Ghidra nfs4-f.exe.c + IDA sig (`this` is the stream tag).
 */
extern int  sndgs[];
extern int  iSNDstreamgetstreamptr(int tag);            /* sst */
extern void STREAM_setgreedystate(int stream, int s);   /* eacpsxz stream.obj */

extern int SNDSTRM_setgreedystate(int tag, int s);      /* @0x800E9D8C */

/* SNDSTRM_setgreedystate @0x800E9D8C : -10 if uninit, -8 if no such stream, else set its greedy state. */
extern int SNDSTRM_setgreedystate(int tag, int s)
{
    int p;
    if ((signed char)sndgs[0xf] == '\0')
        return -10;
    p = iSNDstreamgetstreamptr(tag);
    if (p == 0)
        return -8;
    STREAM_setgreedystate(*(int *)(p + 4), s);
    return 0;
}

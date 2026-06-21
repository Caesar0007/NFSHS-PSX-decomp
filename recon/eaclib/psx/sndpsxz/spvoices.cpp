/* eaclib/psx/sndpsxz/spvoices.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
 *   Source obj : nfs4\eaclib\psx\spvoices.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   4 fns @[0x800E9B44 .. 0x800E9C58].  The PUBLIC SNDSTRM_* streaming-voice API -- a thin wrapper over
 *   the sst.obj internals (iSNDstream*).  Dual-source: Ghidra nfs4-f.exe.c L146576..146684 + disasm-v3
 *   L300275+ (for the dropped forwarder args).
 */

/* ---- sst.obj internals (the layer below) + stream/pktplay/ssysserv backends ---- */
extern "C" int  iSNDstreamcreate(int *priority, int numReq, int pktArg, int objbuf,
                                 int memsize, int extHandle, int extFlag);   /* @0x800E9730 */
extern "C" int  iSNDstreamgetstreamptr(int idx);                            /* @0x800E8C48 */
extern "C" int  iSNDstreamnumcreated(void);                                 /* @0x800E96F8 */
extern "C" int  iSNDstreamqueue(unsigned int s, int name, char *filename, int off, int mode); /* @0x800E9970 */
extern "C" void iSNDstreamservice(void);                                    /* @0x800E9590 (serve hook) */
extern "C" void SNDPKTPLAY_destroy(int pktplay);                            /* spktplay */
extern "C" void SNDPKTPLAY_stop(int pktplay);
extern "C" void STREAM_destroy(int strm);                                   /* stream.obj */
extern "C" void STREAM_kill(int strm);
extern "C" void iSNDserverremoveclient(void *cb);                           /* ssysserv */
extern "C" void *memset(void *d, int c, int n);

extern "C" int sndss;                       /* @0x8013EA80 */
extern "C" int sndgs[];                      /* (char)sndgs[0xf] = init flag, sndgs[0x22] = destroyall hook */

#define MI(p,o) (*(int*)((p)+(o)))
#define MB(p,o) (*(unsigned char*)((p)+(o)))

extern "C" void SNDSTRM_purge(int s);        /* @0x800E9C58 (fwd: destroy calls it) */

/* SNDSTRM_create @0x800E9B44 : create a streaming voice with its OWN ring (extHandle/extFlag forced 0).
 *   Returns the stream slot or a negative error. */
extern "C" int SNDSTRM_create(int *priority, int numReq, int pktArg, int objbuf, int memsize)
{
    return iSNDstreamcreate(priority, numReq, pktArg, objbuf, memsize, 0, 0);
}

/* SNDSTRM_destroy @0x800E9B70 : purge and tear down a streaming voice; when the last one goes, unhook the
 *   audio-server service callback.  Frees the packet player and (if owned) the ring. */
extern "C" int SNDSTRM_destroy(int s)
{
    int S;
    if ((char)sndgs[0xf] == 0)
        return -10;
    S = iSNDstreamgetstreamptr(s);
    if (S == 0)
        return -8;

    SNDSTRM_purge(s);
    if (iSNDstreamnumcreated() == 1) {                  /* this is the last live stream */
        iSNDserverremoveclient((void *)iSNDstreamservice);
        sndgs[0x22] = 0;
    }
    SNDPKTPLAY_destroy(MI(S, 0xc));
    if (MB(S, 0x18) == 0)                                /* owns its ring */
        STREAM_destroy(MI(S, 4));
    (&sndss)[s] = 0;
    return 0;
}

/* SNDSTRM_queuefile @0x800E9C38 : queue a sound from a file (mode 0). */
extern "C" int SNDSTRM_queuefile(unsigned int s, int name, char *filename, int off)
{
    return iSNDstreamqueue(s, name, filename, off, 0);
}

/* SNDSTRM_purge @0x800E9C58 : stop playback, flush the ring, and reset the voice to an empty idle state
 *   (counters, parse index, and both format slots cleared) -- ready to be re-queued. */
extern "C" void SNDSTRM_purge(int s)
{
    int S;
    if ((char)sndgs[0xf] != 0 && (S = iSNDstreamgetstreamptr(s)) != 0) {
        if (-1 < MI(S, 8))                              /* a play handle is active */
            SNDPKTPLAY_stop(MI(S, 0xc));
        MI(S, 8) = -1;
        if (MB(S, 0x18) == 0)
            STREAM_kill(MI(S, 4));
        MB(S, 0x16) = 0;                                /* curReqCount */
        MB(S, 0x17) = 0;                                /* parseIdx */
        MB(S, 0x14) = 0;                                /* state */
        memset((void *)(S + 0x1c), 0, 4);               /* locked rate */
        memset((void *)(S + 0x20), 0, 4);               /* current rate */
        memset((void *)(S + 0x24), 0, 0x14);            /* locked header */
        memset((void *)(S + 0x38), 0, 0x14);            /* current header */
    }
}

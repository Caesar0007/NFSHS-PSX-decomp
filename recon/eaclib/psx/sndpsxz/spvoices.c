/* eaclib/psx/sndpsxz/spvoices.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
 *   Source obj : nfs4\eaclib\psx\spvoices.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   4 fns @[0x800E9B44 .. 0x800E9C58].  The PUBLIC SNDSTRM_* streaming-voice API -- a thin wrapper over
 *   the sst.obj internals (iSNDstream*).  Dual-source: Ghidra nfs4-f.exe.c L146576..146684 + disasm-v3
 *   L300275+ (for the dropped forwarder args).
 */

/* ---- sst.obj internals (the layer below) + stream/pktplay/ssysserv backends ---- */
extern int  iSNDstreamcreate(int *priority, int numReq, int pktArg, int objbuf,
                                 int memsize, int extHandle, int extFlag);   /* @0x800E9730 */
extern int  iSNDstreamgetstreamptr(int idx);                            /* @0x800E8C48 */
extern int  iSNDstreamnumcreated(void);                                 /* @0x800E96F8 */
extern int  iSNDstreamqueue(unsigned int s, int name, char *filename, int off, int mode); /* @0x800E9970 */
extern void iSNDstreamservice(void);                                    /* @0x800E9590 (serve hook) */
extern void SNDPKTPLAY_destroy(int pktplay);                            /* spktplay */
extern void SNDPKTPLAY_stop(int pktplay);
extern void STREAM_destroy(int strm);                                   /* stream.obj */
extern void STREAM_kill(int strm);
extern void iSNDserverremoveclient(void *cb);                           /* ssysserv */
extern void *memset(void *d, int c, int n);

extern int sndss[];                      /* @0x8013EA80 stream slot ptr array */
extern int sndgs[];                      /* (signed char)sndgs[0xf] = init flag, sndgs[0x22] = destroyall hook */

#define MI(p,o) (*(int*)((p)+(o)))
#define MB(p,o) (*(unsigned char*)((p)+(o)))

extern int SNDSTRM_purge(int s);         /* @0x800E9C58 (fwd: destroy calls it) */

/* SNDSTRM_create @0x800E9B44 : create a streaming voice with its OWN ring (extHandle/extFlag forced 0).
 *   Returns the stream slot or a negative error. */
extern int SNDSTRM_create(int *priority, int numReq, int pktArg, int objbuf, int memsize)
{
    return iSNDstreamcreate(priority, numReq, pktArg, objbuf, memsize, 0, 0);
}

/* SNDSTRM_destroy @0x800E9B70 : purge and tear down a streaming voice; when the last one goes, unhook the
 *   audio-server service callback.  Frees the packet player and (if owned) the ring. */
extern int SNDSTRM_destroy(int s)
{
    int S;
    if ((signed char)sndgs[0xf] == 0)
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
    sndss[s] = 0;
    return 0;
}

/* SNDSTRM_queuefile @0x800E9C38 : queue a sound from a file (mode 0). */
extern int SNDSTRM_queuefile(unsigned int s, int name, char *filename, int off)
{
    return iSNDstreamqueue(s, name, filename, off, 0);
}

/* SNDSTRM_purge @0x800E9C58 : stop playback, flush the ring, and reset the voice to an empty idle state
 *   (counters, parse index, and both format slots cleared) -- ready to be re-queued.
 *   MATCH: volatile byte clears preserve the oracle's 0x16/0x17/0x14 store order and make gcc
 *   prepare memset's size before them, leaving the call delay slot as the oracle's nop. */
extern int SNDSTRM_purge(int s)
{
    int S;
    int stopped;
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    S = iSNDstreamgetstreamptr(s);
    if (S == 0)
        return -8;
    if (MI(S, 8) < 0) {
        stopped = -1;
    } else {
        SNDPKTPLAY_stop(MI(S, 0xc));                     /* a play handle is active */
        stopped = -1;
    }
    *(volatile int *)(S + 8) = stopped;
    if (*(volatile unsigned char *)(S + 0x18) == 0)
        STREAM_kill(MI(S, 4));
    *(volatile unsigned char *)(S + 0x16) = 0;           /* curReqCount */
    *(volatile unsigned char *)(S + 0x17) = 0;           /* parseIdx */
    *(volatile unsigned char *)(S + 0x14) = 0;           /* state */
    memset((void *)(S + 0x1c), 0, 4);                   /* locked rate */
    memset((void *)(S + 0x20), 0, 4);                   /* current rate */
    memset((void *)(S + 0x24), 0, 0x14);                /* locked header */
    memset((void *)(S + 0x38), 0, 0x14);                /* current header */
    return 0;
}

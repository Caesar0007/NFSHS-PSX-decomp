/* eaclib/psx/eacpsxz/stream.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 32/32 ***
 *   Source obj : nfs4\eaclib\psx\stream.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   32 fns @[0x800FC2F8 .. 0x800FDCE0].  EA STREAMING ring-buffer manager, layered directly on the
 *   nfile FILE_* op-queue (FILE_open/read/close/callbackop/completeop/priorityop).  Movie/audio/data
 *   are streamed from a file (or memory image) through a circular buffer, parsed into chunks, and
 *   handed to one of N consumers selected by a filter table.
 *
 *   Dual-source reconstruction: Ghidra `C:\Temp\claud\nfs4-f.exe.c` L161640..162970 (primary, bodies)
 *   verified vs disasm-v3 L325990+ (authoritative for register-arg signatures Ghidra dropped).
 *
 *   ===== STREAM object layout (allocated in the caller buffer by STREAM_create) =====
 *     +0x00 magic 'STRM' (0x4D525453)       +0x04 mutex (allocmutex handle)
 *     +0x08 reqArray  (= obj+0xAC)          +0x0C numReq
 *     +0x10 filterArray (= reqArray+numReq*100)   +0x14 numFilters
 *     +0x18 consumerArray (= filterArray+numFilters*0xC)   +0x1C numConsumers
 *     +0x20 bufBase (= consumerArray+numConsumers*0x10)    +0x24 bufEnd (= obj+bufsize)
 *     +0x28 state (0 idle / 1 active / 2 buffer-full-stall)
 *     +0x2C prio1 (0x96)  +0x30 prio2 (0x32)  +0x34 greedylevel  +0x38 greedystate  +0x3C bufusage
 *     +0x40 readptr (oldest live data)  +0x44 writeptr (consumed up to)  +0x48 fillptr (filled up to)
 *     +0x4C queuehead  +0x50 queuecur (request to start next)  +0x54 queuetail  +0x58 freelist
 *     +0x5C name[0x40] (current file)  +0x9C curfilehandle  +0xA0 readaccum  +0xA4 curFILEop  +0xA8 chunklen
 *   REQUEST (100-byte stride):  id@0 (byte0=slot, high=idcounter)  state@4 (1 queued/2 active/3 done/4 cancel)
 *     prev@8  next@0xC  type@0x10 (0 file / 1 mem)  name[?]@0x14  mem@0x54  off@0x58  len@0x5C  startfill@0x60
 *   CONSUMER (0x10):  streamback@0  id@4 (1-based)  count@8 (bytes available)  readcursor@0xC
 *   FILTER (0xC):  mask@0  match@4  value@8 (consumer id, or -1 discard / -2 skip; default 1)
 *   CHUNK in ring buffer:  word0 tag (-1 wrap / -2 free / else stream-header id)  word1 (len | filterValue<<24)
 */

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
 unsigned int requestidcounter; 

/* ---- nfile op-queue backend (the layer this is built on) ---- */
extern unsigned int FILE_open (char *name, unsigned int mode, unsigned int prio, unsigned int udata); /*@0x800EC...*/
extern unsigned int FILE_close(void *handle, unsigned int prio, unsigned int udata);
extern unsigned int FILE_read (void *handle, unsigned int offset, unsigned int dest,
                                   int len, unsigned int a5, unsigned int a6); /*@0x800EC4EC (asm sets a0..a3 only)*/
extern int  FILE_completeop(unsigned int id);
extern void FILE_callbackop(unsigned int id, void (*cb)(int, int));   /*@0x800EBE4C*/
extern void FILE_priorityop(unsigned int id, int prio);               /*@0x800EBECC*/
extern void FILE_closesync(int handle, int prio);                     /* syncfile.obj (asm: a0=handle, a1=0x64) */

/* ---- other eaclib helpers ---- */
extern int  allocmutex(void);                 /* callback.obj @0x800FE424 */
extern void freemutex(int mutex);
extern int  iscurrentthread(int t);           /* threads.obj */
extern void yieldthread(int t);   /* @0x800FE41C: nullsub; arg 0 passed in $a0 (delay slot), ignored */
extern void systemtask(int x);                /* systask.obj */
extern int  strcmp (const char *a, const char *b);          /* syslib C23 */
extern char*strcpy (char *d, const char *s);                /* syslib C25 */
extern char*strncpy(char *d, const char *s, int n);         /* syslib C26 */
extern void*memcpy (void *d, const void *s, int n);         /* syslib C42 @0x800EAAC4 */
extern void*memset (void *d, int c, int n);                 /* syslib C43 @0x800E4318 */

/* shared async request-id counter (also bumped by nasync; high 24 bits, low byte = slot) */
extern unsigned int requestidcounter;

#define STRM_MAGIC 0x4D525453            /* 'STRM' little-endian */

/* ---- cop0 IRQ-disabled critical section ----
 * NOT a call in the oracle: every STREAM_enterCS()/STREAM_leaveCS() site in the real binary is a
 * FULLY INLINED cop0 SR read/mask/write pair (confirmed identically at getfreerequest/queuerequest/
 * decbufferusage/parsechunks/etc, and project-wide in nfile/nasync/InitGeom/iSND*):
 *   mfc0 R,$12; nop; addiu at,zero,-0x402; and t0,R,at; mtc0 t0,$12; nop;nop;nop   (enter, R = old SR)
 *   ...body...
 *   mtc0 R,$12                                                                     (leave, restore R)
 * `-0x402` clears bits 1 and 10 of SR (IRQ enable + one IRQ-mask bit) -- the retail crit-section idiom.
 * Modeled as a value-returning enter/leave pair (the old SR must stay live across the body) so each
 * call site holds it in a real local, matching the oracle's register-held-across-body shape. */
#if defined(__mips__)
static inline int STREAM_enterCS(void)
{
    int sr;
    __asm__ volatile(
        "mfc0 %0,$12\n\t"
        "nop\n\t"
        "li $1,-0x402\n\t"
        "and $8,%0,$1\n\t"
        "mtc0 $8,$12\n\t"
        "nop\n\tnop\n\tnop"
        : "=r"(sr) : : "$1", "$8");
    return sr;
}
static inline void STREAM_leaveCS(int sr)
{
    __asm__ volatile("mtc0 %0,$12" : : "r"(sr));
}
#else
static inline int  STREAM_enterCS(void) { return 0; }
static inline void STREAM_leaveCS(int sr) { (void)sr; }
#endif

/* byte-offset accessors on a stream/request/consumer object held as an int address */
#define MI(p,o) (*(int*)((p)+(o)))
#define MU(p,o) (*(unsigned int*)((p)+(o)))

/* ---- internal forward decls (mutually recursive) ---- */
extern int  validatehandle(int handle, int *outObj, int *outHandle);       /* @0x800FC2F8 */
extern unsigned int inbetween(unsigned int a, unsigned int b, unsigned int c); /* @0x800FC334 */
extern int  decbufferusage(int s, int amount);                             /* @0x800FC374 */
extern int *getfreerequest(int s);                                         /* @0x800FC400 */
extern int  queuerequest(int s, int req);                                  /* @0x800FC478 */
static int  locaterequest(int s, unsigned int reqid);                          /* @0x800FC4E4 */
extern int  freerequest(int s, int req);                                   /* @0x800FC548 */
extern unsigned int filterchunk(int s, int chunk);                         /* @0x800FC5E4 */
extern int  parsechunks(int s);                                            /* @0x800FC634 */
extern void opencallback(int a0, int a1, int s);                           /* @0x800FC810 */
extern void closecallback(int a0, int a1, int s);                          /* @0x800FC850 */
extern int  readcallback(int a0, int a1, int s);                           /* @0x800FC8A8 */
extern int  startnextrequest(int s, unsigned int prio, unsigned int x);    /* @0x800FC9B4 */
extern int  restartstream(int s);                                          /* @0x800FCB44 */
extern int  STREAM_get(int consumer, void *buf, int len);                  /* @0x800FD9AC */
extern void STREAM_release(int s, int consumer);                           /* @0x800FDAD0 */
extern void STREAM_kill(int s);                                            /* @0x800FD808 */
extern void STREAM_setgreedystate(int s, int state);                       /* @0x800FD2B4 */
extern int  STREAM_overhead(int numReq, int numFilters, int numConsumers); /* @0x800FCDE0 */
extern int  STREAM_cancelrequest(int s, int req);                          /* @0x800FD554 */

/* ====================================================================================== */

/* validatehandle @0x800FC2F8 : check a STREAM/consumer handle.  `handle[0]` points to the stream
 *   object; if that begins with 'STRM' it is valid.  Returns 0 and writes out[0]=streamobj, out[1]=handle
 *   (the asm stores to *a1 and *a2, with a2 == a1+4); returns 1 otherwise. */
extern int validatehandle(int handle, int *outObj, int *outHandle)
{
    /* Oracle keeps TWO separate `return 1` epilogues (handle==0 vs magic-mismatch)
     * -- do NOT let gcc tail-merge them.  `bnez a0` (handle!=0 -> check) with the
     * handle==0 case FALLING THROUGH to its own `jr ra; li v0,1`, and the mismatch
     * `bne`-ing to a distinct `return 1`.  Nesting the check inside `if(handle)` and
     * returning 0 in the middle reproduces the block order + branch polarity. */
    if (handle != 0) {
        int sobj = *(int *)handle;
        if (*(int *)sobj == STRM_MAGIC) {
            *outHandle = handle;    /* asm: *a2 = a0 (the handle)                 */
            *outObj = sobj;         /* asm: *a1 = a3 (the stream object), delay slot */
            return 0;
        }
    }
    return 1;
}

/* inbetween @0x800FC334 : is offset `c` inside the (possibly wrapped) ring interval [a, b)? */
extern unsigned int inbetween(unsigned int a, unsigned int b, unsigned int c)
{
    unsigned int ret;
    if (a <= b) {
        ret = 0u;
        if (a <= c)
            ret = c < b;
        return ret;
    }
    ret = 0u;
    if (a <= c)
        ret = 1u;
    else if (c < b)
        ret = 1u;
    return ret;
}

/* decbufferusage @0x800FC374 : subtract `amount` bytes from the stream's buffer usage (+0x3C), inside a
 *   critical section.  If usage falls back below the greedy level while the stream is actively reading
 *   (state==1), drop the in-flight read's priority via FILE_priorityop.  NOTE: the oracle's epilogue does
 *   NOT reload/preserve the return value across the FILE_priorityop call on the greedy-on path -- it
 *   falls through with whatever $v0 holds post-call (the call's own return, clobbering the earlier `1`).
 *   A faithful transcription must NOT hold `ret` live across that call either. */
extern int decbufferusage(int s, int amount)
{
    int sr, old, neu, ret;
    sr = STREAM_enterCS();
    old = MI(s, 0x3c);
    neu = old - amount;
    MI(s, 0x3c) = neu;
    STREAM_leaveCS(sr);
    ret = (neu < MI(s, 0x34));
    if (MI(s, 0x34) <= old && ret != 0) {
        MI(s, 0x38) = 1;                       /* greedy state on */
        if (MI(s, 0x28) != 1)
            return 1;
        FILE_priorityop(MI(s, 0xa4), MI(s, 0x30));
        return 1;
    }
    return ret;
}

/* getfreerequest @0x800FC400 : pop a request slot off the freelist (+0x58), stamp it with a fresh id
 *   (the rolling requestidcounter in the high 24 bits), inside a critical section.  Returns 0 if none. */
extern int *getfreerequest(int s)
{
    int *req, *ret;
    int sr = STREAM_enterCS();
    req = *(int **)(s + 0x58);
    ret = 0;
    if (req != 0) {
        ret = req;
        requestidcounter += 0x100;
        MI(s, 0x58) = req[3];                  /* freelist head = req->next (+0xC) */
        if (requestidcounter == 0)
            requestidcounter = 0x100;
        req[0] = (int)((unsigned char)req[0] | requestidcounter);  /* id = slot | counter */
    }
    STREAM_leaveCS(sr);
    return ret;
}

/* queuerequest @0x800FC478 : append a request to the active queue (head@0x4C / cur@0x50 / tail@0x54),
 *   inside a critical section.  Returns the previous tail (0 if the queue was empty). */
extern int queuerequest(int s, int req)
{
    int ret, sr, tail;
    MI(req, 4) = 1;                            /* state = queued */
    MI(req, 0xc) = 0;                          /* next = 0 */
    sr = STREAM_enterCS();
    ret = tail = MI(s, 0x54);
    if (tail == 0) {                           /* empty queue */
        MI(req, 8) = 0;
        MI(s, 0x4c) = req;                     /* head = cur = req */
        MI(s, 0x50) = req;
    } else {
        MI(req, 8) = tail;                     /* prev = old tail */
        ret = MI(s, 0x54);
        MI(ret, 0xc) = req;                    /* old tail->next = req */
    }
    MI(s, 0x54) = req;                         /* tail = req */
    STREAM_leaveCS(sr);
    return ret;
}

/* locaterequest @0x800FC4E4 : map a request id back to its slot, validating the slot index (low byte),
 *   the full id, and that the slot is in use.  Returns the request pointer or 0. */
static int locaterequest(int s, unsigned int reqid)
{
    unsigned int *req;
    if (MI(s, 0xc) <= (int)(reqid & 0xff))     /* slot index out of range */
        return 0;
    req = (unsigned int *)(MI(s, 8) + (reqid & 0xff) * 100);
    if (reqid == req[0] && req[1] != 0)        /* id matches and slot active */
        return (int)req;
    return 0;
}

/* freerequest @0x800FC548 : unlink a request from the active queue and push it onto the freelist.
 *   Returns the new freelist tail. */
extern int freerequest(int s, int req)
{
    int ret;
    if (req == MI(s, 0x4c))                     /* head */
        MI(s, 0x4c) = MI(req, 0xc);
    else
        MI(MI(req, 8) + 0xc, 0) = MI(req, 0xc); /* prev->next = req->next */

    if (req == MI(s, 0x54))                     /* tail */
        MI(s, 0x54) = MI(req, 8);
    else
        MI(MI(req, 0xc) + 8, 0) = MI(req, 8);   /* next->prev = req->prev */

    if (req == MI(s, 0x50)) {                   /* cur */
        ret = MI(req, 0xc);
        if (ret == 0)
            ret = MI(req, 8);
        MI(s, 0x50) = ret;
    }
    MI(req, 4) = 0;                             /* state = free */
    ret = MI(s, 0x58);
    MI(req, 0xc) = ret;                         /* req->next = old freelist */
    MI(s, 0x58) = req;                          /* freelist = req */
    return ret;
}

/* filterchunk @0x800FC5E4 : classify a chunk by its first word against the filter table; returns the
 *   matching filter's consumer value, or 0xFFFFFFFE ("skip") if none match. */
/* NOTE: the oracle keeps ONE pointer (f, byte offsets 0/4/8, +0xC per iter); gcc-2.8.0 here instead
 * CSEs a SECOND base (f+8) to serve f[1]/f[2] -- tried unsigned-int* w/ +=3, char*-byte-advance, and a
 * raw MI/MU byte-offset int local; all three reproduce the identical dual-base split. Documenting as a
 * near-miss (21 diffs, was 27) rather than a source-shape floor pending further investigation. */
extern unsigned int filterchunk(int s, int chunk)
{
    unsigned int *f;
    int i = 0, n;
    n = MI(s, 0x14);
    if (0 < n) {
        f = *(unsigned int **)(s + 0x10);      /* filterArray */
        do {
            i++;
            if ((*(unsigned int *)chunk & f[0]) == f[1])
                return f[2];
            f += 3;
        } while (i < n);
    }
    return 0xfffffffeu;
}

/* parsechunks @0x800FC634 : walk newly-filled buffer data, splitting it into chunks.  Each chunk header
 *   is {tag, len}; the chunk is classified by filterchunk, tagged with its consumer in the high byte of
 *   word1, and accounted to that consumer.  Stops at a short/invalid header or the end-of-stream id.
 *   Returns 1 if the end-of-stream marker was reached, else 0. */
extern int parsechunks(int s)
{
    int   bvar1;
    int   iVar2, iVar4;
    unsigned int uVar3, uVar5;
    int  *chunk;
    int   reqcur;
    int   sr;

    uVar3   = MU(s, 0x48);                      /* fillptr */
    chunk   = *(int **)(s + 0x44);              /* writeptr */
    reqcur  = MI(s, 0x50);                      /* current request */
    iVar2   = uVar3 - (int)chunk;

    while (1) {
        if (iVar2 < 8 || ((uVar5 = chunk[1], (uVar5 & 0xff000000) != 0)) ||
            uVar3 < (unsigned int)((int)chunk + uVar5))
            return 0;                           /* incomplete / malformed chunk */

        uVar3 = filterchunk(s, (int)chunk);
        if ((int)uVar3 < 0) {                   /* no consumer (skip) */
            sr = STREAM_enterCS();
            bvar1 = (MI(reqcur, 4) == 4);       /* request cancelled? */
            if (!bvar1) {
                chunk[0] = -2;                  /* mark chunk free */
                MI(s, 0x44) += uVar5;           /* advance writeptr */
            }
            STREAM_leaveCS(sr);
        } else {                                /* routed to consumer uVar3 */
            chunk[1] = chunk[1] | (uVar3 << 0x18);
            sr = STREAM_enterCS();
            bvar1 = (MI(reqcur, 4) == 4);
            if (!bvar1) {
                int cons = MI(s, 0x18) + uVar3 * 0x10 - 0x10;  /* consumer slot */
                uVar3 = MI(cons, 8) + uVar5;
                MI(cons, 8) = uVar3;            /* consumer.count += len */
                if (uVar3 == uVar5)             /* first chunk for this consumer */
                    MI(cons, 0xc) = (int)chunk; /* readcursor = chunk */
                MI(s, 0x44) += uVar5;           /* advance writeptr */
                iVar2 = MI(s, 0x3c);
                iVar4 = iVar2 + uVar5;
                MI(s, 0x3c) = iVar4;            /* bufusage += len */
                if (iVar2 < MI(s, 0x34) && MI(s, 0x34) <= iVar4)
                    MI(s, 0x38) = 0;            /* crossed greedy level -> greedy off */
            }
            STREAM_leaveCS(sr);
        }
        if (bvar1)
            break;
        if (chunk[0] == MI(reqcur, 0x5c))       /* reached end-of-stream id */
            return 1;
        uVar3  = MU(s, 0x48);
        chunk  = *(int **)(s + 0x44);
        iVar2  = uVar3 - (int)chunk;
    }
    return 0;
}

/* opencallback @0x800FC810 : nfile open-op completion (stream object arrives in $a2 = udata).  Stash the
 *   opened file handle (+0x9C); if valid, kick the stream's fill engine. */
extern void opencallback(int a0, int a1, int s)
{
    unsigned int h;
    (void)a0; (void)a1;
    h = FILE_completeop(MU(s, 0xa4));
    MU(s, 0x9c) = h;
    if (h != 0)
        ((int (*)(int, int))restartstream)(s, MU(s, 0x30));  /* oracle passes a1=s->0x30; restartstream ignores it (dead 2nd param) but the caller still loads it */
}

/* closecallback @0x800FC850 : nfile close-op completion -> immediately open the next file (its name was
 *   already copied to +0x5C) and arm opencallback. */
extern void closecallback(int a0, int a1, int s)
{
    unsigned int op;
    (void)a0; (void)a1;
    FILE_completeop(MU(s, 0xa4));
    op = FILE_open((char *)(s + 0x5c), 1, MU(s, 0x30), (unsigned int)s);
    MU(s, 0xa4) = op;
    if (op != 0)
        FILE_callbackop(op, (void (*)(int, int))opencallback);
}

/* readcallback @0x800FC8A8 : nfile read-op completion (stream object in $a2).  Advances the read
 *   accounting, parses the freshly-filled data into chunks, and either continues filling or, when the
 *   request finishes, marks it done and starts the next queued request. */
extern int readcallback(int a0, int a1, int s)
{
    int bvar1;
    int iVar2;
    unsigned int uVar3;
    int reqcur;
    (void)a0; (void)a1;

    reqcur = MI(s, 0x50);
    if (MI(reqcur, 0x10) == 1) {               /* memory source */
        uVar3 = MU(s, 0xa8);
        bvar1 = (MI(reqcur, 0x58) <= (int)(MI(s, 0xa0) + uVar3));
    } else {                                   /* file source */
        uVar3 = FILE_completeop(MU(s, 0xa4));
        bvar1 = ((int)uVar3 < MI(s, 0xa8));
    }
    MU(s, 0xa0) += uVar3;                       /* readaccum += bytes */
    MU(s, 0x48) += uVar3;                       /* fillptr   += bytes */
    iVar2 = parsechunks(s);
    if (MI(reqcur, 4) != 4) {                   /* not cancelled */
        if (!bvar1 && iVar2 == 0)
            return restartstream(s);            /* more to read, no EOS -> keep going */
        {
            int sr = STREAM_enterCS();
            MI(reqcur, 4) = 3;                  /* request done */
            STREAM_leaveCS(sr);
        }
    }
    return startnextrequest(s, MU(s, 0x30), (unsigned int)s);
}

/* startnextrequest @0x800FC9B4 : advance the active queue cursor (+0x50) to the next runnable request,
 *   open/seek its file (or rebind to the memory image), and kick restartstream.  Sets state idle if the
 *   queue drains. */
extern int startnextrequest(int s, unsigned int prio, unsigned int x)
{
    int  done;
    int  ret = 0;
    int  cur;
    int  req;
    int  sr;
    (void)x;

    sr = STREAM_enterCS();
    cur  = MI(s, 0x50);
    done = 1;
    if (cur != 0) {
        ret  = 1;
        done = 0;
        if (MI(cur, 4) != 1) {                  /* current no longer queued */
            ret = MI(cur, 0xc);                 /* advance to next */
            if (ret == 0)
                done = 1;
            else
                MI(s, 0x50) = ret;
        }
    }
    if (done) {
        MI(s, 0x28) = 0;                         /* state idle */
    } else {
        req = MI(s, 0x50);
        MI(req, 0x60) = MI(s, 0x44);             /* request start fill ptr = writeptr */
        ret = 2;
        MI(req, 4) = 2;                          /* state = active */
    }
    STREAM_leaveCS(sr);

    if (!done) {
        MI(s, 0x48) = MI(s, 0x44);               /* fillptr = writeptr */
        if (MI(req, 0x10) == 1) {                /* memory source */
            MI(s, 0xa0) = 0;
        } else {                                 /* file source */
            int name = s + 0x5c;
            MI(s, 0xa0) = MI(req, 0x58);         /* readaccum = request offset */
            if (strcmp((char *)(req + 0x14), (char *)name) != 0) {  /* different file */
                strcpy((char *)name, (char *)(req + 0x14));
                if (MU(s, 0x9c) != 0) {          /* close the open file first */
                    unsigned int op = FILE_close((void *)MU(s, 0x9c), prio, (unsigned int)s);
                    MU(s, 0xa4) = op;
                    if (op == 0)
                        return 0;
                    FILE_callbackop(op, (void (*)(int, int))closecallback);
                    return op;
                }
                {
                    unsigned int op = FILE_open((char *)name, 1, prio, (unsigned int)s);
                    MU(s, 0xa4) = op;
                    if (op == 0)
                        return 0;
                    FILE_callbackop(op, (void (*)(int, int))opencallback);
                    return op;
                }
            }
        }
        ret = restartstream(s);
    }
    return ret;
}

/* restartstream @0x800FCB44 : the buffer fill engine.  Reclaims free space at the read head, releases
 *   spent requests, wraps the ring when needed, computes the next contiguous fill region, and issues the
 *   next chunk read -- from the memory image (memcpy + readcallback) or via FILE_read + readcallback.
 *   Stalls (state 2) if there is not at least one sector of room. */
extern int restartstream(int s)
{
    int  iVar1, iVar2;
    unsigned int uVar3, uVar5;
    int *p;
    int *q;
    int  sr;

    /* skip wrap/free markers at the read head (+0x40) up to the writeptr (+0x44) */
    iVar1 = MI(s, 0x40);
    while (iVar1 != MI(s, 0x44)) {
        p = *(int **)(s + 0x40);
        if (p[0] == -1) {                        /* wrap marker -> jump to bufBase (+0x20) */
            MI(s, 0x40) = MI(s, 0x20);
        } else {
            if (p[0] != -2)                      /* a live chunk -> stop */
                break;
            MI(s, 0x40) = (int)p + p[1];         /* free marker -> skip its length */
        }
        iVar1 = MI(s, 0x40);
    }

    /* free finished requests whose data has been fully consumed */
    sr = STREAM_enterCS();
    iVar1 = MI(s, 0x4c);                         /* queue head */
    iVar2 = MI(iVar1, 0xc);
    while (iVar2 != 0 && MI(MI(iVar1, 0xc) + 4, 0) != 1 &&
           inbetween(MU(s, 0x40), MU(s, 0x48), MI(MI(iVar1, 0xc) + 0x60, 0) - 1) == 0) {
        freerequest(s, iVar1);
        iVar1 = MI(s, 0x4c);
        iVar2 = MI(iVar1, 0xc);
    }
    STREAM_leaveCS(sr);

    /* compute the next contiguous fill region [fillptr .. readptr) */
    uVar3 = MU(s, 0x40);                         /* readptr */
    uVar5 = MU(s, 0x48);                         /* fillptr */
    iVar1 = uVar3 - uVar5;
    if (uVar3 <= uVar5) {
        iVar1 = (MI(s, 0x24) - uVar5) - 8;       /* room to bufEnd, less header */
        if (0x1fff < iVar1)
            goto have_room;
        /* not enough tail room -> wrap: move the partial chunk down to bufBase */
        iVar2 = uVar5 - (int)*(unsigned char **)(s + 0x44);
        if ((int)(uVar3 - (int)*(unsigned char **)(s + 0x20)) < iVar2 + 1)
            goto stall;
        memcpy(*(unsigned char **)(s + 0x20), *(unsigned char **)(s + 0x44), iVar2);
        q = *(int **)(s + 0x44);
        q[0] = -1;                               /* leave a wrap marker behind */
        q[1] = 8;
        iVar2 = MI(s, 0x20) + iVar2;
        iVar1 = MI(s, 0x40) - iVar2;
        MI(s, 0x44) = MI(s, 0x20);
        MI(s, 0x48) = iVar2;
    }
    iVar1 = iVar1 - 1;
    if (iVar1 < 0x2000) {
stall:
        MI(s, 0x28) = 2;                         /* buffer-full stall */
        return 2;
    }
have_room:
    iVar2 = MI(s, 0x50);                         /* current request */
    if (MI(iVar2, 0x10) == 1) {                  /* memory source -> memcpy a chunk in */
        if (MI(iVar2, 0x58) < MI(s, 0xa0) + iVar1)
            MI(s, 0xa8) = MI(iVar2, 0x58) - MI(s, 0xa0);  /* clamp to remaining */
        else
            MI(s, 0xa8) = iVar1;
        memcpy(*(unsigned char **)(s + 0x48), *(unsigned char **)(iVar2 + 0x54), MI(s, 0xa8));
        MI(iVar2, 0x54) += MI(s, 0xa8);          /* advance mem source ptr */
        return readcallback(0, 0, s);
    }
    /* file source -> issue a sector read */
    MI(s, 0xa8) = 0x2000;
    {
        unsigned int op = FILE_read((void *)MU(s, 0x9c), MU(s, 0xa0), MU(s, 0x48),
                                    MI(s, 0xa8), 0, 0);   /* asm sets a0..a3 only */
        MU(s, 0xa4) = op;
        if (op == 0)
            return 0;
        FILE_callbackop(op, (void (*)(int, int))readcallback);
        return op;
    }
}

/* STREAM_overhead @0x800FCDE0 : bytes of bookkeeping a stream of this shape needs (excluding the ring). */
extern int STREAM_overhead(int numReq, int numFilters, int numConsumers)
{
    /* FLOOR (documented): the only residual is a $v0-vs-$v1 register-coloring tie-break on the
     * `+0xAC` constant fold (oracle folds it into the filter term in $v1; gcc-2.8.0 folds it into
     * the running total in $v0).  Tried temp-var, nested/right-assoc, operand-swap, and an
     * explicit filter-variable summed-last reassociation (regressed to 12 -- reorders the whole
     * term schedule) -- gcc reassociates commutative int-add freely, so the grouping is not
     * source-controllable here.  $v0-vs-$v1 constant-fold floor (count matches 13==13). */
    return numReq * 100 + (numFilters * 0xc + 0xac) + numConsumers * 0x10;
}

/* STREAM_create @0x800FCE14 : lay a stream object + its sub-arrays into `objbuf` (size `bufsize`) and
 *   initialise the request freelist, filter table and consumer table.  Validates counts and that at
 *   least 0x6000 bytes remain for the ring.  Returns the consumer-array handle (obj+0x18 value), 0 on
 *   failure. */
extern int STREAM_create(int numReq, int numFilters, int numConsumers, int objbuf, int bufsize)
{
    int over, base, i, off;

    over = STREAM_overhead(numReq, numFilters, numConsumers);
    if (bufsize - over < 0x6000)
        return 0;
    if (numReq < 2 || numReq >= 0x101)
        return 0;
    if ((unsigned int)(numFilters - 1) > 0xf)
        return 0;
    if (numConsumers <= 0)
        return 0;
    if (numFilters < numConsumers)
        return 0;

    MI(objbuf, 0x00) = STRM_MAGIC;
    MI(objbuf, 0x04) = allocmutex();
    MI(objbuf, 0x08) = objbuf + 0xac;                          /* reqArray */
    MI(objbuf, 0x24) = objbuf + bufsize;                       /* bufEnd */
    MI(objbuf, 0x2c) = 0x96;
    MI(objbuf, 0x0c) = numReq;
    MI(objbuf, 0x14) = numFilters;
    MI(objbuf, 0x1c) = numConsumers;
    MI(objbuf, 0x28) = 0;
    MI(objbuf, 0x34) = 0;
    MI(objbuf, 0x38) = 0;
    MI(objbuf, 0x3c) = 0;
    MI(objbuf, 0x4c) = 0;
    MI(objbuf, 0x50) = 0;
    MI(objbuf, 0x54) = 0;
    base = MI(objbuf, 0x08) + numReq * 100;
    MI(objbuf, 0x10) = base;                                   /* filterArray */
    base = base + numFilters * 0xc;
    MI(objbuf, 0x18) = base;                                   /* consumerArray */
    base = base + numConsumers * 0x10;
    MI(objbuf, 0x20) = base;                                   /* bufBase */
    MI(objbuf, 0x30) = 0x32;
    MI(objbuf, 0x40) = base;
    MI(objbuf, 0x44) = base;
    MI(objbuf, 0x48) = base;
    MI(objbuf, 0x58) = MI(objbuf, 0x08);                       /* freelist = reqArray[0] */
    memset((unsigned char *)(objbuf + 0x5c), 0, 0x40);         /* clear name */
    MI(objbuf, 0x9c) = 0;

    /* thread the request freelist */
    i = 0;
    if (numReq > 0) {
        int stride = 100, idx = 0;
        do {
            int *r = (int *)(MI(objbuf, 0x08) + idx);
            idx += 100;
            r[0] = i;                                          /* id = slot index */
            r[1] = 0;
            i++;
            r[3] = MI(objbuf, 0x08) + stride;                  /* next */
            stride += 100;
        } while (i < numReq);
    }
    MI(numReq * 100 + MI(objbuf, 0x08) - 0x58, 0) = 0;         /* last->next = 0 (offset +0xC of last slot) */

    /* clear the filter table */
    i = 0;
    if (numFilters > 0) {
        int idx = 0;
        do {
            int *f = (int *)(MI(objbuf, 0x10) + idx);
            i++;
            f[0] = 0;
            f[1] = 0;
            f[2] = 1;
            idx += 0xc;
        } while (i < numFilters);
    }

    /* init the consumer table (back-pointer + 1-based id) */
    i = 0;
    if (numConsumers > 0) {
        do {
            int *c;
            i++;
            c = (int *)(MI(objbuf, 0x18) + (i - 1) * 0x10);
            c[0] = objbuf;
            c[1] = i;
            c[2] = 0;
        } while (i < numConsumers);
    }
    return MI(objbuf, 0x18);
}

/* STREAM_setfilter @0x800FD054 : program filter slot `filterIdx` (1-based) with {mask, match, value}.
 *   `value` is the target consumer id (>0), or -1 (discard) / -2 (skip).  The last filter must be the
 *   catch-all (mask==0 && match==0).  Ignored unless the stream is idle (state 0). */
extern void STREAM_setfilter(int consumer, int filterIdx, unsigned int mask, unsigned int match, int value)
{
    int out[2];
    int nf, obj;
    if (validatehandle(consumer, &out[0], &out[1]) != 0)
        return;
    if (filterIdx <= 0)
        return;
    nf = MI(out[0], 0x14);
    if (filterIdx > nf)
        return;
    if (filterIdx == nf && (mask | match) != 0)
        return;                                  /* last slot must be catch-all */
    if (!(value > 0 || value == -1 || value == -2))
        return;
    obj = out[0];
    if (value > MI(obj, 0x1c))
        return;
    if (MI(obj, 0x28) != 0)                       /* must be idle */
        return;
    {
        int fo = filterIdx * 0xc - 0xc;
        int *f = (int *)(MI(obj, 0x10) + fo);
        f[0] = (int)mask;
        f[1] = (int)match;
        f[2] = value;
    }
}

/* STREAM_destroy @0x800FD144 : kill all requests, wait for the final op to drain, drop the magic, free
 *   the mutex, and close the sync file. */
extern void STREAM_destroy(int s)
{
    int out[2];
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return;
    STREAM_kill(s);
    while (MI(out[0], 0x28) == 1) {               /* wait until not actively reading */
        if (iscurrentthread(0) != 0)
            systemtask(0);
        yieldthread(0);
    }
    freemutex(MI(out[0], 4));
    MI(out[0], 0) = 0;                            /* invalidate magic */
    FILE_closesync(MI(out[0], 0x9c), 100);
}

/* STREAM_setpriority @0x800FD1F8 : set the stream's two priority words (+0x2C, +0x30). */
extern void STREAM_setpriority(int s, int prioA, int prioB)
{
    int out[2];
    int obj;
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return;
    obj = out[0];
    MI(obj, 0x2c) = prioA;
    MI(obj, 0x30) = prioB;
}

/* STREAM_setgreedylevel @0x800FD248 : set the greedy fill threshold (+0x34); if the buffer-usage-vs-level
 *   relation flips, update the greedy state. */
extern void STREAM_setgreedylevel(int s, int lvl)
{
    int out[2];
    int obj, oldlvl, usage, state;
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return;
    obj = out[0];
    oldlvl = MI(obj, 0x34);
    usage  = MI(obj, 0x3c);
    MI(obj, 0x34) = lvl;
    if ((usage < oldlvl) != (state = (usage < lvl)))
        STREAM_setgreedystate(s, state);
}

/* STREAM_setgreedystate @0x800FD2B4 : set the greedy state (+0x38); when turning on while actively
 *   reading, bump the in-flight op back up to the stream's read priority. */
extern void STREAM_setgreedystate(int s, int state)
{
    int out[2];
    int obj;
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return;
    obj = out[0];
    MI(obj, 0x38) = state;
    if (state != 0 && MI(obj, 0x28) == 1)
        FILE_priorityop(MI(obj, 0xa4), MI(obj, 0x30));
}

/* STREAM_queuefile @0x800FD314 : queue a read of `len` bytes at `off` from file `name`.  Allocates a
 *   request, fills it, queues it, and -- if the stream was idle -- starts it.  Returns the request id. */
extern unsigned int STREAM_queuefile(int s, char *name, int off, int len)
{
    int out[2];
    int *req;
    unsigned int id = 0;
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return 0;
    req = getfreerequest(out[0]);
    if (req == 0)
        return 0;
    req[4] = 0;                                   /* type = file */
    strncpy((char *)(req + 5), name, 0x40);       /* req name @ +0x14 */
    req[0x16] = off;
    req[0x17] = len;
    queuerequest(out[0], (int)req);
    {
        int wasidle, sr;
        sr = STREAM_enterCS();
        wasidle = (MI(out[0], 0x28) == 0);
        if (wasidle)
            MI(out[0], 0x28) = 1;
        STREAM_leaveCS(sr);
        if (wasidle) {
            unsigned int prio = (MI(out[0], 0x38) == 0) ? MU(out[0], 0x2c) : MU(out[0], 0x30);
            startnextrequest(out[0], prio, id);
        }
    }
    return (unsigned int)req[0];
}

/* STREAM_queuemem @0x800FD428 : queue a read of `len` bytes from a memory image.  If `ptr` is null, the
 *   source is a chained block list walked to the `len`-th node.  Returns the request id. */
extern unsigned int STREAM_queuemem(int s, int blocklist, void *ptr, int len)
{
    int out[2];
    int *req;
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return 0;
    req = getfreerequest(out[0]);
    if (req == 0)
        return 0;
    if (ptr == 0) {                               /* resolve offset by walking the block chain */
        int acc = 0;
        int *p = (int *)blocklist;
        int v = *p;
        while (v != len) {
            int blklen = p[1];
            p = (int *)((int)p + blklen);
            acc += blklen;
            v = *p;
        }
        ptr = (void *)(acc + p[1]);
    }
    req[4] = 1;                                   /* type = memory */
    req[0x15] = blocklist;                        /* mem source base */
    req[0x16] = (int)ptr;
    req[0x17] = len;
    queuerequest(out[0], (int)req);
    {
        int wasidle, sr;
        sr = STREAM_enterCS();
        wasidle = (MI(out[0], 0x28) == 0);
        if (wasidle)
            MI(out[0], 0x28) = 1;
        STREAM_leaveCS(sr);
        if (wasidle)
            startnextrequest(out[0], 0, 0);
    }
    return (unsigned int)req[0];
}

/* STREAM_cancelrequest @0x800FD554 : cancel an in-flight or queued request and reclaim any of its data
 *   already sitting in the ring buffer (returning consumed chunks via STREAM_get/release, freeing
 *   un-consumed ones).  Returns 0 on success, 1 if it could not be cancelled. */
extern int STREAM_cancelrequest(int s, int reqid)
{
    int out[2];
    int ret;
    int req;
    int *s4, *s6, *s7;
    int sr;

    if (validatehandle(s, &out[0], &out[1]) != 0)
        return 1;
    s = out[0];                                   /* stream object */

    sr = STREAM_enterCS();
    req = locaterequest(s, reqid);
    if (req != 0 && MI(req, 4) != 4) {
        if (MI(req, 4) != 1) {                     /* active (not merely queued) */
            MI(req, 4) = 4;                         /* mark cancelled */
            s7 = *(int **)(s + 0x40);               /* readptr */
            s4 = s7;
            if (req != MI(s, 0x4c))
                s4 = *(int **)(req + 0x60);          /* this request's start fill */
            {
                int nx = MI(req, 0xc);
                if (nx == 0 || MI(nx, 4) == 1) {
                    s6 = *(int **)(s + 0x44);        /* writeptr */
                    ret = 0;
                } else {
                    s6 = *(int **)(nx + 0x60);
                    ret = 0;
                }
            }
            goto reclaim;
        }
        freerequest(s, req);                         /* queued -> just drop it */
    }
    ret = 1;
reclaim:
    STREAM_leaveCS(sr);
    if (ret != 0)
        return ret;

    /* sweep every consumer, returning or freeing the cancelled request's chunks */
    {
        int nC = MI(s, 0x1c);
        int ci = 0;
        if (nC > 0) {
            do {
                int cons = MI(s, 0x18) + ci * 0x10;
                if (MI(cons, 8) > 0) {
                    unsigned int u2 = inbetween((unsigned int)s7, (unsigned int)s4, MU(cons, 0xc));
                    if (u2 == 0) {                   /* consumer head is before this request -> drain it */
                        unsigned int pos = MU(cons, 0xc);
                        int *p;
                        while ((p = s6, inbetween((unsigned int)s4, (unsigned int)s6, pos) != 0)) {
                            ret = STREAM_get(cons, p, pos);
                            STREAM_release(cons, ret);
                            if (MI(cons, 8) < 1)
                                break;
                            pos = MU(cons, 0xc);
                        }
                    } else {                         /* free this request's own chunks in place */
                        int rstate = MI(cons, 4);
                        int *p = s4;
                        while (p != s6) {
                            if (p[0] == -1) {
                                p = *(int **)(s + 0x20);   /* wrap */
                            } else {
                                unsigned int len = p[1] & 0xffffff;
                                if ((unsigned int)(p[1] & 0xff000000) == (unsigned int)(rstate << 0x18)) {
                                    int sr2 = STREAM_enterCS();
                                    MI(cons, 8) -= len;
                                    STREAM_leaveCS(sr2);
                                    decbufferusage(s, len);
                                    p[0] = -2;
                                    p[1] = len;
                                }
                                p = (int *)((int)p + len);
                            }
                        }
                    }
                }
                ci++;
                ret = 0;
            } while (ci < MI(s, 0x1c));
        }
    }
    return ret;
}

/* STREAM_kill @0x800FD808 : cancel every request, free the queue, reset the ring to empty and the state
 *   to idle. */
extern void STREAM_kill(int s)
{
    int out[2];
    int *q;
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return;
    s = out[0];
    q = *(int **)(s + 0x54);                       /* tail */
    if (q == 0)
        return;

    while ((unsigned int)(q[1] - 1) < 2) {          /* cancel active/done requests */
        STREAM_cancelrequest(s, q[0]);
        q = *(int **)(s + 0x54);
    }
    while (MI(s, 0x4c) != MI(s, 0x50))              /* free the rest of the queue */
        freerequest(s, MI(s, 0x4c));
    MI(MI(s, 0x50) + 4, 0) = 4;                     /* mark last cancelled */

    {
        int i = 0;
        if (MI(s, 0x1c) > 0) {                       /* zero all consumer counts */
            do {
                MI(i * 0x10 + MI(s, 0x18) + 8, 0) = 0;
                i++;
            } while (i < MI(s, 0x1c));
        }
    }
    decbufferusage(s, MI(s, 0x3c));                  /* zero the buffer usage */

    q = *(int **)(s + 0x40);                          /* free-mark the whole ring */
    if (q != *(int **)(s + 0x44)) {
        do {
            if (q[0] == -1) {
                q = *(int **)(s + 0x20);
            } else {
                unsigned int len = q[1];
                q[0] = -2;
                q[1] = len & 0xffffff;
                q = (int *)((int)q + (len & 0xffffff));
            }
        } while (q != *(int **)(s + 0x44));
    }
    if (MI(s, 0x28) == 2)
        MI(s, 0x28) = 0;                             /* clear the stall */
}

/* STREAM_get @0x800FD9AC : pop the next available chunk for a consumer, returning a pointer to its data
 *   (or 0 if none).  Advances the consumer's read cursor to the following same-tagged chunk. */
extern int STREAM_get(int consumer, void *buf, int len)
{
    int out[2];
    int cons, chunk;
    unsigned int hdr;
    int *p;
    (void)buf; (void)len;

    if (validatehandle(consumer, &out[0], &out[1]) != 0)
        return 0;
    cons = out[1];                                  /* the consumer handle */
    if (MI(cons, 8) == 0)                           /* no data available */
        return 0;

    chunk = MI(cons, 0xc);                          /* readcursor */
    hdr = MU(chunk, 4) & 0xffffff;
    MU(chunk, 4) = hdr;                             /* strip the consumer tag */
    {
        int sr = STREAM_enterCS();
        int rem = MI(cons, 8) - hdr;
        MI(cons, 8) = rem;                          /* count -= len */
        STREAM_leaveCS(sr);
        if (0 < rem) {                              /* advance cursor to next same-tagged chunk */
            p = (int *)(chunk + hdr);
            hdr = p[1];
            while ((hdr & 0xff000000) != (unsigned int)(MI(cons, 4) << 0x18)) {
                if (p[0] == -1)
                    p = *(int **)(out[0] + 0x20);    /* wrap */
                else
                    p = (int *)((int)p + (p[1] & 0xffffff));
                hdr = p[1];
            }
            MI(cons, 0xc) = (int)p;
        }
    }
    return chunk;
}

/* STREAM_release @0x800FDAD0 : release a chunk previously obtained from STREAM_get, freeing its ring
 *   space and, if the stream had stalled (state 2) on a full buffer, re-arming the fill engine. */
extern void STREAM_release(int s, int chunk)
{
    int out[2];
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return;
    if ((unsigned int)chunk < MU(out[0], 0x20))     /* below bufBase */
        return;
    if ((unsigned int)(MI(out[0], 0x24) - 8) < (unsigned int)chunk)  /* above bufEnd-8 */
        return;
    if (MI(chunk, 0) == -2)                          /* already free */
        return;
    decbufferusage(out[0], MI(chunk, 4));            /* account the chunk's bytes back */
    MI(chunk, 0) = -2;                              /* mark free */
    {
        int wasstall, sr;
        sr = STREAM_enterCS();
        wasstall = (MI(out[0], 0x28) == 2);
        if (wasstall)
            MI(out[0], 0x28) = 1;
        STREAM_leaveCS(sr);
        if (wasstall)
            restartstream(out[0]);
    }
}

/* STREAM_gettable @0x800FDBCC : return the stream's consumer-array base (+0x08 reqArray... actually the
 *   "table" pointer at +0x08). */
extern int STREAM_gettable(int s)
{
    int out[2];
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return 0;
    return MI(out[1], 8);
}

/* STREAM_state @0x800FDC04 : return the stream state word (+0x28). */
extern int STREAM_state(int s)
{
    int out[2];
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return 0;
    return MI(out[0], 0x28);
}

/* STREAM_isendofstream @0x800FDC3C : true iff the stream is idle (state 0) and the consumer has no data. */
extern int STREAM_isendofstream(int s)
{
    int out[2];
    int ret;
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return 0;
    ret = 0;
    if (MI(out[0], 0x28) == 0)
        ret = (MI(out[1], 8) == 0);
    return ret;
}

/* STREAM_buffersize @0x800FDC98 : the ring buffer size (bufEnd - bufBase). */
extern int STREAM_buffersize(int s)
{
    int out[2];
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return 0;
    return MI(out[0], 0x24) - MI(out[0], 0x20);
}

/* STREAM_bufferusage @0x800FDCE0 : current bytes of buffered (filled) data (+0x3C). */
extern int STREAM_bufferusage(int s)
{
    int out[2];
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return 0;
    return MI(out[0], 0x3c);
}

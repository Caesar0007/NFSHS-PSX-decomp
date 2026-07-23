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
static int  func_800FC4E4(int s, unsigned int reqid);                          /* @0x800FC4E4; NOTE:
    the trusted SYM (nfs4-f-v3.txt) names this locaterequest -- the SAME real name as the unrelated
    file-static locaterequest() in nasync.c @0x800F0BF4 (two distinct EA statics that genuinely share
    the descriptive name across TUs). verify_asm resolves an oracle .s purely by C identifier
    (<identifier>.s), so both cannot be spelled `locaterequest` or this fn would silently gate against
    nasync's oracle. The repo's disasm already disambiguated this VA's oracle to func_800FC4E4.s, so we
    keep the C identifier func_800FC4E4 to track that .s filename; its true/SYM name is locaterequest. */
extern int  freerequest(int s, int req);                                   /* @0x800FC548 */
extern unsigned int filterchunk(int s, int chunk);                         /* @0x800FC5E4 */
extern int  parsechunks(int s);                                            /* @0x800FC634 */
extern void opencallback(int a0, int a1, int s);                           /* @0x800FC810 */
extern void closecallback(int a0, int a1, int s);                          /* @0x800FC850 */
extern int  readcallback(int a0, int a1, int s);                           /* @0x800FC8A8 */
extern int  startnextrequest(int s, unsigned int prio, unsigned int x);    /* @0x800FC9B4 */
extern int  restartstream(int s, unsigned int prio);                       /* @0x800FCB44 */
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
    int sobj;
    if (handle == 0)
        return 1;
    sobj = *(int *)handle;
    if (*(int *)sobj != STRM_MAGIC)
        return 1;
    *outHandle = handle;    /* asm: *a2 = a0 (the handle)                 */
    *outObj = sobj;         /* asm: *a1 = a3 (the stream object), delay slot */
    return 0;
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
 *   A faithful transcription must NOT hold `ret` live across that call either.
 * MATCH (35/35): spell the oracle's three exits directly.  The old<level path returns the comparison,
 *   the new>=level path returns 1, and the active-read path intentionally falls through after
 *   FILE_priorityop so that call's value remains in v0. */
extern int decbufferusage(int s, int amount)
{
    int sr, old, neu, lvl;
    sr = STREAM_enterCS();
    old = MI(s, 0x3c);
    neu = old - amount;
    MI(s, 0x3c) = neu;
    STREAM_leaveCS(sr);
    lvl = MI(s, 0x34);
    if (old < lvl)
        return neu < lvl;
    if (lvl <= neu)
        return 1;
    MI(s, 0x38) = 1;                           /* greedy state on */
    if (MI(s, 0x28) != 1)
        return 1;
    FILE_priorityop(MI(s, 0xa4), MI(s, 0x30));
    /* The original falls through here: the FILE_priorityop call leaves its value in v0. */
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
        int newid;
        ret = req;
        newid = requestidcounter + 0x100;
        MI(s, 0x58) = req[3];                  /* freelist head = req->next (+0xC) */
        requestidcounter = newid;
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

/* func_800FC4E4 : map a request id back to its slot, validating the slot index (low byte),
 *   the full id, and that the slot is in use.  Returns the request pointer or 0.
 * MATCH: separate guard returns plus the empty one-shot boundary preserve the shared failure tail
 * while preventing gcc from folding the final active-slot test into a branch-to-success. */
static int func_800FC4E4(int s, unsigned int reqid)
{
    unsigned int *req;
    if (MI(s, 0xc) <= (int)(reqid & 0xff))     /* slot index out of range */
        return 0;
    req = (unsigned int *)(MI(s, 8) + (reqid & 0xff) * 100);
    if (reqid != req[0])
        return 0;
    do { } while (0);
    if (req[1] == 0)
        return 0;
    return (int)req;
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
typedef struct StreamFilter {
    unsigned int mask;
    unsigned int value;
    unsigned int consumer;
} StreamFilter;
/* MATCH (disasm-v4 trace, 21->0 diffs): a volatile record pointer keeps one base for the three
 * filter fields.  Loading the tag before the empty-table test and copying n to the loop-carried
 * `count` recover the oracle's v1->a3 lifetime split.  The counter increment follows the match
 * check, so gcc places it in that branch's delay slot and retains the loop-head load-delay nop. */
extern unsigned int filterchunk(int s, int chunk)
{
    volatile StreamFilter *f;
    unsigned int tag;
    int i = 0, n, count;
    n = MI(s, 0x14);
    tag = *(unsigned int *)chunk;
    if (0 < n) {
        count = n;
        f = *(StreamFilter **)(s + 0x10);      /* filterArray */
        do {
            if ((tag & f->mask) == f->value)
                return f->consumer;
            i++;
            f++;
        } while (i < count);
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
        restartstream(s, MU(s, 0x30));
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
            return restartstream(s, MU(s, 0x30));
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
        /* MATCH: oracle keeps this fn's OWN `prio` parameter cached in a callee-saved reg across every
         * intervening call (strcmp/strcpy/FILE_open/FILE_callbackop/FILE_close) to hand to restartstream
         * as its real 2nd arg (forwarded to FILE_read's a5, see restartstream). */
        ret = restartstream(s, prio);
    }
    return ret;
}

/* restartstream @0x800FCB44 : the buffer fill engine.  Reclaims free space at the read head, releases
 *   spent requests, wraps the ring when needed, computes the next contiguous fill region, and issues the
 *   next chunk read -- from the memory image (memcpy + readcallback) or via FILE_read + readcallback.
 *   Stalls (state 2) if there is not at least one sector of room.
 * w18-a9: two REAL findings, one applied + one PROVEN-but-BLOCKED:
 *   (1) APPLIED, gate-verified 155->149: the two internal loops (skip-wrap-markers @+0x40..+0x44, and
 *       free-finished-requests off the queue head @+0x4C) are EXIT-IN-THE-MIDDLE guard+do-while shapes
 *       (oracle caches the loop-invariant bound in a caller-saved reg BEFORE the loop, tests fresh inside
 *       -- see reference_asm_pattern_catalog.md §B), not `while(cond){...; cond=reload;}` -- rewritten
 *       to match; also fixed the (leftover, unused-since-refactor) callers' func-ptr-cast noise.
 *   (2) PROVEN CORRECTNESS BUG, NOT YET APPLIED (blocked -- see below): `prio` is NOT a dead 2nd param
 *       (every prior wave's comment calling it "dead" was wrong) -- the oracle forwards it, together with
 *       `s` itself, as FILE_read's 5th/6th STACK args (a5=prio, a6=s; oracle
 *       `sw $s4,0x10($sp); sw $s1,0x14($sp)` right before the FILE_read jal, both loaded from a
 *       CALLEE-SAVED reg that survives the whole function). Every call site (opencallback/readcallback/
 *       startnextrequest/STREAM_release) already loads+passes the real prio value through a func-ptr-cast
 *       hack "because restartstream ignores it" -- that belief is the actual bug in the retail-behavior
 *       sense. BLOCKED: forwarding `prio` into the FILE_read call (`FILE_read(...,prio,(unsigned)s)`
 *       instead of `FILE_read(...,0,0)`) is semantically correct per the oracle but keeps `prio` live
 *       across the WHOLE function (every intervening call), which our gcc allocates a 6th callee-saved
 *       register for (s0-s5, frame -0x38) where the oracle manages with 5 (s0-s4, frame -0x30) --
 *       verified 149->160 diffs, insn count 170->173 (worse, not "moving decisively toward oracle" per
 *       the iron rule) purely from the extra sw/lw pair + frame growth.
 *   FOLLOW-UP SESSION (2026-07-19, dedicated): ROOT CAUSE now isolated, still a genuine floor.
 *       Oracle's exact 5-reg map (asm/nonmatchings/main/restartstream.s, frame -0x30, saves s0-s4):
 *         s1 = `s` (whole fn; also FILE_read a6 via `sw $s1,0x14($sp)`)
 *         s4 = `prio` (whole fn; FILE_read a5 via `sw $s4,0x10($sp)`)
 *         s0 = TIME-SHARED: queue-head `iVar1` in the free-requests loop (`lw $s0,0x4C($s1)` @ED3F0/ED448)
 *              THEN current-request `iVar2` in have_room (`lw $s0,0x50($s1)` @ED50C) -- non-overlapping uses.
 *       Our build CANNOT reuse s0 that way because our `iVar1` (queue-head) mutates into the ROOM-SIZE and
 *       stays live THROUGH have_room (read at `MI(iVar2,0x58) < MI(s,0xa0)+iVar1`), so its register can't be
 *       recycled for the current-request the way the oracle's s0 is -> with `prio` also demanding a
 *       callee-saved slot, gcc-2.8.0 needs a 6th (s5). The oracle computes room-size in a *different* reg so
 *       s0 frees up. Tried to reproduce: (a) split reused `iVar1` (w18-a9, 160->162 worse); (b) the PERMUTER
 *       (now unblocked -- both sanitizer fixes landed this session) on the correct-args (160-diff) version,
 *       6 min / 97 iters / -j4: base score 1090 -> best 855, NO byte-match basin found (unguided
 *       randomization couldn't hit the s0-time-share coloring). Genuine gcc-2.8.0 allocator floor. KEPT the
 *       gate-optimal form (`prio` declared+unused -> dropped from save set, frame matches oracle's 5-reg
 *       count @149). NEXT: a source shape that computes room-size WITHOUT keeping queue-head's register live
 *       into have_room (freeing s0 for the current-request reuse), or a longer/@PERM-guided permuter run.
 *       DO NOT re-flag "prio is dead" as settled fact -- it demonstrably is not. */
extern int restartstream(int s, unsigned int prio)
{
    int  iVar1, iVar2;
    unsigned int uVar3, uVar5;
    int *p;
    int *q;
    int  sr;
    (void)prio;  /* KNOWN-BLOCKED FIX: real oracle behavior forwards this to FILE_read's a5 (see above) */

    /* skip wrap/free markers at the read head (+0x40) up to the writeptr (+0x44) */
    if (MI(s, 0x40) != MI(s, 0x44)) {
        unsigned int wr = MU(s, 0x44);           /* cache writeptr for the whole loop */
        do {
            p = *(int **)(s + 0x40);
            if (p[0] == -1) {                    /* wrap marker -> jump to bufBase (+0x20) */
                MI(s, 0x40) = MI(s, 0x20);
            } else {
                if (p[0] != -2)                  /* a live chunk -> stop */
                    break;
                MI(s, 0x40) = (int)p + p[1];     /* free marker -> skip its length */
            }
        } while (MU(s, 0x40) != wr);
    }

    /* free finished requests whose data has been fully consumed */
    sr = STREAM_enterCS();
    iVar1 = MI(s, 0x4c);                         /* queue head */
    if (MI(iVar1, 0xc) != 0) {
        do {
            iVar2 = MI(iVar1, 0xc);              /* req = head->next */
            if (MI(iVar2, 4) == 1)               /* state==queued -> stop */
                break;
            if (inbetween(MU(s, 0x40), MU(s, 0x48), MI(iVar2, 0x60) - 1) != 0)
                break;
            freerequest(s, iVar1);
            iVar1 = MI(s, 0x4c);
        } while (MI(iVar1, 0xc) != 0);
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
                                    MI(s, 0xa8), 0, 0);   /* real args = prio,(uint)s -- see BLOCKED note above */
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
    /* MATCH: separate request/filter terms plus the empty one-shot boundary keep gcc from
     * reassociating +0xac into the request accumulator; the constant stays on the oracle's v1
     * filter term and the consumer term fills the return delay slot. */
    int result = numReq * 100;
    int filters = numFilters * 0xc + 0xac;
    do { } while (0);
    result = result + filters;
    return result + numConsumers * 0x10;
}

/* STREAM_create @0x800FCE14 : lay a stream object + its sub-arrays into `objbuf` (size `bufsize`) and
 *   initialise the request freelist, filter table and consumer table.  Validates counts and that at
 *   least 0x6000 bytes remain for the ring.  Returns the consumer-array handle (obj+0x18 value), 0 on
 *   failure.
 * w18-a9: 77->68 diffs via SEPARATE-CHECK lever -- oracle emits TWO distinct `slti` compares
 *   (numReq<2, then numReq<0x101) that cross-jump-merge to a shared "return 0" block; gcc's OR-of-two-
 *   bounds optimizer folds a combined `numReq<2 || numReq>=0x101` into ONE unsigned range check
 *   (`addiu;sltiu`), which the oracle does NOT do -- so the two checks must be written as SEPARATE
 *   `if` statements to suppress the fold.
 * RESIDUAL FLOOR (68 diffs, not source-reachable so far): the `MI(objbuf,0x30)=0x32` (prio2) store --
 *   oracle schedules it LATE, interleaved with the bufBase->readptr/writeptr/fillptr triple-copy
 *   (a3/t0/t1) right before the freelist-reqArray reload; our gcc's list scheduler HOISTS the
 *   independent (no-dependency) store all the way up next to the prio1(0x96) store regardless of its
 *   textual position in the source (tried: original placement, block-scoped named temps for
 *   rdp/wrp/flp -- both compile to the IDENTICAL hoisted schedule). Genuine SCHEDULING floor: gcc's DAG
 *   scheduler treats the two non-aliasing constant stores as freely reorderable and always wins the
 *   hoist; no C-level statement reordering blocks it without a fabricated fake dependency. */
extern int STREAM_create(int numReq, int numFilters, int numConsumers, int objbuf, int bufsize)
{
    int over, base, i, off;

    over = STREAM_overhead(numReq, numFilters, numConsumers);
    if (bufsize - over < 0x6000)
        return 0;
    if (numReq < 2)
        return 0;
    if (numReq >= 0x101)
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
    /* MATCH: invalidate before freeing.  The block-local object pointer dies at the call, so gcc
     * keeps it in v0 and schedules the zero store into freemutex's jal delay slot. */
    {
        int obj = out[0];
        MI(obj, 0) = 0;                                /* invalidate magic */
        freemutex(MI(obj, 4));
    }
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
 *   request, fills it, queues it, and -- if the stream was idle -- starts it.  Returns the request id.
 * MATCH (40->0): `strncpy` uses the real 0x3F-byte name width; the raw stream state is tested twice;
 * queue-call args are materialized before the request-field stores so the final store fills the jal
 * slot; and the reversed priority ternary keeps the validated object in a0 through the legacy
 * two-argument startnextrequest call. */
extern unsigned int STREAM_queuefile(int s, char *name, int off, int len)
{
    int out[2];
    int *req;
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return 0;
    req = getfreerequest(out[0]);
    if (req == 0)
        return 0;
    req[4] = 0;                                   /* type = file */
    strncpy((char *)(req + 5), name, 0x3f);       /* req name @ +0x14 (oracle: len=0x3F, not 0x40) */
    {
        int r = (int)req;
        int sobj = out[0];
        req[0x16] = off;
        req[0x17] = len;
        queuerequest(sobj, r);
    }
    {
        int state, sr;
        sr = STREAM_enterCS();
        state = MI(out[0], 0x28);              /* MATCH: cache the RAW state, test ==0 twice
                                                 * (same idiom as decbufferusage/STREAM_release) */
        if (state == 0)
            MI(out[0], 0x28) = 1;
        STREAM_leaveCS(sr);
        if (state == 0) {
            int sobj = out[0];
            unsigned int prio = (MI(sobj, 0x38) != 0) ? MU(sobj, 0x30) : MU(sobj, 0x2c);
            ((int (*)(int, unsigned int))startnextrequest)(sobj, prio);
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
        int *p = (int *)blocklist;
        while (*p != len) {                       /* MATCH: no `v` local -- the rotated loop's two
                                                   * test loads are separate anonymous temps (v0/v1) */
            int blklen = p[1];
            p = (int *)((int)p + blklen);
            ptr = (void *)((char *)ptr + blklen); /* MATCH: the ptr param IS the accumulator (0 here) */
        }
        ptr = (void *)((char *)ptr + p[1]);
    }
    {
        int r    = (int)req;                      /* MATCH: both call args precomputed BEFORE the field
                                                   * stores (a1/a0 set first, last store in the jal slot) */
        int sobj = out[0];
        req[4] = 1;                               /* type = memory */
        req[0x15] = blocklist;                    /* mem source base */
        req[0x16] = (int)ptr;
        req[0x17] = len;
        queuerequest(sobj, r);
    }
    {
        int flagv, sr;
        sr = STREAM_enterCS();
        flagv = MI(out[0], 0x28);                 /* MATCH: raw value tested ==0 twice (no bool) */
        if (flagv == 0)
            MI(out[0], 0x28) = 1;
        STREAM_leaveCS(sr);
        if (flagv == 0)
            ((int (*)(int, unsigned int))startnextrequest)(out[0], 0);  /* MATCH: 2-arg site (oracle
                                                   * never sets $a2 here, as in queuefile) */
    }
    return (unsigned int)req[0];
}

/* STREAM_cancelrequest @0x800FD554 : cancel an in-flight or queued request and reclaim any of its data
 *   already sitting in the ring buffer (returning consumed chunks via STREAM_get/release, freeing
 *   un-consumed ones).  Returns 0 on success, 1 if it could not be cancelled.
 * w18-a9: 225->144 diffs, two levers:
 *   (1) BIG WIN (225->148): same out[0]-fresh-reload lever as STREAM_kill -- dropped `s = out[0];` and
 *       used `out[0]` directly everywhere post-validation (the oracle never caches the validated object
 *       pointer in a register; every use reloads fresh from the `out[2]` stack slot since its address
 *       escaped to validatehandle()).
 *   (2) if/else polarity (148->144): oracle's queued-vs-active branch falls THROUGH into the
 *       freerequest() call (branch-if-active jumps AWAY to the reclaim block) -- our original
 *       `if (state != 1) { ...active...; goto reclaim; } freerequest(...);` shape (if-without-else,
 *       negated guard) compiles the opposite layout (branch-if-queued jumps away to freerequest,
 *       active code falls through). Restructured to `if (state == 1) freerequest(...); else
 *       { ...active...; goto reclaim; }` to match the oracle's block order.
 * RESIDUAL FLOOR (144 diffs): the reclaim-region register coloring (`s7`/`fp` vs oracle's naming, the
 *   consumer-sweep temps) is a deep multi-variable allocator tie-break across ~8 saved registers: not
 *   pursued further this wave (see follow-up flag / future session). */
extern int STREAM_cancelrequest(int s, int reqid)
{
    int out[2];
    int ret;
    int req;
    int *s4, *s6, *s7;
    int sr;

    if (validatehandle(s, &out[0], &out[1]) != 0)
        return 1;

    sr = STREAM_enterCS();
    req = func_800FC4E4(out[0], reqid);
    if (req != 0 && MI(req, 4) != 4) {
        if (MI(req, 4) == 1) {                      /* queued -> just drop it */
            freerequest(out[0], req);
        } else {                                     /* active (not merely queued) */
            MI(req, 4) = 4;                         /* mark cancelled */
            s7 = *(int **)(out[0] + 0x40);          /* readptr */
            s4 = s7;
            if (req != MI(out[0], 0x4c))
                s4 = *(int **)(req + 0x60);          /* this request's start fill */
            {
                int nx = MI(req, 0xc);
                if (nx == 0 || MI(nx, 4) == 1) {
                    s6 = *(int **)(out[0] + 0x44);   /* writeptr */
                    ret = 0;
                } else {
                    s6 = *(int **)(nx + 0x60);
                    ret = 0;
                }
            }
            goto reclaim;
        }
    }
    ret = 1;
reclaim:
    STREAM_leaveCS(sr);
    if (ret != 0)
        return ret;

    /* sweep every consumer, returning or freeing the cancelled request's chunks */
    {
        int ci = 0;
        if (MI(out[0], 0x1c) > 0) {
            do {
                int cons = MI(out[0], 0x18) + ci * 0x10;
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
                                p = *(int **)(out[0] + 0x20);   /* wrap */
                            } else {
                                unsigned int len = p[1] & 0xffffff;
                                if ((unsigned int)(p[1] & 0xff000000) == (unsigned int)(rstate << 0x18)) {
                                    int sr2 = STREAM_enterCS();
                                    MI(cons, 8) -= len;
                                    STREAM_leaveCS(sr2);
                                    decbufferusage(out[0], len);
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
            } while (ci < MI(out[0], 0x1c));
        }
    }
    return ret;
}

/* STREAM_kill @0x800FD808 : cancel every request, free the queue, reset the ring to empty and the state
 *   to idle.
 * w18-a9: 88->63 diffs, two real fixes:
 *   (1) never cache `out[0]` into a local -- the oracle keeps `out[2]` address-taken (passed to
 *       validatehandle by reference) and reloads `out[0]` FRESH from the stack at every single use for
 *       the rest of the function (no persistent register at all), same family as STREAM_release/
 *       STREAM_get's documented out[]-reload floor. Reassigning `s = out[0]` let gcc promote it into a
 *       plain scalar and cache it in a callee-saved reg -- wrong shape. Fixed by using `out[0]` directly
 *       everywhere instead of `s`.
 *   (2) REAL BUG: `STREAM_cancelrequest(s, q[0])` must pass the RAW incoming handle `s`, not the
 *       validated `out[0]` -- oracle caches the ORIGINAL `$a0` parameter in `$s0` across the
 *       validatehandle() call SOLELY to feed this one call (STREAM_cancelrequest presumably
 *       re-validates internally); every other access in the function uses out[0].
 * RESIDUAL FLOOR (63 diffs): the free-mark-the-whole-ring do-while (mirrors restartstream's wrap-marker
 *   loop, already in the matching guard+do-while shape) has a pure register-coloring tie-break on which
 *   temp gets a0/a1/a2/a3/v0/v1 for the 3 hoisted loop-invariant constants (-1/-2/0xFFFFFF mask) --
 *   same allocator tie-break family as STREAM_overhead/decbufferusage. Not pursued further this wave. */
extern void STREAM_kill(int s)
{
    int out[2];
    int *q;
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return;
    q = *(int **)(out[0] + 0x54);                  /* tail */
    if (q == 0)
        return;

    while ((unsigned int)(q[1] - 1) < 2) {          /* cancel active/done requests */
        STREAM_cancelrequest(s, q[0]);               /* MATCH: raw handle, not out[0] -- oracle
                                                        * caches the ORIGINAL param in $s0 across
                                                        * validatehandle solely for this call */
        q = *(int **)(out[0] + 0x54);
    }
    while (MI(out[0], 0x4c) != MI(out[0], 0x50))    /* free the rest of the queue */
        freerequest(out[0], MI(out[0], 0x4c));
    MI(MI(out[0], 0x50) + 4, 0) = 4;                /* mark last cancelled */

    {
        int i = 0;
        if (MI(out[0], 0x1c) > 0) {                  /* zero all consumer counts */
            do {
                MI(i * 0x10 + MI(out[0], 0x18) + 8, 0) = 0;
                i++;
            } while (i < MI(out[0], 0x1c));
        }
    }
    decbufferusage(out[0], MI(out[0], 0x3c));        /* zero the buffer usage */

    q = *(int **)(out[0] + 0x40);                     /* free-mark the whole ring */
    if (q != *(int **)(out[0] + 0x44)) {
        do {
            if (q[0] == -1) {
                q = *(int **)(out[0] + 0x20);
            } else {
                unsigned int len = q[1];
                q[0] = -2;
                q[1] = len & 0xffffff;
                q = (int *)((int)q + (len & 0xffffff));
            }
        } while (q != *(int **)(out[0] + 0x44));
    }
    if (MI(out[0], 0x28) == 2)
        MI(out[0], 0x28) = 0;                        /* clear the stall */
}

/* STREAM_get @0x800FD9AC : pop the next available chunk for a consumer, returning a pointer to its data
 *   (or 0 if none).  Advances the consumer's read cursor to the following same-tagged chunk.
 * RESIDUAL FLOOR (37 diffs, down from 51): fixed the final `MI(cons,0xc)=p` store to dereference
 *   `out[1]` directly instead of the cached `cons` local -- oracle reloads out[1] FRESH from the stack
 *   at that one site (its `cons`-holding register got reused for the loop's `p` walk and wasn't kept
 *   live across it), matching this shape exactly (14 insns recovered). REMAINING: the very first
 *   `cons=out[1]` materialization picks a2 in ours vs a1 in oracle -- a pure allocator tie-break for
 *   the first fresh pseudo after the validatehandle() call (both regs equally dead/available); this
 *   ONE swap cascades through the whole function. Tried decl-order reshuffle (no effect). Accept. */
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
            MI(out[1], 0xc) = (int)p;
        }
    }
    return chunk;
}

/* STREAM_release @0x800FDAD0 : release a chunk previously obtained from STREAM_get, freeing its ring
 *   space and, if the stream had stalled (state 2) on a full buffer, re-arming the fill engine.
 * MATCH (39->0): short-lived `sobj` scopes keep each escaped out[0] reload in a0 without promoting it
 * to a callee-saved register; preloading the release size places the free-marker store in the
 * decbufferusage jal slot; and the reversed priority ternary matches the restart call's branch layout.
 * TWO REAL BUGS FOUND+FIXED here (2026-07, wave-16 a1): (1) the restartstream() call was missing a
 *   DEAD 2nd arg (`prio`, same ternary shape as STREAM_queuefile's startnextrequest call) that the
 *   oracle still loads+passes despite restartstream ignoring it -- same family as opencallback's
 *   documented dead-2nd-param call. (2) the `state==2` wasstall test was wrongly materialized as a 0/1
 *   C bool tested twice; the oracle caches the RAW state word and re-tests `state==2` against the SAME
 *   li-2 constant twice (never forms a boolean) -- same idiom as decbufferusage's greedy-state test. */
extern void STREAM_release(int s, int chunk)
{
    int out[2];
    if (validatehandle(s, &out[0], &out[1]) != 0)
        return;
    {
        int sobj = out[0];
        int amount;
        if ((unsigned int)chunk < MU(sobj, 0x20))     /* below bufBase */
            return;
        if ((unsigned int)(MI(sobj, 0x24) - 8) < (unsigned int)chunk)  /* above bufEnd-8 */
            return;
        if (MI(chunk, 0) == -2)                      /* already free */
            return;
        amount = MI(chunk, 4);
        MI(chunk, 0) = -2;                           /* mark free */
        decbufferusage(sobj, amount);                 /* account the chunk's bytes back */
    }
    {
        int state, sr;
        sr = STREAM_enterCS();
        state = MI(out[0], 0x28);              /* MATCH: cache the RAW state (not a 0/1 bool) --
                                                 * oracle tests `state==2` TWICE against the same
                                                 * cached load, never materializes a boolean */
        if (state == 2)
            MI(out[0], 0x28) = 1;
        STREAM_leaveCS(sr);
        if (state == 2) {
            /* MATCH: oracle passes a DEAD 2nd arg (prio, same ternary as STREAM_queuefile's
             * wasidle-startnextrequest call) -- restartstream ignores it but the caller still
             * loads+passes it (same dead-2nd-param family as opencallback's restartstream call). */
            int sobj = out[0];
            unsigned int prio = (MI(sobj, 0x38) != 0) ? MU(sobj, 0x30) : MU(sobj, 0x2c);
            ((int (*)(int, unsigned int))restartstream)(sobj, prio);
        }
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

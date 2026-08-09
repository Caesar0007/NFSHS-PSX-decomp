/* W52-A7 GCC-LADDER RECEIPT (2026-08-09) -- THE COMPILER-VERSION AXIS IS CLOSED FOR eacpsxz.
 * Every residual in this TU was A/B'd across the FULL windows-gcc-psx ladder on UNCHANGED
 * source, on BOTH axes:
 *   (a) ladder lane  NFS4_FORCE_CC1_ALT=<ver>  (272 recipe: macro cc1 + direct GNU-as reorder,
 *       NO maspsx) -- changes compiler AND assembler route at once; and
 *   (b) VERSION-ONLY axis  NFS4_CC1=<ladder>/cc1.exe  (normal compile_c, maspsx KEPT) -- the
 *       clean single-variable experiment.  Use (b) to read a version verdict; (a) confounds.
 * WHOLE-CLUSTER TOTALS, 68 TUs / 244 fns, version-only axis:
 *   default(psq43 CC1PSX)  232 PASS / 173 diffs   <-- the wired lane, WINS
 *   ladder 2.8.0           232 PASS / 173 diffs   <-- BIT-IDENTICAL to psq43 CC1PSX on all 244
 *   ladder 2.8.1           232 PASS / 172 diffs   (+1 F->P nsync, -1 P->F nfile FILE_operror)
 *   2.7.2-970404            61 PASS / 2422        2.7.2  51 / 5855   (SN 2.7.2 == FSF 2.7.2,
 *   2.6.0 / 2.6.3           50 PASS / ~4925        verified via the ladder lane)
 *   2.91.66 92 / 6832       2.95.2 95 / 6881
 * ==> eacpsxz's compiler IS gcc 2.8.0 -- the rung already wired.  NO rung beats it.  Any
 * residual in this file that a prior wave routed to "the toolchain-identity / old-gcc-cse /
 * allocno_compare-delta investigation" is hereby FALSIFIED on the VERSION axis: it is not a
 * gcc-version question.  Remaining candidate axes: per-obj FLAGS (3.25-3d), the assembler
 * route, or source.  Do NOT re-run the ladder on this TU.
 * PER-FN LADDER NUMBERS (version-only axis; 'P' = PASS):
 *   STREAM_create        def 2 | 2.6.0 57 | 2.6.3 57 | 2.7.2-970404 10 | 2.7.2 36 | 2.8.1 2 | 2.91.66 143 | 2.95.2 203
 *   STREAM_cancelrequest def P | 2.6.0 57 | 2.6.3 57 | 2.7.2-970404 12 | 2.7.2 57 | 2.8.1 P | 2.91.66 138 | 2.95.2 115
 */
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
extern unsigned int FILE_callbackop(unsigned int id, void (*cb)(int, int)); /*@0x800EBE4C*/
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
extern int  startnextrequest(int s, unsigned int prio);                    /* @0x800FC9B4 */
extern int  restartstream(int s, unsigned int prio);                       /* @0x800FCB44 */
extern int  STREAM_get(int consumer);                                      /* @0x800FD9AC */
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
    int   consumer;
    int   consumerCount;
    int   level;
    unsigned int fillptr, uVar5;
    int  *chunk;
    int  *originalChunk;
    int   reqcur;
    int   sr;
    int   freeTag;

    fillptr = MU(s, 0x48);
    chunk   = *(int **)(s + 0x44);              /* writeptr */
    reqcur  = MI(s, 0x50);                      /* current request */
    if ((int)(fillptr - (int)chunk) < 8)
        return 0;
    freeTag = -2;

    while (1) {
        uVar5 = chunk[1];
        originalChunk = chunk;
        if ((uVar5 & 0xff000000) != 0)
            goto malformed;
        if (fillptr < (unsigned int)((int)chunk + uVar5))
            goto malformed;

        consumer = filterchunk(s, (int)chunk);
        if (consumer < 0) {                     /* no consumer (skip) */
            sr = STREAM_enterCS();
            bvar1 = (MI(reqcur, 4) == 4);       /* request cancelled? */
            if (!bvar1) {
                chunk[0] = freeTag;             /* mark chunk free */
                MI(s, 0x44) += uVar5;           /* advance writeptr */
            }
            STREAM_leaveCS(sr);
        } else {                                /* routed to consumer uVar3 */
            chunk[1] = chunk[1] | (consumer << 0x18);
            sr = STREAM_enterCS();
            bvar1 = (MI(reqcur, 4) == 4);
            if (!bvar1) {
                int consOffset = (consumer << 4) - 0x10;
                int cons = MI(s, 0x18) + consOffset; /* consumer slot */
                int oldUsage;
                int newUsage;
                consumerCount = MI(cons, 8) + uVar5;
                MI(cons, 8) = consumerCount;    /* consumer.count += len */
                if (consumerCount == uVar5)     /* first chunk for this consumer */
                    MI(cons, 0xc) = (int)chunk; /* readcursor = chunk */
                MI(s, 0x44) += uVar5;           /* advance writeptr */
                oldUsage = MI(s, 0x3c);
                level = MI(s, 0x34);
                newUsage = oldUsage + uVar5;
                MI(s, 0x3c) = newUsage;         /* bufusage += len */
                if (oldUsage < level && level <= newUsage)
                    MI(s, 0x38) = 0;            /* crossed greedy level -> greedy off */
            }
            STREAM_leaveCS(sr);
        }
        if (bvar1)
            break;
        if (originalChunk[0] == MI(reqcur, 0x5c)) /* reached end-of-stream id */
            return 1;
        fillptr = MU(s, 0x48);
        chunk  = *(int **)(s + 0x44);
        if ((int)(fillptr - (int)chunk) < 8)
            return 0;
    }
malformed:
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
 *   request finishes, marks it done and starts the next queued request.
 * MATCH work (37->22 diffs, count-exact 67/67): startnextrequest has only the two arguments
 * consumed by its oracle; the former third `s` argument was phantom.  Positive completion
 * logic plus an explicit late restart label gives the oracle's branch polarity and block
 * order.
 * w33-a2: 22 -> 0 (PASS, 67 insns).  The "whole-function s1/s2 allocation swap between reqcur
 * and bvar1" was NOT a coloring coin-flip -- it was a variable-identity miss visible in the raw:
 * the memory-source arm's running total is computed INTO bvar1's own register (`addu s1,v1,a1`,
 * then `slt v0,s1,v0`, then `xori s1,v0,1` redefines it).  Writing the total as an anonymous
 * sub-expression `(MI(s,0xa0) + uVar3)` gave it a separate caller-saved pseudo ($v0); assigning
 * it to `bvar1` first and then overwriting `bvar1` with the comparison reproduces retail exactly.
 * Side effect (and the reason the swap looked global): the extra two references raise bvar1's
 * allocno priority above reqcur's, so bvar1 takes $s1 and reqcur $s2 as in retail. */
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
        /* MATCH: the running total is computed INTO `bvar1` itself (oracle: `addu s1,v1,a1`
         * writes the sum to the very register the `xori` then redefines as the flag).  Spelling
         * it as an anonymous sub-expression gives the sum its own caller-saved pseudo ($v0). */
        bvar1 = MI(s, 0xa0) + uVar3;
        bvar1 = (MI(reqcur, 0x58) <= bvar1);
    } else {                                   /* file source */
        uVar3 = FILE_completeop(MU(s, 0xa4));
        bvar1 = ((int)uVar3 < MI(s, 0xa8));
    }
    MU(s, 0xa0) += uVar3;                       /* readaccum += bytes */
    MU(s, 0x48) += uVar3;                       /* fillptr   += bytes */
    iVar2 = parsechunks(s);
    if (MI(reqcur, 4) != 4) {                   /* not cancelled */
        if (bvar1 || iVar2 != 0) {
            int sr = STREAM_enterCS();
            MI(reqcur, 4) = 3;                  /* request done */
            STREAM_leaveCS(sr);
        } else {
            goto restart;
        }
    }
    return startnextrequest(s, MU(s, 0x30));
restart:
    return restartstream(s, MU(s, 0x30));
}

/* startnextrequest @0x800FC9B4 : advance the active queue cursor (+0x50) to the next runnable request,
 *   open/seek its file (or rebind to the memory image), and kick restartstream.  Sets state idle if the
 *   queue drains.
 * w32-a2 (72 -> 20 diffs, 106 -> 102 insns): IDA types sub_800FC9B4 as **void** and the raw confirms it --
 *   the oracle has NO return-value bookkeeping at all: the `done` path branches straight to the shared
 *   epilogue with $v0 undefined, and the three real exits just return their callee's $v0 (FILE_open /
 *   FILE_close = 0, FILE_callbackop, restartstream).  The reconstruction had invented an `int ret`
 *   carrying 0/1/2, which cost the whole +6 surplus: a prologue `addu v1,zero,zero`, `ret=1`/`ret=2`
 *   materializations and an `addu v0,v1,zero` result copy.  Also: the oracle FALLS THROUGH into the
 *   FILE_open arm and lays the close-first arm out of line (`bnez $a0,.L800FCAF4`), so the source test
 *   is `if (handle == 0) { open... }` with the close arm as the tail.
 * w33-a2 (20 -> 16 diffs, now INSTRUCTION-COUNT EXACT 100/100).  The "+2 / only one of two textually
 *   identical arms can win" note was wrong on both counts:
 *   - BOTH arms must be written `if (op != 0) return FILE_callbackop(...); return;` -- i.e. the
 *     callbackop tail in the if-body and the zero exit last.  The `if (op == 0) return op;` spelling
 *     lays the zero exit out as its own block and gcc CSE (record_jump_equiv) substitutes the proven
 *     0, producing `j <epilogue>; addu v0,zero,zero`.
 *   - the zero exit must be VALUELESS (`return;`).  This fn is really void (IDA + the raw: the `done`
 *     path reaches the epilogue with $v0 undefined); `return (int)op;` still costs the 2-insn
 *     zero-materialization stub even though $v0 already holds 0.  With both fixed, retail's
 *     `beqz $v0, <epilogue>` + fall-through into the callbackop call comes out exactly.
 * RESIDUAL (16): a 2-slot register shift -- retail merges the `cur->state` compare temp INTO `done`
 *   (both $v1) so `done`/SR land on $v1/$a1, while our local-alloc gives the temp $v1 first and pushes
 *   `done`/SR to $a1/$a3.  TRIED: spelling the temp as `done` itself (does merge them, but then the
 *   allocno priority of `cur` beats `done` and they swap -- $a0/$v1 becomes $v1/$a0, 20 diffs); moving
 *   `done = 1` ahead of `cur = ...` (no effect).  This is the allocno_compare live-length weighting
 *   already on the wave-33 identity charter.
 * w34-a2 QUANTIFIED THE GAP with cc1 -dl/-dg allocno dumps (no diff change; kept at 16).  There are
 *   TWO distinct mechanisms, and the MERGED spelling -- not the shipped one -- is the structurally
 *   correct base even though it currently gates worse (20):
 *   - AS SHIPPED (separate anonymous state temp): local-alloc gives that block-local temp $v1, and
 *     `done` is LIVE ACROSS it, because the source's `done = 0;` precedes the `MI(cur,4)` load AND
 *     sched1 re-hoists it there even when the load is written first (verified in the lreg dump).
 *     Result `82 conflicts: ... 2 3 ...` => `done` can NEVER be $v1; it lands $a1 and pushes SR to
 *     $a3.  The 16 diffs are exactly done + SR.
 *   - MERGED (`done = MI(cur,4); if (done != 1) {...} else done = 0;` -- the shape retail's $v1
 *     reuse implies): the hard-$v1 conflict DISAPPEARS (`82 conflicts: ... 2 29`), SR lands
 *     correctly on $a1, and the ONLY residual is that `cur` is allocated before `done` and takes
 *     $v1 first.  Measured (allocno_compare = floor_log2(refs)*refs/live_length*10000):
 *         cur  = log2(4)*4/7  -> 11428        done = log2(8)*8/22 -> 10909
 *     `done` needs +519: refs 8->9, or live_length 22->21 (a tie hands it to the lower allocno,
 *     i.e. done), or cur live_length 7->8.  No source spelling was found that moves any of the three
 *     without changing the instruction stream -- cur's 4 refs (def / !=0 / state base / next base)
 *     and done's 8 are forced by the oracle, and done's 22 insns of liveness are the two join arms
 *     plus the post-leaveCS re-test.  IDA sub_800FC9B4 confirms the variable shape is right
 *     (v7/$v1 = done, v6/$a0 = cur, v5/$a1 = SR, v8/$v0 = nx).  Also byte-identical: hoisting the
 *     state load above `done = 0`; per-arm `done = 0` is worse (29 diffs, 99 insns);
 *     -fno-schedule-insns and -fno-schedule-insns2 do not move it.
 *     => allocno_compare live-length identity; permuter / length-perturbation class.
 * w35-a5 -- **PASS (100/100)**.  The w34 verdict ("merged gates worse, 20; needs done +519") was
 * measured on an INCOMPLETE merged spelling: merging the state temp into `done` also requires the
 * `state == 1` path to carry an EXPLICIT `else done = 0;` and the advance path an explicit
 * `done = 0;` beside the cursor store, so that every arm of the merged variable is written in the
 * source.  With all three arms spelled out, `done` and `cur` no longer contend at all -- the
 * merge removes the block-local state temp (hence the hard-$v1 conflict on `done`), and the arms'
 * own sets give `done` the extra RTL references the w34 arithmetic said it needed (+519) without
 * adding a single instruction: gcc tail-merges the two `done = 0` stores and folds the else arm,
 * so the stream is byte-identical to the shipped form except for the register roles it fixes
 * (done/SR -> $v1/$a1 = retail, cur -> $a0, nx -> $v0, exactly IDA sub_800FC9B4's v7/v5/v6/v8).
 * LESSON (catalog-worthy): when a "merged variable" experiment gates worse, check that EVERY arm
 * assigns the merged variable explicitly before filing the allocno-priority verdict -- a partially
 * merged spelling leaves the old anonymous temp alive and measures the wrong thing. */
extern int startnextrequest(int s, unsigned int prio)
{
    int  done;
    int  cur;
    int  req;
    int  sr;
    sr = STREAM_enterCS();
    cur  = MI(s, 0x50);
    done = 1;
    if (cur != 0) {
        done = MI(cur, 4);                      /* merged: state temp IS done */
        if (done != 1) {                        /* current no longer queued */
            int nx = MI(cur, 0xc);              /* advance to next */
            if (nx == 0)
                done = 1;
            else {
                MI(s, 0x50) = nx;
                done = 0;
            }
        } else {
            done = 0;
        }
    }
    if (done) {
        MI(s, 0x28) = 0;                         /* state idle */
    } else {
        req = MI(s, 0x50);
        MI(req, 0x60) = MI(s, 0x44);             /* request start fill ptr = writeptr */
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
                /* MATCH: the oracle FALLS THROUGH into the FILE_open arm and lays the
                 * close-first arm OUT OF LINE after it (`bnez $a0,.L800FCAF4`); the natural
                 * `if (handle != 0) {close...} {open...}` spelling emits the opposite layout. */
                if (MU(s, 0x9c) == 0) {          /* nothing open -> open the new file directly */
                    unsigned int op = FILE_open((char *)name, 1, prio, (unsigned int)s);
                    MU(s, 0xa4) = op;
                    if (op != 0)
                        return (int)FILE_callbackop(op, (void (*)(int, int))opencallback);
                    return;                      /* MATCH: valueless (see the void note above) */
                }
                {                                /* close the open file first */
                    unsigned int op = FILE_close((void *)MU(s, 0x9c), prio, (unsigned int)s);
                    MU(s, 0xa4) = op;
                    if (op != 0)
                        return (int)FILE_callbackop(op, (void (*)(int, int))closecallback);
                    return;                      /* MATCH: valueless (see the void note above) */
                }
            }
        }
        /* MATCH: oracle keeps this fn's OWN `prio` parameter cached in a callee-saved reg across every
         * intervening call (strcmp/strcpy/FILE_open/FILE_callbackop/FILE_close) to hand to restartstream
         * as its real 2nd arg (forwarded to FILE_read's a5, see restartstream). */
        return restartstream(s, prio);
    }
    /* MATCH: NO return here -- the oracle's `done` path branches straight to the shared epilogue with
     * whatever $v0 holds.  An explicit `return ret;` forces a live `ret` pseudo across the whole
     * critical section (+6 insns: a prologue `addu v1,zero,zero`, the `ret=1`/`ret=2`
     * materializations and an `addu v0,v1,zero` result copy) -- exactly the +6 surplus. */
}

/* restartstream @0x800FCB44 : the buffer fill engine.  Reclaims free space at the read head, releases
 *   spent requests, wraps the ring when needed, computes the next contiguous fill region, and issues the
 *   next chunk read -- from the memory image (memcpy + readcallback) or via FILE_read + readcallback.
 *   Stalls (state 2) if there is not at least one sector of room.
 * RAW/ORACLE REDUCTION (2026-07-26, 141->42 diffs; count-exact 167/167):
 *   - distinct lexical lifetimes for queue head, room size, wrap-copy size, and current request let
 *     gcc reuse the oracle's five saved registers; this unblocks the real `prio,s` stack arguments
 *     to FILE_read instead of the incorrect zero placeholders;
 *   - the positive-room arm and shared check label recover the oracle's two-arm branch/jump shape;
 *   - named -1/-2 marker constants recover the oracle's prologue scheduling;
 *   - FILE_callbackop's result remains the merged return value.
 * RESIDUAL (42, count-exact 167/167): ONE three-variable coloring family across the whole room
 *   calculation -- (readptr, fillptr, room) is (v1, a2, a0) for us and (a2, v1, a1) in retail, i.e.
 *   the two ring pointers are swapped and `room` shifts one slot.  Every diff in the function is a
 *   rename of those three; the instruction sequence, operand order and delay slots already agree.
 *   w33-a2 TRIED, all byte-identical to the above: spelling the guard `uVar5 < uVar3` instead of
 *   `uVar3 > uVar5` (gcc canonicalises the compare, so the load order does not follow the source);
 *   swapping the two initialising loads' statement order; folding the shared `room - 1` into the
 *   wrap arm as one expression; dropping `uVar3` entirely and re-reading `MU(s,0x40)` at each of its
 *   three uses (cse rebuilds the same single pseudo).  Next step is a cc1 -dl allocno dump: retail
 *   gives $v1 to the MORE-referenced fillptr (7 refs, and it is re-assigned in the wrap arm) while
 *   ours gives it to readptr, which is the allocno_compare live-length weighting already on the
 *   wave-33 toolchain-identity charter.
 * w34-a2 ROOT-CAUSED IT (cc1 -dl/-dg; no diff change, kept at 42).  It is NOT the initial load order
 *   and NOT a global-alloc priority tie -- it is a LOCAL-ALLOC collision in the WRAP arm:
 *     - allocnos: 106 = readptr (4 refs / 13 insns), 107 = fillptr (8 / 18, `preferences: 6`),
 *       108 = room (9 / 21).  Allocation order 107, 108, ..., 106.
 *     - `107 conflicts: ... 2 3 ...` -- fillptr is BANNED from $v1, so it takes its preferred $a2,
 *       room takes $a0 and readptr falls to $v1.  The hard-$v1 conflict comes from the wrap arm's
 *       SECOND `MI(s,0x20)` (bufBase) read: cse makes it ONE block-local pseudo, `q`/$v1 has just
 *       died, and local-alloc hands it $v1.  Retail's build gives that same pseudo $a0
 *       (`lw a0,0x20(s1); addu v1,a0,s0`), leaving $v1 free for the redefined fillptr -- which is
 *       exactly the oracle's register map.
 *   w34-a2 TRIED, all byte-identical or worse: `volatile` on either initial load (42/42), a named
 *   `bb` local for the wrap arm's bufBase (42), storing `MI(s,0x44) = MI(s,0x20)` before the fillptr
 *   update (44).  The lever needed is one that keeps $v1 busy across the wrap arm's bufBase load --
 *   same local-alloc-ordering identity family as startnextrequest.
 * w35-a5 -- 42 -> 2 (167/167).  The w34 root-cause was RIGHT about the mechanism (a block-local
 * bufBase pseudo stealing $v1 in the wrap arm) and WRONG about the fix being unreachable.  Two
 * source levers, both plain C:
 *  (1) GIVE THE WRAP ARM'S bufBase A NAMED FUNCTION-SCOPE LOCAL THAT IS ALSO THE memcpy ARGUMENT
 *      (`unsigned char *bb`, assigned once BEFORE the memcpy/guard and re-read once AFTER it).
 *      A dedicated local used only after the call stays BLOCK-local and changes nothing (measured:
 *      42, in all three declaration positions) -- what matters is that the SAME variable is
 *      assigned in TWO blocks, which promotes it to a global allocno carrying memcpy's `$a0` copy
 *      preference.  It then takes $a0 (retail's register) instead of the just-freed $v1, the
 *      hard-$v1 ban on fillptr disappears, and (readptr, fillptr) snap to retail's (a2, v1).
 *      42 -> 6.  Staging the bufBase in an existing long-lived local instead of a fresh one is a
 *      weaker form of the same lever: into `room` = 22, into `p` = 17 but 166 insns (p's extra
 *      liveness costs the first loop's `addu a0,v1,zero`), into `q` = 34, into `uVar3` = 39.
 *  (2) SPLIT THE `- 1` OFF THE WRAP ARM'S ROOM SUBTRACTION (`roomRaw = readptr - fillptr;` then
 *      `room = roomRaw - 1;` inside the arm, instead of the shared `room = room - 1;`).  With one
 *      variable gcc coalesces both into `subu a1,v0,v1; addiu a1,a1,-1`; the oracle keeps the
 *      subtraction in a scratch (`subu v0,v0,v1; addiu a1,v0,-1`).  6 -> 2.
 * ==== w47-a5: PASS 167/167.  The RESIDUAL 2 below fell to the w45 USE-FENCE FIXPOINT. ====
 * The diagnosis was exactly right (a sched1 ready-list tie on the two initialising loads) and
 * the conclusion 'fillptr's longer dependency chain wins the ready list regardless of source
 * order' was right too -- which is WHY no source ORDER helps.  A zero-insn USE FENCE between
 * the two loads is not an order hint, it is a scheduling BARRIER: insns before it cannot sink
 * past it, so the readptr load must issue first no matter what the ready list prefers.  Cost 0
 * instructions (the operand is already register-resident).  The decl-with-init pair had to
 * become decl + assignment for C89, which is codegen-neutral here.
 * ---- superseded w35-a5 note ----
 * RESIDUAL 2 = a sched1 ready-list tie on the two initialising loads: the oracle issues
 * `lw a2,0x40(s1)` (readptr) before `lw v1,0x48(s1)` (fillptr), ours the other way round; the
 * registers are already retail's, only the two loads are transposed.  Falsified for it: swapping
 * the two initialisers' source order, and the Yoda compare `uVar5 < uVar3` (both byte-identical --
 * fillptr's longer dependency chain wins the ready list regardless of source order). */
extern int restartstream(int s, unsigned int prio)
{
    int *p;
    int *q;
    int  sr;
    unsigned char *bb;

    /* skip wrap/free markers at the read head (+0x40) up to the writeptr (+0x44) */
    if (MI(s, 0x40) != MI(s, 0x44)) {
        int wrapTag = -1;
        int freeTag = -2;
        unsigned int wr = MU(s, 0x44);           /* cache writeptr for the whole loop */
        do {
            p = *(int **)(s + 0x40);
            if (p[0] == wrapTag) {               /* wrap marker -> jump to bufBase (+0x20) */
                MI(s, 0x40) = MI(s, 0x20);
            } else {
                if (p[0] != freeTag)             /* a live chunk -> stop */
                    break;
                MI(s, 0x40) = (int)p + p[1];     /* free marker -> skip its length */
            }
        } while (MU(s, 0x40) != wr);
    }

    /* free finished requests whose data has been fully consumed */
    sr = STREAM_enterCS();
    {
        int head = MI(s, 0x4c);                  /* queue head */
        if (MI(head, 0xc) != 0) {
            do {
                int req = MI(head, 0xc);         /* req = head->next */
                if (MI(req, 4) == 1)             /* state==queued -> stop */
                    break;
                if (inbetween(MU(s, 0x40), MU(s, 0x48), MI(req, 0x60) - 1) != 0)
                    break;
                freerequest(s, head);
                head = MI(s, 0x4c);
            } while (MI(head, 0xc) != 0);
        }
    }
    STREAM_leaveCS(sr);

    /* compute the next contiguous fill region [fillptr .. readptr) */
    {
        unsigned int uVar3;
        unsigned int uVar5;
        int room;
        int roomRaw;
        uVar3 = MU(s, 0x40);                     /* readptr */
        __asm__("" : : "r"(uVar3));              /* w47-a5 sched fixpoint: pin this load first */
        uVar5 = MU(s, 0x48);                     /* fillptr */
        if (uVar3 > uVar5) {
            room = (uVar3 - uVar5) - 1;
            goto check_room;
        } else {
            room = (MI(s, 0x24) - uVar5) - 8;    /* room to bufEnd, less header */
            if (0x1fff < room)
                goto have_room;
            /* not enough tail room -> wrap: move the partial chunk down to bufBase */
            {
                int moveSize = uVar5 - (int)*(unsigned char **)(s + 0x44);
                bb = *(unsigned char **)(s + 0x20);
                if ((int)(uVar3 - (int)bb) < moveSize + 1)
                    goto stall;
                memcpy(bb, *(unsigned char **)(s + 0x44), moveSize);
                q = *(int **)(s + 0x44);
                q[0] = -1;                       /* leave a wrap marker behind */
                q[1] = 8;
                bb = *(unsigned char **)(s + 0x20);
                uVar5 = (unsigned int)bb + moveSize;
                roomRaw = MI(s, 0x40) - uVar5;
                MI(s, 0x44) = (int)bb;
                MI(s, 0x48) = uVar5;
                room = roomRaw - 1;
            }
        }
check_room:
        if (room < 0x2000) {
stall:
            MI(s, 0x28) = 2;                     /* buffer-full stall */
            return 2;
        }
have_room:
        {
            int req = MI(s, 0x50);               /* current request */
            if (MI(req, 0x10) == 1) {            /* memory source -> memcpy a chunk in */
                if (MI(req, 0x58) < MI(s, 0xa0) + room)
                    MI(s, 0xa8) = MI(req, 0x58) - MI(s, 0xa0); /* clamp to remaining */
                else
                    MI(s, 0xa8) = room;
                memcpy(*(unsigned char **)(s + 0x48), *(unsigned char **)(req + 0x54), MI(s, 0xa8));
                MI(req, 0x54) += MI(s, 0xa8);    /* advance mem source ptr */
                return readcallback(0, 0, s);
            }
        }
    }
    /* file source -> issue a sector read */
    MI(s, 0xa8) = 0x2000;
    {
        unsigned int op = FILE_read((void *)MU(s, 0x9c), MU(s, 0xa0), MU(s, 0x48),
                                    MI(s, 0xa8), prio, (unsigned int)s);
        MU(s, 0xa4) = op;
        if (op != 0)
            op = FILE_callbackop(op, (void (*)(int, int))readcallback);
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
 * w33-a2 (68 -> 22 diffs, now INSTRUCTION-COUNT EXACT 144/144).  The old "not source-reachable
 *   scheduling floor" verdict fell to two source facts:
 *   (1) READ-BACK CURSORS (see the inline note): `readptr/writeptr/fillptr = objbuf->bufBase` --
 *       three separate re-reads of the field just stored -- are what produce the oracle's triple
 *       `addu a3/t0/t1,v0,zero` copy AND push `li 50`/`sw 48` down into their middle.  Three named
 *       locals initialised from one expression do not (copy-propagated to one register).
 *   (2) CONSUMER LOOP index form: `c = consumerArray + i * 0x10; ... c[1] = i + 1; i++;` -- indexing
 *       off the PRE-increment counter and letting cse share the `i+1` with the loop increment.  The
 *       old `i++; c = ...(i-1)*0x10; c[1] = i;` spelling let loop.c strength-reduce into a walking
 *       +16 pointer with a +16/-16 fixup pair (and flipped the whole a0/a1 pair).  -41 diffs alone.
 * w34-a2 (22 -> 4 diffs, still count-exact 144/144).  The "list-scheduler placement floor" was three
 *   independent source facts, each found by walking the oracle's basic-block layout:
 *   (3) OPERAND ORDER on the ring-base sum: `numConsumers * 0x10 + <read-back of 0x18>` (shift term
 *       FIRST) reproduces retail's `addu v0,v0,v1`; the natural `<read-back> + numConsumers * 0x10`
 *       emits `addu v0,v1,v0` (gcc expands operand 0 first, and the read-back costs no insn).  -2.
 *   (4) VOLATILE consumerArray STORE.  ROOT CAUSE (the whole "scheduler" cluster): with a plain
 *       store, cse rewrites the following read-back of 0x18 as a register COPY of `base` and a later
 *       pass COPY-PROPAGATES it away; that keeps `base`/$v1 live to the very end of the block, so
 *       the `sw v1,24(s0)` store SINKS below the ring-base add and the freelist `lw ,8(s0)` re-read
 *       is hoisted ~30 insns up into its own extra register (a3).  Retail's build keeps the copy
 *       (`addu v0,v1,zero`), which frees $v1 for the `sll` and therefore FORCES the store to be
 *       emitted before it.  Marking the store volatile is the only in-tree way found to keep the
 *       read-back a real memory reference at that point: it restores the store's position, the late
 *       freelist load, and the a3/t0/t1 ring-base copies.  -14.
 *   (5) COMBINED `numConsumers <= 0 || numFilters < numConsumers` guard.  As two separate `if`s,
 *       jump.c proves $v0 is already 0 at the `blez` (check-4's return-0 setup ran unconditionally)
 *       and THREADS the branch past the shared `j <epilogue>; addu v0,zero,zero` stub straight to
 *       the epilogue -- which makes the `blez` delay slot unfillable (`nop`).  Written as one `||`
 *       both arms target the local stub, and reorg fills the slot with the oracle's `slt v0,s2,s3`.
 *       (Note this is the INVERSE of the w18-a9 SEPARATE-CHECK lever, which applies to the numReq
 *       range pair only -- there the fold to be avoided is the unsigned range check, not the stub.)
 *   (6) NAMED `one` for the filter table's `f[2] = 1`: loop.c inserts hoisted movables at the END of
 *       the preheader, so an anonymous invariant `1` lands AFTER the `idx = 0` copy; a local
 *       declared before `idx` puts `li a0,1` first, as retail has it.  -2.
 * RESIDUAL (4): the consumerArray read-back is a real `lw v1,24(s0)` for us where retail has cse's
 *   `addu v0,v1,zero` copy (and the $v0/$v1 roles of the following `sll` swap with it).  This is the
 *   flip side of (4): a plain store gives the copy but then copy-prop removes it and the whole block
 *   re-schedules (17-19 diffs, 143 insns).  Tried: volatile on the read-back instead of the store
 *   (same 4), read-back into a named local, in-place `cbase = cbase + n*0x10` mutation, `base` used
 *   directly, an empty `__asm__("" : : "r"(base))` fence (23).  Needs a non-volatile way to keep
 *   cse's copy alive = the "old-gcc no-copy-prop" toolchain-identity class. */
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
    if (numConsumers <= 0 || numFilters < numConsumers)
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
    /* MATCH (w34-a2 #4): volatile keeps the following read-back a real memory reference, which
     * frees $v1 and therefore pins this store ahead of the ring-base `sll` (see the header note).
     * w49-a3 RESIDUAL 4 = ours re-READS the field (`lw v1,24(s0)`) where retail keeps a register
     * COPY of the just-stored value (`addu v0,v1,zero`), plus the paired `sll` destination.  The
     * volatile IS what forces the real reload -- but every non-volatile route measured WORSE, so
     * it stays: plain `MI(objbuf,0x18) = base;` 17 @143/144 (cse fully propagates the read-back,
     * so we land 1 SHORT -- exactly the missing copy); + a named `rb` read-back local 17 @143;
     * + an OPACITY FENCE on `base` after the store 10 @144 (keeps the count but reorders the
     * memset arg block); anonymous store + named read-back (the w45 cse double-evaluation recipe
     * that supplies a reg-reg copy elsewhere) 33 @143.  Keeping the volatile store + a named
     * read-back local is diff-neutral (4).  => the copy is an allocation artifact (the read-back
     * pseudo must land in a DIFFERENT hard reg than `base` while `base` is still live), not a
     * cse-shape question.
     * w50-a4: 4 -> 2 by putting the read-back FIRST in the ring-base sum (see that statement).
     * RESIDUAL 2 = the reload-vs-copy alone, and it is now bounded: a plain store lands 1 SHORT
     * (143) in EVERY spelling measured, because the surviving copy needs a SECOND live consumer
     * that retail's source does not have (contrast the three cursor read-backs below, whose three
     * simultaneously-live copies is exactly why THOSE survive copy-prop).  Falsified this wave on
     * top of the earlier list, all at the reversed operand order: plain store + `memory` clobber
     * (8 @144), plain + opacity fence on base (8 @144), plain + void-tail fence (28 @142), plain +
     * use fence (28 @142), volatile + void-tail fence (8 @144), volatile read-back (2, identical),
     * an opacity-fenced COPY of `base` instead of the read-back (28 @142 / 21 @143), a plain
     * `cbase = base` copy (19 @143), `base` used directly (19 @143), and an opacity fence on a
     * read-back local (21-23 @143).  => the missing insn is cse's copy under a NON-volatile store,
     * and every device that restores the copy also un-pins the store. */
    *(volatile int *)(objbuf + 0x18) = base;                   /* consumerArray */
    {
        /* MATCH (w33-a2): the oracle's THREE `addu <reg>,v0,zero` copies of the ring base are NOT a
         * missing copy-propagation in retail's compiler -- they are THREE SEPARATE SOURCE
         * EVALUATIONS.  Each cursor is initialised by READING BACK the bufBase field that was just
         * stored; cse.c replaces each load with a register COPY of the stored value, and because
         * all three copies are live at once nothing can coalesce them.  Three separate C locals all
         * initialised from one expression do NOT work (gcc copy-propagates them into one register,
         * verified) -- the read-back is what makes it three evaluations.  This also frees $v0 for
         * the late `li 50` and takes the function from 142 to the oracle's 144 instructions. */
        /* MATCH (w50-a4, 4 -> 2, still 144/144): with the VOLATILE store above the read-back is a
         * real `lw`, and gcc expands operand 0 FIRST -- so the READ-BACK must be operand 0 to land
         * in retail's $v0 (and push the `sll numConsumers,4` onto $v1).  The w34-a2 #3 receipt
         * ("shift term FIRST") was measured in the PLAIN-store basin where the read-back was a
         * free cse copy; once the store went volatile the operand order inverted with it and the
         * receipt went stale.  RESIDUAL 2 = the load itself (`lw v0,24(s0)` vs retail's cse copy
         * `addu v0,v1,zero`): the volatile store is what makes the read-back a real memory
         * reference, and every non-volatile route is worse (see the store's note). */
        MI(objbuf, 0x20) = MI(objbuf, 0x18) + numConsumers * 0x10;  /* bufBase */
        MI(objbuf, 0x30) = 0x32;
        MI(objbuf, 0x40) = MI(objbuf, 0x20);
        MI(objbuf, 0x44) = MI(objbuf, 0x20);
        MI(objbuf, 0x48) = MI(objbuf, 0x20);
    }
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
        int one = 1;   /* MATCH (w34-a2 #6): a NAMED invariant is emitted ahead of the `idx = 0`
                        * copy; an anonymous `1` is hoisted by loop.c to the END of the preheader. */
        int idx = 0;
        do {
            int *f = (int *)(MI(objbuf, 0x10) + idx);
            i++;
            f[0] = 0;
            f[1] = 0;
            f[2] = one;
            idx += 0xc;
        } while (i < numFilters);
    }

    /* init the consumer table (back-pointer + 1-based id) */
    i = 0;
    if (numConsumers > 0) {
        do {
            /* MATCH: index off the PRE-increment counter (`i * 0x10`, recomputed each iteration --
             * oracle's `sll a0,a1,4`), not off `(i-1) * 0x10` after the increment, which loop.c
             * strength-reduces into a walking `v1 += 16` plus a +16/-16 fixup pair. */
            int *c = (int *)(MI(objbuf, 0x18) + i * 0x10);
            c[0] = objbuf;
            c[1] = i + 1;                                      /* 1-based consumer id */
            c[2] = 0;
            i++;
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
 * Later raw/oracle trace (2026-07-26) reduced the detailed residual 144->61:
 *   - return validatehandle's actual nonzero status instead of materializing a new literal 1;
 *   - fall through into the in-place free sweep and branch to the drain sweep, matching raw CFG;
 *   - call STREAM_get with its one meaningful argument (the untouched a1/a2 values are incidental);
 *   - reuse escaped out[1] as the consumer stack slot, pre-shift the consumer tag once, and reuse
 *     the same `sr` local for both CP0 critical sections;
 *   - express the drain pass as a guarded do-while, reproducing the oracle's separate initial and
 *     loop-back inbetween tests.
 * w32-a2 (61 -> 14 diffs, INSTRUCTION-COUNT EXACT 173/173).  Four fixes, all read off the IDA
 * per-register annotation of sub_800FD554 + the raw CFG:
 *   - NO trailing `return`.  The oracle falls into the shared epilogue with whatever $v0 holds (the
 *     consumer loop's own `slt` result on the normal exit).  Spelling `return ret;` kept `ret` live
 *     across the whole consumer sweep -> it was promoted to a callee-saved reg ($s7), spilled the
 *     readptr, and grew the frame 0x40 -> 0x48.  `ret` now dies at the `if (ret) return ret;` test.
 *   - the request test-chain is a flat goto ladder (`req==0`/`state==4` -> notactive, `state!=1` ->
 *     active) so the `ret = 1` join sits right after freerequest(), where the oracle has it; the
 *     nested if/else spelling laid that join AFTER both active arms.
 *   - the consumer sweep re-reads out[0] into a `sobj` local ONCE per iteration, at the loop TAIL --
 *     that single load serves this iteration's `ci < numConsumers` test and the NEXT iteration's
 *     consumerArray read (oracle keeps it in $v1 across the back edge).  Reading MI(out[0],..) at
 *     both sites emitted two reloads + two load-delay nops per iteration.  (Same lever as
 *     STREAM_kill; IDA renders it as the `for (...; ...; v8 = v11)` update.)
 *   - the `MI(req,4)=4` store's shared `4` constant must stay live ACROSS the out[0] materialization
 *     (block-local `sobj0` read BEFORE the store) -- otherwise the constant lands in $v1, the reload
 *     cannot be scheduled into its load-delay slot, and a nop appears.
 * w33-a2 (14 -> 2 diffs, still 173/173).  The "readptr <-> hoisted -1 marker $s7/$fp callee-saved
 * pair swap" was a COPY-DIRECTION artifact, not an allocator coin-flip:
 *   - `s7 = readptr; if (req != head) s4 = req->startfill;` (assign-then-conditionally-overwrite)
 *     let gcc coalesce the LOAD's pseudo with `s4` and emit the copy backwards (`lw s4,64(v1);
 *     addu fp,s4,zero`), which pushed the readptr onto $fp and the -1 marker onto $s7.  Writing
 *     the two definitions symmetrically -- `if (req == head) s4 = s7; else s4 = req->startfill;`
 *     -- coalesces the load with `s7` as retail does ($s7 readptr / $fp marker), and the ring
 *     loop's `bne v0,fp` + the `addu a0,s7,zero` call arg fall out with it.  (-10 diffs)
 *   - the consumer slot's COUNT is loaded BEFORE `out[1]` is written, so the `sw v1,20(sp)` is the
 *     last insn ahead of the `blez` and fill_simple_delay_slots' BACKWARD scan moves it into the
 *     slot.  With the store first, the store/load memory order pins it and the slot instead gets
 *     the inbetween() call's `addu a0,s7,zero`.  (-2 diffs)
 * RESIDUAL (2): the ring walk's back-edge polarity (documented at the loop). */
extern int STREAM_cancelrequest(int s, int reqid)
{
    int out[2];
    int ret;
    int valid;
    int req;
    int *s4, *s6, *s7;
    int sr;

    valid = validatehandle(s, &out[0], &out[1]);
    if (valid != 0)
        return valid;

    sr = STREAM_enterCS();
    req = func_800FC4E4(out[0], reqid);
    /* MATCH: the oracle's block order is test-chain -> freerequest -> `ret=1` join -> the ACTIVE
     * block (the nested if/else spelling lays the `ret=1` join AFTER both active arms instead). */
    if (req == 0)
        goto notactive;
    if (MI(req, 4) == 4)
        goto notactive;
    if (MI(req, 4) != 1)
        goto active;
    freerequest(out[0], req);                        /* queued -> just drop it */
notactive:
    ret = 1;
    goto reclaim;
active:                                              /* active (not merely queued) */
    {
        /* MATCH: one out[0] load feeds 0x40/0x4c/0x44 here, and it is materialized BEFORE the
         * `MI(req,4)=4` store so the store's shared `4` constant (reused from the compare above)
         * is still live across it -- that overlap is what keeps the constant OFF $v1 and lets the
         * store fill the load-delay slot of `lw $v1,0x10($sp)` instead of costing a nop. */
        int sobj0 = out[0];
        MI(req, 4) = 4;                             /* mark cancelled (reuses the compare's `4`) */
        s7 = *(int **)(sobj0 + 0x40);               /* readptr */
        if (req == MI(sobj0, 0x4c))
            s4 = s7;
        else
            s4 = *(int **)(req + 0x60);              /* this request's start fill */
        {
            int nx = MI(req, 0xc);
            if (nx == 0 || MI(nx, 4) == 1) {
                s6 = *(int **)(sobj0 + 0x44);        /* writeptr */
                ret = 0;
            } else {
                s6 = *(int **)(nx + 0x60);
                ret = 0;
            }
        }
    }
reclaim:
    STREAM_leaveCS(sr);
    if (ret != 0)
        return ret;

    /* sweep every consumer, returning or freeing the cancelled request's chunks */
    {
        int ci = 0;
        int sobj = out[0];         /* MATCH: ONE out[0] reload per iteration, taken at the loop
                                    * TAIL -- it feeds this iteration's `ci < numConsumers` test AND
                                    * the NEXT iteration's consumerArray read (oracle keeps it in $v1
                                    * across the back edge). Reading MI(out[0],..) at both sites emits
                                    * two reloads + two load-delay nops per iteration. */
        if (MI(sobj, 0x1c) > 0) {
            do {
                int cslot = MI(sobj, 0x18) + ci * 0x10;
                int ccount = MI(cslot, 8);
                /* MATCH: the count is loaded BEFORE the `out[1] = cslot` store, so the store is the
                 * last insn before the `blez` and the delay-slot filler moves it DOWN into the slot
                 * (fill_simple_delay_slots' backward scan).  With the store ahead of the load the
                 * memory ordering pins it and the slot gets the call's `addu a0,s7,zero` instead. */
                out[1] = cslot;
                if (ccount > 0) {
                    unsigned int u2;
                    u2 = inbetween((unsigned int)s7, (unsigned int)s4, MU(out[1], 0xc));
                    if (u2 != 0) {                   /* free this request's own chunks in place */
                        unsigned int rstate = (unsigned int)MI(out[1], 4) << 0x18;
                        int *p = s4;
                        /* RESIDUAL (2): the ring walk's back edge.  Oracle `bne p,s6,<head>;
                         * j <exit>`; ours `beq p,s6,<exit>; j <head>` -- jump.c's
                         * invert-conditional-around-unconditional fires in retail but not here
                         * (our pass threads `goto Lend` straight to the merge label first, which
                         * destroys the "target is the label right after the jump" precondition).
                         * TRIED and all identical-or-worse: guard + do-while (2), `continue` in
                         * the wrap arm (2), empty one-shot boundary after the loop (2), full
                         * label+goto loop (59 -- also de-hoists the -1 marker).
                         * w49-a3 FALSIFIES the jump-threading attribution above: a direct A/B on
                         * the REAL cc1 (cpp'd TU -> CC1PSX -O2 -G4 -g1 -mgpOPT -fgnu-linker,
                         * with and without -fno-thread-jumps, tools/cc1try.py) is BYTE-IDENTICAL
                         * for this whole function -- `beq $16,$22,$L248 ; nop ; j $L252 ; nop`
                         * either way.  thread_jumps is NOT the mechanism, so the per-fn
                         * PER_FN_NO_THREAD_JUMPS splice lane cannot help here; the polarity comes
                         * out of RTL generation / expand_end_loop's rotation, and retail's form
                         * (`bne back ; j exit`) is what a rotated do-while emits.  Count is exact
                         * 173/173, so the remaining lever is the loop's BLOCK LAYOUT, not a flag. */
                        while (p != s6) {
                            if (p[0] == -1) {
                                p = *(int **)(out[0] + 0x20);   /* wrap */
                            } else {
                                unsigned int len = p[1] & 0xffffff;
                                if ((unsigned int)(p[1] & 0xff000000) == rstate) {
                                    sr = STREAM_enterCS();
                                    MI(out[1], 8) -= len;
                                    STREAM_leaveCS(sr);
                                    decbufferusage(out[0], len);
                                    p[0] = -2;
                                    p[1] = len;
                                }
                                p = (int *)((int)p + len);
                            }
                        }
                        /* MATCH (w50-a4, 2 -> PASS 173/173): the back-edge polarity above is a
                         * JUMP-FORWARDING artifact of THIS arm's tail, not of the loop.
                         * gcc rotates the `while` the same way in both builds and emits
                         * `beq p,s6,Lexit ; j Lhead` at the bottom.  jump.c then inverts that pair
                         * into retail's `bne p,s6,Lhead` -- but ONLY when `Lexit:` is the label
                         * immediately after the `j Lhead` (jump.c's "conditional jump around an
                         * unconditional jump" rule).  In retail `Lexit:` is followed by this arm's
                         * own `j <join>` (the jump over the else-arm), so it IS adjacent and the
                         * inversion fires.  Our build forwards the loop-exit edge straight to the
                         * join FIRST -- the `Lexit: j <join>` block disappears, the precondition is
                         * gone, and the un-inverted `beq exit ; j head` survives.
                         * The zero-insn VOID-TAIL FENCE (w48) at the end of the arm re-materializes
                         * that block: an asm_operands insn between `Lexit:` and the `j` stops the
                         * forwarding, the inversion fires, and the arm's `j <join>` is retail's.
                         * Falsified at this basin (all 2 diffs, exact 173/173, 16 spellings across
                         * three waves): for/while/do-while/while(1)+break/!(p==s6)/if-guard+do-while/
                         * `for(p=s4;p!=s6;)`/goto-label loop/`continue` in the wrap arm/an explicit
                         * `goto` past the else arm -- the loop's own spelling is NOT the dial.
                         * A use fence on `s6` here costs 34 (it lengthens s6 past the arm). */
                        __asm__("" : : "i"(0));
                    } else {                         /* consumer head is before this request -> drain it */
                        unsigned int pos = MU(out[1], 0xc);
                        if (inbetween((unsigned int)s4, (unsigned int)s6, pos) != 0) {
                            do {
                                STREAM_release(out[1], STREAM_get(out[1]));
                                if (MI(out[1], 8) < 1)
                                    break;
                                pos = MU(out[1], 0xc);
                            } while (inbetween((unsigned int)s4, (unsigned int)s6, pos) != 0);
                        }
                    }
                }
                ci++;
                sobj = out[0];
            } while (ci < MI(sobj, 0x1c));
        }
    }
    /* MATCH: NO `return` statement here.  The oracle falls straight into the shared epilogue with
     * whatever $v0 happens to hold -- the loop's own `slt $v0,$s3,$v0` result (0 on the normal
     * exit) or the `blez`-tested numConsumers on the no-consumer path.  Spelling an explicit
     * `return ret;`/`return 0;` keeps `ret` live across the whole sweep, which pushes it into a
     * callee-saved register (s7), spills the readptr, and grows the frame 0x40 -> 0x48. */
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
 * w32-a2: 63 -> 0 (PASS, 105 insns).  The "63-diff coloring floor" above was NOT a floor -- it was a
 *   VARIABLE-SHAPE miss, read straight off the IDA per-register annotation of sub_800FD808 (v3/$a1,
 *   v4/$a1, v8/$a0, i/$v1).  Four changes, each reproducing a live-range the oracle actually has:
 *   (a) LOOP-CARRIED out[0] RE-READ.  Both trailing loops keep ONE stack reload of out[0] per iteration,
 *       placed MID-BODY, whose value serves the loop CONDITION of this iteration AND the first field
 *       read of the NEXT one (oracle: `lw v0,24(a1); lw a1,16(sp); ... lw v0,28(a1)`).  Writing the
 *       loop with a local `sobj` that is re-assigned `sobj = out[0]` mid-body reproduces exactly that
 *       (one reload/iteration); reading `MI(out[0],...)` at both sites emits TWO reloads + 2 load-delay
 *       nops per iteration (the whole +7 instruction surplus).  IDA renders it as `v4 = v11;` inside the
 *       loop and `for (...; ...; v8 = v11)` -- that IS the register dataflow, not an artifact.
 *   (b) let loop.c build the i*0x10 giv: index inline with `i * 0x10`, do NOT hand-roll a separate `off`
 *       accumulator (a multiply-set variable blocks strength reduction -- catalog SB "multiply-set SR
 *       blocker"); the oracle's preheader `sll v1,a0,4` (of i==0!) is the giv initializer.
 *   (c) the ring walker is its OWN local (`r`), not a reuse of the first loop's `q` -- retail has two
 *       distinct variables ($a1 and $v1); reusing one forces the q/mask register pair to swap.
 *   (d) mask BEFORE the -2 store (`len = r[1] & 0xffffff; r[0] = -2;`) so loop.c hoists the invariants
 *       in the oracle's order -1 / mask / -2.
 *   (e) `qc = MI(out[0],0x50)` read into its own local BEFORE `sobj = out[0]`: that keeps the queuecur
 *       load's pseudo live across the `sobj` definition, so gcc emits the oracle's `addu a1,v0,zero`
 *       copy instead of loading straight into the loop-carried register (1 insn we were SHORT). */
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
    {
        int qc = MI(out[0], 0x50);
        int sobj = out[0];
        int i;
        MI(qc + 4, 0) = 4;                          /* mark last cancelled */
        i = 0;
        if (MI(sobj, 0x1c) > 0) {                    /* zero all consumer counts */
            do {
                int ca = MI(sobj, 0x18);
                sobj = out[0];
                MI(i * 0x10 + ca + 8, 0) = 0;
                i++;
            } while (i < MI(sobj, 0x1c));
        }
    }
    decbufferusage(out[0], MI(out[0], 0x3c));        /* zero the buffer usage */

    {
        int sobj = out[0];
        int *r = *(int **)(sobj + 0x40);              /* free-mark the whole ring */
        if (r != *(int **)(sobj + 0x44)) {
            do {
                if (r[0] == -1) {
                    r = *(int **)(sobj + 0x20);
                } else {
                    unsigned int len = r[1] & 0xffffff;
                    r[0] = -2;
                    r[1] = len;
                    r = (int *)((int)r + len);
                }
                sobj = out[0];
            } while (r != *(int **)(sobj + 0x44));
        }
        if (MI(sobj, 0x28) == 2)
            MI(sobj, 0x28) = 0;                      /* clear the stall */
    }
}

/* STREAM_get @0x800FD9AC : pop the next available chunk for a consumer, returning a pointer to its data
 *   ARITY (w32-a10 prototype audit, R3): ONE arg.  All four call sites (STREAM_cancelrequest,
 *   iSNDstreamhotroddatachunks, iSNDstreamservice, sst.c x2) set up $a0 only -- the a1/a2 the callee
 *   passes to validatehandle() are its OWN &out[0]/&out[1], materialized inside.  eaclib.h and
 *   video_externs.h already declared the 1-arg form; the 3-arg decl here was a stale-register artifact
 *   patched over with `(void)buf;(void)len;` + a 1-arg fn-ptr cast at the call site -- all removed.
 *   Diff-neutral (37 before and after), no neighbour regressions.
 *   (or 0 if none).  Advances the consumer's read cursor to the following same-tagged chunk.
 * w33-a2: 37 -> 0 (PASS, 73 insns).  The "allocator tie-break, accept" verdict was WRONG -- the whole
 *   cons=$a2-vs-$a1 cascade was a SCHEDULING consequence of one statement, not a coloring coin-flip:
 *   TAG-HOIST.  The consumer tag must be computed as its own statement BEFORE the cursor pointer:
 *       unsigned int tag = MI(cons,4) << 24;
 *       p = (int *)(chunk + hdr);
 *       while ((p[1] & 0xff000000) != tag) { ... }
 *   Written that way the oracle's order falls out exactly -- `lw v0,4(a1)` (cons->id) is issued while
 *   `cons` is still live, `addu a1,a3,a0` then REUSES that register for `p` (which is why retail's
 *   `cons` is $a1: it is the same pseudo, not a different colour), and `sll a2,v0,24` fills the load
 *   delay slot.  Leaving `MI(cons,4)<<24` inside the loop condition evaluated `p[1]` first, forced a
 *   separate register for `cons` across the whole function, and swapped the tag/mask register pair.
 *   Second (smaller) part: mask into the SAME `hdr` variable inside the walk (`hdr = p[1]&0xffffff;
 *   p = (int*)((int)p+hdr);`) so the mask result reuses the `hdr` pseudo ($a0) as retail does.
 *   NOTE the epilogue's apparent extra insn (`addu v0,a3,zero` in the `blez` delay slot) is NOT a
 *   second `return chunk` -- it is gcc's delayed-branch TARGET-STEAL of the shared return
 *   materialization; spelling an explicit early `return chunk;` instead flips the branch to
 *   `bgtz`+`j` (+2).  Keep the single trailing `return chunk;`. */
extern int STREAM_get(int consumer)
{
    int out[2];
    int cons, chunk;
    unsigned int hdr;
    int *p;

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
            /* MATCH (TAG-HOIST): the consumer tag is computed BEFORE the cursor pointer, so the
             * oracle's `lw v0,4(a1)` (cons->id) is issued while `cons` is still in its register,
             * `addu a1,a3,a0` reuses that register for `p`, and the `sll a2,v0,24` fills the
             * load-delay slot.  Evaluating the tag inside the loop condition instead put the
             * p[1] load first and swapped the tag/mask register pair. */
            unsigned int tag = (unsigned int)(MI(cons, 4) << 0x18);
            p = (int *)(chunk + hdr);
            while ((p[1] & 0xff000000) != tag) {    /* advance cursor to next same-tagged chunk */
                if (p[0] == -1) {
                    p = *(int **)(out[0] + 0x20);    /* wrap */
                } else {
                    hdr = p[1] & 0xffffff;           /* MATCH: reuses the `hdr` pseudo ($a0) */
                    p = (int *)((int)p + hdr);
                }
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

/* eaclib/psx/eacpsxz/nasync.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\nasync.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   23 fns @[0x800F0B1C .. 0x800F16D8].  EA async file loader built ON TOP of the nfile FILE_* API.
 *   FULL reconstruction (disasm-v3 MIPS); NOT stubs.  Uses lib/nasync.h (struct-first).
 *
 *   A load reserves an AsyncReq from `freequeue`, stamps it with a fresh id (slot index | requestidcounter)
 *   and drives it through the FILE state machine via completion callbacks:
 *       FILE_open -> loadfileopencallback
 *                      |-- buffer==0 -> FILE_read  -> loadfilereadcallback (chunked) -> FILE_close
 *                      |-- buffer==1 -> FILE_size  -> loadfilesizecallback (alloc)  -> FILE_read ...
 *                                                       -> loadfilereadcallback (chunked) -> FILE_close
 *                                                          -> loadfileclosecallback -> finish/cancelrequest
 *   Segment loads (setasyncfile + asyncloadsegment) read a range from a persistent `asyncfilehandle`
 *   through loadsegreadcallback.  Finished requests with a user callback go on `callqueue`, drained by
 *   asyncsystemtask(); poll-only loads are harvested by getasyncreadadr/getasyncreadstatus.
 *
 *   Op-id encoding mirrors nfile; the request id low byte is the slot index (used by locaterequest).
 *   Queue/slot edits run in a cop0 IRQ-disabled critical section (host no-op via lib/nasync.h).
 *   (-m32-only verified: req stride 0x2C + pointer-sized queue links diverge from the LLP64 host layout.)
 */
#include "../../../lib/nasync.h"
typedef unsigned int size_t;   /* was <stddef.h>; C TU is self-contained */

/* nasync's cop0 IRQ-disabled critical section: nasync.h declares ASYNC_enterCS/leaveCS as real
 * void->void functions, but the oracle INLINES the exact raw cop0 mfc0/mask/mtc0 sequence at every
 * call site (mask -0x402 clears SR bits 0x400+0x2, same constant nfile.c's FILE_CS_ENTER/LEAVE use) --
 * confirmed byte-identical across queueadd/queuefetch/cancelrequest oracles. A real `jal` to a
 * ASYNC_enterCS/leaveCS function can't express that; bypass the header decls with a local macro pair
 * threading the saved SR through a real C local (same technique as nfile.c). */
#undef ASYNC_enterCS
#undef ASYNC_leaveCS
#if defined(__mips__)
#define ASYNC_enterCS(saved) \
    __asm__ volatile("mfc0 %0,$12\n\t nop\n\t addiu $at,$zero,-0x402\n\t and $8,%0,$at\n\t mtc0 $8,$12\n\t nop\n\t nop\n\t nop" \
                      : "=r"(saved) : : "at", "t0")
#define ASYNC_leaveCS(saved) __asm__ volatile("mtc0 %0,$12" : : "r"(saved))
#else
#define ASYNC_enterCS(saved) ((void)(saved = 0))
#define ASYNC_leaveCS(saved) ((void)(saved))
#endif

/* ---- nfile FILE_* API (eacpsxz) + memory/system helpers this loader drives ---- */
extern unsigned int FILE_open(char *name, unsigned int a1, unsigned int a2, unsigned int a3); /* @0x800EC36C */
extern unsigned int FILE_close(void *handle, unsigned int a1, unsigned int a2);               /* @0x800EC42C */
extern unsigned int FILE_read(void *handle, unsigned int offset, unsigned int dest,
                                  int len, unsigned int a5, unsigned int a6);                      /* @0x800EC4EC */
extern unsigned int FILE_size(void *handle, unsigned int a1, unsigned int a2);                /* @0x800EC5D0 */
extern int  FILE_completeop(unsigned int id);                                                 /* @0x800EC2B0 */
extern void FILE_callbackop(unsigned int id, void (*cb)(int, int));                           /* @0x800EBE4C */
extern void FILE_cancelop(unsigned int id);                                                   /* @0x800EC008 */
extern int  FILE_opensync(char *name, int mode, int prio, int *outHandle);                    /* @0x800EA8A8 */
extern int  FILE_closesync(int handle, int prio);                                             /* @0x800EA950 */
extern void *reservememadr(char *name, int size, int classid);                                /* @0x800E533C */
extern void  purgememadr(void *p);                                                            /* @0x800E5540 */
extern int   addsystemtask(int (*fn)(void), int a1, int a2);                                  /* @0x800E6AF4 */
extern void *allocmutex(void);                                                                /* @0x800FE424 */

/* forward decls for the FILE completion callbacks (referenced by FILE_callbackop and each other) */
extern int loadfileclosecallback(int id, int status, AsyncReq *req);
extern void loadfilereadcallback(int id, int status, AsyncReq *req);
extern int loadfilesizecallback (int id, int status, AsyncReq *req);
extern int loadfileopencallback (int id, int status, AsyncReq *req);
extern int loadsegreadcallback  (int id, int status, AsyncReq *req);
extern int asyncsystemtask(void);

#define RQ(r)  ((unsigned int)(size_t)(AsyncReq *)(r))   /* req ptr as a FILE callback param (uint) */

/* ---- request queue + slot primitives ---- */

/* queueadd @0x800F0B1C : append `n` to FIFO `q` ({head,tail}). */
extern void queueadd(AsyncQueue *q, AsyncReq *n)
{
    int sr;
    ASYNC_enterCS(sr);
    if (q->head == 0) q->head = n;          /* empty -> head = n */
    else              q->tail->next = n;    /* else link onto the tail */
    q->tail = n;
    n->next = 0;
    ASYNC_leaveCS(sr);
}

/* queuefetch @0x800F0B74 : pop the head of FIFO `q` (returns 0 if empty). */
extern AsyncReq *queuefetch(AsyncQueue *q)
{
    /* MATCH (was a documented v0-vs-v1 "floor" -- cracked): oracle loads head into $v0 for the
     * test, defaults the return value $v1=0 in the beqz's OWN delay slot (dead-code-motion of
     * the zero-init down to its latest legal point), and only INSIDE the taken branch copies
     * v0->v1 before dereferencing ->next THROUGH v1 (not v0). Reproduce with a SEPARATE `head`
     * pointer for the queue-head load/test, `r=0` initialized as its OWN statement placed right
     * AFTER the head load (not with the other decls up top -- that hoists the zero-init before
     * the critical section instead of into the branch slot), and `r=head;` + `r->next` (not
     * `head->next`) inside the if-body so the dereference goes through the copy. */
    AsyncReq *head;
    AsyncReq *r;
    int sr;
    ASYNC_enterCS(sr);
    head = q->head;                         /* 0 if empty */
    r = 0;
    if (head != 0) {
        r = head;
        q->head = r->next;
    }
    ASYNC_leaveCS(sr);
    return r;
}

/* newrequestid @0x800F0BC0 : stamp `r` with a fresh id = (slot index) | rolling counter; return it. */
extern int newrequestid(AsyncReq *r)
{
    requestidcounter += 0x100;
    if (requestidcounter == 0)              /* never 0 */
        requestidcounter = 0x100;
    r->id = (int)((unsigned char)r->id) | requestidcounter;
    return r->id;
}

/* locaterequest @0x800F0BF4 : id -> its live AsyncReq, or 0 if the id is invalid/stale.
 *   slot = id & 0xFF; valid only if id >= 0x100, slot < numrequests and request[slot].id == id. */
static AsyncReq *locaterequest(int id)
{
    /* MATCH: oracle uses SIGNED compares throughout (`slti`/`slt`, not `sltiu`/`sltu`) and
     * computes `slot = id & 0xFF` UNCONDITIONALLY (it's the first branch's delay slot, so it
     * always executes before the id<0x100 test's result is even known) -- both id and
     * numrequests fit comfortably in the signed range so the unsigned casts were behavior-
     * neutral but wrong codegen; and slot must be materialized before the first return. */
    int slot = id & 0xFF;
    AsyncReq *r;
    if (id < 0x100)
        return 0;
    if (slot < numrequests) {               /* MATCH: positive-branch form (lever #7) --
                                              * continue is a jump TARGET, not a fallthrough */
        r = (AsyncReq *)((char *)request + slot * 0x2C);
        if (r->id != id)                    /* slot recycled -> stale */
            return 0;
        return r;
    }
    return 0;
}

/* cancelrequest @0x800F0C50 : if pending, mark cancelled, free its buffer, return the slot to freequeue. */
extern void cancelrequest(AsyncReq *r)
{
    /* MATCH: keep the RAW status value cached (not pre-folded into a 0/1 bool) -- the oracle
     * loads r->status ONCE and re-compares it against the literal 1 TWICE (bne v1,a1 both
     * times); a `wasPending = (status==1)` bool forces a materialized xori/sltiu 0/1 value
     * (extra 2 insns) that ours reused for both tests instead. */
    int status;
    int sr;
    ASYNC_enterCS(sr);
    status = r->status;
    if (status == 1) r->status = 2;
    ASYNC_leaveCS(sr);
    if (status != 1)
        return;
    if ((unsigned int)r->buffer >= 2)       /* real buffer (0/1 are "none"/sentinel) -> free it; asm: sltiu (unsigned) */
        purgememadr((void *)(size_t)(unsigned int)r->buffer);
    r->id = (unsigned char)r->id;           /* clear the counter bits -> slot is free (asm: lbu scheduled
                                              * early, but the sw itself lands in queueadd's jal delay slot) */
    r->fileop = 0;
    queueadd((AsyncQueue *)&freequeuehead, r);
}

/* finishrequest @0x800F0CE8 : queue `r` for its user callback (only if it has one). */
extern void finishrequest(AsyncReq *r)
{
    int cb = r->callback;
    r->fileop = 0;                          /* unconditional (oracle: in the beqz delay slot) */
    if (cb == 0)                            /* poll-only request -> nothing to do */
        return;
    queueadd((AsyncQueue *)&callqueuehead, r);
}

/* ---- the FILE completion callbacks (open -> size -> read* -> close -> finish) ---- */

/* loadfileclosecallback @0x800F0D24 : harvest the close op, then finish or cancel the request. */
extern int loadfileclosecallback(int id, int status, AsyncReq *req)
{
    /* MATCH: a FRESH pointer pseudo (`req2`) is materialized unconditionally right after entry
     * (oracle: `addu s1,s0,zero` in the FILE_completeop jal's delay slot) and used ONLY by the
     * finishrequest branch; the cancelrequest branch keeps using the original `req` (s0)
     * directly. Same family as synccallback's s1/s2 split, but here scoped to ONE branch only. */
    AsyncReq *req2 = req;
    (void)id; (void)status;
    FILE_completeop(req->fileop);
    if (req->status != 0) cancelrequest(req);    /* cancelled mid-flight -> cleanup */
    else                  finishrequest(req2);   /* done -> hand back to the user */
    /* MATCH: no `return 0` -- oracle falls straight off both (void) calls into the epilogue,
     * $v0 left incidental/unused (same value-less-fall-off idiom as initasync). */
}

/* loadfilereadcallback @0x800F0D80 : one chunk read; loop until EOF/cancel, then close. */
extern void loadfilereadcallback(int id, int status, AsyncReq *req)
{
    int n = FILE_completeop(req->fileop);       /* bytes read this chunk */
    unsigned int nextop;
    (void)id; (void)status;
    req->bytesread += n;
    if (n < readblocksize || req->status != 0) {            /* short read (EOF) or cancel -> close */
        nextop = FILE_close((void *)(size_t)(unsigned int)req->handle, 0x63, RQ(req));
        req->fileop = (int)nextop;             /* §3.21: stored in the beqz delay slot (even if 0) */
        if (nextop == 0) return;
        FILE_callbackop(nextop, (void (*)(int, int))loadfileclosecallback);
    } else {                                                 /* full chunk -> read the next one */
        req->offset += n;
        req->dest   += n;
        nextop = FILE_read((void *)(size_t)(unsigned int)req->handle,
                           (unsigned int)req->offset, (unsigned int)req->dest,
                           readblocksize, 0x63, RQ(req));
        req->fileop = (int)nextop;             /* §3.21: stored in the beqz delay slot (even if 0) */
        if (nextop == 0) return;
        FILE_callbackop(nextop, (void (*)(int, int))loadfilereadcallback);
    }
    /* MATCH: callback return is unused; the value-less fall-through preserves FILE_callbackop's v0. */
}

/* loadfilesizecallback @0x800F0E54 : got the size -> allocate the buffer and start reading. */
extern int loadfilesizecallback(int id, int status, AsyncReq *req)
{
    /* MATCH (21->0): a FRESH pointer pseudo (`req2`) is materialized unconditionally right after entry
     * (oracle: `addu s0,s1,zero` in the FILE_completeop jal's delay slot) and used ONLY by the
     * allocate/read (else) branch; the cancelled/close branch keeps using the original `req`
     * (s1) directly.  Storing each new fileop before its zero test makes the stores unconditional
     * delay-slot work, and positive callback guards tail-merge into the oracle's shared call block. */
    AsyncReq *req2 = req;
    int filesize = FILE_completeop(req->fileop);
    unsigned int nextop;
    (void)id; (void)status;
    if (req->status != 0) {                                  /* cancelled -> close */
        nextop = FILE_close((void *)(size_t)(unsigned int)req->handle, 0x63, RQ(req));
        req->fileop = (int)nextop;
        if (nextop != 0)
            FILE_callbackop(nextop, (void (*)(int, int))loadfileclosecallback);
    } else {                                                 /* allocate "ASYNCBUF" of the file size */
        void *buf = reservememadr((char *)"ASYNCBUF", filesize, req2->arg24);
        req2->buffer = (int)(size_t)buf;
        req2->dest   = (int)(size_t)buf;
        nextop = FILE_read((void *)(size_t)(unsigned int)req2->handle,
                           (unsigned int)req2->offset, (unsigned int)req2->dest,
                           readblocksize, 0x63, RQ(req2));
        req2->fileop = (int)nextop;
        if (nextop != 0)
            FILE_callbackop(nextop, (void (*)(int, int))loadfilereadcallback);
    }
    return;
}

/* loadfileopencallback @0x800F0F18 : open done -> read directly, size-then-read, or close on cancel. */
extern int loadfileopencallback(int id, int status, AsyncReq *req)
{
    /* 🔴 RESIDUAL FLOOR (31 diffs, unchanged from before this wave): oracle materializes a
     * second req-copy (s1=s0) in the FILE_completeop jal's delay slot for the FILE_size branch
     * only; reproducing it as an explicit `req2` local coalesced badly (s1 got merged with the
     * incoming `status` param instead), and removing the "value-less" returns didn't help
     * either -- tried both independently and combined, no net improvement. Accept for now. */
    int handle = FILE_completeop(req->fileop);
    unsigned int nextop;
    (void)id;
    req->handle = handle;                          /* asm: stored on both paths (delay slot) */
    if (handle == 0) {                             /* open failed */
        if (req->status != 0) cancelrequest(req);
        else                  finishrequest(req);
        return 0;
    }
    if (req->status != 0) {                        /* cancelled during open -> close */
        nextop = FILE_close((void *)(size_t)(unsigned int)handle, 0x63, RQ(req));
        if (nextop == 0) return 0;
        req->fileop = (int)nextop;
        FILE_callbackop(nextop, (void (*)(int, int))loadfileclosecallback);
    } else if (req->buffer != 0) {                 /* alloc mode -> get the size first */
        nextop = FILE_size((void *)(size_t)(unsigned int)handle, (unsigned int)status, RQ(req));
        if (nextop == 0) return 0;
        req->fileop = (int)nextop;
        FILE_callbackop(nextop, (void (*)(int, int))loadfilesizecallback);
    } else {                                        /* direct read into the preset dest */
        nextop = FILE_read((void *)(size_t)(unsigned int)handle,
                           (unsigned int)req->offset, (unsigned int)req->dest,
                           readblocksize, 0x63, RQ(req));
        if (nextop == 0) return 0;
        req->fileop = (int)nextop;
        FILE_callbackop(nextop, (void (*)(int, int))loadfilereadcallback);
    }
    return 0;
}

/* loadsegreadcallback @0x800F1024 : segment read from asyncfilehandle, chunked with a clamped tail. */
extern int loadsegreadcallback(int id, int status, AsyncReq *req)
{
    /* MATCH: a FRESH pointer pseudo (`req2`) is materialized unconditionally right after entry
     * (oracle: `addu s1,s0,zero` in the FILE_completeop jal's delay slot), used ONLY by the
     * final FILE_read call's offset/dest reloads and its RQ() arg; every other access keeps
     * using the original `req` (s0). Same family as loadfilesizecallback's req2 split. */
    AsyncReq *req2 = req;
    int n = FILE_completeop(req->fileop);
    int remaining, len;
    unsigned int nextop;
    (void)id; (void)status;
    req->bytesread += n;
    req->offset    += n;
    asyncfileoffset = req->offset;
    /* MATCH: the cancelrequest/finishrequest exits are value-less fall-offs (goto the shared
     * end with no explicit return -- $v0 left incidental, oracle's delay slot after each jal is
     * a bare nop not a fresh `li v0,0`); the FILE_read fileop store is unconditional (§3.21,
     * schedules into the beqz's delay slot even on the nextop==0/failure path). */
    if (req->status != 0) { cancelrequest(req); goto done; }     /* cancelled */
    if (n < readblocksize) { finishrequest(req); goto done; }    /* short read -> done */
    req->arg24 -= n;                                            /* remaining bytes */
    req->dest  += n;
    remaining = req->arg24;
    len = (readblocksize < remaining) ? readblocksize : remaining;   /* clamp to a block */
    nextop = FILE_read((void *)(size_t)(unsigned int)asyncfilehandle,
                       (unsigned int)req2->offset, (unsigned int)req2->dest, len, 0x63, RQ(req2));
    req2->fileop = (int)nextop;
    if (nextop != 0) {
        FILE_callbackop(nextop, (void (*)(int, int))loadsegreadcallback);
    }
done:
    ;
}

/* asyncsystemtask @0x800F1120 : drain callqueue -- fire each finished request's user callback (or clean
 *   up a cancelled one), then recycle the slot.  Registered as a periodic system task by initasync. */
extern int asyncsystemtask(void)
{
    AsyncReq *req = queuefetch((AsyncQueue *)&callqueuehead);
    while (req != 0) {
        if (req->status != 0) {                    /* cancelled -> full cleanup */
            cancelrequest(req);
        } else {                                   /* normal completion -> fire the callback */
            void (*cb)(int) = (void (*)(int))(size_t)(unsigned int)req->callback;
            cb(req->id);
            req->id = (unsigned char)req->id;      /* free the slot (MATCH: store BEFORE the call -> sw
                                                    * lands in the queueadd jal delay slot, §3.21 family) */
            queueadd((AsyncQueue *)&freequeuehead, req);
        }
        req = queuefetch((AsyncQueue *)&callqueuehead);
    }
    return 0;
}

/* initasync @0x800F11B0 : allocate the request pool (<=0x100 slots), build the free list, create the
 *   mutex, and register asyncsystemtask.  No-op if already initialised or numreq out of range. */
extern int initasync(int numreq, int blocksize, int memclass)
{
    if (request == 0 && numreq < 0x101) {
        int size;                                          /* numreq*0x2C, then mutated in place (-0x2C) */
        int i;
        readblocksize = blocksize;
        numrequests   = numreq;
        size = numreq * 0x2C;
        request = (AsyncReq *)reservememadr((char *)"ASYNCREQ", size, memclass);
        size -= 0x2C;                                      /* MATCH: oracle mutates s0 in place (§3.12#14) */
        freequeuehead = request;
        freequeuetail = (AsyncReq *)((char *)request + size);   /* &request[numreq-1] */
        callqueuehead = 0;
        callqueuetail = 0;
        asyncfilehandle = 0;
        mutex = allocmutex();
        for (i = 0; i < numreq; i++) {                     /* link every slot onto the free list */
            request[i].id     = i;                         /* id low byte == slot index */
            request[i].next   = &request[i + 1];           /* MATCH: index form -> base+off giv (§3.12#1) */
            request[i].fileop = 0;
        }
        request[numreq - 1].next = 0;                      /* terminate the free list */
        addsystemtask(asyncsystemtask, 1, 1);
    }
    /* MATCH: no `return 0` — oracle leaves $v0 = addsystemtask's return (int decl, value-less fall-off) */
}

/* ---- public load entry points ---- */

/* asyncloadfilecallback @0x800F12B0 : begin an async load that allocates its own buffer (poll via
 *   getasyncreadadr, or `cb` fires on completion).  Returns the request id (0 if no free slot/open fail). */
extern int asyncloadfilecallback(int name, int memclass, int cb)
{
    AsyncReq *req = queuefetch((AsyncQueue *)&freequeuehead);
    unsigned int op;
    if (req == 0)
        return 0;
    newrequestid(req);
    req->bytesread = 0;
    req->status    = 0;
    req->buffer    = 1;                 /* "allocate by size" sentinel */
    req->callback  = cb;
    req->offset    = 0;
    req->arg24     = memclass;         /* §3.21: goes in FILE_open jal delay slot (sw s3,0x24) */
    op = FILE_open((char *)(size_t)(unsigned int)name, 1, 0x64, RQ(req));
    req->fileop = (int)op;             /* §3.21: goes in beqz delay slot (stored even if op==0) */
    if (op == 0)
        return 0;
    FILE_callbackop(op, (void (*)(int, int))loadfileopencallback);
    return req->id;
}

/* asyncloadfile @0x800F1368 : as above, no completion callback (poll-only). */
extern int asyncloadfile(int name, int memclass)
{
    return asyncloadfilecallback(name, memclass, 0);
}

/* asyncloadfileatcallback @0x800F1388 : async load into a caller-provided destination (no allocation). */
extern int asyncloadfileatcallback(int name, int dest, int cb)
{
    AsyncReq *req = queuefetch((AsyncQueue *)&freequeuehead);
    unsigned int op;
    if (req == 0)
        return 0;
    newrequestid(req);
    req->bytesread = 0;
    req->status    = 0;
    req->buffer    = 0;                 /* direct read (no alloc) */
    req->callback  = cb;
    req->offset    = 0;
    req->dest      = dest;             /* §3.21: goes in FILE_open jal delay slot (sw s3,0x28) */
    op = FILE_open((char *)(size_t)(unsigned int)name, 1, 0x64, RQ(req));
    req->fileop = (int)op;             /* §3.21: goes in beqz delay slot (stored even if op==0) */
    if (op == 0)
        return 0;
    FILE_callbackop(op, (void (*)(int, int))loadfileopencallback);
    return req->id;
}

/* asyncloadfileat @0x800F143C : as above, poll-only. */
extern int asyncloadfileat(int name, int dest)
{
    return asyncloadfileatcallback(name, dest, 0);
}

/* setasyncfile @0x800F145C : (re)open the persistent file used by segment loads; 0 closes it. */
extern void setasyncfile(int name)
{
    if (asyncfilehandle != 0)
        FILE_closesync(asyncfilehandle, 0x64);
    if (name == 0) {
        asyncfilehandle = 0;
        return;
    }
    FILE_opensync((char *)(size_t)(unsigned int)name, 1, 0x64, &asyncfilehandle);
    asyncfileoffset = 0;
}

/* asyncloadsegmentcallback @0x800F14BC : read a [offset, offset+size) range of the persistent async file
 *   into `dest`.  If no file is open the request finishes immediately. */
extern int asyncloadsegmentcallback(int offset, int dest, int size, int cb)
{
    AsyncReq *req = queuefetch((AsyncQueue *)&freequeuehead);
    unsigned int op;
    if (req == 0)
        return 0;
    newrequestid(req);
    req->bytesread = 0;
    req->status    = 0;
    req->buffer    = 0;
    /* MATCH: oracle store order is callback,offset,arg24(size),dest(delay) -- NOT struct-field
     * order -- reproduce the literal statement order to match the codegen. */
    req->callback  = cb;
    req->offset    = offset;
    req->arg24     = size;             /* remaining bytes */
    req->dest      = dest;             /* asm: delay slot */
    if (asyncfilehandle == 0) {        /* no file open -> finish now */
        finishrequest(req);
        return req->id;
    }
    /* MATCH: clamp `size` IN PLACE (§3.12 #14) instead of a fresh named `len` temp -- oracle
     * mutates the size pseudo directly and reuses it as the FILE_read arg. */
    if (readblocksize < size)
        size = readblocksize;
    op = FILE_read((void *)(size_t)(unsigned int)asyncfilehandle,
                   (unsigned int)req->offset, (unsigned int)req->dest, size, 0x64, RQ(req));
    req->fileop = (int)op;            /* asm: set on both branches */
    if (op != 0) {                    /* MATCH: positive-branch form (lever #7) */
        FILE_callbackop(op, (void (*)(int, int))loadsegreadcallback);
        return req->id;
    }
    return 0;
}

/* asyncloadsegment @0x800F15B0 : as above, poll-only. */
extern int asyncloadsegment(int offset, int dest, int size)
{
    return asyncloadsegmentcallback(offset, dest, size, 0);
}

/* cancelasyncload @0x800F15D0 : request cancellation of a load; cancels the FILE op and, if nothing is
 *   in flight and there is no callback pending, releases the request immediately. */
extern int cancelasyncload(int id)
{
    /* MATCH (oracle-verified, corrects an earlier "always return 0" wrong guess): only the
     * req==0 and status!=0 exits return a deliberate constant (0 -- already 0 for free, since
     * v0==req there -- and the literal 1); the fileop!=0 and callback!=0 exits instead leave
     * whatever was just loaded into $v0 (the fileop id / callback pointer) as an incidental
     * return value, and the final cancelrequest() fall-off leaves $v0 = cancelrequest's own
     * (garbage, since it's void) incidental value -- no explicit return at all. */
    AsyncReq *req = locaterequest(id);
    if (req != 0) {
        if (req->status != 0)          /* already cancelling/cancelled */
            return 1;
        req->status = 1;               /* schedules into FILE_cancelop's delay slot */
        FILE_cancelop(req->fileop);
        if (req->fileop == 0) {        /* no in-flight FILE op */
            if (req->callback == 0)
                cancelrequest(req);
        }
    }
}

/* getasyncreadadr @0x800F1640 : the loaded buffer address, or 0 if not ready.  For a poll-only request
 *   (no callback) this also recycles the slot, so call it once the load is done. */
extern int getasyncreadadr(int id)
{
    AsyncReq *req = locaterequest(id);
    int adr;
    if (req == 0)        return 0;
    if (req->status != 0) return 0;    /* cancelled */
    if (req->fileop != 0) return 0;    /* still loading */
    adr = req->buffer;
    if (adr == 1) adr = 0;             /* alloc sentinel, not a real address */
    if (req->buffer == 0) return adr;  /* MATCH: reuses the just-computed $s0 (adr==0 here already
                                         * since adr was set from buffer, which is 0) instead of a
                                         * fresh literal-0 materialization -- oracle: addu v0,s0,zero */
    if (req->callback != 0)            /* a callback owns the lifecycle */
        return adr;
    /* MATCH: id-clear BEFORE the call (§3.21 -- the store schedules into queueadd's jal delay
     * slot); `req` is never needed again after, so it stays in a caller-saved reg the whole
     * function (never promoted to callee-saved) -- only `adr` (the return value) survives the
     * call and needs an s-register. */
    req->id = (unsigned char)req->id;
    queueadd((AsyncQueue *)&freequeuehead, req);         /* poll-only -> recycle the slot now */
    return adr;
}

/* getasyncreadstatus @0x800F16D8 : -2 invalid id OR cancelling/cancelled, 0 while a read is still
 *   in flight, -1 not started, else the bytes read.  Recycles the slot when fully done with no
 *   buffer/callback.  MATCH (oracle-verified, corrects an earlier wrong-guess doc comment): the
 *   status!=0 and fileop!=0 exits return the LITERAL constants -2/0, not the field's own value --
 *   confirmed by the oracle explicitly re-materializing `li v0,-2` / `addu v0,zero,zero` in each
 *   branch's delay slot (a "return the field" shape would leave the just-loaded v0 untouched, a
 *   bare nop, which is what an incorrect recon here compiles to). */
extern int getasyncreadstatus(int id)
{
    AsyncReq *req = locaterequest(id);
    int st;
    if (req == 0)        return -2;
    if (req->status != 0) return -2;                   /* cancelling/cancelled -> reported as invalid */
    if (req->fileop != 0) return 0;                     /* still loading */
    st = (req->bytesread != 0) ? req->bytesread : -1;
    if (req->buffer != 0)   return st;
    if (req->callback != 0) return st;
    req->id = (unsigned char)req->id;    /* MATCH: id-clear BEFORE the call, see getasyncreadadr */
    queueadd((AsyncQueue *)&freequeuehead, req);                         /* harvested -> recycle the slot */
    return st;
}

 AsyncReq *freequeuehead; AsyncReq *freequeuetail;   /* @0x8013DEA0/A4 : freequeue {head,tail} as 4B words -> .comm/.sbss -> gp-rel (see nasync.h) */
 AsyncReq *callqueuehead; AsyncReq *callqueuetail;   /* @0x8013DEA8/AC : callqueue {head,tail} likewise */
 AsyncReq *request;   /* @0x8013DE98 : request slot pool base; 4B -> .comm/.sbss -> gp-rel */
 int asyncfileoffset; int numrequests; int readblocksize;   /* owning-TU defs (BSS) */
 void *mutex;    /* nasync.obj async-pool mutex handle (= allocmutex() result); BSS */
 int asyncfilehandle;    /* @0x8013DEB0 : open file handle for segment reads; 4B → .comm/.sbss → gp-rel */
 int requestidcounter;    /* @0x8013DEB8 : request-ID counter; 4B → .comm/.sbss → gp-rel */

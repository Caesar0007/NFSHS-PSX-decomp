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
extern int loadfilereadcallback (int id, int status, AsyncReq *req);
extern int loadfilesizecallback (int id, int status, AsyncReq *req);
extern int loadfileopencallback (int id, int status, AsyncReq *req);
extern int loadsegreadcallback  (int id, int status, AsyncReq *req);
extern int asyncsystemtask(void);

#define RQ(r)  ((unsigned int)(size_t)(AsyncReq *)(r))   /* req ptr as a FILE callback param (uint) */

/* ---- request queue + slot primitives ---- */

/* queueadd @0x800F0B1C : append `n` to FIFO `q` ({head,tail}). */
extern void queueadd(AsyncQueue *q, AsyncReq *n)
{
    ASYNC_enterCS();
    if (q->head == 0) q->head = n;          /* empty -> head = n */
    else              q->tail->next = n;    /* else link onto the tail */
    q->tail = n;
    n->next = 0;
    ASYNC_leaveCS();
}

/* queuefetch @0x800F0B74 : pop the head of FIFO `q` (returns 0 if empty). */
extern AsyncReq *queuefetch(AsyncQueue *q)
{
    AsyncReq *r;
    ASYNC_enterCS();
    r = q->head;                            /* 0 if empty */
    if (r != 0) q->head = r->next;
    ASYNC_leaveCS();
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
    int slot;
    AsyncReq *r;
    if ((unsigned int)id < 0x100)
        return 0;
    slot = id & 0xFF;
    if ((unsigned int)slot >= (unsigned int)numrequests)
        return 0;
    r = (AsyncReq *)((char *)request + slot * 0x2C);
    if (r->id != id)                        /* slot recycled -> stale */
        return 0;
    return r;
}

/* cancelrequest @0x800F0C50 : if pending, mark cancelled, free its buffer, return the slot to freequeue. */
extern void cancelrequest(AsyncReq *r)
{
    int wasPending;
    ASYNC_enterCS();
    wasPending = (r->status == 1);
    if (wasPending) r->status = 2;
    ASYNC_leaveCS();
    if (!wasPending)
        return;
    if (r->buffer >= 2)                     /* real buffer (0/1 are "none"/sentinel) -> free it */
        purgememadr((void *)(size_t)(unsigned int)r->buffer);
    r->fileop = 0;
    queueadd(&freequeue, r);
    r->id = (unsigned char)r->id;           /* clear the counter bits -> slot is free */
}

/* finishrequest @0x800F0CE8 : queue `r` for its user callback (only if it has one). */
extern void finishrequest(AsyncReq *r)
{
    int cb = r->callback;
    r->fileop = 0;                          /* unconditional (oracle: in the beqz delay slot) */
    if (cb == 0)                            /* poll-only request -> nothing to do */
        return;
    queueadd(&callqueue, r);
}

/* ---- the FILE completion callbacks (open -> size -> read* -> close -> finish) ---- */

/* loadfileclosecallback @0x800F0D24 : harvest the close op, then finish or cancel the request. */
extern int loadfileclosecallback(int id, int status, AsyncReq *req)
{
    (void)id; (void)status;
    FILE_completeop(req->fileop);
    if (req->status != 0) cancelrequest(req);   /* cancelled mid-flight -> cleanup */
    else                  finishrequest(req);   /* done -> hand back to the user */
    return 0;
}

/* loadfilereadcallback @0x800F0D80 : one chunk read; loop until EOF/cancel, then close. */
extern int loadfilereadcallback(int id, int status, AsyncReq *req)
{
    int n = FILE_completeop(req->fileop);       /* bytes read this chunk */
    unsigned int nextop;
    (void)id; (void)status;
    req->bytesread += n;
    if (n < readblocksize || req->status != 0) {            /* short read (EOF) or cancel -> close */
        nextop = FILE_close((void *)(size_t)(unsigned int)req->handle, 0x63, RQ(req));
        req->fileop = (int)nextop;             /* §3.21: stored in the beqz delay slot (even if 0) */
        if (nextop == 0) return 0;
        FILE_callbackop(nextop, (void (*)(int, int))loadfileclosecallback);
    } else {                                                 /* full chunk -> read the next one */
        req->offset += n;
        req->dest   += n;
        nextop = FILE_read((void *)(size_t)(unsigned int)req->handle,
                           (unsigned int)req->offset, (unsigned int)req->dest,
                           readblocksize, 0x63, RQ(req));
        req->fileop = (int)nextop;             /* §3.21: stored in the beqz delay slot (even if 0) */
        if (nextop == 0) return 0;
        FILE_callbackop(nextop, (void (*)(int, int))loadfilereadcallback);
    }
    /* Residual 1-diff: oracle falls through the shared (tail-merged) FILE_callbackop call
     * to the epilogue returning v0 (no move-v0-zero); a plain return 0 here emits the extra
     * move-v0-zero.  Returning the tail call value un-merges the two calls (+7 diffs), so
     * this 1-insn move-v0-zero is the clean floor. */
    return 0;
}

/* loadfilesizecallback @0x800F0E54 : got the size -> allocate the buffer and start reading. */
extern int loadfilesizecallback(int id, int status, AsyncReq *req)
{
    int filesize = FILE_completeop(req->fileop);
    unsigned int nextop;
    (void)id; (void)status;
    if (req->status != 0) {                                  /* cancelled -> close */
        nextop = FILE_close((void *)(size_t)(unsigned int)req->handle, 0x63, RQ(req));
        if (nextop == 0) return 0;
        req->fileop = (int)nextop;
        FILE_callbackop(nextop, (void (*)(int, int))loadfileclosecallback);
    } else {                                                 /* allocate "ASYNCBUF" of the file size */
        void *buf = reservememadr((char *)"ASYNCBUF", filesize, req->arg24);
        req->buffer = (int)(size_t)buf;
        req->dest   = (int)(size_t)buf;
        nextop = FILE_read((void *)(size_t)(unsigned int)req->handle,
                           (unsigned int)req->offset, (unsigned int)req->dest,
                           readblocksize, 0x63, RQ(req));
        if (nextop == 0) return 0;
        req->fileop = (int)nextop;
        FILE_callbackop(nextop, (void (*)(int, int))loadfilereadcallback);
    }
    return 0;
}

/* loadfileopencallback @0x800F0F18 : open done -> read directly, size-then-read, or close on cancel. */
extern int loadfileopencallback(int id, int status, AsyncReq *req)
{
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
    int n = FILE_completeop(req->fileop);
    int remaining, len;
    unsigned int nextop;
    (void)id; (void)status;
    req->bytesread += n;
    req->offset    += n;
    asyncfileoffset = req->offset;
    if (req->status != 0) { cancelrequest(req); return 0; }     /* cancelled */
    if (n < readblocksize) { finishrequest(req); return 0; }    /* short read -> done */
    req->arg24 -= n;                                            /* remaining bytes */
    req->dest  += n;
    remaining = req->arg24;
    len = (readblocksize < remaining) ? readblocksize : remaining;   /* clamp to a block */
    nextop = FILE_read((void *)(size_t)(unsigned int)asyncfilehandle,
                       (unsigned int)req->offset, (unsigned int)req->dest, len, 0x63, RQ(req));
    if (nextop == 0) return 0;
    req->fileop = (int)nextop;
    FILE_callbackop(nextop, (void (*)(int, int))loadsegreadcallback);
    return 0;
}

/* asyncsystemtask @0x800F1120 : drain callqueue -- fire each finished request's user callback (or clean
 *   up a cancelled one), then recycle the slot.  Registered as a periodic system task by initasync. */
extern int asyncsystemtask(void)
{
    AsyncReq *req = queuefetch(&callqueue);
    while (req != 0) {
        if (req->status != 0) {                    /* cancelled -> full cleanup */
            cancelrequest(req);
        } else {                                   /* normal completion -> fire the callback */
            void (*cb)(int) = (void (*)(int))(size_t)(unsigned int)req->callback;
            cb(req->id);
            queueadd(&freequeue, req);
            req->id = (unsigned char)req->id;      /* free the slot */
        }
        req = queuefetch(&callqueue);
    }
    return 0;
}

/* initasync @0x800F11B0 : allocate the request pool (<=0x100 slots), build the free list, create the
 *   mutex, and register asyncsystemtask.  No-op if already initialised or numreq out of range. */
extern int initasync(int numreq, int blocksize, int memclass)
{
    if (request == 0 && numreq < 0x101) {
        int i;
        readblocksize = blocksize;
        numrequests   = numreq;
        request = (AsyncReq *)reservememadr((char *)"ASYNCREQ", numreq * 0x2C, memclass);
        freequeue.head = request;
        freequeue.tail = (AsyncReq *)((char *)request + (numreq * 0x2C - 0x2C));  /* &request[numreq-1] */
        callqueue.head = 0;
        callqueue.tail = 0;
        asyncfilehandle = 0;
        mutex = allocmutex();
        for (i = 0; i < numreq; i++) {                     /* link every slot onto the free list */
            AsyncReq *r = (AsyncReq *)((char *)request + i * 0x2C);
            r->id     = i;                                 /* id low byte == slot index */
            r->next   = (AsyncReq *)((char *)r + 0x2C);
            r->fileop = 0;
        }
        request[numreq - 1].next = 0;                      /* terminate the free list */
        addsystemtask(asyncsystemtask, 1, 1);
    }
    return 0;
}

/* ---- public load entry points ---- */

/* asyncloadfilecallback @0x800F12B0 : begin an async load that allocates its own buffer (poll via
 *   getasyncreadadr, or `cb` fires on completion).  Returns the request id (0 if no free slot/open fail). */
extern int asyncloadfilecallback(int name, int memclass, int cb)
{
    AsyncReq *req = queuefetch(&freequeue);
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
    AsyncReq *req = queuefetch(&freequeue);
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
    AsyncReq *req = queuefetch(&freequeue);
    int len;
    unsigned int op;
    if (req == 0)
        return 0;
    newrequestid(req);
    req->bytesread = 0;
    req->status    = 0;
    req->buffer    = 0;
    req->callback  = cb;
    req->offset    = offset;
    req->arg24     = size;             /* remaining bytes */
    req->dest      = dest;             /* asm: delay slot */
    if (asyncfilehandle == 0) {        /* no file open -> finish now */
        finishrequest(req);
        return req->id;
    }
    len = (readblocksize < size) ? readblocksize : size;   /* clamp the first chunk */
    op = FILE_read((void *)(size_t)(unsigned int)asyncfilehandle,
                   (unsigned int)req->offset, (unsigned int)req->dest, len, 0x64, RQ(req));
    req->fileop = (int)op;            /* asm: set on both branches */
    if (op == 0)
        return 0;
    FILE_callbackop(op, (void (*)(int, int))loadsegreadcallback);
    return req->id;
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
    AsyncReq *req = locaterequest(id);
    if (req == 0)
        return 0;
    if (req->status != 0)              /* already cancelling/cancelled */
        return 0;
    FILE_cancelop(req->fileop);
    req->status = 1;                   /* request cancel (asm: delay slot) */
    if (req->fileop != 0)              /* still in flight -> let the callback finish it */
        return 0;
    if (req->callback != 0)            /* has a callback -> it will run */
        return 0;
    cancelrequest(req);
    return 0;
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
    if (req->buffer == 0) return 0;    /* nothing allocated */
    if (req->callback != 0)            /* a callback owns the lifecycle */
        return adr;
    queueadd(&freequeue, req);         /* poll-only -> recycle the slot now */
    req->id = (unsigned char)req->id;
    return adr;
}

/* getasyncreadstatus @0x800F16D8 : -2 invalid id, 1/2 cancel state, the in-flight op id while loading,
 *   -1 not started, else the bytes read.  Recycles the slot when fully done with no buffer/callback. */
extern int getasyncreadstatus(int id)
{
    AsyncReq *req = locaterequest(id);
    int st;
    if (req == 0)        return -2;
    if (req->status != 0) return req->status;
    if (req->fileop != 0) return req->fileop;          /* still loading (nonzero op id) */
    st = (req->bytesread != 0) ? req->bytesread : -1;
    if (req->buffer != 0)   return st;
    if (req->callback != 0) return st;
    queueadd(&freequeue, req);                         /* harvested -> recycle the slot */
    req->id = (unsigned char)req->id;
    return st;
}

 AsyncQueue callqueue; AsyncQueue freequeue; int asyncfileoffset; int numrequests; int readblocksize;   /* owning-TU defs (BSS) */
 void *mutex;    /* nasync.obj async-pool mutex handle (= allocmutex() result); BSS */
 int asyncfilehandle;    /* @0x8013DEB0 : open file handle for segment reads; 4B → .comm/.sbss → gp-rel */
 int requestidcounter;    /* @0x8013DEB8 : request-ID counter; 4B → .comm/.sbss → gp-rel */

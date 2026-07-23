/* eaclib/psx/eacpsxz/syncfile.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\syncfile.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3 FILE record line 357483).
 *   8 fns @[0x800EA6CC .. 0x800EAAC4]: synchronous (blocking) wrappers over the asynchronous FILE_* API
 *   (nfile.obj).  Each issues an async op, FILE_waitop()s for it, FILE_completeop()s, and reports status.
 *   The block-IO path (syncblockio + the synccallback completion handler) auto-chunks transfers >0x2000 B,
 *   re-issuing per completion through a 9-field control block.
 *      synccallback   @0x800EA6CC (static) -- async completion handler; advances the control block & re-issues
 *      syncblockio    @0x800EA7E8 (static) -- start a chunked blocking transfer, return total bytes moved
 *      FILE_opensync  @0x800EA8A8 -- blocking open  -> BOOL ok, *out = handle
 *      FILE_readsync  @0x800EA920 -- blocking read  (syncblockio with FILE_read as the io fn)
 *      FILE_closesync @0x800EA950 -- blocking close
 *      FILE_sizesync  @0x800EA9A4 -- blocking size query
 *      FILE_addbigsync@0x800EA9F8 -- blocking add-to-BIG-archive -> BOOL ok, *out = handle
 *      FILE_delbigsync@0x800EAA70 -- blocking remove-from-BIG-archive
 *   Sources: disasm-v3 is AUTHORITATIVE here -- Ghidra mis-decompiled syncblockio (dropped the control-block
 *   build, the 6th call arg, and returned 0 instead of bytes-moved) and synccallback's iofn arity (showed 5,
 *   the asm passes 6).  IDA sigs recovered all dropped reg/stack args; `-0x7ff15934` = 0x800EA6CC =
 *   synccallback (the registered completion callback).  Plain C -> extern "C".
 */
struct SyncCtrl;
typedef int (*SyncIoFn)(int fd, int buf, int offset, int chunk, int cbarg, struct SyncCtrl *ctrl);

typedef struct SyncCtrl {
    int      cbarg;   /* +0  user callback arg (passed as the io fn's 5th param) */
    int      fd;      /* +4  file handle */
    int      buf;     /* +8  destination pointer (advances by bytes-done) */
    int      remain;  /* +12 bytes still to transfer */
    int      done;    /* +16 bytes transferred so far (syncblockio's return), advances */
    int      chunk;   /* +20 current chunk size (clamped to 0x2000) */
    int      offset;  /* +24 source offset (finalized on the last/short chunk) */
    SyncIoFn iofn;    /* +28 async io fn (only stored for multi-chunk transfers) */
    int      op;      /* +32 current async op handle */
} SyncCtrl;

/* --- async FILE_* API (nfile.obj) --- */
extern unsigned int FILE_open  (char *name, int a2, int a3, int a4);
extern unsigned int FILE_close (int fd, int a2, int a3);
extern unsigned int FILE_size  (int fd, int a2, int a3);
extern unsigned int FILE_addbig(char *name, int a2, int a3, int a4);
extern unsigned int FILE_delbig(int a0, int a1, int a2);
extern int          FILE_read(int fd, int buf, int offset, int chunk, int cbarg, SyncCtrl *ctrl); /* @0x800EC4EC */
extern void         FILE_waitop    (unsigned int op);
extern int          FILE_opstatus  (unsigned int op);
extern unsigned int FILE_completeop(unsigned int op);
extern void         FILE_callbackop(unsigned int op, void *cb);

extern void synccallback(int op, int type, SyncCtrl *ctrl);                 /* @0x800EA6CC */
extern int  syncblockio(int fd, int buf, int offset, int len, int cbarg, SyncIoFn iofn); /* @0x800EA7E8 */

/* synccallback @0x800EA6CC : async completion -- on a successful chunk, advance the control block and, if more
 *   remains, re-issue the next chunk; otherwise mark the transfer finished. */
extern void synccallback(int op, int type, SyncCtrl *c)
{
    unsigned int done = FILE_completeop((unsigned int)op);
    c->op = 0;
    if (type == 1) {
        int newoffset = c->offset + done;
        c->buf  += done;
        c->done += done;
        if (done < (unsigned int)c->chunk) {        /* short transfer => this was the last chunk */
            c->offset = newoffset;
            c->remain = 0;
        } else {
            c->remain -= done;
        }
        if (0 < c->remain) {
            c->chunk = (0x2000 < c->remain) ? 0x2000 : c->remain;
            c->op = c->iofn(c->fd, c->buf, c->offset, c->chunk, c->cbarg, c);
            if (c->op != 0) {
                FILE_callbackop((unsigned int)c->op, (void *)synccallback);
                return;
            }
        } else {
            return;
        }
    }
    c->remain = 0;
}

/* syncblockio @0x800EA7E8 : run a chunked blocking transfer of `len` bytes via `iofn`; returns bytes moved. */
extern int syncblockio(int fd, int buf, int offset, int len, int cbarg, SyncIoFn iofn)
{
    SyncCtrl c;
    int firstchunk;
    *(volatile int *)&c.cbarg  = cbarg;
    *(volatile int *)&c.fd     = fd;
    *(volatile int *)&c.buf    = buf;
    *(volatile int *)&c.remain = len;
    *(volatile int *)&c.done   = 0;
    *(volatile int *)&c.chunk  = len;
    firstchunk = *(volatile int *)&c.chunk;
    *(volatile int *)&c.offset = offset;
    /* MATCH (disasm-v4 trace): the volatile initialization view preserves the oracle's ordered
     * stack stores.  It then re-reads the just-stored chunk before storing offset; keeping that
     * value in `firstchunk` recovers the exact load/save-ra/store-offset/compare sequence.
     * `c.iofn = iofn` is unconditional and lands in the chunk-test branch delay slot.  Reading
     * c.offset and c.chunk for the first call recovers the oracle's a2/a3 stack reloads. */
    c.iofn = iofn;
    if (firstchunk > 0x2000)
        c.chunk = 0x2000;
    c.op = iofn(fd, buf, c.offset, c.chunk, cbarg, &c);
    if (c.op != 0) {
        FILE_callbackop((unsigned int)c.op, (void *)synccallback);
        while ((c.remain != 0) || (c.op != 0))
            FILE_waitop((unsigned int)c.op);
    }
    return c.done;
}

/* FILE_opensync @0x800EA8A8 : blocking open; *out = handle.  Returns 1 if the op succeeded. */
extern int FILE_opensync(char *name, int a2, int a3, int *out)
{
    int          ok = 0;
    unsigned int op = FILE_open(name, a2, a3, 0);
    if (op != 0) {                                    /* oracle: beqz→zero path, fall-through→nonzero */
        FILE_waitop(op);
        ok   = (FILE_opstatus(op) == 1);
        *out = (int)FILE_completeop(op);              /* §3.21: sw in j delay slot */
    } else {
        *out = 0;
    }
    return ok;
}

/* FILE_readsync @0x800EA920 : blocking read (chunked via syncblockio + FILE_read). */
extern void FILE_readsync(int fd, int buf, int offset, int len, int cbarg)
{
    syncblockio(fd, buf, offset, len, cbarg, FILE_read);
}

/* FILE_closesync @0x800EA950 : blocking close.
 * MATCH: SHARED-CONSTANT-RETURN (catalog §A) -- `result` is materialized ONCE as the literal 0,
 * doubling as the FILE_close third-arg AND (post-call) the return value; oracle keeps both in $s1. */
extern int FILE_closesync(int fd, int a2)
{
    int result = 0;
    unsigned int op = FILE_close(fd, a2, result);
    if (op != 0) {
        FILE_waitop(op);
        result = (int)FILE_completeop(op);
    }
    return result;
}

/* FILE_sizesync @0x800EA9A4 : blocking size query.  MATCH: same shared-constant-return shape. */
extern int FILE_sizesync(int fd, int a2)
{
    int result = 0;
    unsigned int op = FILE_size(fd, a2, result);
    if (op != 0) {
        FILE_waitop(op);
        result = (int)FILE_completeop(op);
    }
    return result;
}

/* FILE_addbigsync @0x800EA9F8 : blocking add-to-BIG; *out = handle.  Returns 1 if the op succeeded. */
extern int FILE_addbigsync(char *name, int a2, int a3, int *out)
{
    int          ok = 0;
    unsigned int op = FILE_addbig(name, a2, a3, 0);
    if (op != 0) {                                    /* oracle: beqz→zero path, fall-through→nonzero */
        FILE_waitop(op);
        ok   = (FILE_opstatus(op) == 1);
        *out = (int)FILE_completeop(op);              /* §3.21: sw in j delay slot */
    } else {
        *out = 0;
    }
    return ok;
}

/* FILE_delbigsync @0x800EAA70 : blocking remove-from-BIG.  MATCH: same shared-constant-return shape. */
extern int FILE_delbigsync(int a0, int a1)
{
    int result = 0;
    unsigned int op = FILE_delbig(a0, a1, result);
    if (op != 0) {
        FILE_waitop(op);
        result = (int)FILE_completeop(op);
    }
    return result;
}

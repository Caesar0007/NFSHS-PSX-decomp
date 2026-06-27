/* eaclib/psx/eacpsxz/syncfile.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
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
extern "C" unsigned int FILE_open  (char *name, int a2, int a3, int a4);
extern "C" unsigned int FILE_close (int fd, int a2, int a3);
extern "C" unsigned int FILE_size  (int fd, int a2, int a3);
extern "C" unsigned int FILE_addbig(char *name, int a2, int a3, int a4);
extern "C" unsigned int FILE_delbig(int a0, int a1, int a2);
extern "C" int          FILE_read(int fd, int buf, int offset, int chunk, int cbarg, SyncCtrl *ctrl); /* @0x800EC4EC */
extern "C" void         FILE_waitop    (unsigned int op);
extern "C" int          FILE_opstatus  (unsigned int op);
extern "C" unsigned int FILE_completeop(unsigned int op);
extern "C" void         FILE_callbackop(unsigned int op, void *cb);

extern "C" void synccallback(int op, int type, SyncCtrl *ctrl);                 /* @0x800EA6CC */
extern "C" int  syncblockio(int fd, int buf, int offset, int len, int cbarg, SyncIoFn iofn); /* @0x800EA7E8 */

/* synccallback @0x800EA6CC : async completion -- on a successful chunk, advance the control block and, if more
 *   remains, re-issue the next chunk; otherwise mark the transfer finished. */
extern "C" void synccallback(int op, int type, SyncCtrl *c)
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
extern "C" int syncblockio(int fd, int buf, int offset, int len, int cbarg, SyncIoFn iofn)
{
    SyncCtrl c;
    c.cbarg  = cbarg;
    c.fd     = fd;
    c.buf    = buf;
    c.remain = len;
    c.done   = 0;
    c.offset = offset;
    if (len <= 0x2000) {
        c.chunk = len;
    } else {
        c.iofn  = iofn;                             /* only needed when re-issuing (matches the binary) */
        c.chunk = 0x2000;
    }
    c.op = iofn(fd, buf, offset, c.chunk, cbarg, &c);
    if (c.op != 0) {
        FILE_callbackop((unsigned int)c.op, (void *)synccallback);
        while ((c.remain != 0) || (c.op != 0))
            FILE_waitop((unsigned int)c.op);
    }
    return c.done;
}

/* FILE_opensync @0x800EA8A8 : blocking open; *out = handle.  Returns 1 if the op succeeded. */
extern "C" int FILE_opensync(char *name, int a2, int a3, int *out)
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
extern "C" void FILE_readsync(int fd, int buf, int offset, int len, int cbarg)
{
    syncblockio(fd, buf, offset, len, cbarg, FILE_read);
}

/* FILE_closesync @0x800EA950 : blocking close. */
extern "C" void FILE_closesync(int fd, int a2)
{
    unsigned int op = FILE_close(fd, a2, 0);
    if (op != 0) {
        FILE_waitop(op);
        FILE_completeop(op);
    }
}

/* FILE_sizesync @0x800EA9A4 : blocking size query. */
extern "C" void FILE_sizesync(int fd, int a2)
{
    unsigned int op = FILE_size(fd, a2, 0);
    if (op != 0) {
        FILE_waitop(op);
        FILE_completeop(op);
    }
}

/* FILE_addbigsync @0x800EA9F8 : blocking add-to-BIG; *out = handle.  Returns 1 if the op succeeded. */
extern "C" int FILE_addbigsync(char *name, int a2, int a3, int *out)
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

/* FILE_delbigsync @0x800EAA70 : blocking remove-from-BIG. */
extern "C" void FILE_delbigsync(int a0, int a1)
{
    unsigned int op = FILE_delbig(a0, a1, 0);
    if (op != 0) {
        FILE_waitop(op);
        FILE_completeop(op);
    }
}

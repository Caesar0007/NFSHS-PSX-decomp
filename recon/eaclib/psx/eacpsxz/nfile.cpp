/* eaclib/psx/eacpsxz/nfile.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** WIP ***
 *   Source obj : nfs4\eaclib\psx\nfile.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   27 fns @[0x800EBBF4 .. 0x800ED334].  EA async file-operation layer (op queue + handle table).
 *   FULL reconstruction (disasm-v3 MIPS); NOT stubs.  Uses lib/nfile.h (struct-first nfile pass).
 *
 *   PROGRESS (this file is built up incrementally; foundation allocators first):
 *     [done] freeop, freehandle, reservehandle, reserveop  -- op/handle table slot alloc/free
 *     [done] FILE_overhead, FILE_opstatus, FILE_operror     -- size calc + op-id query accessors
 *     [done] FILE_init, FILE_completeop                     -- system bring-up + op result harvest
 *     [done] FILE_callbackop                                -- fire a completion callback for an op
 *     [done] FILE_open, FILE_close, FILE_read, FILE_size    -- the user-facing file ops (dispatch)
 *     [done] iFILE_perror, FILE_waitop, FILE_atomic, FILE_priorityop, FILE_cancelop, FILE_initwithmem
 *     [done] iFILE_delbigclosecallback, iFILE_CommandCompleteCallback
 *     [done] iFILE_addbigopencallback, iFILE_addbigreadcallback, FILE_addbig  -- BIG-archive mount
 *     [done] FILE_delbig                                                      -- BIG-archive unmount
 *     [done] iFILE_ExecCommand   -- the I/O command pump (queue + device dispatch).  *** 27/27 COMPLETE ***
 *            (cancelop is a sorted-linked-list queue op using op->qnext@+0x2C, like FILE_priorityop.)
 *
 *   BIG-archive node (reservememadr'd, 0x10 bytes; chained on gFileMgr.devicelist):
 *     node+0x00 databuf  -- loaded header buffer (typeofbigfile/sizeofbigfileheader/getblocksize parse it)
 *     node+0x04 handle   -- FileHandle* of the open archive (its first 0x40 bytes == the filename)
 *     node+0x08 cmdop    -- the FILE_addbig/FILE_delbig command op (iFILE_ExecCommand'd on completion)
 *     node+0x0C next     -- device-list link
 *   Mount sequence: FILE_addbig reserves the node + a 0x800 header buffer, FILE_opens the archive with the
 *   node as the open op's param, and arms iFILE_addbigopencallback.  On open success that reads the first
 *   0x800 header block and arms iFILE_addbigreadcallback, which (if sizeofbigfileheader > one block) grows
 *   the buffer and re-reads the remainder (re-arming itself) until the whole header is in, then publishes
 *   the node on the device list and ExecCommands the user's command op.  (-m32-only verified: the node is
 *   accessed as int[4], and op-array stride 0x30 + op->qnext diverge from the LLP64 host layout.)
 *   NOTE: functions touching op->qnext (a pointer) + the hardcoded 0x30 op stride are -m32-only verified
 *   (host FileOp sizeof is 0x38 due to LLP64 8-byte pointers -> field offsets diverge; logic transcribed).
 *
 *   Op fields are MULTIPURPOSE (input args on submit, results on completion) so the file ops below
 *   use raw byte offsets into the op to match the asm exactly: +0x10/+0x14/+0x18 args, +0x0C error,
 *   +0x1C/+0x20/+0x24 op-specific.  The op-type nibble (bits 20-23) selects the operation:
 *     2 open (0x200000), 3 close (0x300000), 4 read (0x400000), 6 size (0x600000).
 *
 *   The FILE manager singleton lives @0x8013EA88 (gFileMgr): opcount/handlecount/idmask + oparray
 *   (0x30-byte FileOp slots) + handlearray (0x4C-byte FileHandle slots).  Slot alloc/free run inside
 *   a PSX interrupt-disabled critical section.
 */
#include "../../../lib/nfile.h"

/* freeop @0x800ED1F8 : clear a 0x30-byte op slot (release it back to the pool). */
extern "C" void freeop(FileOp *op)
{
    FILE_enterCS();
    blockclear(op, 0x30);
    FILE_leaveCS();
}

/* freehandle @0x800ED2F0 : clear a 0x4C-byte file handle (release it). */
extern "C" void freehandle(FileHandle *h)
{
    FILE_enterCS();
    blockclear(h, 0x4C);
    FILE_leaveCS();
}

/* reservehandle @0x800ED240 : find a free (inuse==0) handle slot, mark it used, return it (0 if none). */
extern "C" FileHandle *reservehandle(void)
{
    FileHandle *result = 0;
    int i;
    FILE_enterCS();
    for (i = 0; i < gFileMgr.handlecount; i++) {
        FileHandle *h = (FileHandle *)((char *)gFileMgr.handlearray + i * 0x4C);
        if (h->inuse == 0) {       /* first empty slot */
            h->inuse = 1;
            result = h;
            break;
        }
    }
    FILE_leaveCS();
    return result;
}

/* reserveop @0x800ED0DC : claim a free op slot, stamp it with op index + a fresh 20-bit request id. */
extern "C" FileOp *reserveop(void)
{
    FileOp *result = 0;
    int i;
    FILE_enterCS();
    for (i = 0; i < gFileMgr.opcount; i++) {
        FileOp *op = (FileOp *)((char *)gFileMgr.oparray + i * 0x30);
        if (((op->id >> 0x14) & 0xF) == 0) {                 /* type nibble (bits 20-23) == 0 -> free */
            op->id = (op->id & 0xFF0FFFFFu) | 0x100000u;     /* set type nibble = 1 */
            ((unsigned char *)&op->id)[3] = (unsigned char)i;/* byte3 (bits 24-31) = op index */
            op->id = (op->id & 0xFFF00000u) | (gFileOpSeq & 0xFFFFF);  /* bits 0-19 = request seq */
            if (++gFileOpSeq > 0xFFFFF)                      /* 20-bit wrap */
                gFileOpSeq = 0;
            result = op;
            break;
        }
    }
    FILE_leaveCS();
    return result;
}

/* FILE_overhead @0x800EBD74 : total RAM the FILE system needs for the given pool sizes (0 -> default). */
extern "C" int FILE_overhead(int handlecount, int memsize, int opcount)
{
    if (handlecount == 0) handlecount = 0x18;     /* 24 handles  */
    if (memsize == 0)     memsize     = 0x800;    /* 2 KB io mem */
    if (opcount == 0)     opcount     = 0xA;      /* 10 ops      */
    return ((5 * handlecount + 3 * opcount) << 4) + 20 * memsize;  /* 80*h + 48*op + 20*mem */
}

/* FILE_opstatus @0x800EBDC4 : status of the op named by `id` (index=id>>24); -3 if id is 0 or stale. */
extern "C" int FILE_opstatus(unsigned int id)
{
    FileOp *op;
    if (id == 0)
        return -3;
    op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    if ((id & 0xFFFFF) != (op->id & 0xFFFFF))     /* request id no longer matches -> stale */
        return -3;
    return op->status;
}

/* FILE_operror @0x800EBE1C : raw error code of the op named by `id` (index=id>>24; no validation). */
extern "C" int FILE_operror(unsigned int id)
{
    FileOp *op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    return op->error;
}

/* the FILE system backend (allocator + device init) */
extern "C" void *reservememadr(char *name, int size, int classid);  /* eacpsxz @0x800E533C */
extern "C" int   FILE_initwithmem(int handlecount, int memsize, int opcount, void *membuf); /* below (todo) */

/* FILE_init @0x800EBBF4 : bring the FILE system up, allocating its own pool ("File Sys"). */
extern "C" int FILE_init(int handlecount, int memsize, int opcount)
{
    void *buf;
    /* asm: beqz opcount -> body (the == 0 guard); the already-init return-0 is the FALL-THROUGH */
    if (gFileMgr.opcount == 0) {            /* gFileDevice == 0 -> not yet initialised */
        buf = reservememadr("File Sys", FILE_overhead(handlecount, memsize, opcount), 0);
        return FILE_initwithmem(handlecount, memsize, opcount, buf);
    }
    return 0;
}

/* FILE_completeop @0x800EC2B0 : harvest a finished op's result (by op type), then free the op slot.
 *   Returns 0 unless the op's status is 1 (complete).  Result field is per op-type nibble (2..10):
 *     2,9 -> result24 (open handle)   3,7,10 -> status   4,5 -> result1C (read)   6,8 -> result18 (size) */
extern "C" int FILE_completeop(unsigned int id)
{
    FileOp *op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    int result = 0;
    if (op->status == 1) {                  /* op finished */
        int type = (op->id >> 0x14) & 0xF;  /* op type nibble */
        switch (type) {
            case 2: case 9:           result = op->result24; break;
            case 3: case 7: case 10:  result = op->status;   break;
            case 4: case 5:           result = op->result1C; break;
            case 6: case 8:           result = op->result18; break;
            default:                  result = 0;            break;  /* type outside 2..10 */
        }
    }
    freeop(op);
    return result;
}

/* FILE_callbackop @0x800EBE4C : if the op has a (non-zero) status, store the callback and fire it
 *   immediately with (status, param), bracketed by the manager's pending-callback counter.  A status
 *   of 0 (op not started/no result yet) does nothing. */
extern "C" void FILE_callbackop(unsigned int id, void (*callback)(int status, int param))
{
    FileOp *op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    if (op->status != 0) {
        op->callback = (void (*)(void))callback;   /* remember it on the op */
        gFileMgr.cbpending++;
        callback(op->status, op->param);
        gFileMgr.cbpending--;
    }
}

/* ---- the user-facing file ops ---- */
extern "C" int    strlen(const char *s);                       /* libc C27 */
extern "C" char  *strncpy(char *d, const char *s, int n);      /* libc */
extern "C" void   iFILE_perror(FileOp *op);                    /* @0x800ED0D4 (below); op passed in $a0 (delay slot), ignored */
extern "C" int    iFILE_ExecCommand(void *cmd);                /* @0x800ECB98 (below, todo) */
extern "C" int    systemtask(int);                             /* @0x800E6C04 vsync/idle pump */

#define OPI(op, off)  (*(int  *)((char *)(op) + (off)))        /* int  field at byte offset */
#define OPP(op, off)  (*(void**)((char *)(op) + (off)))        /* ptr  field at byte offset */

/* FILE_open @0x800EC36C : open `name`; reserve an op (type 2) + a handle, copy the name, dispatch. */
extern "C" unsigned int FILE_open(char *name, unsigned int a1, unsigned int a2, unsigned int a3)
{
    FileOp *op = reserveop();
    void   *handle;
    OPI(op, 0x14) = (int)a3;
    OPI(op, 0x18) = (int)a1;
    OPI(op, 0x10) = (int)a2;
    op->id = (op->id & 0xFF0FFFFFu) | 0x200000u;          /* type 2 = open */
    handle = reservehandle();
    OPP(op, 0x24) = handle;                               /* store the handle (asm: always, delay slot) */
    if (handle == 0) {                                    /* no free handle */
        OPI(op, 0x0C) = 2;                                /* error code 2 */
        iFILE_perror(op);
    }
    (void)strlen(name);                                   /* (asm calls strlen; result unused) */
    /* reload handle straight into the strncpy dest arg ($a0) so gcc adds +0xC in-place (no $v0 temp) */
    strncpy((char *)OPP(op, 0x24) + 0x0C, name, 0x40);    /* name lives at handle+0xC (0x40 bytes) */
    iFILE_ExecCommand(op);                                /* dispatch the open op */
    return op->id;
}

/* FILE_close @0x800EC42C : close handle (type 3); errors if it is still a registered device. */
extern "C" unsigned int FILE_close(void *handle, unsigned int a1, unsigned int a2)
{
    FileOp *op = reserveop();
    char   *node = (char *)gFileMgr.devicelist;          /* mgr+0x24 device list head */
    OPI(op, 0x10) = (int)a1;
    OPI(op, 0x14) = (int)a2;
    OPP(op, 0x24) = handle;
    op->id = (op->id & 0xFF0FFFFFu) | 0x300000u;          /* type 3 = close */
    while (node) {                                        /* device still open with this handle? */
        if (OPP(node, 0x04) == handle) {
            OPI(op, 0x0C) = 3;                            /* error 3: can't close a live device */
            iFILE_perror(op);
            break;
        }
        node = (char *)OPP(node, 0x0C);                   /* next device */
    }
    iFILE_ExecCommand(op);
    return op->id;
}

/* FILE_read @0x800EC4EC : read from `handle` (type 4); clamps the length to the handle's size. */
extern "C" unsigned int FILE_read(void *handle, unsigned int offset, unsigned int dest,
                                  int len, unsigned int a5, unsigned int a6)
{
    FileOp *op = reserveop();
    op->id = (op->id & 0xFF0FFFFFu) | 0x400000u;          /* type 4 = read */
    OPI(op, 0x14) = (int)a6;
    OPI(op, 0x10) = (int)a5;                              /* asm: delay slot -> set unconditionally */
    if (handle == 0) {
        OPI(op, 0x0C) = 6;                                /* error 6 */
        iFILE_perror(op);
    }
    OPP(op, 0x24) = handle;
    {
        int size = OPI(handle, 0x04);                     /* handle->size */
        if (size < (int)(offset + (unsigned)len)) {       /* would read past EOF -> clamp */
            len = size - (int)offset;
            if (len < 0)
                len = 0;
        }
    }
    OPI(op, 0x1C) = len;                                  /* clamped read length */
    OPI(op, 0x20) = (int)dest;
    OPI(op, 0x18) = (int)offset;
    iFILE_ExecCommand(op);
    return op->id;
}

/* FILE_size @0x800EC5D0 : query the size of `handle` (type 6). */
extern "C" unsigned int FILE_size(void *handle, unsigned int a1, unsigned int a2)
{
    FileOp *op = reserveop();
    OPI(op, 0x14) = (int)a2;
    OPI(op, 0x10) = (int)a1;
    op->id = (op->id & 0xFF0FFFFFu) | 0x600000u;          /* type 6 = size */
    if (handle == 0) {
        OPI(op, 0x0C) = 6;                                /* error 6 */
        iFILE_perror(op);
    }
    OPP(op, 0x24) = handle;
    iFILE_ExecCommand(op);
    return op->id;
}

#undef OPI
#undef OPP

/* iFILE_perror @0x800ED0D4 : debug error reporter, compiled out in the release build (a nullsub).
 *   Takes the failing op in $a0 (callers rematerialize it into the jal delay slot); ignored here. */
extern "C" void iFILE_perror(FileOp *op)
{
    (void)op;
}

/* FILE_waitop @0x800EC1BC : block until the op named by `id` completes; return its status.
 *   Pumps systemtask(0) while the op's status is 0.  Returns -3 if `id` is 0/stale, or if the slot
 *   gets recycled out from under us during the wait. */
extern "C" int FILE_waitop(unsigned int id)
{
    FileOp *op;
    if (id == 0)
        return -3;
    op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    if ((id & 0xFFFFF) != (op->id & 0xFFFFF))         /* stale id */
        return -3;
    while (op->status == 0) {                          /* not finished yet -> pump the system */
        systemtask(0);
        op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
        if ((id & 0xFFFFF) != (op->id & 0xFFFFF))      /* slot recycled -> give up */
            return -3;
    }
    return op->status;
}

/* FILE_atomic @0x800ECB40 : run `fn(a3, a4)` (fn takes the 3rd/4th args -- $a2/$a3), flush the FILE
 *   command queue (iFILE_ExecCommand), and return fn's result.  The manager's +0x08 word (idmask) is
 *   saved and restored around the call -- a net no-op as written (the intermediate write is overwritten).
 *   The return value is fn's result, captured in ExecCommand's branch delay slot ($s0=$v0) before the
 *   call clobbers $v0; the 2nd arg is unused. */
extern "C" int FILE_atomic(int (*fn)(int, int), int unused, int a3, int a4)
{
    int saved = gFileMgr.idmask;     /* mgr+0x08 */
    int result;
    (void)unused;
    gFileMgr.idmask = a3;            /* asm: sw $a0,8(s0) in the jalr delay slot ($a0==a3, fn's 1st arg) */
    result = fn(a3, a4);
    gFileMgr.idmask = saved;         /* restore */
    iFILE_ExecCommand((void *)0);
    return result;
}

/* FILE_priorityop @0x800EBECC : change an op's queue priority, repositioning it in the pending queue.
 *   Updates op->prio always; only reorders the queue when the dispatcher is active (state>=2), the op
 *   isn't the one currently being dispatched, hasn't started (status==0), and its priority changed.
 *   The pending queue is a singly-linked list (op->qnext, head at gFileMgr.queuehead) kept sorted by
 *   ascending priority; the op is unlinked then reinserted before the first higher-priority op. */
extern "C" void FILE_priorityop(unsigned int id, int priority)
{
    FileOp *op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    int oldprio;

    FILE_enterCS();
    oldprio = op->prio;
    op->prio = priority;
    if (gFileMgr.state >= 2 && op != gFileMgr.curop && op->status == 0 && oldprio != priority) {
        FileOp *prev = 0, *node = gFileMgr.queuehead;
        while (node && node != op) {                 /* find op in the queue */
            prev = node;
            node = node->qnext;
        }
        if (prev == 0) gFileMgr.queuehead = op->qnext;   /* unlink (op was head) */
        else           prev->qnext        = op->qnext;

        prev = 0;
        node = gFileMgr.queuehead;
        while (node && node->prio <= priority) {     /* sorted reinsert (ascending) */
            prev = node;
            node = node->qnext;
        }
        op->qnext = node;                            /* op goes before the first higher-prio op */
        if (prev == 0) gFileMgr.queuehead = op;
        else           prev->qnext        = op;
    }
    FILE_leaveCS();
}

/* FILE device backend (other objs) + the manager init's CD/file-io bring-up. */
extern "C" int  CD_Init(int handlecount, int memsize, void *iomem, void (*cb)(void)); /* @0x800FA394 */
extern "C" void initfileio(void);                                  /* @0x800F3A34 */
extern "C" int  iFILE_CommandCompleteCallback(int result);         /* @0x800ED020 (below) */
extern "C" int  disablecd;                                         /* global: nonzero == CD backend off */

/* FILE_initwithmem @0x800EBC78 : set the manager up over a caller-provided pool, then bring up the
 *   CD device + file-io backend.  Returns 0 if the system was already initialised, else 1. */
extern "C" int FILE_initwithmem(int handlecount, int memsize, int opcount, void *membuf)
{
    int size;
    if (handlecount == 0) handlecount = 0x18;     /* 24 */
    if (memsize == 0)     memsize     = 0x800;    /* 2 KB */
    if (opcount == 0)     opcount     = 0xA;      /* 10 */
    if (gFileMgr.opcount != 0)                    /* already up */
        return 0;
    gFileMgr.opcount     = opcount;
    gFileMgr.handlecount = handlecount;
    gFileMgr.idmask      = 0xFF;
    size = FILE_overhead(handlecount, memsize, opcount);
    gFileMgr.oparray     = (FileOp *)membuf;                       /* op array at the pool base */
    blockclear(membuf, size);                                     /* zero the whole pool */
    gFileMgr.handlearray = (FileHandle *)((char *)membuf + opcount * 0x30);  /* handles after ops */
    if (disablecd == 0) {                                          /* CD backend enabled */
        char *iomem = (char *)gFileMgr.handlearray + handlecount * 0x4C;     /* io mem after handles */
        int r = CD_Init(handlecount, memsize, iomem,
                        (void (*)(void))iFILE_CommandCompleteCallback);
        disablecd = (r < 1) ? 1 : 0;                              /* disable CD if init failed */
    }
    initfileio();
    return 1;
}

extern "C" void stopreadfile(int dev);   /* @0x800F4100 abort an in-flight read on a device */

/* FILE_cancelop @0x800EC008 : cancel the op named by `id` (no-op for close/type-10 ops or stale ids).
 *   - if the op is the one currently being dispatched (mgr.curop): flag op->cancelreq=1, and if it is a
 *     read, abort the device read via stopreadfile;
 *   - else if the op already completed (status==1): mark it cancelled (status=-1);
 *   - else (still queued): unlink it from the pending queue, decrement mgr.state, mark it cancelled
 *     (status=-1) and fire its completion callback with (id, param). */
extern "C" void FILE_cancelop(unsigned int id)
{
    FileOp *op;
    int     nibble, action = 0;

    FILE_enterCS();
    if (id == 0) { FILE_leaveCS(); return; }
    op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    if ((id & 0xFFFFF) != (op->id & 0xFFFFF)) { FILE_leaveCS(); return; }   /* stale id */
    nibble = (id >> 0x14) & 0xF;
    if (nibble == 3 || nibble == 0xA) { FILE_leaveCS(); return; }           /* close/type-10: not cancellable */

    if (op == gFileMgr.curop) {                  /* op is in flight */
        op->cancelreq = 1;
        action = 1;
    } else if (op->status == 1) {                /* already complete */
        op->status = -1;                         /* mark cancelled (no further action) */
    } else {                                     /* still queued -> remove it */
        FileOp *prev = 0, *node = gFileMgr.queuehead;
        if (node == 0) { FILE_leaveCS(); return; }
        while (node && node != op) { prev = node; node = node->qnext; }
        if (node == 0) { FILE_leaveCS(); return; }              /* not in queue */
        if (prev == 0) gFileMgr.queuehead = op->qnext;
        else           prev->qnext        = op->qnext;
        gFileMgr.state--;                        /* one fewer queued op */
        op->status = -1;                         /* mark cancelled */
        action = 2;
    }

    if (action == 1) {                           /* in-flight read -> stop the device read */
        if (((op->id >> 0x14) & 0xF) == 4) {
            void *handle = (void *)op->result24;
            stopreadfile(*(int *)handle);
        }
    } else if (action == 2) {                    /* removed from queue -> notify */
        if (op->callback) {
            /* @0x800EC198-1A4: callback(op->id, -1, op->param) -- $a0=*op(id), $a2=*(20+op)(param),
             * and $a1=-1 (status) in the JAL delay slot. The recon called the 2-arg form cb(id,param),
             * putting param in the status slot and dropping the real 3rd param arg (M02). 3-arg
             * (id,status,param) convention per iFILE_CommandCompleteCallback (see line 462). */
            void (*cb)(int, int, int) = (void (*)(int, int, int))op->callback;
            cb((int)op->id, -1, op->param);
        }
    }
    FILE_leaveCS();
}

/* iFILE_delbigclosecallback @0x800EC980 : completion callback for the BIG-archive close op -- harvest
 *   the close op (FILE_completeop), then kick the next queued command (iFILE_ExecCommand). */
extern "C" int iFILE_delbigclosecallback(unsigned int id, int a1, void *cmd)
{
    (void)a1;
    FILE_completeop(id);
    return iFILE_ExecCommand(cmd);
}

/* iFILE_CommandCompleteCallback @0x800ED020 : the CD/device completion driver (handed to CD_Init).
 *   Resolves the final status of the in-flight op (mgr.curop): a pending cancel -> -1 (cancelled), else
 *   result==0 -> -2 (device fail), result!=0 -> 1 (ok).  Clears mgr.curop, fires the op's completion callback
 *   (id, status, param) bracketed by mgr.cbpending, then dispatches the next command if nothing nested. */
extern "C" int iFILE_CommandCompleteCallback(int result)
{
    FileOp *cmd = gFileMgr.curop;
    int status;
    if (cmd == 0)
        return 0;
    /* @0x800ED040-50: delay slots set the stored value -- cancelreq!=0 -> -1, result==0 -> -2, else 1.
     * The recon stored cmd->cancelreq (the flag value, ~1) instead of -1, and -1 instead of -2 (M03). */
    if (cmd->cancelreq != 0) status = -1;               /* cancel in flight -> cancelled */
    else if (result == 0)    status = -2;               /* device reported failure */
    else                     status = 1;                /* success */
    cmd->status = status;
    gFileMgr.curop = 0;
    if (cmd->callback) {
        void (*cb)(int, int, int) = (void (*)(int, int, int))cmd->callback;
        gFileMgr.cbpending++;
        cb((int)cmd->id, cmd->status, cmd->param);
        gFileMgr.cbpending--;
    }
    if (gFileMgr.cbpending == 0)
        iFILE_ExecCommand((void *)0);                   /* kick the next queued command */
    return 0;
}

/* ---- BIG-archive (.BIG) mount: FILE_addbig + its open/read completion callbacks ---- */
#include <stddef.h>                                     /* size_t (target-faithful ptr<->int casts) */

extern "C" void  purgememadr(void *p);                  /* eacpsxz @0x800E5540 : free a reservememadr block */
extern "C" int   typeofbigfile(void *hdr);              /* eacpsxz @0x800E5F1C : archive type from header  */
extern "C" int   sizeofbigfileheader(void *hdr);        /* eacpsxz @0x800E5F84 : full header byte size      */
extern "C" int   getblocksize(void *hdr);               /* eacpsxz @0x800E52D4 : bytes valid in the buffer  */
extern "C" void  blockmove(void *src, void *dst, int n);/* eacpsxz @0x800E62DC : memmove(dst,src,n)          */
extern "C" int   iscurrentthread(int);                  /* eacpsxz @0x800FE408 : (called for side-effect)   */
extern "C" int   strncmp(const char *, const char *, int); /* libc C24 @0x800EB1D0                          */

/* iFILE_addbigreadcallback @0x800EC660 : completion of a header read.  Records the handle, finalizes the
 *   read op, and if the header spans more than the block already read, grows the buffer and re-reads the
 *   remainder (re-arming itself).  When the whole header is loaded it links the node onto the device list
 *   and kicks the user's command op.  `id`=read op id, `status` unused, `node`=the BIG node (int[4]). */
extern "C" void iFILE_addbigreadcallback(unsigned int id, int status, int *node)
{
    FileOp *op    = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    int     handle = op->result24;        /* FILE_read stashed the handle in result24 (+0x24) */
    int     prio   = op->prio;            /* +0x10 */
    FileOp *cmdop  = (FileOp *)(size_t)(unsigned int)node[2];
    int     hdrsize, blksize;
    (void)status;

    node[1] = handle;                     /* node->handle */
    FILE_completeop(id);                  /* finalize this read op (frees the slot) */
    cmdop->result24 = handle;             /* propagate the handle to the command op (asm: delay slot) */

    if (typeofbigfile((void *)(size_t)(unsigned int)node[0]) == 0)
        purgememadr((void *)(size_t)(unsigned int)node[0]);   /* invalid type -> drop the buffer */

    hdrsize = sizeofbigfileheader((void *)(size_t)(unsigned int)node[0]);
    blksize = getblocksize((void *)(size_t)(unsigned int)node[0]);
    if (blksize < hdrsize) {              /* header bigger than what we have -> read the rest */
        void *newbuf = reservememadr((char *)"bigfile buf", hdrsize, 0x10);
        unsigned int rid;
        blockmove((void *)(size_t)(unsigned int)node[0], newbuf, 0x800);  /* keep the first block */
        purgememadr((void *)(size_t)(unsigned int)node[0]);
        node[0] = (int)(size_t)newbuf;
        rid = FILE_read((void *)(size_t)handle, 0x800,
                        (unsigned int)(size_t)((char *)newbuf + 0x800),
                        hdrsize - 0x800, prio, (unsigned int)(size_t)node);
        FILE_callbackop(rid, (void (*)(int, int))iFILE_addbigreadcallback);
    } else {                             /* header complete -> publish the device */
        node[3] = (int)(size_t)gFileMgr.devicelist;   /* node->next = old head */
        gFileMgr.devicelist = node;
        iFILE_ExecCommand(cmdop);
    }
}

/* iFILE_addbigopencallback @0x800EC7A0 : completion of the archive FILE_open.  Harvests the handle and,
 *   on success, kicks off reading the first 0x800 header block (arming iFILE_addbigreadcallback); on
 *   failure marks the command op error 4 and runs it.  `status`==1 means open succeeded. */
extern "C" void iFILE_addbigopencallback(unsigned int id, int status, int *node)
{
    FileOp *op   = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    int     prio = op->prio;               /* +0x10 */
    int     handle = FILE_completeop(id);  /* open op result24 == the opened handle */

    if (status != 1) {                     /* open failed */
        FileOp *cmdop = (FileOp *)(size_t)(unsigned int)node[2];
        cmdop->error = 4;
        iFILE_ExecCommand(cmdop);
    } else {                               /* open ok -> read the first header block */
        unsigned int rid = FILE_read((void *)(size_t)handle, 0,
                                     (unsigned int)node[0], 0x800,
                                     prio, (unsigned int)(size_t)node);
        FILE_callbackop(rid, (void (*)(int, int))iFILE_addbigreadcallback);
    }
}

/* FILE_addbig @0x800EC858 : mount a .BIG archive `name` (type 9 command op).  If an archive with the same
 *   name is already open (its handle's first 0x40 bytes hold the name), hand back the existing handle and
 *   run the command immediately.  Otherwise allocate a device node + header buffer, FILE_open the archive
 *   (passing the node as the open op's param) and arm iFILE_addbigopencallback to drive the header load.
 *   Returns op->id (used as an op id by FILE_addbigsync); the dup-hit path returns the op pointer (an asm
 *   quirk faithfully reproduced). */
extern "C" unsigned int FILE_addbig(char *name, unsigned int a1, unsigned int datatype, unsigned int param)
{
    int    *node = (int *)gFileMgr.devicelist;     /* device-list head */
    FileOp *op   = reserveop();
    void   *databuf;

    op->param = (int)param;                        /* +0x14 */
    op->prio  = (int)datatype;                     /* +0x10 */
    op->id    = (op->id & 0xFF0FFFFFu) | 0x900000u;/* type nibble 9 = add-big */
    iscurrentthread(0);                            /* (asm calls it; return unused) */

    for (; node; node = (int *)(size_t)(unsigned int)node[3]) {   /* already mounted? */
        /* compare against the handle's embedded name (handle+0xC); asm: a1 += 0xC in the delay slot */
        if (strncmp(name, (char *)((size_t)(unsigned int)node[1] + 0x0C), 0x40) == 0) {
            op->result24 = node[1];                /* hand back the existing handle */
            iFILE_ExecCommand(op);
            return (unsigned int)(size_t)op;       /* asm returns the op pointer in this path (quirk) */
        }
    }

    node    = (int *)reservememadr(name, 0x10, (int)a1);          /* 0x10-byte device node */
    node[2] = (int)(size_t)op;                     /* node->cmdop = op (asm: databuf-alloc delay slot) */
    databuf = reservememadr((char *)"bigfile header", 0x800, 0x10);/* first header block buffer (stays in $v0) */
    node[0] = (int)(size_t)databuf;                /* node->databuf -- store sinks into FILE_open's delay slot */
    {
        unsigned int oid = FILE_open(name, 1, datatype, (unsigned int)(size_t)node);
        FILE_callbackop(oid, (void (*)(int, int))iFILE_addbigopencallback);
    }
    return op->id;                                 /* asm: v0 = *op = op->id */
}

/* FILE_delbig @0x800EC9AC : unmount the .BIG archive whose device handle is `delHandle` (type 0xA command
 *   op).  Sweeps the handle array first -- if any open handle is still bound to this device it flags the
 *   op busy (status -2, error 1) but proceeds anyway -- then finds the device node, unlinks it, frees its
 *   header buffer and the node, and issues a FILE_close (chained to iFILE_delbigclosecallback which runs
 *   the command op once the close finishes).  Returns the command op's id.
 *   NOTE (faithful quirks): the close handle is captured from the device-LIST HEAD before the search, and
 *   the head-removal case zeroes gFileMgr.devicelist rather than relinking node->next -- i.e. the routine
 *   effectively assumes the target archive is the head of the device list (BIG archives are torn down
 *   LIFO).  A not-found device dereferences null (matches the asm; never happens in practice). */
extern "C" unsigned int FILE_delbig(int delHandle, unsigned int a2, unsigned int a3)
{
    int    *node = (int *)gFileMgr.devicelist;      /* s1 */
    FileOp *op   = reserveop();                      /* s2 */
    int    *h    = (int *)gFileMgr.handlearray;      /* a1 */
    int     closeHandle;                             /* s3 */
    int    *prev = 0;                                /* s0 (also the initial handle-loop guard, == 0) */
    int     i;

    op->param = (int)a3;                             /* +0x14 */
    op->prio  = (int)a2;                             /* +0x10 */
    op->id    = (op->id & 0xFF0FFFFFu) | 0xA00000u;  /* type nibble 0xA = del-big */

    if (((int *)(size_t)(unsigned int)delHandle)[2] != 0)   /* delHandle+8 != 0 -> note busy */
        op->error = 1;

    /* handle-array scan: is any open handle still pointing at this device? -> mark busy. */
    for (i = 0; i < gFileMgr.handlecount; i++) {
        if (h != 0 && h[2] != 0) {                   /* handle slot in use (h+8 != 0) */
            int *hn = (int *)(size_t)(unsigned int)h[0];   /* handle[0] -> its device node */
            if (hn[1] == delHandle) {                /* node+4 == delHandle */
                op->status = -2;                     /* device-busy sentinel (asm delay-slot v0=-2) */
                op->error  = 1;
                break;
            }
        }
        h = (int *)((char *)h + 0x4C);               /* next FileHandle (0x4C stride) */
    }

    /* device-list scan for the node owning delHandle, then unlink it. */
    closeHandle = node ? node[1] : 0;                /* s3 = head node+4 (asm loads it unconditionally) */
    if (node != 0) {
        for (;;) {
            if (node[1] == delHandle)                /* node+4 == delHandle -> found */
                break;
            prev = node;
            node = (int *)(size_t)(unsigned int)node[3];   /* node->next (+0xC) */
            if (node == 0)
                break;                               /* exhausted */
        }
    }
    if (node == 0)
        op->error = 1;                               /* empty / not found */

    if (prev == 0)
        gFileMgr.devicelist = 0;                     /* head case: clears the list head (see NOTE) */
    else
        prev[3] = node[3];                           /* mid-list: prev->next = node->next */

    purgememadr((void *)(size_t)(unsigned int)node[0]);    /* free the header buffer */
    purgememadr(node);                                     /* free the node */
    {
        unsigned int cid = FILE_close((void *)(size_t)(unsigned int)closeHandle,
                                      a2, (unsigned int)(size_t)op);  /* close op param = this command op */
        FILE_callbackop(cid, (void (*)(int, int))iFILE_delbigclosecallback);
    }
    return op->id;
}

/* ---- the device backend (fileio.obj @0x800F3xxx) + string helpers used by the dispatcher ---- */
extern "C" int   openfile(char *name, int flags, void *handle);  /* @0x800F3BE0 */
extern "C" int   closefile(int dev);                             /* @0x800F3E84 */
extern "C" int   readfile(int dev, int dest, int offset, int len);/* @0x800F3EE0 (async; completes via CD cb) */
extern "C" int   writefile(int dev, int buf, int offset, int len);/* @0x800F4020 (async) */
extern "C" int   getfilesize(int dev);                          /* @0x800F409C */
extern "C" int   locatebigentryz(void *bighdr, char *entry, int flags, int *outOffset, int *outSize); /* @0x800E5FFC */
extern "C" char *strchr(const char *s, int c);                  /* @0x800F6214 */
extern "C" char *strcpy(char *d, const char *s);                /* @0x800E5B28 */
extern "C" int   strcmp(const char *a, const char *b);          /* @0x800E5D7C */
extern "C" void  freehandle(FileHandle *h);                     /* @0x800ED2F0 (above) */

#define OPI(op, off)  (*(int *)((char *)(op) + (off)))          /* multipurpose op field at byte offset */

/* iFILE_ExecCommand @0x800ECB98 : the FILE-system command pump (the heart of the subsystem).  Runs inside
 *   an IRQ-disabled critical section.  (1) If `cmd` is non-null, inserts it into the priority-sorted
 *   pending queue (ascending by prio, reusing cmd->qnext as the walk cursor) and bumps the queued count
 *   (mgr.state).  (2) If an op is already in flight (mgr.curop != 0) it returns -- one op dispatches at a
 *   time.  (3) Otherwise it dequeues the head (if its prio fits under mgr.idmask), makes it the current op,
 *   and dispatches by op-type nibble into the device backend:
 *     open(2)/exists(8): parse a "volume|entry" name, openfile() the base, and -- for BIG-archive refs --
 *        locatebigentryz() the entry in each mounted device; type 8 just probes existence (close+free).
 *     close(3): closefile() a real file (not a BIG entry) then freehandle().
 *     read(4):  readfile() (async) -- BIG entries add the entry's base offset; len<=0 completes now.
 *     write(5): writefile() (async).   size(6): publish handle->size.   7/9/10: status-only completion.
 *   Synchronous ops finish via iFILE_CommandCompleteCallback(); async ops (read/write) return and are
 *   completed later by the device's CD callback.  (-m32-only verified: op stride 0x30 + qnext pointer.) */
extern "C" int iFILE_ExecCommand(void *cmdp)
{
    FileOp *cmd = (FileOp *)cmdp;
    int type, ccc;

    FILE_enterCS();                              /* cop0: disable IRQs */

    if (cmd != 0) {                              /* insert into the priority-sorted pending queue */
        FileOp *prev = 0;
        FileOp *qh   = gFileMgr.queuehead;
        if (qh == 0) {
            cmd->qnext = 0;
        } else {
            cmd->qnext = qh;
            for (;;) {
                FileOp *node = cmd->qnext;       /* cursor (cmd->qnext is reused as the walk pointer) */
                if (cmd->prio < node->prio)      /* insert before the first higher-prio op */
                    break;
                prev = node;
                if (node->qnext == 0) {          /* tail */
                    cmd->qnext = 0;
                    break;
                }
                cmd->qnext = node->qnext;        /* advance cursor */
            }
        }
        if (prev == 0) gFileMgr.queuehead = cmd;
        else           prev->qnext        = cmd;
        gFileMgr.state++;                        /* one more queued op */
    }

    if (gFileMgr.curop != 0) {                   /* an op is already being dispatched */
        FILE_leaveCS();
        return 0;
    }

    {                                            /* dequeue the head (if its prio fits under idmask) */
        FileOp *head = gFileMgr.queuehead;
        FileOp *pick = 0;
        if (head != 0 && !(gFileMgr.idmask < head->prio)) {
            gFileMgr.queuehead = head->qnext;
            gFileMgr.state--;
            pick = head;
        }
        gFileMgr.curop = pick;
        cmd = pick;
    }
    FILE_leaveCS();                              /* cop0: re-enable IRQs */

    if (cmd == 0)
        return 0;                                /* nothing to dispatch */

    type = (cmd->id >> 0x14) & 0xF;
    if (type < 2 || type > 10)                   /* op-type nibble must be 2..10 */
        return 0;

    {
        int  *handle = (int *)(size_t)(unsigned int)cmd->result24;   /* the open-file handle */
        ccc = 0;

        switch (type) {
        case 2:                                  /* open */
        case 8: {                                /* exists-probe */
            char *name = (char *)handle + 0x0C;  /* the filename (handle+0xC) */
            char *bar  = strchr(name, '|');      /* "volume|entry" separator? */
            char  volbuf[0x40], entrybuf[0x40];
            int   s2 = 0, s3;

            entrybuf[0] = 0;
            if (bar != 0) {
                s3 = 2;
                if (name[0] != '|') {            /* "volume|entry" -> split out the volume name */
                    int vollen = (int)(strchr(name, '|') - name);
                    s3 = 4;
                    volbuf[0] = 0;
                    strncpy(volbuf, name, vollen);
                    volbuf[vollen] = 0;
                }
                strcpy(entrybuf, strchr(name, '|') + 1);   /* entry = text after '|' */
            } else {
                s3 = 1;
                if (OPI(cmd, 0x18) & 1) {        /* flag bit 0 -> also search BIG archives */
                    s3 = 3;
                    strcpy(entrybuf, name);
                }
            }

            if (s3 & 1) {                        /* odd modes (1,3): open the plain file */
                if (openfile(name, OPI(cmd, 0x18), handle) != 0) {
                    s2 = 1;                      /* opened OK (asm: delay slot -> set for BOTH types) */
                    if (type == 8) closefile(handle[0]);         /* probe: open+close */
                    else           handle[1] = getfilesize(handle[0]); /* handle->size */
                }
            }

            if (s2 == 0 && (s3 & 6)) {           /* modes 2,3,4,6: search the mounted BIG archives */
                int *dev = (int *)gFileMgr.devicelist;
                while (dev != 0) {
                    int doLookup = 1;
                    if (s3 & 4) {                /* volume name must match this device's name */
                        int *devfh = (int *)(size_t)(unsigned int)dev[1];   /* dev->handle (+4) */
                        if (strcmp((char *)devfh + 0x0C, volbuf) != 0)
                            doLookup = 0;
                    }
                    if (doLookup) {
                        int off, sz;
                        if (locatebigentryz((void *)(size_t)(unsigned int)dev[0],
                                            entrybuf, 0, &off, &sz) != 0) {
                            handle[0] = (int)(size_t)dev;           /* handle->dev = this device node */
                            handle[1] = sz;                         /* handle->size  */
                            handle[2] = off;                        /* handle->flags = entry base offset */
                            s2 = 1;
                        }
                    }
                    dev = (int *)(size_t)(unsigned int)dev[3];      /* next device (+0xC) */
                    if (s2 != 0)
                        break;
                }
            }

            if (type == 8) {                     /* exists-probe: drop the handle, report found flag */
                freehandle((FileHandle *)handle);
                OPI(cmd, 0x18) = s2;
            }
            ccc = s2;
            break;
        }

        case 3:                                  /* close */
            cmd->error = 0;                      /* asm: delay slot -> cleared on BOTH paths */
            if (handle != 0) {
                if (handle[2] == 0)              /* real file (not a BIG entry) -> close the device */
                    cmd->error = closefile(handle[0]);
                freehandle((FileHandle *)handle);
                cmd->result24 = 0;
            }
            ccc = (cmd->error < 1);              /* falls through to the 7/9/10 completion in the asm */
            break;

        case 4: {                                /* read */
            int len = OPI(cmd, 0x1C);
            if (len <= 0) { ccc = 1; break; }    /* nothing to read -> complete now */
            if (handle[2] != 0) {                /* BIG entry: add the entry's base offset */
                int *dev   = (int *)(size_t)(unsigned int)handle[0];
                int *devfh = (int *)(size_t)(unsigned int)dev[1];   /* dev->handle (+4) */
                readfile(devfh[0], OPI(cmd, 0x20), handle[2] + OPI(cmd, 0x18), len);
            } else {                             /* real file */
                readfile(handle[0], OPI(cmd, 0x20), OPI(cmd, 0x18), len);
            }
            return 0;                            /* async: completes via the CD callback */
        }

        case 5:                                  /* write (async) */
            writefile(handle[0], OPI(cmd, 0x20), OPI(cmd, 0x18), OPI(cmd, 0x1C));
            return 0;

        case 6:                                  /* size */
            OPI(cmd, 0x18) = handle[1];          /* publish handle->size as the result (+0x18) */
            ccc = 1;
            break;

        case 7:                                  /* status-only completions */
        case 9:
        case 10:
            ccc = (cmd->error < 1);
            break;
        }
    }

    iFILE_CommandCompleteCallback(ccc);          /* finalize the current (synchronous) op */
    return 0;
}

#undef OPI

extern "C" { FileMgr gFileMgr; int gFileOpSeq; }  /* owning-TU defs (BSS) */

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
 *   remains, re-issue the next chunk; otherwise mark the transfer finished.
 *   Oracle trace fixes retained here: offset advances on every successful chunk (not only a
 *   short final chunk), the short-read test is signed, and remain is re-read for each clamp
 *   decision.  w31-a5: clamp rewritten if/else with slti-0x2001 polarity (oracle beqz + li-in-ds
 *   toward the 0x2000 arm) and the op store funneled through `r` (oracle tests the jalr $v0, not a
 *   reload) -- 46 diffs, 67/71 insns (count parity narrowed from -6 to -4; kept as a documented
 *   correctness improvement).
 *   RESIDUAL ANALYSIS (w31-a5, do not re-fight blindly): the oracle body (a) runs the advance
 *   phase as STRICTLY SERIAL single-scratch v0 chains with load-delay nops -- volatile access
 *   ordering, while ours interleaves two chains; (b) keeps a SECOND copy of the ctrl pointer
 *   (`addu s2,s1,zero` right after the completeop call) and bases the whole re-issue phase + the
 *   shared final remain=0 on s2 -- no source shape found that stops cc1 2.8.0 from copy-
 *   propagating a `ctrl = c` local away (volatile view, init-after-call, cast chains all tested);
 *   (c) has volatile-class stores sitting in branch delay slots (op=0, offset+=, op=r), which
 *   gcc's reorg refuses for volatile MEMs -- the aspsx-fills-blind identity (methodology 3.25 3b/
 *   3c).  A full-volatile one-pointer body reproduces (a) exactly (72/71 insns) but loses the
 *   piecewise-volatile ds-store matches -- net worse (57 diffs); the s1/s2 split alone is worth
 *   ~20 rename diffs and looks like an inlined-helper or assembler-era artifact.  Suspected
 *   partial identity floor.
 *   w32-a3 CONFIRMS the (b) verdict with the IDA register annotations (nfs4-psx-IDA.c
 *   sub_800EA6CC): retail's locals are `v5 // $a0` (the completeop result) plus two $v0 temps --
 *   the control block is the plain parameter, ONE variable, dereferenced throughout.  There is no
 *   second ctrl-pointer variable in the source: the oracle's `addu s2,s1,zero` (with `sw s2,32(sp)`
 *   in the completeop jal delay slot, i.e. a pseudo BORN AFTER the call) is retail cc1 splitting
 *   that single pointer's live range at the `remain > 0` join -- the same redundant-copy artifact
 *   as nfile.c's reservehandle / FILE_completeop / FILE_cancelop / FILE_operror, which our cc1
 *   always copy-propagates away.  Also falsified this wave for (a): -fno-schedule-insns is NOT this
 *   obj's identity -- it makes synccallback WORSE (59 diffs, 72 insns) and regresses the
 *   neighbouring syncblockio (PASS -> 9 diffs), so the serial single-scratch chains are not an
 *   unscheduled-cc1 signature.  => partial per-obj old-gcc no-copy-prop identity (methodology 3.25
 *   / catalog §G); source-reachable ceiling is roughly the non-rename half of the residual.
 *   w32-a3 CHANGE for (a): the three advance accumulates are now written through the volatile view
 *   (`*(volatile int *)&c->buf += done;` etc.) -- the SyncCtrl block is async/IRQ-written (the
 *   remain re-reads below already model that, methodology 3.12 #13), and volatile MEM ordering is
 *   what produces the oracle's STRICTLY SERIAL `lw; nop; addu; sw` chains.  The buf chain now
 *   matches the oracle instruction-for-instruction and the count gap narrows -4 -> -2 (67 -> 69 of
 *   71) at an unchanged 46 diffs -- a documented correctness improvement, not a diff win (the
 *   residual is dominated by the s1/s2 rename of (b)).  Falsified around it: volatile on buf+done
 *   only, leaving offset plain (68 insns / 49 diffs), and additionally volatilizing the `c->chunk`
 *   read in the short-transfer test (72 insns / 57 diffs -- it also blocks the offset store from
 *   the beqz delay slot, which is point (c)).
 *   w34-a3 (46 -> 21, insn gap -2 -> +1): the (b) verdict is OVERTURNED -- the second ctrl
 *   pointer IS source-reachable, via cse.c make_regs_eqv.  gcc-2.8 cse makes the COPY (`new`)
 *   canonical -- i.e. keeps the copy insn and rewrites the SOURCE reg's later uses onto it --
 *   only when BOTH (1) `new` lives past the end of the current cse extended basic block, and
 *   (2) last_uid(new) > last_uid(firstr).  w32/w33 rewrote the WHOLE re-issue phase + the shared
 *   remain=0 on the second pointer, which makes it die inside the same EBB pieces cse is already
 *   walking, so it was copy-propagated away every time.  The form that survives is a TAIL-ONLY
 *   `t`: declare `SyncCtrl *t;`, assign `t = c;` immediately after FILE_completeop, and use it at
 *   EXACTLY ONE site -- the shared `t->remain = 0;` at the very end (a 2-referenced label, so a
 *   fresh EBB, so condition (1) holds and c's last use precedes it, so does (2)).  cse then keeps
 *   `addu s?,s?,zero` AND rewrites the advance phase onto the copy, giving the oracle's TWO
 *   callee-saved ctrl registers with the oracle's own body register numbers ($s1 advance /
 *   $s2 re-issue) -- 46 -> 21 diffs.
 *   RESIDUAL 21 = the copy's DIRECTION: ours makes the param HOME $s2 and the copy $s1 (the copy
 *   inherits the advance phase, the home keeps the re-issue phase), retail has home $s1 / copy $s2
 *   (home keeps the advance, copy takes re-issue AND the tail).  Reaching retail's grouping needs
 *   the tail and the re-issue phase on the SAME pointer while the advance stays on the param --
 *   mutually exclusive under make_regs_eqv: if `t` also covers the re-issue phase it outlives `c`
 *   inside EBB1 and absorbs the advance too (w33-a1's 70); if the tail goes back on `c`, `t` has no
 *   post-EBB use and the copy dies.  Measured this wave: tail-only 21 (kept) / +`t->op = r` 23 /
 *   re-issue-on-t-with-tail-on-c 61 / `t = c` as an initialiser before the call 61 / clamp funnel
 *   temp 25 (70 insns) / clamp ternary 29 (70 insns).
 *   w33-a1: (i) the SLD line-tracing lever is NOT AVAILABLE for this TU -- the trusted SYM
 *   carries `Set SLD to line N of file ...` records for only 194 source files, all GAME/FRONTEND
 *   plus exactly ONE eaclib member (PAD.C); every other eaclib/syslib .lib member was linked
 *   debug-stripped, so there is no statement segmentation to read for syncfile/nsync/cdfs.
 *   (ii) Re-tested the (b) verdict with a TAIL-ONLY second pointer (`SyncCtrl *t;` assigned
 *   AFTER the completeop call, whole re-issue phase + the shared remain=0 rewritten on t): cc1
 *   copy-propagates it away and the extra allocno reshuffles s0/s1 -- 70 diffs, still 69 insns.
 *   The s1/s2 split remains a no-copy-prop identity artifact.
 *   w49-a3 (21 -> 19, 72/71): TWO cooperating zero-insn devices, both catalog-grammar.
 *   (1) the OPACITY/IDENTITY FENCE `__asm__("" : "=r"(t) : "0"(t))` (catalog w47 3rd fence
 *       mode) placed right AFTER the completeop call stops cse's make_regs_eqv from proving
 *       t == c, so the copy survives as a genuinely distinct pseudo and the phase split below
 *       (advance on the param, re-issue + tail on the copy) is honoured instead of being
 *       collapsed onto whichever pointer outlives the other;
 *   (2) `t = c;` is hoisted ABOVE the completeop call (live-range LENGTHENING = the demote
 *       direction of the allocno dial) -- the copy then loses the priority race it used to win.
 *   MEASURED MATRIX this wave (fence x t=c-position x which-phase-on-t):
 *       fence + before-call + re-issue-on-t ............ 19  @72  <- KEPT
 *       fence + before-call + tail-only-t ...............43  @72
 *       fence + before-call + re-issue-on-t + fence-before-call .. 18 @73 (count worse, rejected)
 *       fence + after-call  + re-issue-on-t ............ 63  @72
 *       fence + after-call  + re-issue-on-t + do{}while(0) on the 3 advance accumulates .. 22 @75
 *           (the wrapper's ref dial DOES flip s1/s2 to the oracle's exact assignment and the
 *            whole prologue matches -- but its NOTE_INSN_LOOP_BEG barrier costs +4 insns:
 *            `done` lands in $v1 not $a0 and the c->chunk read can no longer fill the offset
 *            load's delay slot.  A zero-insn inflator delivering the same +refs on `c` would
 *            land the prologue; a 2-statement wrapper is not enough (60 @73).)
 *       fence-on-c instead of t ........................ 75  @70
 *       no fence + before-call + re-issue-on-t ......... 46  @69
 *   RESIDUAL 19 = (a) the copy DIRECTION/prologue-save order (4: ours param->$s2 copy->$s1,
 *   retail param->$s1 copy->$s2 -- an allocno priority swap; retail's numbers are refs 11/live 44
 *   for `c` vs 13/59 for `t`, pri .75 vs .66) and (b) the c->chunk read not filling the offset
 *   load's delay slot (the rest).  Both are ref/live dials away; see the wrapper row above for
 *   the proof that (a) IS reachable. */
extern void synccallback(int op, int type, SyncCtrl *c)
{
    SyncCtrl *t;
    unsigned int done;
    t = c;
    done = FILE_completeop((unsigned int)op);
    __asm__("" : "=r"(t) : "0"(t));
    c->op = 0;
    if (type == 1) {
        *(volatile int *)&c->buf    += done;
        *(volatile int *)&c->done   += done;
        *(volatile int *)&c->offset += done;
        if ((int)done < c->chunk) {                 /* short transfer => this was the last chunk */
            *(volatile int *)&c->remain = 0;
        } else {
            c->remain -= done;
        }
        if (0 < *(volatile int *)&t->remain) {
            int r;
            if (*(volatile int *)&t->remain < 0x2001)   /* if/else, slti polarity: beqz -> 0x2000 arm */
                t->chunk = *(volatile int *)&t->remain;
            else
                t->chunk = 0x2000;
            r = t->iofn(t->fd, t->buf, t->offset, t->chunk, t->cbarg, t);
            t->op = r;                              /* sw in the jalr-test branch delay slot */
            if (r != 0) {
                FILE_callbackop((unsigned int)r, (void *)synccallback);
                return;
            }
        } else {
            return;
        }
    }
    t->remain = 0;
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

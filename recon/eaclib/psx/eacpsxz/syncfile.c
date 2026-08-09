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
 *   synccallback   def 19 | 2.6.0 30 | 2.6.3 30 | 2.7.2-970404 25 | 2.7.2 29 | 2.8.1 19 | 2.91.66 37 | 2.95.2 20
 */
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
 *   the proof that (a) IS reachable.
 *   w50-a4 -- the "zero-insn +refs on `c`" hunt, with numbers.  The CHEAPEST wrapper is a
 *   ONE-STATEMENT depth wrapper on a single advance accumulate (`do { *(volatile int *)&c->buf +=
 *   done; } while (0);` -- or the same on `c->done`): 19 -> 14 diffs and the WHOLE BODY register
 *   map becomes retail-exact (advance on $s1, re-issue on $s2, every body insn identical); the
 *   residual 14 is then only (i) the PROLOGUE pair -- ours saves/copies param->$s2, copy->$s1,
 *   retail param->$s1, copy->$s2 -- and (ii) TWO delay-slot fills the LOOP_BEG/END notes cost
 *   (`sw c->offset` no longer lands in the short-transfer `beqz` slot, and the re-issue `sw
 *   t->chunk` no longer lands in the `j` slot), i.e. 73 insns vs 71.  NOT ADOPTED: it buys the
 *   map with +2 real instructions, so the honest 72/71 baseline is kept; the wrapper's value is
 *   as PROOF that the whole residual is ONE allocno dial plus two scheduling slots.
 *   ARM-DUPLICATION (the zero-insn alternative the briefing named) does NOT reach it here: there
 *   is no cross-jumpable identical TAIL that references `c` -- the only shared tail is
 *   `t->remain = 0;` (wrong pointer: duplicating it measures 19 @72, unchanged), and hoisting
 *   `c->op = 0;` into both arms of `if (type == 1)` is a HEAD, not a tail, so cross_jump cannot
 *   merge it (24 @73).  Also falsified this wave, all at 72/71: moving refs from `t` to `c` (they
 *   alias, so it is a pure ref dial) at the remain guard (21), the clamp (23), the guard+clamp
 *   (25), all five iofn args (31), the fd arg alone (53), and the tail (61); wrapping `c->op = 0`
 *   (19) or the `c->remain -= done` else-arm (19) -- both outside the advance chain, no effect;
 *   wrapping two accumulates (14 @73) or nesting the wrapper twice (14 @73) -- no extra depth
 *   gain, the flr2 step is already crossed by depth 1. */
extern void synccallback(int op, int type, SyncCtrl *c)
{
    SyncCtrl *t;
    unsigned int done;
    t = c;
    done = FILE_completeop((unsigned int)op);
    __asm__("" : "=r"(t) : "0"(t));
    /* MATCH (w53-a10, 19 -> 17 at the same 72/71): the W52 FENCE-DIAL LAW supplies the
     * "zero-insn +refs on `c`" instrument the w50-a4 receipt above was hunting.  An IDENTITY
     * fence is a def+use pair, i.e. +2 REG_N_REFS at zero instructions -- the do{}while(0)
     * wrapper's ref effect WITHOUT its NOTE_INSN_LOOP_BEG barrier (which cost +2 insns).
     * Placement is load-bearing: AFTER the `t` fence = 17 @72/71 (kept); BEFORE it = 75 @70
     * (the `t` copy is eliminated again); at the type==1 head = 17 @72/71 (equivalent);
     * after the three advance accumulates = 28 @75.  A 2nd/3rd identity fence on `c` adds
     * nothing (17, flat) -- one crossing of the flr2 step is all the dial has.
     * RESIDUAL 17 is the SAME two items the w50-a4 note isolated: (a) the prologue pair (ours
     * param -> $s2, copy -> $s1; retail param -> $s1, copy -> $s2) and (b) two delay-slot fills.
     * Falsified on top of the c-fence, all 17 @72/71: a read-only DEMOTE fence on `t` at the tail
     * or right after its own fence; a 2nd/3rd identity fence on `c`; an identity fence on `c` at
     * the type==1 head or before the remain guard.  The w50 do{}while(0) wrapper still STACKS with
     * it -- c-fence + a wrapper on the buf (or done) accumulate gates 12 @73/71, i.e. 2 better than
     * the wrapper alone -- but it still costs the same +2 real instructions, so the count-exact
     * 72/71 baseline is kept per the standing decision in that note.
     * PER-OBJ FLAG AXIS CLOSED for syncfile.c (21 cc1 flags x all 8 fns): control 17 total / 7
     * PASS and thirteen flags inert; every other flag is worse in TU total (-fno-force-mem 21,
     * -mno-split-addresses 27, -fno-schedule-insns 51, -fno-schedule-insns2 70, both 104,
     * -fno-delayed-branch 121).  ONE PER-FUNCTION OPPORTUNITY worth recording:
     * -fno-schedule-insns2 takes synccallback ALONE 17 -> 16 while costing the other seven fns
     * 7 PASS, so it is reachable only through a PER-FUNCTION dual-compile splice (build.py's
     * _apply_fn_splice family, which currently wires only -fno-delayed-branch / -fno-thread-jumps
     * / -fforce-addr).  1 diff for a new table -- recorded, not requested. */
    __asm__("" : "=r"(c) : "0"(c));
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

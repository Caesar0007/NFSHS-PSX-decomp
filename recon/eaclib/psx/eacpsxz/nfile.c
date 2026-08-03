/* eaclib/psx/eacpsxz/nfile.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** WIP ***
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
 *   w34-a1 ORACLE-AVAILABILITY NOTE: the NFS2 PC-beta named-source oracle (C:/Temp/nfs2-clean/
 *   pc-beta) does NOT cover this TU -- the FILE_ op-queue/handle-table generation does not
 *   exist in that build.  Checked: pc-split/INDEX.csv has no reserveop/reservehandle/freeop/
 *   FILE_op-anything/ExecCommand entry, nfsw.IDA.c has 0 hits for any of those names, nfs2-v1.txt
 *   (Watcom SYM) shows the NFS2 file layer is winfile/async.obj/fileio.obj/blockio.obj/queue.obj
 *   (_openhandle/_asyncread/_qinsert/...), a different API generation.  Together with the SLD
 *   census (w33: nfile.obj is a debug-stripped eacpsxz.lib member with ZERO line records) this
 *   TU has NO independent source-shape oracle -- only the raw .s + the cc1 RTL dumps.
 *   The FILE manager singleton lives @0x8013EA88 (gFileMgr): opcount/handlecount/idmask + oparray
 *   (0x30-byte FileOp slots) + handlearray (0x4C-byte FileHandle slots).  Slot alloc/free run inside
 *   a PSX interrupt-disabled critical section.
 */
#include "../../../lib/nfile.h"

/* iFILE critical section -- raw cop0 SR mask/restore (NOT a BIOS syscall).  The oracle inlines this
 * exact sequence (mfc0/and-mask/mtc0, three trailing nops for the mtc0-writeback hazard) at every
 * FILE_enterCS/FILE_leaveCS call site rather than calling a real function -- nfile.h's FILE_enterCS()/
 * FILE_leaveCS() declarations (void->void, no SR threaded through) can't express that shape, so this TU
 * bypasses them with a local macro pair that threads the saved SR through a real C local (survives
 * across any jal in the critical section, exactly like the oracle's per-fn s0/a3/t5/t1/a2/t9 choice).
 * Mask -0x402 clears bits 0x400+0x2 of SR (IEc + one IM bit) -- same constant at every call site. */
#if defined(__mips__)
#define FILE_CS_ENTER(saved) \
    __asm__ volatile("mfc0 %0,$12\n\t nop\n\t addiu $at,$zero,-0x402\n\t and $8,%0,$at\n\t mtc0 $8,$12\n\t nop\n\t nop\n\t nop" \
                      : "=r"(saved) : : "at", "t0")
#define FILE_CS_LEAVE(saved) __asm__ volatile("mtc0 %0,$12" : : "r"(saved))
#else
#define FILE_CS_ENTER(saved) ((void)(saved = 0))
#define FILE_CS_LEAVE(saved) ((void)(saved))
#endif

/* freeop @0x800ED1F8 : clear a 0x30-byte op slot (release it back to the pool). */
extern void freeop(FileOp *op)
{
    int sr;
    FILE_CS_ENTER(sr);
    blockclear(op, 0x30);
    FILE_CS_LEAVE(sr);
}

/* freehandle @0x800ED2F0 : clear a 0x4C-byte file handle (release it). */
extern void freehandle(FileHandle *h)
{
    int sr;
    FILE_CS_ENTER(sr);
    blockclear(h, 0x4C);
    FILE_CS_LEAVE(sr);
}

/* reservehandle @0x800ED240 : find a free (inuse==0) handle slot, mark it used, return it (0 if none).
 * asm: walks a pointer (not an indexed array) to find the slot but, after leaving the CS, RECOMPUTES
 * the found slot's address from the loop COUNTER alone (handlearray + i*0x4C) rather than carrying the
 * walking pointer out -- so the C tracks only the index `i`, never a separate result pointer.
 * w31-a5 (29->17 diffs, 43/44): the loop is a guarded do/while with a TWO-VARIABLE walk --
 * `cur = next` at the top (oracle `addu v1,a1,zero` per iteration), advance `next = cur + 0x4C`
 * in the back-edge delay slot -- and the scan bound is a BLOCK-LOCAL re-read of handlecount
 * inside the guard (`if (gFileMgr.handlecount > 0) { int count = gFileMgr.handlecount; ... }`):
 * cc1's CSE turns the re-read into the oracle's register COPY `addu a2,v1,zero` (lazy-copy
 * family, catalog DrawW row).  This un-rotates the loop and recovers the bottom `i < count` test.
 * RESIDUAL 17: one allocator web -- ours coalesces the cur/next pair into one walker reg (43 vs
 * 44, the lone missing `addu v1,a1,zero`) and colors sr->a2/count->a1 where retail has sr->a3/
 * count->a2 (mfc0 scratch tie).
 * w32-a3 -- SETTLED by the IDA register annotations (nfs4-psx-IDA.c sub_800ED240): retail's
 * locals are `v0 // $a3` (saved SR), `v1 // $a0` (i) and `v2 // $a1` -- ONE walker pointer, in
 * $a1, with the loop written `while (*v2 != 0) { ++v1; v2 += 19; if (v1 >= count) goto out; }
 * *v2 = 1;`.  So the oracle's second walker register ($v1, fed by `addu v1,a1,zero` at the top of
 * the loop) is NOT a source-level variable: it is retail cc1 SPLITTING the single pointer's live
 * range with a redundant copy, which our cc1 always coalesces (any C form with two pointers is
 * copy-propagated back to one -- cur and next hold the same value at every program point, so no
 * legal C can keep them apart).  That lone extra pseudo is the whole 17: with it, the ripple is
 * cur->v1 / next->a1 / count->a2 / sr->a3 = retail exactly.  Falsified this wave: the literal IDA
 * one-pointer while+goto shape (27 diffs, 47 insns -- worse), and cc1 flags -fno-schedule-insns /
 * -fno-cse-follow-jumps / -fno-cse-skip-blocks / -fno-rerun-cse-after-loop / -fno-thread-jumps /
 * -fno-caller-saves / -fno-strength-reduce / -fno-expensive-optimizations (all no movement).
 * w33-a3 -- the "no legal C can keep them apart" verdict is now KNOWN TO BE TOO STRONG for this
 * SHAPE class: the identical loop-head copy in callback.c allocmutex WAS cracked from source, as a
 * loop.c GIV ANCHOR (index form with TWO references to the same element -- the test load and the
 * flag store -- makes gcc 2.8 build two address givs and derive the second from the last one in
 * body order with a +0 `move`, advancing the walker FROM the anchor).  That is exactly this
 * oracle's `addu v1,a1,zero` + `addiu a1,v1,0x4C`.  It does NOT transfer here for a MECHANICAL
 * reason: FileHandle stride is 0x4C, not a power of two, and our cc1's loop.c refuses to
 * strength-reduce `ha[i]` at that stride -- index form emits the 76-multiply inside the loop and
 * peels iteration 0 (55 insns / 25-31 diffs across three spellings tried: bare
 * gFileMgr.handlearray[i], hoisted-base ha[i], and the anti-peel `for(;;i++)` form).  So the
 * residual is "our loop.c is weaker at SR", not "retail keeps a redundant copy".  Retest index
 * form if the SR behaviour ever changes.
 * w33-a3 -- SLD LINE TRACING IS UNAVAILABLE FOR THIS TU: nfile.obj is a debug-stripped
 * eacpsxz.lib member.  nfs4-f-v3.txt carries only the `Def class FILE ... eacpsxz.lib(nfile.obj)`
 * marker PAIR with ZERO line records between them, and a VA-range scan of every 0x80-0x89 SLD
 * opcode over 0x800EBDC4-0x800ED2F0 returns nothing.  Statement segmentation cannot be read off
 * the SYM for anything in eaclib except the 16 C:\LIB\PSX\*.ASM members and EACLIB\PSX\PAD.C.
 * => still a floor, but now for a NAMED compiler reason (loop.c SR at non-power-of-2 stride),
 * not the blanket "per-obj no-copy-prop identity". */
extern FileHandle *reservehandle(void)
{
    int i, sr;
    FILE_CS_ENTER(sr);
    i = 0;
    if (gFileMgr.handlecount > 0) {
        int count = gFileMgr.handlecount;  /* CSE turns this re-read into the oracle's reg COPY */
        FileHandle *next = gFileMgr.handlearray;
        do {
            FileHandle *cur = next;        /* two-var walk: cur (v1) = next (a1) each iteration */
            if (cur->inuse == 0) {         /* first empty slot */
                next->inuse = 1;           /* == cur here; the oracle stores via the a1/next reg */
                break;
            }
            i++;
            next = (FileHandle *)((char *)cur + 0x4C);  /* back-edge delay slot */
            /* w47-a1 (17 -> 3, 43 -> 45 vs 44): the USE FENCE cracks the "no legal C can keep
             * cur and next apart" verdict above.  Holding `cur` live PAST the advance makes the
             * two pointers simultaneously live with DIFFERENT values, so cc1 can no longer
             * copy-propagate them into one walker: retail's loop-head `addu v1,a1,zero` appears
             * and the whole cur/next/count/sr web (v1/a1/a2/a3) lands exactly on retail's.
             * Zero insns (cur is register-resident, w45 cost profile).
             * RESIDUAL 3 = ours is ONE insn LONGER: the fence is a scheduling barrier, so
             * reorg cannot do the SIMPLE fill of the `bnez` delay slot with the advance
             * (retail's `addiu a1,v1,76`) and instead EAGER-STEALS the branch target's first
             * insn -- a duplicate of the loop-head copy -- into the slot (w45 fence/reorg
             * mechanism).  Moving the fence ABOVE the advance frees the simple fill and gets
             * the count exact 44/44, but the copy then lands after the beqz and the whole a-band
             * rotates (24 diffs).  NEXT ANGLE: a split-forcing device that is NOT a scheduling
             * barrier (the pair is 44/44-reachable, so only the fence's barrier property is in
             * the way). */
            __asm__("" : : "r"(cur));
        } while (i < count);
    }
    FILE_CS_LEAVE(sr);
    if (i == gFileMgr.handlecount)
        return 0;
    return (FileHandle *)((char *)gFileMgr.handlearray + i * 0x4C);
}

/* reserveop @0x800ED0DC : claim a free op slot, stamp it with op index + a fresh 20-bit request id.
 * asm: same shape as reservehandle -- walks a pointer to find the slot but, after leaving the CS,
 * RECOMPUTES the slot's address from the loop COUNTER alone (oparray + i*0x30); the C tracks only `i`. */
/* the oracle re-derives the slot address FRESH from gFileMgr.oparray (a real memory reload, not a
 * cached pointer) at each of the id-field mutation sites below -- only the VERY FIRST combine
 * (the type-nibble set) reuses the address+value already computed for the free-check condition;
 * the byte3 store and the seq-combine store each redo `oparray + off` from scratch (2 extra
 * lui/lw/addu-shaped reloads the oracle has that a single persistent `op` local doesn't produce).
 * A persistent manager base plus fresh `mgr->oparray + off` expressions preserves those reloads.
 * Hoisting the four id masks first improved the detailed residual 97->88.  Matching the raw
 * unrotated do/while CFG, re-reading opcount at the back edge, and ordering the independent
 * offset/index updates so the count load's delay slot is filled reduce it further to 46 diffs
 * with the exact 71/71 instruction count.  `off` remains the oracle's byte-offset induction
 * variable; the remaining residual is one allocator cycle among off/slot/base/seq-mask.
 * w32-a3: IDA (sub_800ED0DC) gives retail's variable->register map -- `v0 // $t5` (saved SR),
 * `v1 // $a2` (i), `v2 // $a1` (the BYTE OFFSET) -- and, decisively, writes every slot access as
 * `*(_DWORD *)(v2 + dword_8013EAA0)`: the OFFSET is the FIRST addu operand, matching the oracle's
 * `addu a0,a1,v0` / `addu v0,a1,v0`.  The four slot expressions below are therefore written
 * offset-first (`(FileOp *)(off + (int)gFileMgr.oparray)`); that flips our `addu rD,base,off` to
 * the oracle's `addu rD,off,base` at both sites (diff-neutral 46->46 -- kept as an oracle-proven
 * correctness alignment, catalog §5.0c commutative-addu lever, so those two lines stop reading as
 * unexplained).  Retail has NO named slot-pointer local and no mask/constant locals; the residual
 * is the allocation order (retail off->a1 + slot-temp->a0 + seqMask->a3, ours off->a0 +
 * slot->a1 + seqMask->t1).  Falsified: masked-value-first statement order in the seq combine
 * (52 diffs).
 * w34-a1 -- the allocation order is now QUANTIFIED and REPRODUCIBLE from the -dg dump, so the
 * remaining 46 is a two-swap problem, not a mystery.  global.c hands out REG_ALLOC_ORDER
 * (v0,v1,a0,a1,a2,a3,t0,t1,...) in descending QTY_CMP_PRI = floor_log2(refs)*refs/live_len, with
 * in-loop refs counted DOUBLE; feeding this fn's own dump numbers reproduces its printed
 * ";; 13 regs to allocate" list EXACTLY (94:2.4 > 82:1.5 = 90:1.5 > 80:0.73 > 91:0.37 > 92:0.31
 * > 88:0.29 > ...).  Retail's registers imply the order [slot, off, i, seqMask, mgrbase, hicopy]
 * where ours is [off, slot, i, mgrbase, hicopy, seqMask] -- i.e. TWO flips are needed:
 *   (1) slot(6 refs/8 insns) must beat off(11 refs/22) -- they are an EXACT 1.5 tie today;
 *   (2) seqMask(5 refs/34) must beat mgrbase(7 refs/38), i.e. either a 3rd in-loop seqMask
 *       reference (none exists: the oracle uses it exactly twice, `and`+`slt`) or a mgrbase
 *       live range > 1.4x longer (its def cannot move earlier without changing the head).
 * Falsified this wave, all with numbers: `FileMgr *mgr = &gFileMgr;` as the first statement in
 * the guard (51 diffs, 72 insns -- it DOES put base->t0, seqMask->a3, i->a2 = retail, and the
 * base is materialized before the constants like the oracle, but gcc then needs THREE address
 * insns: losum-from-%hi, a copy of the base, AND a separate %hi copy for the back-edge opcount
 * load, where retail derives the base FROM the single %hi copy); the same plus a back-edge
 * `mgr->opcount` (74, restructures the guard); literal masks instead of the four constant
 * locals (52 -- but note it DOES hoist the base+%hi-copy into the oracle's position and makes
 * the back-edge `lw v0,0(t1)` match, so the constants-as-locals are what pin the base late);
 * seq-combine operand swap `(gFileOpSeq & seqMask) | (id & keepType)` (54); literals + that
 * swap (50).  Next lever to try: something that lengthens the mgrbase live range or shortens
 * seqMask's WITHOUT adding an insn. */
/* w35-a5 -- 46 -> 40 (71/71), and the w34 "two flips" verdict is REFUTED for BOTH flips.
 * (1) FLIP 1 LANDED, honest C: read the sequence counter into a guard-local ONCE
 *     (`unsigned int seq = gFileOpSeq;` as the first statement of the free-slot guard, used by
 *     the id-combine; the wrap keeps `++gFileOpSeq`).  That lengthens `off`'s live range by one
 *     insn (22 -> 23), which is enough to break the EXACT 1.5 priority tie in slot's favour:
 *     slot 6 refs/8 = 2*6/8 = 1.500 vs off 11 refs/23 = 3*11/23 = 1.435 (was 11/22 = 1.500,
 *     and a tie goes to the LOWER allocno number = off).  The -dg list flips to
 *     `94 90 82 80 91 92 88` = retail's [slot, off, i, ...] and slot lands in $a0 like retail;
 *     mgrbase also moves to retail's $t0 and the whole seq/id block (lw 24(t0) x2, addiu v1,v1,1,
 *     sw v1,0(gp), or v0,v0,a1) becomes instruction-identical.  Residual 40 = the tail of the
 *     permutation: off $a2 (retail $a1), i $a3 ($a2), seqMask $t1 ($a3), hicopy $a1 ($t1).
 * (2) FLIP 2 (seqMask must beat mgrbase) IS ALSO REACHABLE -- via the w35 IN-LOOP-DEF REF DIAL:
 *     declaring seqMask uninitialised and assigning `seqMask = 0xFFFFFu;` as the first statement
 *     INSIDE the do-loop leaves the code identical (loop.c hoists the invariant back into the
 *     pre-header) but the def is then counted at loop depth, so REG_N_REFS goes 5 -> 6 and the
 *     -dg order becomes EXACTLY retail's `... 90 82 80 88 91 92` = [slot, off, i, seqMask,
 *     mgrbase, hicopy].  So the w34 note's "either a 3rd in-loop seqMask reference (none exists)
 *     or a 1.4x longer mgrbase live range" dichotomy was FALSE -- the dial supplies the extra
 *     weighted ref with zero instructions.  Arithmetic without the dial: seqMask 5/35 = 0.286,
 *     mgrbase 7/40 = 0.350, hicopy 4/26 = 0.308.
 *     BUT the dial COSTS more than it buys here (46 vs 40), for two NAMED reasons, both new:
 *       (a) loop.c emits the hoisted movable at the END of the pre-header, so the seqMask
 *           lui/ori moves from retail's slot (3rd constant) to after the base materialisation
 *           = 2 unconditional diffs;
 *       (b) the ordering win is then eaten by LOCAL-alloc: the block-local pair {oparray reload,
 *           slot address} is pre-assigned $a1, so `off`/`i`/`seqMask` all carry a hard-reg-5
 *           conflict (see the ";; NN conflicts: ... 2 5 29" lines in the -dg dump) and global
 *           alloc cannot give `off` retail's $a1 no matter what the allocno ORDER is.
 *     Retail's local-alloc instead put that pair in $a0 and the masked-seq value in $a1, which
 *     it can only do if the `and seq,seqMask` is SCHEDULED BEFORE the `addiu seq,seq,1` (then the
 *     seq load dies into the addiu and the addiu re-uses $v1, freeing $a0).  Ours always picks the
 *     addiu at that ready-list slot.  ==> THE REMAINING BLOCKER IS ONE SCHED1 READY-LIST TIE,
 *     not the allocno order.  Falsified this wave for that tie (all at 71/71 unless noted):
 *     splitting `++` out of the `if` (54); a `seq`/`next` pair with the store BEFORE the combine
 *     (54); a guard-top `seqv = gFileOpSeq & seqMask` (46); or-operand swap on top of the head
 *     hoist (44); all-literal constants (52); literals + the dial (52); `gFileOpSeq = seq + 1`
 *     with the wrap re-reading the global (45, 70 insns -- loses the second load).
 *     Also measured but REJECTED as scaffolding: hoisting `seqv = gFileOpSeq & 0xFFFFFu;` to the
 *     TOP OF THE LOOP BODY (i.e. computing it on iterations that never use it) reaches 44 at
 *     71/71, and without the seqMask dial 34 at 73/71 -- both introduce a cross-block `seqv`
 *     allocno retail does not have, which then steals retail's $a3 from seqMask.  Not kept. */

extern FileOp *reserveop(void)
{
    int i, sr, off;
    FILE_CS_ENTER(sr);
    i = 0;
    if (gFileMgr.opcount > 0) {
        unsigned int clearType = 0xFF0FFFFFu;
        unsigned int setType = 0x100000u;
        unsigned int seqMask = 0xFFFFFu;
        unsigned int keepType = 0xFFF00000u;
        off = 0;
        do {
            FileOp *op = (FileOp *)(off + (int)gFileMgr.oparray);
            if (((op->id >> 0x14) & 0xF) == 0) {
                unsigned int seq = gFileOpSeq;
                op->id = (op->id & clearType) | setType; /* set type nibble = 1 */
                ((unsigned char *)&((FileOp *)(off + (int)gFileMgr.oparray))->id)[3] =
                    (unsigned char)i;  /* byte3 = op index */
                ((FileOp *)(off + (int)gFileMgr.oparray))->id =
                    (((FileOp *)(off + (int)gFileMgr.oparray))->id & keepType) |
                    (seq & seqMask); /* bits 0-19 = request seq */
                if (++gFileOpSeq > (int)seqMask)             /* 20-bit wrap */
                    gFileOpSeq = 0;
                break;
            }
            off += 0x30;
            i++;
        } while (i < gFileMgr.opcount);
    }
    FILE_CS_LEAVE(sr);
    if (i == gFileMgr.opcount)
        return 0;
    return (FileOp *)((char *)gFileMgr.oparray + i * 0x30);
}

/* FILE_overhead @0x800EBD74 : total RAM the FILE system needs for the given pool sizes (0 -> default). */
extern int FILE_overhead(int handlecount, int memsize, int opcount)
{
    if (handlecount == 0) handlecount = 0x18;     /* 24 handles  */
    if (memsize == 0)     memsize     = 0x800;    /* 2 KB io mem */
    if (opcount == 0)     opcount     = 0xA;      /* 10 ops      */
    /* MATCH: keep the source in natural per-pool byte costs.  GCC strength-reduces the 0x30 and
     * 0x50 terms into the retail shared shift while retaining the oracle's v0/v1 allocation. */
    return 0x30 * opcount + 0x50 * handlecount + 0x14 * memsize;
}

/* FILE_opstatus @0x800EBDC4 : status of the op named by `id` (index=id>>24); -3 if id is 0 or stale. */
extern int FILE_opstatus(unsigned int id)
{
    volatile int frame[3];
    /* MATCH: positive-branch form (lever #7) -- the match test jumps FORWARD to the success
     * return; the -3 "stale/invalid id" return is the shared fallthrough/jump target.
     * The unused volatile three-word aggregate recovers the oracle's otherwise unexplained
     * 16-byte leaf frame (including its branch delay-slot allocation). The only residual is
     * an equivalent addu a0,v1,v0 vs addu a0,v0,v1 operand-order allocator tie-break.
     * 🆕 wave-21 NEGATIVE RESULTS (both reverted, both WORSE): (1) factoring the shared
     * `oparray+(id>>24)*0x30` index-math (byte-identical across opstatus/operror/callbackop/
     * completeop/priorityop) into a `static`/`static __inline__` helper -- non-inline emits a
     * real out-of-line `jal` (22 insns, wrong shape entirely); `__inline__` fully substitutes
     * with ZERO stack-frame footprint (no phantom appears), same 21-insn shape as direct
     * inline, ruling out "tree-inlined helper leaves a residual frame" for this compiler.
     * (2) merging both `return` sites into a single `result; goto tail;` shared epilogue (the
     * shape the oracle visually has) -- gcc picks $a3 for `result` + flips branch polarity
     * (bne) instead of adopting the oracle's exact form; 12 diffs, worse. No source lever
     * tried (now spanning 2 waves) moved it; accept as the same toolchain floor. */
    FileOp *op;
    if (id != 0) {
        op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
        if ((id & 0xFFFFF) == (op->id & 0xFFFFF))   /* request id still matches -> not stale */
            goto success;
    }
    return -3;
success:
    return op->status;
}

/* FILE_operror @0x800EBE1C : raw error code of the op named by `id` (index=id>>24; no validation). */
/* RESIDUAL 13 (ours 11 / oracle 12), w32-a3 classification: the missing instruction is the oracle's
 * `addu v1,a0,zero` -- retail copies the `id` param out of $a0 and srl's the COPY, leaving $a0 free
 * for the `lui a0,%hi(oparray)`; ours srl's $a0 in place and uses $v1 for the lui.  Identical shape
 * to FILE_completeop's `addu a0,a1,zero`: retail cc1 keeps a redundant register-to-register copy our
 * cc1 never emits.  Fifth instance of that pattern in this TU (reservehandle, FILE_completeop,
 * FILE_cancelop, FILE_operror, + syncfile.c synccallback).
 * w33-a3 -- the family verdict is now SPLIT, not one identity.  FILE_cancelop was CRACKED
 * (42->14): its copy was a cse.c artifact of TWO source evaluations of the slot address.
 * allocmutex (callback.c) was CRACKED: its copy was a loop.c giv anchor.  THIS one differs from
 * both -- `id` has exactly ONE use, so there is no second evaluation for cse to turn into a copy
 * and no loop to build givs in; the copy can only be the allocator declining to coalesce the
 * shift result with the dying param pseudo (w32-a7's irreducible core).  Falsified here this
 * wave (all still 13 diffs / 11 vs 12 insns): index form gFileMgr.oparray[id>>0x18], a named
 * `idx` local, a cached `ops` base local, param-as-cursor `id >>= 0x18`, and combinations.
 * SLD cannot arbitrate: nfile.obj is a debug-stripped .lib member with ZERO line records (see
 * the reservehandle comment).  Do not grind.
 * w34-a1 -- MECHANISM NAMED (cc1 -dl/-dg RTL dumps, this TU).  The residual is NOT "the
 * allocator declined to coalesce"; it is a REF-COUNT-driven parm-copy elimination:
 *   .lreg insn14 = (set (reg 85) (lshiftrt (reg:SI 4 a0) 24)) with REG_DEAD (reg a0)
 * i.e. the parm copy `pseudo = $a0` is already GONE before allocation (combine substitutes a
 * hard arg reg into its SINGLE use), so the shift reads the dying $a0 and local-alloc ties the
 * shift's quantity to it => `srl a0,a0,24`.  PROOF OF THE RULE, both directions, in this TU:
 *   (a) FILE_opstatus references `id` TWICE (index + 0xFFFFF compare) -> the copy SURVIVES and
 *       our build emits retail's exact shape `addu a2,a0,zero; srl v1,a2,24` (residual there is
 *       only an addu operand order);
 *   (b) adding a second `id` reference to FILE_completeop (recomputing the slot address at the
 *       freeop call) made OUR build emit `addu a1,a0,zero; srl v1,a1,24` -- the copy appears on
 *       demand (but costs +7 insns, see that fn's comment).
 * So the family splits cleanly: where the ORACLE has the copy (this fn, 11 vs 12 insns) retail's
 * `id` had >=2 RTL refs; where the oracle has NO copy but still shifts into $v1 (priorityop,
 * completeop) it is the local-alloc TIE documented under FILE_priorityop.  Re-opening this one
 * needs a SECOND, INSTRUCTION-FREE reference to `id` -- none exists in C (a mask/compare/asm
 * operand all cost an insn or are scaffolding).  Falsified again w34: `int frame[4]`
 * (non-volatile pad) - identical 13. */
extern int FILE_operror(unsigned int id)
{
    volatile int frame[3];
    /* w47-a1 (13 -> 3, 11/12): TWO zero-insn devices, both catalog-grammar.
     *  (1) the SHIFT SPLIT into its own statement (`idx = id >> 0x18;`) writes the shift
     *      OUT-OF-PLACE (`srl v1,a0,24`) instead of in place on $a0, and
     *  (2) the USE FENCE right after it holds `id` live in $a0 across the shift (0 insns --
     *      the value is already register-resident, w45 cost profile) so the in-place form is
     *      illegal; $a0 then DIES at the fence, freeing it for the %hi base.
     * Result: `lui a0,%hi` lands in retail's register and the whole index chain (sll/addu/
     * lw %lo/sll/addu/lw) is instruction-identical.  The fence also pins the frame `addiu
     * sp,sp,-16` at ENTRY (without it gcc sinks the unused-frame allocation to the tail = 2
     * further diffs).  RESIDUAL 3 = the oracle's surviving assign_parms PARM COPY
     * (`addu v1,a0,zero` + in-place `srl v1,v1,24`); see the w34/w47 note above -- our cse
     * copy-propagates $a0 into every use because $a0 is unmodified between the copy and the
     * uses, and no C spelling modifies it (the %hi that clobbers $a0 in retail is still a
     * pseudo at cse time).  NEW ANGLE (w47): this is now a PER-TU FLAG question, not a
     * spelling one -- the parm-copy survival differs between cc1 configurations. */
    unsigned int idx = id >> 0x18;
    __asm__("" : : "r"(id));
    return ((FileOp *)((char *)gFileMgr.oparray + idx * 0x30))->error;
    /* The volatile aggregate recovers the oracle's 16-byte leaf frame (14->13 diffs), while the
     * direct field return remains better than caching `op`. GCC still sinks the otherwise unused
     * allocation to the tail instead of placing it at entry, and keeps `id` in a0 instead of
     * copying it to v1; those scheduling/coloring differences are the remaining floor. */
    return ((FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30))->error;
}

/* the FILE system backend (allocator + device init) */
extern void *reservememadr(char *name, int size, int classid);  /* eacpsxz @0x800E533C */
extern int   FILE_initwithmem(int handlecount, int memsize, int opcount, void *membuf); /* below (todo) */

/* FILE_init @0x800EBBF4 : bring the FILE system up, allocating its own pool ("File Sys"). */
extern int FILE_init(int handlecount, int memsize, int opcount)
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
 *     2,9 -> result24 (open handle)   3,7,10 -> status   4,5 -> result1C (read)   6,8 -> result18 (size)
 * 🆕 wave-21: switch case-body LAYOUT ORDER is load-bearing here -- the oracle's jump-table blocks
 * appear in .text as 2/9, 3/7/10, 6/8, 4/5 (result18 BEFORE result1C), not the "natural" ascending
 * 2/9,3/7/10,4/5,6/8 order; the case labels below are ordered to match (verified: the two `lw
 * s0,24/28(...)` loads now land in the oracle's exact sequence). The volatile four-word pad
 * recovers the 40-byte frame and cuts the residual 39->27; the remaining mismatch is centered on
 * op-pointer/register coloring plus the oracle's extra tail instruction.
 * w31-a5: the "extra tail instruction" solved -- the oracle's ENTRY has a DEAD first status load
 * (`lw v0,8(a1)` immediately overwritten) = a volatile re-read pair of the IRQ-written status
 * word; the dead `st` local reproduces it, making the stream COUNT-EXACT 47/47 (was 46/47).
 * Residual 28 = ONE coloring web: ours srl's the id in place (a0) and colors op->a0 (saving the
 * freeop arg copy), retail keeps id in a0, srl->v1, op->a1 + `addu a0,a1,zero` in the freeop
 * delay slot -- the §3.12 "ours-shorter base-reuse" swap, now count-neutral; permuter territory
 * (idx-split and param-liveness levers tested, no movement).
 * w32-a3 -- ROOT CAUSE identified from the cc1 -dg dump + IDA.  cc1 -dg says our op-pointer
 * pseudo carries `preferences: 4` -- a hard-reg preference for $a0 created by the `freeop(op)`
 * argument copy -- and global.c's find_reg honours copy preferences BEFORE the plain
 * REG_ALLOC_ORDER scan, so it takes $a0 (nothing conflicts there: the pseudo dies AT the call and
 * `id` dies at the srl).  Retail put it in $a1 (IDA sub_800EC2B0: `_DWORD *v1; // $a1`, `int v2;
 * // $s0`), i.e. retail's allocator did NOT take that preference and emitted the redundant
 * `addu a0,a1,zero` instead -- the same live-range-split copy retail keeps in reservehandle /
 * FILE_cancelop / FILE_operror.  For $a0 to be unavailable, `id` would have to stay live past the
 * op-pointer definition; it does not, in retail or here.  Falsified this wave: recomputing the
 * address expression at the freeop call site (gcc does NOT re-CSE it -> 54 insns / 37 diffs), and
 * the whole -fno-{schedule-insns,cse-follow-jumps,cse-skip-blocks,rerun-cse-after-loop,
 * thread-jumps,caller-saves,strength-reduce,expensive-optimizations} sweep (no movement).
 * w33-a3 -- reconfirmed (28, 47/47).  Reproduced w32's negative exactly (recompute at the
 * freeop site = 54 insns / 37 diffs) and added three more no-movement spellings:
 * `&gFileMgr.oparray[id>>0x18]` index form, a cached `ops` base + index, and both together.
 * NOTE the contrast with FILE_cancelop in this TU, which WAS cracked this wave by the
 * double-evaluation/cse-copy route: there the oracle has an EXTRA copy we lacked; here the
 * oracle merely colors op into $a1 while ours (legitimately shorter by the copy the $a0
 * preference saves) colors it $a0 -- an allocator preference no source form expresses.
 * SLD cannot arbitrate (nfile.obj is a debug-stripped .lib member, zero line records).
 * => toolchain-identity class, not source-reachable.
 * w34-a1 -- reconfirmed 28 (47/47) and the "recompute at the freeop site" negative REPRODUCED
 * with its cause identified: the freeop call sits in the switch's JOIN block, and gcc-2.8's cse
 * only carries equivalences along an EXTENDED basic block (single-pred chains), so a second
 * evaluation there cannot become the oracle's `addu a0,a1,zero` copy -- it re-materializes the
 * whole lui/lw/srl/sll/addu chain (54 insns / 37 diffs, exactly as w32 measured).  That rules
 * the cse-double-evaluation route (the lever that cracked FILE_cancelop) OUT for this fn on
 * structural grounds, not by trial.  Also falsified w34: a `FileOp *dead = op; freeop(dead);`
 * temp (coalesced, identical 28).  The `srl a0` half is the FILE_priorityop local-alloc tie
 * (see there); the op->$a0-vs-$a1 half is the $a0 copy preference w32 measured. */
extern int FILE_completeop(unsigned int id)
{
    volatile int frame[4];
    FileOp *op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    int st = *(volatile int *)&op->status;      /* dead first read -- the oracle keeps BOTH
                                                 * status loads (lw v0,8; lw v1,8): the status
                                                 * word is IRQ-written, volatile semantics */
    int result;
    __asm__("" : : "r"(id));
    if (*(volatile int *)&op->status != 1) {    /* op not finished */
        result = 0;
    } else {                                    /* op finished */
        int type = (op->id >> 0x14) & 0xF;  /* op type nibble */
        switch (type) {
            case 2: case 9:           result = op->result24; break;
            case 3: case 7: case 10:  result = op->status;   break;
            case 6: case 8:           result = op->result18; break;  /* asm: this block precedes
                                                                       * the 4/5 block in .text */
            case 4: case 5:           result = op->result1C; break;
            default:                  result = 0;            break;  /* type outside 2..10 */
        }
    }
    freeop(op);
    return result;
}

/* FILE_callbackop @0x800EBE4C : if the op has a (non-zero) status, store the callback and fire it
 *   immediately with (id, status, param), bracketed by the manager's pending-callback counter. A status
 *   of 0 (op not started/no result yet) does nothing. */
/* w33-a3: FILE_opstatus 2 and FILE_callbackop 2 RE-VERDICTED AS FLOORS (both unchanged).
 * opstatus: offset-first pointer arithmetic DOES flip the `addu a0,v0,v1` operand order to
 * retail's, but re-colors the mask/base web (2 -> 18) -- here the operand order is a SYMPTOM of
 * the coloring, not a lever (contrast reserveop, where it is one).  callbackop: the lone diff is
 * the SCHEDULE POSITION of `addu a3,a1,zero` (retail insn #2, ours one slot later) -- a reorg
 * tie with no source handle.  SLD could not re-verdict either: nfile.obj is a debug-stripped
 * eacpsxz.lib member and the SYM carries ZERO line records for it (see reservehandle). */
/* MATCH work: the real callback ABI is (id,status,param), and the four-word pad recovers the
 * oracle's 40-byte frame; together these cut 28->2 diffs. Only the equivalent `callback`->a3 copy
 * scheduling remains (oracle places it at entry, ours in the status branch delay slot).
 * w34-a1 -- the CAUSE is now pinned, and the "delay-slot scheduling makes this unconditional"
 * note above is literally true of the SOURCE too: the oracle's `sw a3,0x28(v1)` sits in the
 * beqz DELAY SLOT, i.e. retail stores op->callback on BOTH paths.  Writing the store
 * UNCONDITIONALLY in C (before the `if (op->status != 0)`) reproduces that exactly -- the store
 * moves into the delay slot -- but then our sched2 fills the `lw v0,8(v1)` -> `beqz` load-use
 * gap with the parm copy `addu a3,a1,zero`, where retail simply pays a `nop` there and keeps the
 * copy at insn #2.  Result: 31 insns / 3 diffs vs the current 32 / 2 -- BETTER structure, WORSE
 * gate (insn parity lost), so it is not taken.  The whole residual is therefore ONE sched2
 * decision (fill the load-delay slot with the ready parm copy, or leave it empty); volatile on
 * the status load does not block it (tested: no change, since a reg-reg copy has no memory
 * dependence on the volatile MEM).  Reopen only with a lever that removes a ready insn from
 * sched2's window at that point.
 * w34 follow-up (post-movfxya) -- two more classes FALSIFIED, floor hardened to STRONG:
 *   (1) VOLATILE unconditional store (`*(void * volatile *)&op->callback = ...`): does force
 *       sw-before-lw memory ordering, but reorg REFUSES a volatile store as a delay-slot
 *       candidate -> unfilled branch slot, 6 diffs.  General negative worth remembering:
 *       a retail slot-store is never volatile-qualified in the source.
 *   (2) sched1 A/B on the unconditional form: -fno-schedule-insns leaves the copy in the load
 *       gap (31/3) -- the sink is SCHED2, post-reload, where the shared hard base reg makes
 *       sw 0x28 vs lw 0x8 provably disjoint, so the lw is independent and the priority-2 parm
 *       copy always sinks to the last free cycle.  An alias-dependence route (separate base
 *       pseudo for the store) cannot survive to sched2: after reload both addresses share the
 *       hard base.  Retail's copy-at-insn-2 is not reproducible by any priority/tie model of
 *       our sched2 over this RTL; residual class = old-sched ready-list emission-order identity. */
extern void FILE_callbackop(unsigned int id, void (*callback)(unsigned int id, int status, int param))
{
    volatile int frame[4];
    FileOp *op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    if (op->status != 0) {
        op->callback = (void (*)(void))callback;   /* delay-slot scheduling makes this unconditional */
        gFileMgr.cbpending++;
        callback(id, op->status, op->param);
        gFileMgr.cbpending--;
    }
}

/* ---- the user-facing file ops ---- */
extern int    strlen(const char *s);                       /* libc C27 */
extern char  *strncpy(char *d, const char *s, int n);      /* libc */
extern void   iFILE_perror(FileOp *op);                    /* @0x800ED0D4 (below); op passed in $a0 (delay slot), ignored */
extern int    iFILE_ExecCommand(void *cmd);                /* @0x800ECB98 (below, todo) */
extern int    systemtask(int);                             /* @0x800E6C04 vsync/idle pump */

#define OPI(op, off)  (*(int  *)((char *)(op) + (off)))        /* int  field at byte offset */
#define OPP(op, off)  (*(void**)((char *)(op) + (off)))        /* ptr  field at byte offset */

/* FILE_open @0x800EC36C : open `name`; reserve an op (type 2) + a handle, copy the name, dispatch. */
extern unsigned int FILE_open(char *name, unsigned int a1, unsigned int a2, unsigned int a3)
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
extern unsigned int FILE_close(void *handle, unsigned int a1, unsigned int a2)
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
extern unsigned int FILE_read(void *handle, unsigned int offset, unsigned int dest,
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
extern unsigned int FILE_size(void *handle, unsigned int a1, unsigned int a2)
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
extern void iFILE_perror(FileOp *op)
{
    (void)op;
}

/* FILE_waitop @0x800EC1BC : block until the op named by `id` completes; return its status.
 *   Pumps systemtask(0) while the op's status is 0.  Returns -3 if `id` is 0/stale, or if the slot
 *   gets recycled out from under us during the wait. */
extern int FILE_waitop(unsigned int id)
{
    /* MATCH (53->0 diffs, 61/61 instructions): the otherwise-unused 24-byte `frame`
     * restores the retail 72-byte frame.  Keeping the loop-only mask/wanted-id/manager/offset
     * values inside the status guard gives their exact s3/s2/s5/s1 allocation.  The offset-first
     * check-pointer expression fixes the retail addu operand order, while the inline `invalid`
     * block followed by `valid` reproduces its positive equality branch and shared -3 tail.
     * The volatile final status read preserves the deliberate post-loop reload. */
    volatile int frame[6];
    /* asm: op's address is computed UNCONDITIONALLY first (no side effects), THEN id==0 is
     * tested -- and the whole "recompute op + validate id" sequence (incl. the id==0 test,
     * vestigial though it is once inside the loop -- id is a local param that can't change) is
     * duplicated verbatim after each systemtask() pump, not hoisted into a shared helper.
     * `op` itself is computed EXACTLY ONCE and kept in a fixed register ($s0) for every
     * `status` read (both the entry checks and the final return) -- the in-loop re-validation
     * uses a SEPARATE, throwaway freshly-recomputed address (never written back to `op`) purely
     * to re-check the id/slot; reassigning a single `op` local each iteration (as an earlier
     * draft did) forces the compiler to treat it as one continuously-updated value instead of a
     * fixed pointer + a disposable check, so the two are kept as separate locals here. */
    FileOp *op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    if (id == 0)
        goto invalid;
    if ((id & 0xFFFFF) != (op->id & 0xFFFFF))         /* stale id */
        goto invalid;
    if (op->status == 0) {                             /* not finished yet -> pump the system */
        unsigned int loopmask = 0xFFFFF;
        unsigned int wanted = id & 0xFFFFF;
        FileMgr *mgr = &gFileMgr;
        unsigned int offset = (id >> 0x18) * 0x30;
        do {
            systemtask(0);
            if (id == 0)
                goto invalid;
            {
                FileOp *check = (FileOp *)(offset + (unsigned int)mgr->oparray);
                if (wanted == (check->id & loopmask))
                    goto valid;
invalid:
                return -3;                            /* slot recycled -> give up */
valid:
                if (op->status == 0)
                    continue;
                break;
            }
        } while (1);
    }
    return *(volatile int *)&op->status;
}

/* FILE_atomic @0x800ECB40 : run `fn(a3, a4)` (fn takes the 3rd/4th args -- $a2/$a3), flush the FILE
 *   command queue (iFILE_ExecCommand), and return fn's result.  The manager's +0x08 word (idmask) is
 *   saved and restored around the call -- a net no-op as written (the intermediate write is overwritten).
 *   The return value is fn's result, captured in ExecCommand's branch delay slot ($s0=$v0) before the
 *   call clobbers $v0; the 2nd arg is unused. */
extern int FILE_atomic(int (*fn)(int, int), int unused, int a3, int a4)
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
extern void FILE_priorityop(unsigned int id, int priority)
{
    /* The otherwise-unused pad recovers the oracle's 16-byte frame.  The unlink scan and sorted-reinsert
     * node are distinct source variables, matching the oracle's separate v0/v1 live ranges; the reinsert
     * walks through op->qnext itself.  Together these recover the retail list-mutation order and reduce
     * the detailed residual from 38 to 6 diffs at the exact 79-instruction length.
     * w33-a3 -- the 6 are ONE instruction triple: retail `srl v1,a0,24; sll v0,v1,1;
     * addu v0,v0,v1` vs ours `srl a0,a0,24; ...` -- our allocator coalesces the shift result
     * into the dying `id` param register, retail's does not.  Same single-use variant of the
     * copy family as FILE_operror (see its comment for the now-SPLIT family verdict).
     * Falsified this wave: a named `idx` local + index form (still 6).  SLD cannot arbitrate
     * (nfile.obj is a debug-stripped eacpsxz.lib member with zero line records).
     * w34-a1 -- MECHANISM NAMED, and it is an EXACT local-alloc PRIORITY TIE, not a coalesce
     * refusal.  From the cc1 -dl dump of this fn: the srl's dest pseudo (85) is "used 3 times
     * across 3 insns in block 0" and the sll's dest (87) "2 times across 2 insns"; local-alloc's
     * QTY_CMP_PRI = floor_log2(refs)*refs*size/(death-birth) gives 1*3/3 = 1.0 and 1*2/2 = 1.0 --
     * a dead tie, so which quantity is allocated first (and therefore which one inherits the
     * dying $a0 vs takes the next free reg) falls out of qsort's handling of equal keys.  Ours
     * allocates the srl dest first (it takes $a0, the dying param); retail allocated the sll
     * dest first (it took $v0, pushing the srl dest to $v1).  No source form changes 3 refs/3
     * insns or 2 refs/2 insns without changing the oracle's own instruction shape, so this is
     * unreachable from C.  (Same tie explains FILE_completeop's srl->$v1.)  Also falsified w34:
     * computing `op` after FILE_CS_ENTER (16 diffs), and a separate declaration+assignment of
     * `op` (C89 decl-order error / no movement). */
    volatile int frame[3];
    FileOp *op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);
    int oldprio, sr;
    FileOp *prev, *scan, *node;

    __asm__("" : : "r"(id));
    FILE_CS_ENTER(sr);
    oldprio = op->prio;
    op->prio = priority;
    if (gFileMgr.state >= 2 && op != gFileMgr.curop && op->status == 0 && oldprio != priority) {
        prev = 0; scan = gFileMgr.queuehead;
        while (scan != 0) {                          /* find op in the queue */
            if (scan == op)
                break;
            prev = scan;
            scan = scan->qnext;
        }
        if (prev != 0) prev->qnext        = op->qnext;
        else            gFileMgr.queuehead = op->qnext; /* unlink (op was head) */

        prev = 0;
        op->qnext = gFileMgr.queuehead;
        while (op->qnext != 0) {                     /* sorted reinsert (ascending) */
            node = op->qnext;
            if (op->prio < node->prio)
                break;
            prev = node;
            op->qnext = node->qnext;
        }
        if (prev != 0) prev->qnext        = op;
        else           gFileMgr.queuehead = op;
    }
    FILE_CS_LEAVE(sr);
}

/* FILE device backend (other objs) + the manager init's CD/file-io bring-up. */
extern int  CD_Init(int handlecount, int memsize, void *iomem, void (*cb)(void)); /* @0x800FA394 */
extern void initfileio(void);                                  /* @0x800F3A34 */
extern int  iFILE_CommandCompleteCallback(int result);         /* @0x800ED020 (below) */
extern int  disablecd;                                         /* global: nonzero == CD backend off */

/* FILE_initwithmem @0x800EBC78 : set the manager up over a caller-provided pool, then bring up the
 *   CD device + file-io backend.  Returns 0 if the system was already initialised, else 1. */
extern int FILE_initwithmem(int handlecount, int memsize, int opcount, void *membuf)
{
    int size;
    if (handlecount == 0) handlecount = 0x18;     /* 24 */
    if (memsize == 0)     memsize     = 0x800;    /* 2 KB */
    if (opcount == 0)     opcount     = 0xA;      /* 10 */
    if (gFileMgr.opcount != 0)                    /* already up -- asm sinks the "return 0" to the
                                                     * SHARED TAIL at the end (forward branch), not
                                                     * an inline early-return */
        goto already_init;
    gFileMgr.opcount     = opcount;
    gFileMgr.handlecount = handlecount;
    gFileMgr.idmask      = 0xFF;
    gFileMgr.oparray     = (FileOp *)membuf;    /* op array at the pool base -- stored BEFORE the
                                                  * FILE_overhead call (asm: sinks into its delay
                                                  * slot), not after computing `size` */
    size = FILE_overhead(handlecount, memsize, opcount);
    /* asm re-reads gFileMgr.oparray/.opcount/.handlecount from memory for everything below
     * (rather than keeping the membuf/opcount/handlecount params alive across the intervening
     * FILE_overhead/blockclear/CD_Init calls) -- same not-cached-across-calls pattern as
     * HANDLE()/NAME() in iFILE_ExecCommand. */
    blockclear(gFileMgr.oparray, size);                           /* zero the whole pool */
    gFileMgr.handlearray = (FileHandle *)((char *)gFileMgr.oparray + gFileMgr.opcount * 0x30);  /* handles after ops */
    if (disablecd == 0) {                                          /* CD backend enabled */
        char *iomem = (char *)gFileMgr.handlearray + gFileMgr.handlecount * 0x4C;     /* io mem after handles */
        unsigned int r = CD_Init(gFileMgr.handlecount, memsize, iomem,
                        (void (*)(void))iFILE_CommandCompleteCallback);  /* asm: sltiu (unsigned compare) */
        disablecd = (r < 1) ? 1 : 0;                              /* disable CD if init failed */
    }
    initfileio();
    return 1;
already_init:
    return 0;
}

extern void stopreadfile(int dev);   /* @0x800F4100 abort an in-flight read on a device */

/* FILE_cancelop @0x800EC008 : cancel the op named by `id` (no-op for close/type-10 ops or stale ids).
 *   - if the op is the one currently being dispatched (mgr.curop): flag op->cancelreq=1, and if it is a
 *     read, abort the device read via stopreadfile;
 *   - else if the op already completed (status==1): mark it cancelled (status=-1);
 *   - else (still queued): unlink it from the pending queue, decrement mgr.state, mark it cancelled
 *     (status=-1) and fire its completion callback with (id, param). */
extern void FILE_cancelop(unsigned int id)
{
    /* MATCH work (59->47->42 diffs): the retail object reserves a dead 24-byte local
     * area, so this pad restores its 48-byte frame and saved-register offsets.
     * wave-29: the "not found in queue" exit is its OWN dedicated CS-leave+return in
     * the oracle (a separate mtc0+j block at .L800EC0F4), not a shared jump to the
     * common `cleanup:` tail that every OTHER early-out uses -- writing it as an
     * explicit FILE_CS_LEAVE(sr); return; (instead of goto cleanup;) reproduces that
     * duplicate block and fixes the instruction count to exact (106/109 -> 109/109),
     * cutting 47->42.
     * w32-a3 diagnosis (kept, it was right): IDA sub_800EC008 gives retail's map
     * `v1 // $a2` = action, `v2 // $s0` = sr, `v3 // $a3` = op, param id -> $a1, and
     * the oracle fills the `lw v0,20(t0)` load-delay slot with `addu a1,a3,zero` --
     * a live-range-split COPY of `op` into the register `id` just vacated, used for
     * the whole rest of the body.  Ours had no such pseudo, so our single `op` pseudo
     * was allocated first, grabbed $a1 and pushed id->a2 / action->a3: one missing
     * copy drove the entire 42-diff web.
     * w33-a3 SOLVED IT (42->16->14, 109/109 parity throughout).  The w32 verdict
     * "no C form can produce it / per-obj no-copy-prop identity" was WRONG.  The copy
     * is a CSE ARTIFACT, and it is source-reachable: the retail source computes the
     * slot address TWICE -- once as an ANONYMOUS expression inside the stale-id test,
     * and again for the named `op` used by the body.  cse.c replaces the second
     * computation with a register COPY of the first result (it does NOT copy-propagate
     * it away, because the two are separate pseudos with separate live ranges), which
     * is exactly the oracle's `addu a1,a3,zero`.  Writing the stale test through the
     * named `op` (one computation) is what deleted the copy and rotated three
     * registers.  Same family as the giv-anchor copy cracked in callback.c allocmutex:
     * an apparently redundant retail reg-to-reg move is usually a SECOND source-level
     * evaluation the optimizer folded, not a weaker compiler.
     * Also from this wave: the in-flight test is `mgr->curop == op`, not `op ==
     * mgr->curop` -- the oracle's `bne v0,a1` puts the LOADED value first (-2 diffs).
     * RESIDUAL 14: (a) the `addiu v0,zero,1` that the oracle hoists into that bne's
     * delay slot and reuses for both `op->cancelreq = 1` and `action = 1` (ours leaves
     * a nop; `action = 1; op->cancelreq = action;` and `op->cancelreq = action = 1;`
     * both REGRESS to 18); (b) a v0/v1 name swap on the `gFileMgr.state--` RMW in the
     * unlink arm (address in v1 + value in v0 in retail, reversed here) -- join-block
     * rematerialization coloring. */
    volatile int frame[6];
    FileOp *op;
    int     nibble, action = 0, sr;

    FILE_CS_ENTER(sr);
    if (id == 0) goto cleanup;
    if ((id & 0xFFFFF) !=
        (((FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30))->id & 0xFFFFF))
        goto cleanup;                                         /* stale id */
    nibble = (id >> 0x14) & 0xF;
    if (nibble == 3 || nibble == 0xA) goto cleanup;           /* close/type-10: not cancellable */
    op = (FileOp *)((char *)gFileMgr.oparray + (id >> 0x18) * 0x30);

    if (gFileMgr.curop == op) {                  /* op is in flight */
        op->cancelreq = 1;
        action = 1;
    } else if (op->status == 1) {                /* already complete */
        op->status = -1;                         /* mark cancelled (no further action) */
    } else {                                     /* still queued -> remove it */
        FileOp *prev = 0, *node = gFileMgr.queuehead;
        if (node == 0) goto cleanup;
        while (node != 0) {
            if (node == op)
                break;
            prev = node;
            node = node->qnext;
        }
        if (node == 0) { FILE_CS_LEAVE(sr); return; }  /* not in queue */
        if (prev != 0) prev->qnext        = op->qnext;
        else            gFileMgr.queuehead = op->qnext;
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
cleanup:
    FILE_CS_LEAVE(sr);
}

/* iFILE_delbigclosecallback @0x800EC980 : completion callback for the BIG-archive close op -- harvest
 *   the close op (FILE_completeop), then kick the next queued command (iFILE_ExecCommand). */
extern int iFILE_delbigclosecallback(unsigned int id, int a1, void *cmd)
{
    (void)a1;
    FILE_completeop(id);
    return iFILE_ExecCommand(cmd);
}

/* iFILE_CommandCompleteCallback @0x800ED020 : the CD/device completion driver (handed to CD_Init).
 *   Resolves the final status of the in-flight op (mgr.curop): a pending cancel -> -1 (cancelled), else
 *   result==0 -> -2 (device fail), result!=0 -> 1 (ok).  Clears mgr.curop, fires the op's completion callback
 *   (id, status, param) bracketed by mgr.cbpending, then dispatches the next command if nothing nested. */
extern int iFILE_CommandCompleteCallback(int result)
{
    FileOp *cmd = gFileMgr.curop;
    if (cmd == 0)
        return;
    /* @0x800ED040-50: a flat chain of early-out tests, EACH jumping (with its value already loaded in
     * the branch's delay slot) straight to the shared store -- not an if/else-if/else (that nests the
     * tests instead of chaining independent early-outs to one target). cancelreq!=0 -> -1, result==0 ->
     * -2, else 1 (fall-through default).
     * MATCH: a volatile-qualified dead read retains the oracle's overwritten old status load;
     * the reversed nested ternary keeps the status chain in v0; value-less returns recover the
     * entry branch and final tail; and spelling both callback-field accesses directly preserves
     * the oracle's deliberate reload before jalr. */
    (void)*(volatile int *)&cmd->status;
    cmd->status = (cmd->cancelreq != 0) ? -1 : ((result != 0) ? 1 : -2);
    gFileMgr.curop = 0;
    if (cmd->callback) {
        gFileMgr.cbpending++;
        ((void (*)(int, int, int))cmd->callback)((int)cmd->id, cmd->status, cmd->param);
        gFileMgr.cbpending--;
    }
    if (gFileMgr.cbpending == 0)
        iFILE_ExecCommand((void *)0);                   /* kick the next queued command */
    return;
}

/* ---- BIG-archive (.BIG) mount: FILE_addbig + its open/read completion callbacks ---- */
typedef unsigned int size_t;   /* was <stddef.h>; C TU is self-contained */                                     /* size_t (target-faithful ptr<->int casts) */

extern void  purgememadr(void *p);                  /* eacpsxz @0x800E5540 : free a reservememadr block */
extern int   typeofbigfile(void *hdr);              /* eacpsxz @0x800E5F1C : archive type from header  */
extern int   sizeofbigfileheader(void *hdr);        /* eacpsxz @0x800E5F84 : full header byte size      */
extern int   getblocksize(void *hdr);               /* eacpsxz @0x800E52D4 : bytes valid in the buffer  */
extern void  blockmove(void *src, void *dst, int n);/* eacpsxz @0x800E62DC : memmove(dst,src,n)          */
extern int   iscurrentthread(int);                  /* eacpsxz @0x800FE408 : (called for side-effect)   */
extern int   strncmp(const char *, const char *, int); /* libc C24 @0x800EB1D0                          */

/* iFILE_addbigreadcallback @0x800EC660 : completion of a header read.  Records the handle, finalizes the
 *   read op, and if the header spans more than the block already read, grows the buffer and re-reads the
 *   remainder (re-arming itself).  When the whole header is loaded it links the node onto the device list
 *   and kicks the user's command op.  `id`=read op id, `status` unused, `node`=the BIG node (int[4]). */
extern void iFILE_addbigreadcallback(unsigned int id, int status, int *node)
{
    /* MATCH: `branchbuf` starts as node and becomes the grown buffer only in the read-more
     * branch, producing the oracle's s0 branch value while node, manager, and priority occupy
     * s1/s3/s4.  The two-word pad fixes the saved-register offsets.  `cmd` is intentionally
     * short-lived: its handle propagation schedules into FILE_completeop's delay slot, while
     * the final command dispatch reloads node[2] through `publish`. */
    volatile int frame[2];
    void   *branchbuf = node;
    FileMgr *mgr   = &gFileMgr;
    FileOp *cmd    = (FileOp *)(size_t)(unsigned int)node[2];
    FileOp *op     = (FileOp *)((char *)mgr->oparray + (id >> 0x18) * 0x30);
    int     prio   = op->prio;            /* +0x10 */
    int     hdrsize, blksize;
    (void)status;

    {
        int handle = op->result24;         /* FILE_read stashed the handle in result24 (+0x24) */
        node[1] = handle;                  /* node->handle */
        cmd->result24 = handle;
    }
    FILE_completeop(id);                   /* final store above schedules into this call's delay slot */

    if (typeofbigfile((void *)(size_t)(unsigned int)node[0]) == 0)
        purgememadr((void *)(size_t)(unsigned int)node[0]);   /* invalid type -> drop the buffer */

    hdrsize = sizeofbigfileheader((void *)(size_t)(unsigned int)node[0]);
    blksize = getblocksize((void *)(size_t)(unsigned int)node[0]);
    if (blksize < hdrsize) {              /* header bigger than what we have -> read the rest */
        void *newbuf = reservememadr((char *)"bigfile buf", hdrsize, 0x10);
        unsigned int rid;
        branchbuf = newbuf;
        blockmove((void *)(size_t)(unsigned int)node[0], newbuf, 0x800);  /* keep the first block */
        purgememadr((void *)(size_t)(unsigned int)node[0]);
        node[0] = (int)(size_t)newbuf;
        rid = FILE_read((void *)(size_t)(unsigned int)node[1], 0x800,
                        (unsigned int)(size_t)((char *)newbuf + 0x800),
                        hdrsize - 0x800, prio, (unsigned int)(size_t)node);
        FILE_callbackop(rid, (void (*)(unsigned int, int, int))iFILE_addbigreadcallback);
    } else {                             /* header complete -> publish the device */
        int *publish = (int *)branchbuf;
        publish[3] = (int)(size_t)mgr->devicelist;   /* node->next = old head */
        mgr->devicelist = publish;
        iFILE_ExecCommand((void *)(size_t)(unsigned int)publish[2]);
    }
}

/* iFILE_addbigopencallback @0x800EC7A0 : completion of the archive FILE_open.  Harvests the handle and,
 *   on success, kicks off reading the first 0x800 header block (arming iFILE_addbigreadcallback); on
 *   failure marks the command op error 4 and runs it.  `status`==1 means open succeeded. */
extern void iFILE_addbigopencallback(unsigned int id, int status, int *node)
{
    /* MATCH: the separate success-path node copy prevents it being coalesced with the
     * failure-path node value, recovering the oracle's s1 -> s2 copy in the status-branch
     * delay slot.  Loading `ops` separately materializes the manager base before the index
     * arithmetic; spelling the final sum index-first gives the oracle's v0 destination. */
    volatile int frame[2];
    int    *readNode = node;
    FileOp *ops  = gFileMgr.oparray;
    FileOp *op   = (FileOp *)((id >> 0x18) * 0x30 + (size_t)ops);
    int     prio = op->prio;               /* +0x10 */
    int     handle = FILE_completeop(id);  /* open op result24 == the opened handle */

    if (status != 1) {                     /* open failed: don't cache cmdop -- the oracle stores
                                             * error=4 via one reload of node[2], then reloads
                                             * node[2] AGAIN fresh for the iFILE_ExecCommand arg */
        ((FileOp *)(size_t)(unsigned int)node[2])->error = 4;
        iFILE_ExecCommand((void *)(size_t)(unsigned int)node[2]);
    } else {                               /* open ok -> read the first header block */
        unsigned int rid = FILE_read((void *)(size_t)handle, 0,
                                     (unsigned int)readNode[0], 0x800,
                                     prio, (unsigned int)(size_t)readNode);
        FILE_callbackop(rid, (void (*)(unsigned int, int, int))iFILE_addbigreadcallback);
    }
}

/* FILE_addbig @0x800EC858 : mount a .BIG archive `name` (type 9 command op).  If an archive with the same
 *   name is already open (its handle's first 0x40 bytes hold the name), hand back the existing handle and
 *   run the command immediately.  Otherwise allocate a device node + header buffer, FILE_open the archive
 *   (passing the node as the open op's param) and arm iFILE_addbigopencallback to drive the header load.
 *   Returns op->id (used as an op id by FILE_addbigsync); the dup-hit path returns the op pointer (an asm
 *   quirk faithfully reproduced). */
extern unsigned int FILE_addbig(char *name, unsigned int a1, unsigned int datatype, unsigned int param)
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
        FILE_callbackop(oid, (void (*)(unsigned int, int, int))iFILE_addbigopencallback);
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
 *   LIFO).  A not-found device dereferences null (matches the asm; never happens in practice).
 * MATCH: initializing `prev` before the reserveop call deliberately overlaps its lifetime with
 * the saved third argument.  GCC then reuses that argument register for `prev` and, once the
 * gFileMgr base dies, recycles its register for `closeHandle`, matching the retail allocation. */
extern unsigned int FILE_delbig(int delHandle, unsigned int a2, unsigned int a3)
{
    int    *prev = 0;                               /* s0 after the saved a3 value dies */
    int    *node = (int *)gFileMgr.devicelist;      /* s1 */
    FileOp *op   = reserveop();                      /* s2 */
    int    *h    = (int *)gFileMgr.handlearray;      /* a1 */
    int     closeHandle;                             /* s3 */
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
    closeHandle = node[1];                           /* s3 = head node+4 -- UNCONDITIONAL load (oracle
                                                      *      has no null guard; null head never happens) */
    while (node != 0) {
        if (node[1] == delHandle)                    /* node+4 == delHandle -> found */
            break;
        prev = node;
        node = (int *)(size_t)(unsigned int)node[3]; /* node->next (+0xC) */
    }
    if (node == 0)
        op->error = 1;                               /* empty / not found */

    if (prev != 0)
        prev[3] = node[3];                           /* mid-list: prev->next = node->next */
    else
        gFileMgr.devicelist = 0;                     /* head case: clears the list head (see NOTE) */

    purgememadr((void *)(size_t)(unsigned int)node[0]);    /* free the header buffer */
    purgememadr(node);                                     /* free the node */
    {
        unsigned int cid = FILE_close((void *)(size_t)(unsigned int)closeHandle,
                                      a2, (unsigned int)(size_t)op);  /* close op param = this command op */
        FILE_callbackop(cid, (void (*)(unsigned int, int, int))iFILE_delbigclosecallback);
    }
    return op->id;
}

/* ---- the device backend (fileio.obj @0x800F3xxx) + string helpers used by the dispatcher ---- */
extern int   openfile(char *name, int flags, void *handle);  /* @0x800F3BE0 */
extern int   closefile(int dev);                             /* @0x800F3E84 */
extern int   readfile(int dev, int dest, int offset, int len);/* @0x800F3EE0 (async; completes via CD cb) */
extern int   writefile(int dev, int buf, int offset, int len);/* @0x800F4020 (async) */
extern int   getfilesize(int dev);                          /* @0x800F409C */
extern int   locatebigentryz(void *bighdr, char *entry, int flags, int *outOffset, int *outSize); /* @0x800E5FFC */
extern char *strchr(const char *s, int c);                  /* @0x800F6214 */
extern char *strcpy(char *d, const char *s);                /* @0x800E5B28 */
extern int   strcmp(const char *a, const char *b);          /* @0x800E5D7C */
extern void  freehandle(FileHandle *h);                     /* @0x800ED2F0 (above) */

#define OPI(op, off)  (*(int *)((char *)(op) + (off)))          /* multipurpose op field at byte offset */
#define HANDLE(cmd)   ((int *)(size_t)(unsigned int)OPI(cmd, 0x24))  /* not cached -- see below */
#define NAME(cmd)     ((char *)HANDLE(cmd) + 0x0C)

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
/* RAW/ORACLE REDUCTION (2026-07-26, 56->10 detailed diffs, count-exact 290/290):
 *   - clear the entry buffer before the first strchr, as the raw instruction order requires;
 *   - scope/initialize the found flag at its first live branch (the jump-table delay slot stays nop);
 *   - express the optional volume filter directly instead of introducing a doLookup boolean;
 *   - preserve the raw archive-walk exit order (end-of-list first, found second);
 *   - write the dequeue priority test directly as cmd->prio <= idmask, matching the oracle's
 *     cmd-field-before-manager-field load order;
 *   - complete each synchronous switch arm directly, allowing cc1's common-tail merge to put the
 *     result in $a0 at the shared callback label instead of keeping every result live in $s2.
 * RESIDUAL 10 diffs @ 290/290 (w31-a5, FLOOR -- do not re-fight): ONE root cause -- at the second
 * strchr(name+12,'|') call our cc1 COPY-PROPAGATES the 124 ('|') already sitting in $v0 from the
 * preceding `name[0] != '|'` compare (`addu a1,v0,zero`), while retail cc1 REMATERIALIZES
 * `li a1,124` in the jal delay slot; the other 8 lines are the la/scheduling shuffle downstream of
 * that one choice.  This is the documented "old-gcc no-copy-prop" per-obj toolchain-identity class
 * (methodology 3.25-3b tail: DrawOTag/_padSetActAlign/CdRead2 siblings) -- invariant across our
 * cc1/cc1plus, not source-reachable.
 * Raw nfs4-f.exe DD398..DD81F SHA-256:
 * f005d1d202c25693bdaa4a6af71d553309201f7f8db575ef547012c92aaecb52. */
extern int iFILE_ExecCommand(void *cmdp)
{
    FileOp *cmd = (FileOp *)cmdp;
    int type, sr;

    FILE_CS_ENTER(sr);                           /* cop0: disable IRQs */

    /* the oracle stores `cmd->qnext = queuehead` UNCONDITIONALLY (the entry beqz's own delay slot,
     * before testing queuehead!=0) rather than special-casing the qh==0 branch -- i.e. the true
     * shape is `cmd->qnext = qh; if (qh != 0) { for(;;){...} }` with no separate `qnext=0` arm. */
    if (cmd != 0) {                              /* insert into the priority-sorted pending queue */
        FileOp *prev = 0;
        FileOp *qh   = gFileMgr.queuehead;
        cmd->qnext = qh;
        if (qh != 0) {
            for (;;) {
                FileOp *node = cmd->qnext;       /* cursor (cmd->qnext is reused as the walk pointer) */
                if (cmd->prio < node->prio)      /* insert before the first higher-prio op */
                    break;
                prev = node;
                cmd->qnext = node->qnext;        /* advance cursor (naturally becomes 0 at the tail) */
                if (cmd->qnext == 0)
                    break;
            }
        }
        if (prev != 0) prev->qnext        = cmd;  /* oracle: fallthrough=prev!=0, branch-target=prev==0 */
        else           gFileMgr.queuehead = cmd;
        gFileMgr.state++;                        /* one more queued op */
    }

    if (gFileMgr.curop != 0) {                   /* an op is already being dispatched */
        FILE_CS_LEAVE(sr);
        return;                                  /* oracle: no v0 zeroing on ANY exit of this fn (see below) */
    }

    /* dequeue the head (if its prio fits under idmask). oracle reuses cmd's own dead register
     * (cmd is unused at this point -- it was already stored into the queue in the block above)
     * directly for the dequeued head/pick value, rather than a separate `head`/`pick` local. */
    cmd = gFileMgr.queuehead;
    if (cmd != 0 && cmd->prio <= gFileMgr.idmask) {
        gFileMgr.queuehead = cmd->qnext;
        gFileMgr.state--;
    } else {
        cmd = 0;
    }
    gFileMgr.curop = cmd;
    FILE_CS_LEAVE(sr);                           /* cop0: re-enable IRQs */

    if (cmd == 0)
        return;                                  /* nothing to dispatch */

    /* the oracle RE-DERIVES this nibble fresh from cmd->id at 3 separate sites (srl 20;andi 0xF
     * at 0x800ECCD0 for dispatch, again at 0x800ECDE8 and 0x800ECEE0 for the two `type==8` checks
     * deep in the case-2/8 body, AFTER openfile/strchr/strncpy/strcpy calls) rather than keeping
     * ONE cached `type` alive across those calls. The two post-call `type==8` checks in the
     * case-2/8 body are re-derived as `((cmd->id>>0x14)&0xF)==8` below -- this eliminates the
     * extra callee-saved $s4 a cached `type` would force across those calls (the 5-register save
     * set would otherwise be s0/s1/s2/s3/s4/ra vs the oracle's s0/s1/s2/s3/ra). */
    type = (cmd->id >> 0x14) & 0xF;
    if (type < 2 || type > 10)                   /* op-type nibble must be 2..10 */
        return;

    {
        /* the open-file handle: NOT cached in a local -- the oracle re-reads cmd->result24 fresh
         * at every use site (only CSE-merged by the compiler across a call-free span), so a
         * cached local here would artificially extend its live range across the whole switch and
         * force extra callee-saved registers the oracle never allocates. */
        switch (type) {
        case 2:                                  /* open */
        case 8: {                                /* exists-probe */
            char *bar;                           /* "volume|entry" separator? */
            char  volbuf[0x40], entrybuf[0x40];
            int   s3, ccc;

            /* The raw body clears entrybuf before strchr, but does not materialize the found
             * accumulator until the s3&1 test below (in that branch's delay slot). */
            entrybuf[0] = 0;
            bar = strchr(NAME(cmd), '|');
            if (bar != 0) {
                s3 = 2;
                if (NAME(cmd)[0] != '|') {       /* "volume|entry" -> split out the volume name */
                    int vollen = (int)(strchr(NAME(cmd), '|') - NAME(cmd));
                    s3 = 4;
                    volbuf[0] = 0;
                    strncpy(volbuf, NAME(cmd), vollen);
                    volbuf[vollen] = 0;
                }
                strcpy(entrybuf, strchr(NAME(cmd), '|') + 1);   /* entry = text after '|' */
            } else {
                s3 = 1;
                if (OPI(cmd, 0x18) & 1) {        /* flag bit 0 -> also search BIG archives */
                    s3 = 3;
                    strcpy(entrybuf, NAME(cmd));
                }
            }

            ccc = 0;
            if (s3 & 1) {                        /* odd modes (1,3): open the plain file */
                if (openfile(NAME(cmd), OPI(cmd, 0x18), HANDLE(cmd)) != 0) {
                    ccc = 1;                     /* opened OK (asm: delay slot -> set for BOTH types) */
                    if (((cmd->id >> 0x14) & 0xF) == 8) closefile(HANDLE(cmd)[0]);         /* probe: open+close */
                    else           HANDLE(cmd)[1] = getfilesize(HANDLE(cmd)[0]); /* handle->size */
                }
            }

            if (ccc == 0 && (s3 & 6)) {          /* modes 2,3,4,6: search the mounted BIG archives */
                int *dev = (int *)gFileMgr.devicelist;
                while (dev != 0) {
                    /* Explicit volume names only probe matching mounted devices. */
                    if (!(s3 & 4) ||
                        strcmp((char *)(size_t)(unsigned int)dev[1] + 0x0C, volbuf) == 0) {
                        int off, sz;
                        if (locatebigentryz((void *)(size_t)(unsigned int)dev[0],
                                            entrybuf, 0, &off, &sz) != 0) {
                            HANDLE(cmd)[0] = (int)(size_t)dev;      /* handle->dev = this device node */
                            HANDLE(cmd)[1] = sz;                    /* handle->size  */
                            HANDLE(cmd)[2] = off;                   /* handle->flags = entry base offset */
                            ccc = 1;
                        }
                    }
                    dev = (int *)(size_t)(unsigned int)dev[3];      /* next device (+0xC) */
                    if (dev == 0)
                        break;
                    if (ccc == 0)
                        continue;
                    else
                        break;
                }
            }

            if (((cmd->id >> 0x14) & 0xF) == 8) { /* exists-probe: drop the handle, report found flag */
                freehandle((FileHandle *)HANDLE(cmd));
                OPI(cmd, 0x18) = ccc;
            }
            iFILE_CommandCompleteCallback(ccc);
            return;
        }

        case 3:                                  /* close */
            cmd->error = 0;                      /* asm: delay slot -> cleared on BOTH paths */
            if (HANDLE(cmd) != 0) {
                if (HANDLE(cmd)[2] == 0)         /* real file (not a BIG entry) -> close the device */
                    cmd->error = closefile(HANDLE(cmd)[0]);
                freehandle((FileHandle *)HANDLE(cmd));
                cmd->result24 = 0;
            }
            iFILE_CommandCompleteCallback(cmd->error == 0);
            return;

        case 4: {                                /* read */
            int len = OPI(cmd, 0x1C);
            if (len <= 0) {                      /* nothing to read -> complete now */
                iFILE_CommandCompleteCallback(1);
                return;
            }
            if (HANDLE(cmd)[2] != 0) {           /* BIG entry: add the entry's base offset */
                int *dev   = (int *)(size_t)(unsigned int)HANDLE(cmd)[0];
                int *devfh = (int *)(size_t)(unsigned int)dev[1];   /* dev->handle (+4) */
                readfile(devfh[0], OPI(cmd, 0x20), HANDLE(cmd)[2] + OPI(cmd, 0x18), len);
            } else {                             /* real file */
                readfile(HANDLE(cmd)[0], OPI(cmd, 0x20), OPI(cmd, 0x18), len);
            }
            return;                              /* async: completes via the CD callback */
        }

        case 5:                                  /* write (async) */
            writefile(HANDLE(cmd)[0], OPI(cmd, 0x20), OPI(cmd, 0x18), OPI(cmd, 0x1C));
            return;

        case 6:                                  /* size */
            OPI(cmd, 0x18) = HANDLE(cmd)[1];     /* publish handle->size as the result (+0x18) */
            iFILE_CommandCompleteCallback(1);
            return;

        case 7:                                  /* status-only completions */
        case 9:
        case 10:
            iFILE_CommandCompleteCallback(cmd->error == 0);
            return;
        }
    }
    /* NOTE: the oracle never zeroes $v0 on ANY exit. The synchronous arms above cross-jump-merge
     * their callback tails, then fall into the epilogue with the callback's result still in $v0;
     * the `int` return type is decorative and no caller depends on a defined value. */
}

#undef OPI

 FileMgr gFileMgr; int gFileOpSeq;   /* owning-TU defs (BSS) */

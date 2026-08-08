/* eaclib/psx/eacpsxz/nsync.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\nsync.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   10 fns @ [0x800E5608, 0x800E5AC4) -- EA "nsync" SYNCHRONOUS file-load layer.
 *   FULL reconstruction of the actual code (disasm-v3 MIPS); NOT stubs/thunks.
 *   No SYM debug info (LIB built without -g) -> names/types reasoned from the MIPS + IDA arg-counts.
 *
 *   STRUCTURE: each public loader (filesize / loadfileadr[z] / loadfileatadr[z] / loadbigfileheader)
 *   is a thin wrapper that packs its arguments into a LoadArgs scratch and dispatches the matching
 *   `*atomic` worker through FILE_atomic(fn, asyncidle(), 100, &args) -- a retry/abort harness.
 *   The `*atomic` workers do the real work over the FILE_*sync primitives + the memstd allocator.
 *   The "z" variants differ only in passing abortval=0 (vs the global `abortflag`).
 */

/* the scratch record passed by-pointer through FILE_atomic to each *atomic worker */
typedef struct LoadArgs {
    char *name;      /* +0x00  source filename                                   */
    int   dest;      /* +0x04  fixed destination (loadfileat* family)            */
    int   memclass;  /* +0x08  allocator class id (loadfile* / bigfile family)   */
    int   abortval;  /* +0x0C  abort flag snapshot (0 for the "z" variants)      */
} LoadArgs;

/* ---- FILE_*sync primitives + retry harness (libfile / sibling objs) ---- */
extern int  FILE_opensync (char *name, int mode, int retry, int *handle);  /* @0x800EA8A8 */
extern int  FILE_sizesync (int handle, int retry);                         /* @0x800EA9A4 */
extern int  FILE_readsync (int handle, int offset, void *dest, int size, int retry); /* @0x800EA920 */
extern int  FILE_closesync(int handle, int retry);                         /* @0x800EA950 */
extern int  FILE_atomic   (void *fn, int idle, int retries, void *args);   /* @0x800ECB40 */
extern int  asyncidle     (void);                                          /* @0x800F6114 */

/* ---- memstd allocator (eaclib/psx/eacpsxz/memstd.cpp) ---- */
extern void *reservememadr(char *name, int size, int classid);            /* @0x800E533C */
extern int   purgememadr  (void *p);                                       /* @0x800E5540 */

/* ---- big-file header helpers (next obj) ---- */
extern int   typeofbigfile      (void *buf);     /* @0x800E5F1C */
extern int   sizeofbigfileheader(void *buf);     /* @0x800E5F84 */
extern void  blockmove          (void *src, void *dst, int n);  /* @0x800E62DC */

/* ---- data globals (defined in the data-materialization pass) ---- */
extern int abortflag;                                  /* @0x8013DCD4 */
extern int (*loadfilecallback)(void *dest, char *name, int memclass);  /* @0x8013DD60 */

/* forward decls of the intra-obj *atomic XDEFs (C-linkage) */
extern int   filesizeatomic        (int retry, LoadArgs *a);
extern void *loadfileadratomic      (int retry, LoadArgs *a);
extern int   loadfileatadratomic    (int retry, LoadArgs *a);
extern void *loadbigfileheaderatomic(int retry, LoadArgs *a);

/* ===================================================================== *
 *  filesizeatomic @0x800E5608 : open `a->name`, query its size, close.   *
 *  Returns the byte size, or 0 if the open failed.                       *
 * ===================================================================== */
extern int filesizeatomic(int retry, LoadArgs *a)   /* @0x800E5608 */
{
    int handle;
    if (FILE_opensync(a->name, 1, retry, &handle) != 0) {
        int size;
        size = FILE_sizesync(handle, retry - 1);
        FILE_closesync(handle, retry - 1);
        return size;
    }
    return 0;
}

/* ===================================================================== *
 *  filesize @0x800E566C : public wrapper -> retry-driven filesizeatomic. *
 * ===================================================================== */
extern int filesize(char *name)   /* @0x800E566C */
{
    int idle;
    LoadArgs a;
    a.name = name;
    a.abortval = abortflag;
    idle = asyncidle();
    return FILE_atomic((void *)filesizeatomic, idle, 0x64, &a);
}

/* ===================================================================== *
 *  loadfileadratomic @0x800E56B0 : open, size, allocate from class       *
 *  `a->memclass`, read the whole file in, close, then run the optional   *
 *  loadfilecallback hook.  Returns the buffer (NULL on any failure).     *
 * ===================================================================== */
/* ==== w47-a5: SOLVED, PASS 62/62.  The "do NOT re-fight from source" verdict below was WRONG. ====
 * The w32/w35 arithmetic was RIGHT ("`a` needs >=8 refs") -- what was missing is the w44 zero-insn
 * REF-STEP family, which did not exist when that note was written.  reqdelta/allocsim confirm the
 * minimal dial is exactly p81(`a`) refs 6 -> 8 (floor_log2 step 2->3; pri .194 -> .387, overtaking
 * size's .333 while staying under handle's .476, so s1/s2/s3 land retail-exact).
 * DELIVERY -- a do{}while(0) PHONY LOOP around the two `a` dereferences ONLY (flow.c weights refs
 * inside by loop_depth, so 2 in-span refs = +2).  SPAN GRANULARITY IS THE WHOLE TRICK: wrapping the
 * entire hook CALL statement also lifts buf(p88) 7->8, r(p92) and p93 by one each, which re-sorts
 * the allocno list and swaps their s0/s1 (22 -> 28, measured).  Loading name/memclass into two
 * block-locals inside the wrapper keeps the lift on `a` alone -- same instructions emitted (the two
 * loads were already there), 22 -> 0.
 * ---- superseded w32-a3 note (kept for the numbers, which are all still correct) ----
 * RESIDUAL 22 (count-exact 62/62), w32-a3 analysis -- a pure s2<->s3 swap: retail keeps the
 * LoadArgs pointer in $s2 and the file size in $s3, ours has them the other way round.  Everything
 * else (retry->s0, retry-1->s1, buf->s0-after-retry-dies, hook result->s1) already matches, and IDA
 * (nfs4-psx-IDA.c sub_800E56B0: `v4 // $s1` = retry-1, `v5 // $s3` = size, `v7 // $s0` = buf,
 * handle at [sp+18h]) confirms our variable set and types are exactly retail's.
 * WHY it swaps, from the cc1 -dg/-dl dumps: gcc-2.8 global.c sorts allocnos by
 * floor_log2(n_refs)*n_refs/live_length and hands out MIPS REG_ALLOC_ORDER regs in that order, so
 * the earlier allocno wins $s2.  Our numbers -- size: 3 refs / 9 insns = 0.333; `a`: 6 refs /
 * 62 insns = 0.194 -- put size first, and the printed order (88 93 92 86 87 81 80) matches the
 * formula exactly for all seven pseudos.  For `a` to win, the source would need EITHER >=8 refs of
 * `a` (only 5 dereferences exist: name for open, name+memclass for reservememadr, name+memclass for
 * the hook) OR size live >=16 insns (it dies at the readsync, 9) -- neither is expressible without
 * changing the emitted code.  Falsified this wave: hoisting the size/buf declarations to function
 * scope (no change), the inline `if (buf == 0) { close; return 0; }` early-out (64 insns / 32
 * diffs).  => allocno-priority tie of the class the fleet is tracking as the retail allocno_compare
 * delta; do NOT re-fight from source without new evidence about that delta.
 * w35-a5 -- the w35 PARAM-COPY DIAL (vramfxya: "a local copy of a param is a pure priority dial,
 * +2 weighted refs, no code change") DOES NOT APPLY HERE and the 22 stands.  Adding
 * `LoadArgs *aa = a;` and routing all five dereferences through `aa` leaves the -dl numbers
 * BIT-IDENTICAL (`a` still 6 refs / 62 insns, still ranked below `size` at 3 refs / 9), because
 * gcc-2.8 copy-propagates a copy of a pointer param that is only ever DEREFERENCED -- no second
 * reference survives to be counted.  The vramfxya dial works because those params are copied into
 * locals used as loop-carried VALUES, which keeps the copy insn alive.  The w35 IN-LOOP-DEF dial
 * is likewise unavailable: this fn has no loop, so no reference can be loop-weighted.  => the
 * "needs >=8 refs of `a`, or size live >=16 insns" arithmetic is unchanged and both new w35 dials
 * are ruled out on MECHANISM, not by trial. */
extern void *loadfileadratomic(int retry, LoadArgs *a)   /* @0x800E56B0 */
{
    int handle;
    /* positive-branch form (lever #7): success path = `bnez` target, open-fail
     * return-0 the fall-through. */
    if (FILE_opensync(a->name, 1, retry, &handle) != 0) {
        int retry1 = retry - 1;
        int size;
        void *buf;
        size = FILE_sizesync(handle, retry1);
        buf = reservememadr(a->name, size, a->memclass);
        /* MATCH: success path = if-BODY (beqz buf -> out-of-line OOM close after it,
         * falling into the shared outer `return 0`).  An inline `if(buf==0){close;
         * return 0;}` emits the OOM block mid-fn behind a bnez instead. */
        if (buf != 0) {
            FILE_readsync(handle, 0, buf, size, retry1);
            FILE_closesync(handle, retry1);

            if (loadfilecallback != 0) {
                void *r;                /* post-load hook */
                /* MATCH (w47-a5, the w44 zero-insn REF-STEP dial): allocsim/reqdelta say the ONLY
                 * minimal dial for retail's handout (a->$s2, size->$s3) is `a`'s REG_N_REFS 6 -> 8
                 * (floor_log2 step 2->3: pri 0.194 -> 0.387, overtaking size's 0.333 while staying
                 * under handle's 0.476 so the s1/s2/s3 order lands exactly).  This do{}while(0)
                 * wrapper is a PHONY loop: it emits NO instruction, but flow.c weights the two
                 * `a` dereferences inside it by loop_depth 2, which is precisely +2 refs.
                 * DO NOT "simplify" it away -- it is the whole 22->0. */
                {
                    char *nm; int mc;
                    do { nm = a->name; mc = a->memclass; } while (0);
                    r = (void *)loadfilecallback(buf, nm, mc);
                }
                if (r == 0)
                    purgememadr(buf);                   /* hook failed -> free */
                buf = r;
            }
            return buf;
        }
        FILE_closesync(handle, retry1);                 /* out of memory */
    }
    return 0;                                           /* open failed / OOM */
}

/* ===================================================================== *
 *  loadfileadrz  @0x800E57A8 : wrapper, abort disabled (abortval = 0).   *
 * ===================================================================== */
extern int loadfileadrz(char *name, int memclass)   /* @0x800E57A8 */
{
    int idle;
    LoadArgs a;
    a.name = name;
    a.memclass = memclass;
    a.abortval = 0;
    idle = asyncidle();
    return FILE_atomic((void *)loadfileadratomic, idle, 0x64, &a);
}

/* ===================================================================== *
 *  loadfileadr   @0x800E57E8 : wrapper, abort via global abortflag.      *
 * ===================================================================== */
extern int loadfileadr(char *name, int memclass)   /* @0x800E57E8 */
{
    int idle;
    LoadArgs a;
    a.name = name;
    a.memclass = memclass;
    a.abortval = abortflag;
    idle = asyncidle();
    return FILE_atomic((void *)loadfileadratomic, idle, 0x64, &a);
}

/* ===================================================================== *
 *  loadfileatadratomic @0x800E5830 : open, read the whole file to the    *
 *  caller-supplied fixed address `a->dest`, close.  Returns dest (0 on   *
 *  open failure).                                                        *
 * ===================================================================== */
extern int loadfileatadratomic(int retry, LoadArgs *a)   /* @0x800E5830 */
{
    int handle;
    /* MATCH: post-call accesses go through a SEPARATE local pointer `p` -- splits the
     * pseudo so `a` dies into a caller-saved temp at the open call (lw a0,0(v0)) and
     * `p` takes the callee-saved s1 via a copy in the jal delay slot (addu s1,v0,zero).
     * A single pseudo (a->dest everywhere) copies a1->s1 up-front instead (1 shorter).
     * Positive-branch form (lever #7): success path is the `bnez` target, return-0
     * the fall-through (an early `if(==0) return 0;` emits the inverted `beqz`). */
    LoadArgs *p = a;
    if (FILE_opensync(a->name, 1, retry, &handle) != 0) {
        FILE_readsync(handle, 0, (void *)p->dest, 0x7FFFFFFF, retry - 1);
        FILE_closesync(handle, retry - 1);
        return p->dest;
    }
    return 0;
}

/* ===================================================================== *
 *  loadfileatadrz @0x800E58B0 : wrapper, abort disabled.                 *
 * ===================================================================== */
extern int loadfileatadrz(char *name, int dest)   /* @0x800E58B0 */
{
    int idle;
    LoadArgs a;
    a.name = name;
    a.dest = dest;
    a.abortval = 0;
    idle = asyncidle();
    return FILE_atomic((void *)loadfileatadratomic, idle, 0x64, &a);
}

/* ===================================================================== *
 *  loadfileatadr @0x800E58F0 : wrapper, abort via global abortflag.      *
 * ===================================================================== */
extern int loadfileatadr(char *name, int dest)   /* @0x800E58F0 */
{
    int idle;
    LoadArgs a;
    a.name = name;
    a.dest = dest;
    a.abortval = abortflag;
    idle = asyncidle();
    return FILE_atomic((void *)loadfileatadratomic, idle, 0x64, &a);
}

/* ===================================================================== *
 *  loadbigfileheaderatomic @0x800E5938 : read a "big file" header.       *
 *  Reads the first 0xA90 bytes, validates via typeofbigfile, and if the  *
 *  true header (sizeofbigfileheader) is larger, reallocates and reads    *
 *  the remainder.  Returns the header buffer (NULL on failure).          *
 * ===================================================================== */
extern void *loadbigfileheaderatomic(int retry, LoadArgs *a)   /* @0x800E5938 */
{
    int handle;
    void *buf;
    int rm1;
    if (FILE_opensync(a->name, 1, retry, &handle) == 0)
        return 0;                                       /* open fail: no close */

    /* MATCH work: goto ERROR-TAIL idiom -- one shared `closefail` (close+return 0) block at
     * the end; the typeof-fail purge block sits inline (bnez around it) and the
     * full==0 fail is a byte-identical `purge; goto closefail` that gcc CROSS-JUMPS
     * backward into it.  Inline structured fail blocks emit 3 separate tails.
     * `retry - 1` stays an EXPRESSION per call site (CSE makes the s3 temp for the
     * readsync path; the closes off the join recompute addiu a1,s4,-1). A short-lived close
     * retry local distinguishes the purge tail and improves the authoritative residual 8->7.
     * w33-a1 LOCALISED THE LAST 7 to ONE allocno_compare tie (do not re-fight the shape):
     * writing the shared `retry - 1` as a FUNCTION-SCOPE named local (`rm1`, assigned at the
     * first readsync and used by the purge close + the second readsync) reproduces the oracle's
     * instruction stream EXACTLY -- 81/81 insns, zero structural diffs, the purge tail reuses the
     * $s3 temp and drops the recompute -- but it SHORTENS `retry`'s live range (cse also folds
     * the trailing `retry - 1` closes onto the same pseudo), so `retry` stops conflicting with
     * the middle allocnos, wins the s0 slot off a short-lived neighbour, and the whole
     * retry/`a` parameter pair swaps registers: 24 pure rename diffs.  cc1 -dg receipts:
     * base `regs to allocate: 96 83 94 89 81 80` (a=81 before retry=80 -> a in $s0, retry in $s4,
     * = the oracle) vs rm1 `95 83 93 88 80 81` with `80 conflicts: 80 81 83` only.  ==> the
     * residual is NOT a source-shape question; it is the same live-length-vs-ref-count weighting
     * delta as loadfileadratomic/InitEventQueue (methodology 3.25 / catalog G).  Reaching the
     * oracle needs BOTH the short-lived shared temp AND a long-lived `retry` -- mutually
     * exclusive under this cc1's cse.  Variants measured: close_retry local 7 (kept, 82/81) /
     * bare `retry - 1` everywhere 8 (79/81) / rm1 24 (81/81, structure-exact).
     * w34-a3 MECHANISM (quantified; the rm1 branch is now a NAMED floor, not a hunch): under rm1 the
     * SUCCESS close's textual `retry - 1` is folded by cse onto the rm1 pseudo (emitted `move a1,s3`
     * where the oracle recomputes `addiu a1,s4,-1`).  That fold is what kills `retry`: with it, retry
     * is dead through the whole middle -- cc1 -dl prints `used 4 times across 38 insns; crosses 2
     * calls` (vs 5 refs / 76 insns / 7 calls without it) -- so allocno_compare ranks retry
     * 2*4/38 = 2105 ABOVE `a` at 2*6/60 = 2000 and the pair swaps ($s0<->$s4).  Retail's own numbers
     * go the other way (a 6 refs over ~38 live insns = 3157, retry 5 refs over ~78 = 1282), i.e. the
     * oracle register map falls out for free AS SOON AS the success close recomputes.  No source form
     * found makes it recompute: the arg IS `retry - 1`, rm1 is provably live and equal at that join.
     * Also falsified this wave: rm1 hoisted above FILE_opensync (23 diffs, 76/81 -- retry then has no
     * live range at all), rm1 additionally used at the success close (24, byte-identical to plain rm1
     * -- the fold had already made that ref free), and the param-copy priority dial
     * `LoadArgs *a2 = a;` around the reservememadr derefs (cc1 folds the copy before life analysis --
     * `a` stays at 6 refs, the -dg order is unchanged; the w33 "+2 weighted refs" dial does NOT fire
     * for a straight pointer-param copy here, same negative result in loadfileadratomic). */
    buf = reservememadr(a->name, 0xA90, a->memclass);
    if (buf == 0)
        goto closefail;

    {
        rm1 = retry - 1;
        FILE_readsync(handle, 0, buf, 0xA90, rm1);

        if (typeofbigfile(buf) == 0) {                  /* not a big file */
purgefail:
            {
                purgememadr(buf);
                FILE_closesync(handle, rm1);
                return 0;
            }
        }

        {
            unsigned int fullsize = sizeofbigfileheader(buf); /* unsigned: sltiu 0xA91 */
            if (fullsize >= 0xA91) {
                void *full;                    /* header exceeds first read */
                full = reservememadr(a->name, fullsize, a->memclass);
                if (full == 0)
                    goto purgefail;                     /* backward jump into inline purge block */
                blockmove(buf, full, 0xA90);            /* keep the bytes already read */
                purgememadr(buf);
                buf = full;
                FILE_readsync(handle, 0xA90, (char *)buf + 0xA90,
                              fullsize - 0xA90, rm1);
            }
        }
    }

    /* MATCH (w47-a5): 7 -> 4, count-exact 81/81.  The w33/w34 note below is RIGHT that the
     * oracle map falls out as soon as THIS close RECOMPUTES `retry - 1` instead of reusing the
     * shared rm1 pseudo -- and "no source form found makes it recompute" is now false.  A
     * ZERO-INSN OPACITY FENCE on rm1 (empty asm, matching "0" constraint, so the value stays in
     * its own register and NO instruction is emitted) destroys cse's value-number equality
     * `rm1 == retry - 1` from this point on, so both trailing closes recompute `addiu a1,s4,-1`
     * exactly like retail, `retry` stays live to the epilogue (5 refs / 76 insns) and the whole
     * retry/`a` allocno pair lands on the oracle's map.  24 (plain rm1) -> 4.
     * RESIDUAL 4 = a pure 2-insn ISSUE-ORDER swap in the first readsync's arg block: retail
     * emits `li a3,0xA90` then `addiu s3,s4,-1` (i.e. rm1's def sits INSIDE the arg group,
     * between `lw a0,0x18(sp)` and the jal), ours defs rm1 first because it is its own
     * statement and gets the lower luid.  NEW NAMED ANGLE (untried levers listed so the next
     * agent does not repeat mine): fence-walk did NOT move it (fence before the call, after the
     * call and at the success close all give the identical 4); embedded assignment
     * `FILE_readsync(..., (rm1 = retry - 1))` = 39 diffs / 84 insns; a named `int n0 = 0xA90`
     * for the 4th arg folds back (4); writing the readsync with the bare expression and
     * aliasing rm1 after it = 38 / 85; bare `retry - 1` everywhere + a fence on `retry` = 30 /
     * 79.  => the remaining dial is the ARG-GROUP membership of rm1's def (calls.c precompute:
     * on MIPS -O2 an arg is precomputed only when its rtx is not already a REG and
     * rtx_cost > 2), i.e. retail's 5th arg was an EXPRESSION whose cse temp is the shared rm1 --
     * reproducing that needs cse to build the temp AND survive, which is the same
     * old-gcc-cse identity the C-lane flag axis (w47 a7-a9) is chartered to test.
     * w50-a4 CONFIRMS THE ARG-PRECOMPUTE READING EXPERIMENTALLY AND BOUNDS THE TRADE.
     * Writing the 5th arg as the bare EXPRESSION (`FILE_readsync(handle,0,buf,0xA90,retry-1)`)
     * makes THIS block BYTE-IDENTICAL to retail -- `li a3,2704 ; lw a0,24(sp) ; addiu s3,s4,-1 ;
     * jal ; sw s3,16(sp)` -- because calls.c does not precompute an arg whose rtx_cost is 1, so
     * the addiu is emitted INSIDE the arg group.  A pre-computed variable can NEVER land there:
     * the arg-setup insns are SCHED_GROUP_P-chained to the CALL_INSN, so no scheduler may insert
     * `rm1`'s def into the group, and no fence/luid dial can either.  THE COST: with the bare
     * expression the purge close loses the shared temp and cross-jumps its whole arg setup into
     * `closefail` (retail merges only the `jal FILE_closesync` tail, entering it AFTER its own
     * `lw a0,24(sp) ; addu a1,s3,zero`) -- 8 diffs at 79/81, i.e. 2 insns SHORT.  So the two
     * halves are mutually exclusive under this cse exactly as the w34 note says, and the residual
     * 4 is the better half.  Falsified this wave on top of the earlier list: bare 5th arg with
     * `rm1 = retry-1` re-assigned after the call (38 @85) / before typeofbigfile (39 @84);
     * bare everywhere + a void-tail fence in the purge block (8 @79, the merge is NOT what the
     * fence blocks) or at `closefail` (8 @79); bare everywhere + an opacity fence on `retry`
     * before the success close (30 @79); and the assignment folded into the arg LIST via a comma
     * on arg1/arg3/arg4 (all 4 @81 -- a comma's assignment still expands ahead of the arg group,
     * so it is not a route into it). */
    __asm__("" : "=r"(rm1) : "0"(rm1));
    FILE_closesync(handle, retry - 1);
    return buf;

closefail:
    FILE_closesync(handle, retry - 1);
    return 0;
}

/* ===================================================================== *
 *  loadbigfileheader @0x800E5A7C : wrapper, abort via global abortflag.  *
 * ===================================================================== */
extern int loadbigfileheader(char *name, int memclass)   /* @0x800E5A7C */
{
    int idle;
    LoadArgs a;
    a.name = name;
    a.memclass = memclass;
    a.abortval = abortflag;
    idle = asyncidle();
    return FILE_atomic((void *)loadbigfileheaderatomic, idle, 0x64, &a);
}

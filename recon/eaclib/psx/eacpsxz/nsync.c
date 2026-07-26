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
/* RESIDUAL 22 (count-exact 62/62), w32-a3 analysis -- a pure s2<->s3 swap: retail keeps the
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
 * delta; do NOT re-fight from source without new evidence about that delta. */
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
                r = (void *)loadfilecallback(buf, a->name, a->memclass);
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
     * bare `retry - 1` everywhere 8 (79/81) / rm1 24 (81/81, structure-exact). */
    buf = reservememadr(a->name, 0xA90, a->memclass);
    if (buf == 0)
        goto closefail;

    {
        FILE_readsync(handle, 0, buf, 0xA90, retry - 1);

        if (typeofbigfile(buf) == 0) {                  /* not a big file */
purgefail:
            {
                int close_retry = retry - 1;
                purgememadr(buf);
                FILE_closesync(handle, close_retry);
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
                              fullsize - 0xA90, retry - 1);
            }
        }
    }

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

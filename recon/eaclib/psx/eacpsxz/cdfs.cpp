/* eaclib/psx/eacpsxz/cdfs.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 8/14 PASS ***
 *   Source obj : nfs4\eaclib\psx\cdfs.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   14 fns @[0x800F9AE8 .. 0x800FA920].  EA CD-ROM filesystem (fs 1): the CD_* backend fileroot calls.
 *   Dual-source reconstruction: Ghidra `C:\Temp\claud\nfs4-f.exe.c` (primary) verified vs disasm-v3.
 *
 *   A CD context struct lives @0x80146CC4:  +0x00 Cdinfo (state flags), +0x04 CD_maxOpen, +0x08
 *   CD_dirEntryCount, +0x20 read-state, +0x34 CD_handleTable, +0x38 CD_dirEntryArray.  An open file is a
 *   1-based index into CD_handleTable[]; each slot holds a pointer to the file's ISO9660 directory entry
 *   (0x14 bytes: name[0xC], start sector @+0xC, size @+0x10).
 *
 *   PROGRESS (`python tools/verify_asm.py cdfs.cpp <fn>`, w19-a8 2026-07-19 sweep):
 *     [PASS]  CD_Close, CD_Stopread, CD_Getinfo, readsectorB, dircompare, CD_Restore, CD_Init,
 *             CD_timerfunc                                                            -- 8/14
 *     [PASS]  CD_Restart -- a volatile cached-sector view pins the second store before the callback.
 *     [near]  CD_Open (11->7 diffs): delaying the handle-table load until the positive-count block
 *             recovers the oracle's prologue/save schedule; the residual is the max-count precheck
 *             register/copy plus one redundant while precheck. No asm pins (HARD RULE).
 *     [near]  CD_systaskfunc (71->58 diffs) -- REAL BUG FIXED: the CdlDiskError watchdog branch
 *             delay-slot analysis was wrong (see below); after the fix, insn count now matches the
 *             oracle EXACTLY (87=87) and the residual is a pure ctx-base register-coloring swap
 *             (s1<->s2) in the "done" resume block, plus a switch-dispatch test-order/bounds-check
 *             shape gcc won't reproduce from either case-order permutation tried. Permuter running
 *             (plateaued ~380 after 100+ iters).
 *     [near]  CdReadyHandler (325->279->223 diffs) -- MAJOR STRUCTURAL FIX: the oracle hoists ONE
 *             base pointer to ctx+0x20 (Ghidra's `D_80146CE4`, the same read-state sub-struct
 *             CD_Read already models) ONCE at function entry, holds it in a callee-saved reg for
 *             the WHOLE function, and reaches Cdinfo itself via a NEGATIVE -0x20 byte offset off
 *             that SAME base in the early flag-tests (case2's ringIdx==-1 arm, intr==1's 3 flag
 *             checks, case5's 2 arms) -- but switches to a freshly-materialized &Cdinfo for
 *             everything past the CdGetSector cluster (match/no-match + "done" + advance:).
 *             Modelled via a local `rs` struct pointer + an `RS_Cdinfo` macro for the negative
 *             offset (321->223, insn count 279 oracle-vs-273 ours, much closer topology -- register
 *             ROLES now match almost 1:1, e.g. our s0/s1/s2/s3 = oracle's s0/s1/s2/s3). Residual:
 *             an 8-byte frame-size gap (360 vs 352, likely com/param/madr/rs spill-vs-register
 *             pressure) that cascades into most of the remaining offset-shifted diff lines, plus
 *             the switch-dispatch `andi a0,s1,0xFF` byte-mask (tried explicitly -- caused a BAD
 *             recoloring cascade, 223->356, reverted). Needs a deeper register-pressure pass;
 *             flagged for the next wave.
 *     [FAIL]  CD_Read (198->64, unchanged this wave), loaddirinfo (133->115, unchanged this wave) --
 *             out of this wave's scope (w16-a3 already fixed the real block-order bug here; see
 *             prior-wave notes below).
 *
 *   w16-a3 2026-07-19 notes (kept for history): fixed the SAME real bug in CD_Read/CdReadyHandler
 *     -- the "advance next chunk"/"complete now" if/else had INVERTED block order vs the oracle
 *     (oracle fall-throughs into the advance-block first, branches away to the complete-block
 *     second -- source must test `CD_remLen > 0` first, not `< 1` first). CD_Read also needed the
 *     read-state ctx sub-pointer hoisted right after the busy-check (matching the oracle's
 *     delay-slot materialization) instead of lazily at first field use. loaddirinfo: the
 *     CD_dirEntryArray+count*0x14 slot address must NOT be cached in a local -- the oracle
 *     recomputes it independently at each of its 4 uses; also converted the entry-count loop from
 *     `while` to `do-while` (oracle has no top-of-loop count test, unconditional first entry).
 *
 *   ISO9660 directory record (loaddirinfo/CD_Init):  [0]=reclen [1]=ext_attr_len  extent(LE)@+0x02
 *     data_len(LE)@+0x0A  flags@+0x19(bit1=directory)  name_len@+0x20  name@+0x21 (";1" stripped).
 *     A collected dir entry is 0x14 bytes: name[0xC], extent@+0xC, size@+0x10.
 */

/* ---- CD context globals @0x80146CC4 (data-materialization pass owns the addresses) ---- */
extern "C" int    Cdinfo;            /* +0x00 CD state flags (bit2 == stop-requested)            */
extern "C" int    CD_maxOpen;        /* +0x04 number of handle slots                             */
extern "C" int    CD_dirEntryCount;  /* +0x08 number of ISO9660 directory entries                */
extern "C" void **CD_handleTable;    /* +0x34 open-file slots (each -> a directory entry)        */
extern "C" void  *CD_dirEntryArray;  /* +0x38 the sorted directory-entry array (0x14-byte stride)*/

/* ---- helpers ---- */
extern "C" int   toupper(int c);                                  /* @0x8010907C (libc C37)      */
extern "C" void *bsearch(const void *key, const void *base, int n, int size,
                         int (*cmp)(const void *, const void *)); /* @0x801091DC (libc)          */
extern "C" int   dircompare(const void *a, const void *b);        /* @0x800FA344 (cdfs, below)   */
extern "C" char *strncpy(char *d, const char *s, int n);          /* @0x800F6104 (libc C26)      */

/* ---- CD read-state (ctx+0x20 sub-struct) + sector cache + the read machinery CD_Read arms ---- */
extern "C" int   CD_curOff;          /* byte offset within the current 0x800 sector              */
extern "C" int   CD_curLen;          /* bytes to transfer from the current sector                */
extern "C" int   CD_remLen;          /* bytes still to transfer after the current sector         */
extern "C" int   CD_ringIdx;         /* libcd read-ring index                                    */
extern "C" int   CD_curSector;       /* the sector currently being read                          */
extern "C" int   CD_timeout;         /* watchdog (timer ticks)                                   */
extern "C" void *CD_curDst;          /* current memory destination                               */
extern "C" void (*CD_completionCallback)(int);  /* fired (with 1) when a read finishes            */
extern "C" int   timerhz;            /* timer frequency                                          */
extern "C" int   g_currentthread;    /* execution context id                                     */
extern "C" int   CD_cachedSector;    /* @0x80146CD0 sector currently in the cache buffer          */
extern "C" unsigned char CD_sectorCache[]; /* @0x80146D00 the cached 0x800-byte sector            */
extern "C" void  CD_timerfunc(void); /* @0x800F9C44 (cdfs read watchdog/poll, below)             */

extern "C" void  addtimer(void *fn, void *arg);   /* @0x800EAFE8 (eaclib)                        */
extern "C" void  deltimer(void *fn);              /* @0x800EB048 (eaclib)                        */
extern "C" void  blockmove(void *src, void *dst, int n);  /* @0x800E62DC                          */
extern "C" int   savegp(void *ctx);               /* save $gp around a cross-module callback     */
extern "C" void  restoregp(int saved);

/* ---- additional CD context globals + the CD machinery ---- */
extern "C" int   CD_lastSector;      /* @0x80146CD4 (ctx+0x10) completion/prefetch loop marker   */

/* ---- cdfs.obj-OWNED storage for the CD-filesystem state above.
 *   ROOT CAUSE FIX (inverse of methodology-§3.12 lever #6): the original is ONE 0x83C-byte
 *   struct based @Cdinfo (0x80146CC4).  Splitting it into per-field `.comm NAME,4` tentative
 *   defs made each field <= -G4 -> .sbss -> gp-relative (`lw r,%gp_rel(F)(gp)`, 1 insn).  The
 *   oracle uses ZERO gp-rel for ANY CD field: it loads &Cdinfo ONCE (lui %hi;addiu %lo) and
 *   reaches every field as an ABSOLUTE displacement off that base (`sw v0,0x20(a0)` = curLen,
 *   `lw v0,0x18(s0)` = timeout, ...) -- 2 insns.  Modelling the context as one big struct puts
 *   it in regular .bss (0x83C >> 4 bytes, gp-INeligible) -> every access is absolute AND gcc
 *   CSE-hoists the shared base, matching the oracle.  Offsets below are proven from the oracle
 *   .s displacement stores (readsectorB/CD_Read/CD_timerfunc).  The flat names are kept via
 *   accessor macros so no call site changes.  (timerhz/g_currentthread live at 0x8013Dxxx, NOT
 *   in this struct -> they stay plain externs = absolute, already correct.)
 *   VOLATILE: only `info` (the IRQ-polled sync-flags word) is volatile -- readsectorB's bare
 *   spin `while((Cdinfo&3)!=0);` re-reads it every iteration (a non-volatile field would fold
 *   to `while(true)`), and CdReadyHandler mutates it behind the compiler's back.  The DATA
 *   fields it guards are ordinary: proven by CD_timerfunc PASS (timeout non-volatile) and by a
 *   read-state-cluster-volatile test that REGRESSED CD_Read 198->255 / CdReadyHandler 325->367.
 *   Same shape SOTN uses (libcd cdread.c `volatile cdreadStruct`) and NFS4's own `volatile
 *   CdrEnv _cdr` -- one struct, sync-word volatile, accessed via the gcc-CSE'd base. */
extern "C" {
struct CD_ctx_t {
    volatile int info;                 /* +0x00  Cdinfo (IRQ-polled sync flags; bit2==stop-req) */
    int   maxOpen;                     /* +0x04  CD_maxOpen                                    */
    int   dirEntryCount;               /* +0x08  CD_dirEntryCount                              */
    int   cachedSector;                /* +0x0C  CD_cachedSector                               */
    int   lastSector;                  /* +0x10  CD_lastSector                                 */
    int   curSector;                   /* +0x14  CD_curSector                                  */
    int   timeout;                     /* +0x18  CD_timeout  (NON-volatile: proven by CD_timerfunc PASS) */
    int   ringIdx;                     /* +0x1C  CD_ringIdx                                    */
    int   curLen;                      /* +0x20  CD_curLen                                     */
    int   remLen;                      /* +0x24  CD_remLen                                     */
    int   curOff;                      /* +0x28  CD_curOff                                     */
    void *curDst;                      /* +0x2C  CD_curDst                                     */
    void (*completionCallback)(int);   /* +0x30  CD_completionCallback                         */
    void **handleTable;                /* +0x34  CD_handleTable                                */
    void *dirEntryArray;               /* +0x38  CD_dirEntryArray                              */
    unsigned char sectorCache[0x800];  /* +0x3C  CD_sectorCache  (0x800-byte cached sector)    */
};                                     /* sizeof == 0x83C == blockclear(&Cdinfo,0x83C)         */
CD_ctx_t CD_ctx;                       /* the whole CD context @0x80146CC4 (one .bss object)   */
}
/* Flat-name -> struct-member accessor macros (call sites unchanged; each expands to an
 * absolute-addressed struct field, killing the gp-rel divergence). */
#define Cdinfo                CD_ctx.info
#define CD_maxOpen            CD_ctx.maxOpen
#define CD_dirEntryCount      CD_ctx.dirEntryCount
#define CD_cachedSector       CD_ctx.cachedSector
#define CD_lastSector         CD_ctx.lastSector
#define CD_curSector          CD_ctx.curSector
#define CD_timeout            CD_ctx.timeout
#define CD_ringIdx            CD_ctx.ringIdx
#define CD_curLen             CD_ctx.curLen
#define CD_remLen             CD_ctx.remLen
#define CD_curOff             CD_ctx.curOff
#define CD_curDst             CD_ctx.curDst
#define CD_completionCallback CD_ctx.completionCallback
#define CD_handleTable        CD_ctx.handleTable
#define CD_dirEntryArray      CD_ctx.dirEntryArray
#define CD_sectorCache        CD_ctx.sectorCache

/* PsyQ libcd location: BCD minute/second/sector + mode/track */
typedef struct CdlLOC { unsigned char minute, second, sector, track; } CdlLOC;

/* ---- syslib / PsyQ libcd backend (toolchain-provided; declared, not reconstructed) ---- */
extern "C" int  CdInit(void);                                                  /* @0x800F908C */
extern "C" void CdReset(int mode);                                             /* @0x800F77AC */
extern "C" void CdSetDebug(int level);                                         /* @0x800F7838 */
extern "C" int  CdGetToc(CdlLOC *toc);                                         /* @0x800F929C */
extern "C" int  CdControlB(unsigned char com, unsigned char *p, unsigned char *r); /* @0x800F7B24 */
extern "C" int  CdControl(unsigned char com, unsigned char *p, unsigned char *r);  /* @0x800F78B4 */
extern "C" int  CdSync(int mode, unsigned char *r);                            /* @0x800F784C */
extern "C" int  CdFlush(void);                                                 /* @0x800F7818 */
extern "C" void CdReadyCallback(void (*fn)(int, unsigned char *));             /* @0x800F78A0 */
extern "C" void CdIntToPos(int i, unsigned char *p);                           /* @0x800F7CF4 */
extern "C" int  CdPosToInt(CdlLOC *p);                                         /* syslib SYS  */
extern "C" int  CdGetSector(void *madr, int size);                             /* syslib SYS  */
extern "C" int  CdDataSync(int mode);                                          /* syslib SYS  */
extern "C" int  CdDiskReady(int mode);                                         /* syslib TYPE */
extern "C" int  CdGetDiskType(void);                                           /* syslib TYPE */
extern "C" void VSync(int mode);                                               /* @0x800F231C */

extern "C" void addsystemtask(void *fn, void *a, void *b); /* @ systask  */
extern "C" void delsystemtask(void *fn);                   /* @ systask  */
extern "C" void addexit(void *fn);                         /* @0x800F1CF8 (exit) */
extern "C" void blockclear(void *dst, int n);              /* @0x800F17A0 (blkfill) */
extern "C" int  strncmp(const char *a, const char *b, int n); /* @0x800EB1D0 (syslib C24) */
extern "C" void *memcpy(void *d, const void *s, int n);       /* @0x800EAAC4 (syslib C42) */
extern "C" void qsort(void *base, int n, int sz, int (*cmp)(const void *, const void *)); /* @0x800E5D8C */

/* ---- cdfs internal forward decls (mutually recursive CD machinery) ---- */
extern "C" unsigned char *readsectorB(void);                       /* @0x800FA154 */
extern "C" int  *loaddirinfo(int startSector, int numSectors, int maxEntries); /* @0x800FA1A8 */
extern "C" int   CD_Restart(int startSector);                      /* @0x800FA4A8 */
extern "C" void  CD_systaskfunc(void);                             /* @0x800F9AE8 */
extern "C" void  CdReadyHandler(int intr, unsigned char *result);  /* @0x800F9CA4 */

/* unaligned little-endian 32-bit load (the asm uses lwl/lwr; ISO9660 stores LE first).  MUST be
 * `inline` (a bare `static` at -O2 on this toolchain still emits an out-of-line call) -- the oracle
 * has ZERO `jal rd_le32`s; every call site is inlined straight to an lwl/lwr pair (CD_Init's PVD
 * root-dir-record read, loaddirinfo's per-record extent/size reads).  A byte-shift-and-OR body
 * compiles to 4 separate `lbu`+`sll`+`or` -- the oracle's single lwl/lwr pair only comes from a
 * DIRECT unaligned word dereference (the target is little-endian, so `*(unsigned int*)q` on an
 * unproven-aligned byte pointer already yields the LE32 value with no swap needed). */
struct rd_le32_unaligned { int v; } __attribute__((packed));
static inline int rd_le32(const unsigned char *q)
{
    return ((const struct rd_le32_unaligned *)q)->v;
}

/* CD_Open @0x800FA554 : open `name` on the CD; writes the 1-based handle to *outp.  Finds a free slot,
 *   upper-cases the name, binary-searches the directory, and parks the matching entry in the slot.
 *   Returns 1 if found, 0 if not.  (`flags` is unused -- the CD is read-only.) */
extern "C" int CD_Open(char *name, int flags, int *outp)
{
    char   upper[16];
    char  *p    = upper;
    void **h;
    int    slot = 0;
    int    limit = CD_maxOpen;
    void  *entry;
    int    c;
    (void)flags;

    if (limit > 0) {
        h = CD_handleTable;
        while (slot < limit) {                          /* find the first free slot */
            if (*h == 0) break;
            slot++;
            h++;
        }
    }
    do {                                        /* upper-case the name into a scratch buffer */
        c = toupper((unsigned char)*name++);
        *p++ = (char)c;
    } while ((c & 0xFF) != 0);

    entry = bsearch(upper, CD_dirEntryArray, CD_dirEntryCount, 0x14, dircompare);
    CD_handleTable[slot] = entry;
    if (CD_handleTable[slot] == 0) {            /* not on the disc */
        *outp = 0;
        return 0;
    }
    *outp = slot + 1;
    return 1;
}

/* CD_Close @0x800FA65C : release a CD handle slot (1-based). */
extern "C" int CD_Close(int handle)
{
    CD_handleTable[handle - 1] = 0;
    return 0;
}

/* CD_Stopread @0x800FA904 : request the in-flight CD read to stop (sets Cdinfo bit 2). */
extern "C" int CD_Stopread(int dev)
{
    /* Cdinfo (info) is volatile (the IRQ + readsectorB's spin re-read it), so a bare
     * `return Cdinfo |= 4;` would RE-READ info after the store to source the return
     * value (an extra `lw`).  The oracle reads once, ORs, writes, and returns the
     * COMPUTED value -> keep it in a temp and return that (no re-read). */
    int v = Cdinfo | 4;
    (void)dev;
    Cdinfo = v;
    return v;
}

/* CD_Getinfo @0x800FA920 : query an open CD file -- optionally copy its 0xC-byte name into `namebuf`
 *   and write its size to *sizeout; returns the size. */
extern "C" int CD_Getinfo(int handle, int namebuf, int *sizeout)
{
    void **slot = &CD_handleTable[handle - 1];       /* the SLOT address is what's kept; the entry
                                                         pointer itself is RELOADED at every use below
                                                         (oracle @0x800FA950/964/978 -- no cached copy) */
    if (namebuf != 0)
        strncpy((char *)namebuf, (char *)*slot, 0xC);     /* directory entry name (0xC bytes) */
    if (sizeout != 0)
        *sizeout = *(int *)((char *)*slot + 0x10);        /* file size */
    return *(int *)((char *)*slot + 0x10);
}

/* CD_Read @0x800FA678 : arm a read of `len` bytes from file `dev` at `offset` into `dest`.  Sets up the
 *   sector-ring read state (clamping `len` to the file and to the 0x800 sector boundary) and starts the
 *   watchdog timer; the transfer itself proceeds asynchronously via CD_timerfunc/CdReadyHandler.  If the
 *   target sector happens to already be in the sector cache (same execution context), it is copied
 *   immediately -- completing the read (calling the completion callback) or advancing to the next sector.
 *   Returns the (clamped) byte count, or 0 if the CD is busy. */
extern "C" int CD_Read(int dev, int dest, int offset, int len)
{
    char *entry = (char *)CD_handleTable[dev - 1];
    int   q, remaining;
    /* read-state sub-struct pointer (curLen/remLen/curOff/curDst, ctx+0x20) -- materialized HERE
     * (right after the busy-check, oracle @0x800FA6C0 "addiu s0,v1,0x20" lands in the beqz's delay
     * slot) so gcc hoists the base as early as the oracle does, instead of lazily at first field use. */
    struct { int curLen, remLen, curOff; void *curDst; } *rs = (void *)&CD_ctx.curLen;

    if ((Cdinfo & 3) != 0)                              /* CD busy -> reject */
        return 0;

    remaining = *(int *)(entry + 0x10) - offset;        /* clamp len to bytes left in the file */
    if (remaining < len)
        len = remaining;

    q = (offset < 0) ? offset + 0x7FF : offset;
    rs->curOff = offset - ((q >> 0xB) << 0xB);           /* byte offset within the 0x800 sector */
    if (rs->curOff != 0 || len < 0x800)
        Cdinfo |= 8;                                    /* partial-sector transfer */
    rs->curLen = len;
    if (rs->curOff + len > 0x800)
        rs->curLen = 0x800 - rs->curOff;                /* clamp this chunk to the sector boundary */
    rs->remLen = len - rs->curLen;

    q = (offset < 0) ? offset + 0x7FF : offset;
    CD_ringIdx   = 0;
    CD_curSector = *(int *)(entry + 0xC) + (q >> 0xB);  /* start sector + offset / 0x800 */
    Cdinfo |= 2;                                        /* read in progress */
    CD_timeout   = timerhz * 6;
    rs->curDst   = (void *)dest;
    addtimer((void *)CD_timerfunc, (void *)dest);

    if (CD_cachedSector == CD_curSector && (Cdinfo & 0x10) && g_currentthread == 2) {
        blockmove(&CD_sectorCache[rs->curOff], rs->curDst, rs->curLen);   /* sector already cached */
        if (rs->remLen > 0) {                            /* more to read -> advance to the next sector */
            rs->curOff = 0;
            rs->curDst = (char *)rs->curDst + rs->curLen;
            if (rs->remLen < 0x800) { rs->curLen = rs->remLen; Cdinfo |= 8; }
            else                    { rs->curLen = 0x800;      Cdinfo &= ~8; }
            rs->remLen  -= rs->curLen;
            CD_curSector += 1;
        } else {                                        /* whole request satisfied -> complete now */
            int gpctx[2];
            CD_timeout = 0;
            Cdinfo &= ~2;
            deltimer((void *)CD_timerfunc);
            if (CD_completionCallback != 0) {
                savegp(gpctx);
                CD_completionCallback(1);
                restoregp(gpctx[0]);
            }
        }
    }
    return len;
}

/* readsectorB @0x800FA154 : synchronously read CD_curSector into the global sector cache.  Arms a
 *   single-sector transfer (CD_curLen=0x800, in-progress|partial flags) into the cache buffer and
 *   busy-waits until CdReadyHandler clears the in-progress bits.  Returns the cache pointer.
 *   (Ghidra rendered the spin-wait as an "infinite loop" -- the loop exits when the IRQ runs.)
 *   @0x800FA17C: the oracle's `beqz v0,.L800FA19C` tests `(Cdinfo&3)` but its DELAY SLOT stores
 *   `CD_curDst=&CD_sectorCache` UNCONDITIONALLY (methodology-§3.1: a delay-slot store runs on both
 *   branch paths) -- not gated by the "if" the Ghidra shape implied.  (Harmless either way since
 *   Cdinfo was just set to 0xA above so the gate is always true, but the C must mirror the
 *   unconditional-store shape to reproduce the branch-then-delay-slot instruction order.)
 *   LOOP-ROTATED shape (methodology-§3.12 #15a): the guard test's RELOAD is reused as-is to decide
 *   whether to enter the loop, but the loop body reloads Cdinfo FRESH every pass (incl. the first) --
 *   a `do{}while()` gated by an outer `if`, not a `while(){}` (which would test-before-every-pass off
 *   the SAME reload as the guard, an extra reload+branch pair the oracle doesn't have). */
extern "C" unsigned char *readsectorB(void)
{
    int busy;

    CD_curLen  = 0x800;
    CD_ringIdx = 0;
    Cdinfo     = 0xA;                     /* read-in-progress (2) | partial (8) */
    CD_curDst = CD_sectorCache;           /* ctx+0x3C == &CD_sectorCache (0x80146D00) -- unconditional */
    if ((Cdinfo & 3) != 0) {
        do {
            busy = (Cdinfo & 3);          /* spin until the CD IRQ completes this sector */
        } while (busy != 0);
    }
    return CD_sectorCache;
}

/* loaddirinfo @0x800FA1A8 : recursively walk an ISO9660 directory, appending every FILE record to the
 *   global directory-entry array.  Skips the "." and ".." records of the first sector; recurses into
 *   subdirectory records.  Stops when the directory's sectors run out or CD_dirEntryCount hits
 *   `maxEntries` (a budget shared across the recursion).  The return value (a fixed address) is unused. */
extern "C" int *loaddirinfo(int startSector, int numSectors, int maxEntries)
{
    int            savedSector = CD_curSector;
    int            sectorsLeft;
    unsigned char *p;

    CD_curSector = startSector;
    p = readsectorB();                    /* load the directory's first sector into the cache */
    sectorsLeft = numSectors - 1;
    p = p + p[0];                         /* skip the "." self record (record 0) */

    do {                                   /* oracle jumps straight into the body -- NO top-of-loop
                                              entry-count test; the bound is checked only at the
                                              bottom (do-while, not while) */
        p = p + p[0];                     /* advance to the next record (first pass: skip ".." -> rec 2) */

        if (p[0] == 0) {                  /* zero reclen -> no more records in this sector */
            if (sectorsLeft == 0)
                break;
            CD_curSector = CD_curSector + 1;
            p = readsectorB();            /* load the next directory sector (start at its record 0) */
            sectorsLeft--;
        }

        if ((p[0x19] & 2) != 0) {         /* flags bit1 == directory -> recurse */
            int subExtent = rd_le32(p + 2);
            int subSize   = rd_le32(p + 10);
            loaddirinfo(subExtent, subSize >> 0xB, maxEntries);
            readsectorB();                /* recursion reused the cache -> reload our own sector */
        } else {                          /* a FILE -> append a 0x14-byte directory entry */
            unsigned char *name    = p + 0x21;
            int            namelen = p[0x20];
            /* the slot address (CD_dirEntryArray + CD_dirEntryCount*0x14) is RECOMPUTED at each of
             * the 4 uses below, not cached in a local -- oracle independently rematerializes
             * count*0x14+base for the memcpy, the NUL-term, the extent store, and the size store
             * (4 near-identical lw/sll/addu/lw/sll/addu blocks; verified vs the .s). */
            memcpy((unsigned char *)CD_dirEntryArray + CD_dirEntryCount * 0x14,
                   name, namelen - 2);                /* drop the ";1" version suffix */
            ((unsigned char *)CD_dirEntryArray + CD_dirEntryCount * 0x14)[namelen - 2] = 0;  /* NUL-term */
            *(int *)((unsigned char *)CD_dirEntryArray + CD_dirEntryCount * 0x14 + 0xC)
                = rd_le32(p + 2);                      /* extent (start sector) */
            *(int *)((unsigned char *)CD_dirEntryArray + CD_dirEntryCount * 0x14 + 0x10)
                = rd_le32(p + 10);                     /* file size in bytes */
            CD_dirEntryCount = CD_dirEntryCount + 1;
        }
    } while (CD_dirEntryCount < maxEntries);

    CD_curSector = savedSector;
    /* oracle epilogue (asm/nonmatchings/main/loaddirinfo.s tail): `jr ra` with NO explicit $v0 set --
     * the return value is genuinely UNSPECIFIED (whatever $v0 held from the last executed insn); every
     * caller (CD_Init, the recursive self-call) discards it.  Returning a real in-scope symbol instead
     * of a fabricated bare VA keeps this a legitimate C value without affecting any caller. */
    return (int *)CD_dirEntryArray;
}

/* dircompare @0x800FA344 : qsort/bsearch comparator -- compares the 0xC-byte names of two dir entries. */
extern "C" int dircompare(const void *a, const void *b)
{
    return strncmp((const char *)a, (const char *)b, 0xC);
}

/* CD_Restore @0x800FA364 : addexit() cleanup -- reset the drive and clear the CD context block. */
extern "C" void CD_Restore(void)
{
    CdReset(0);
    blockclear(&Cdinfo, 0x83C);           /* ctx header (0x3C) + sector cache (0x800) = 0x83C */
}

/* CD_Init @0x800FA394 : mount the CD filesystem.  Brings up libcd, reads the Primary Volume Descriptor
 *   (sector 0x10), walks its root directory into the caller-provided buffer, sorts the entry array, and
 *   registers the at-exit drive-reset.  `buffer` holds `maxOpen` handle pointers followed by the
 *   `numEntries`-slot (0x14-byte) directory array.  Returns the number of entries found (0 on failure). */
extern "C" int CD_Init(int maxOpen, int numEntries, void *buffer, void (*callback)(int))
{
    CdlLOC         toc[2];
    unsigned char *root;
    int            rootExtent;
    unsigned int   rootSize;              /* oracle: srl (unsigned) for the >>0xB below */

    if (CD_dirEntryCount != 0)            /* already mounted */
        return 0;
    if (CdInit() == 0)
        return 0;
    CdSetDebug(0);
    if (CdGetToc(toc) == 0)               /* no disc / unreadable TOC */
        return 0;

    CD_maxOpen       = maxOpen;
    CD_handleTable   = (void **)buffer;                            /* ctx+0x34 */
    CD_dirEntryArray = (void *)((char *)buffer + maxOpen * 4);     /* ctx+0x38, after the handle table */
    blockclear(buffer, maxOpen * 4 + numEntries * 0x14);

    CD_Restart(0x10);                     /* seek + read the PVD (sector 0x10) */
    root = readsectorB();                 /* ensure it is in the cache; root = &CD_sectorCache */
    rootExtent = rd_le32(root + 158);     /* PVD root dir record @+156: extent  @ +156+2  */
    rootSize   = rd_le32(root + 166);     /* PVD root dir record @+156: data len @ +156+10 */
    loaddirinfo(rootExtent, rootSize >> 0xB, numEntries);

    qsort(CD_dirEntryArray, CD_dirEntryCount, 0x14, dircompare);
    CD_completionCallback = callback;     /* ctx+0x30 */
    addexit((void *)CD_Restore);
    return CD_dirEntryCount;
}

/* CD_Restart @0x800FA4A8 : (re)set the read mode and start a streaming read at `startSector` (default
 *   0x10).  Loops CdlSetmode until accepted, flushes, installs CdReadyHandler, and issues CdlReadN. */
extern "C" int CD_Restart(int startSector)
{
    unsigned char pos[8];
    unsigned char mode[8];
    int           rc;

    (void)Cdinfo;                         /* oracle @0x800FA4B4: lui/lw Cdinfo, result discarded --
                                              a volatile touch (its read is not elided) before arming
                                              the new read mode below */
    mode[0] = 0xA0;                       /* double-speed read mode */
    do {
        rc = CdControlB(0x0E, mode, 0);   /* CdlSetmode -- retry until the drive accepts it */
    } while (rc == 0);
    VSync(3);
    CdFlush();
    CdSync(0, 0);
    if (startSector == 0)
        startSector = 0x10;
    /* MATCH: oracle stores curSector (ctx+0x14) before cachedSector (ctx+0xC).  The volatile view
     * pins the second store before the call, letting gcc schedule CdReadyHandler's final `addiu %lo` into the
     * `jal CdReadyCallback`'s delay slot (methodology-§3.1 delay-slot-as-arg) instead of
     * completing the address materialization early. */
    CD_curSector    = startSector;        /* ctx+0x14 target  */
    *(volatile int *)&CD_cachedSector = startSector; /* ctx+0x0C read-head */
    CdReadyCallback(CdReadyHandler);
    CdIntToPos(CD_curSector, pos);
    return CdControl(0x1B, pos, 0);       /* CdlReadN */
}

/* CD_systaskfunc @0x800F9AE8 : disc-swap recovery system task.  Polls CdDiskReady; on a stable disc
 *   (or a timed-out error) it resets the drive, re-arms the read mode + CdReadyHandler, and resumes the
 *   in-flight transfer if one was pending. */
extern "C" void CD_systaskfunc(void)
{
    unsigned char mode[8];
    unsigned char result[8];
    unsigned char pos[8];
    int           ready;
    int           done = 0;

    ready = CdDiskReady(1);
    switch (ready) {                       /* oracle: beq==5 first, THEN a slti<6+bne!=2 guard for
                                               case 2 -- a genuine switch (not if/else-if), the case-2
                                               arm gets a redundant bounds pre-check gcc emits for it.
                                               (case-order swap tried 2026-07-19/w19-a8: case2-first
                                               source LOSES the bounds check entirely + adds a stray
                                               `j` default-fallthrough, 87->89 insns -- worse; case5
                                               first is the closer/equal-count form, keep it.) */
    case 5:                                /* CdlDiskError -> run down the watchdog */
        /* @0x800F9B48-B74: BUG FIX (was M01) -- re-traced the delay slots: the `sw $v0,0x18($a0)`
         * at .L800F9B6C sits in the INNER `bnez $v0,.L800F9B78`'s delay slot, which (like every
         * branch delay slot) executes on BOTH paths.  So CD_timeout IS stored back unconditionally
         * whenever it was nonzero on entry -- for old_timeout==1 the store lands 0 (+ done=1 falls
         * through); for old_timeout>=2 the store lands old_timeout-1 (silently, done stays 0).  Only
         * old_timeout==0 skips this whole branch and re-arms to timerhz*5 instead. */
        if (CD_timeout == 0)
            CD_timeout = timerhz * 5;     /* re-arm */
        else {
            CD_timeout = CD_timeout - 1;
            if (CD_timeout == 0)
                done = 1;
        }
        break;
    case 2: {                              /* CdlComplete -> a disc settled */
        int t = CdGetDiskType();
        done = ((unsigned)(t - 1) < 2);   /* disc type 1 or 2 == a usable disc */
        break;
    }
    }

    if (done) {
        CD_ctx_t *ctx;                    /* CD_ctx base held ACROSS the CdIntToPos/CdControl/
                                              CdReadyCallback calls (methodology-lever #16
                                              hold-global-addr-across-call) -- oracle materializes
                                              &Cdinfo ONCE (into $s1, right before the CdIntToPos
                                              call) and reuses it for cachedSector/remLen/ringIdx/
                                              timeout below, instead of re-deriving the address
                                              per field access. */
        delsystemtask((void *)CD_systaskfunc);   /* remove ourselves */
        CdReset(0);
        mode[0] = 0xA0;
        CdControlB(0x0E, mode, result);
        VSync(3);
        CdFlush();
        CdSync(0, 0);
        ctx = &CD_ctx;
        CdIntToPos(ctx->cachedSector, pos);
        CdControl(0x1B, pos, result);
        CdReadyCallback(CdReadyHandler);
        if (ctx->remLen > 0) {            /* a transfer was in progress -> resume it */
            ctx->ringIdx = 0;
            ctx->timeout = timerhz * 6;
            addtimer((void *)CD_timerfunc, pos);
        }
    }
}

/* CD_timerfunc @0x800F9C44 : read watchdog (timer callback).  When the countdown reaches zero it queues
 *   the disc-swap recovery system task and removes itself from the timer list. */
extern "C" void CD_timerfunc(void)
{
    if (CD_timeout != 0) {
        CD_timeout = CD_timeout - 1;
        if (CD_timeout == 0) {
            addsystemtask((void *)CD_systaskfunc, 0, 0);
            CD_timeout = 0;
            deltimer((void *)CD_timerfunc);
        }
    }
}

/* CdReadyHandler @0x800F9CA4 : the CD data-ready interrupt callback -- the streaming sector engine.
 *   `intr` is the libcd interrupt type (1=DataReady, 2=Complete, 5=DiskError); `result` is the status
 *   buffer.  On each ready sector it pulls the 0x800-byte payload (whole into CD_curDst, or via the
 *   cache for a partial slice), validates the sector address, advances the transfer, and fires the
 *   completion callback when the request is satisfied.  It also keeps the drive streaming/prefetching
 *   ahead of CD_curSector and re-installs itself on exit. */
extern "C" void CdReadyHandler(int intr, unsigned char *result)
{
    CdlLOC        hdr[3];                 /* sector address header (CdGetSector .. 3 words) */
    unsigned char sub[284];               /* trailing sector bytes (CdGetSector .. 0x46 words) */
    unsigned char pos[8];
    int           gpctx[2];
    unsigned char com;
    unsigned char *param;
    void          *madr;
    int           done;
    /* oracle hoists ONE base pointer to ctx+0x20 (the Ghidra-named `D_80146CE4` -- the read-state
     * sub-struct curLen/remLen/curOff/curDst, same fields CD_Read models via an identical local)
     * ONCE at function entry and holds it in a callee-saved reg ($s0) for the WHOLE function --
     * used both for curLen/remLen/curOff/curDst (positive offsets) AND, in several spots that
     * precede the CdGetSector/CdPosToInt calls, to reach Cdinfo itself via a NEGATIVE -0x20 byte
     * offset off that SAME base (RS_Cdinfo below) instead of re-deriving &Cdinfo.  Once the fn
     * passes the CdGetSector cluster, the oracle switches to a FRESH, separately-materialized
     * &Cdinfo (the plain `Cdinfo` macro already models this) for the match/no-match + "done" +
     * advance: logic -- so only the EARLY Cdinfo touches (case2's ringIdx==-1 arm, the intr==1
     * flag tests, and case5's two arms) route through RS_Cdinfo; everything past CdGetSector stays
     * on the flat macro. */
    struct { int curLen, remLen, curOff; void *curDst; } *rs = (void *)&CD_ctx.curLen;
#define RS_Cdinfo (*(volatile int *)((char *)rs - 0x20))

    CdReadyCallback(0);                   /* disarm while we run */
    done = 0;

    if ((*result & 0x10) != 0) {          /* shell open / hard error -> hand off to the recovery task */
        deltimer((void *)CD_timerfunc);
        addsystemtask((void *)CD_systaskfunc, 0, 0);
        return;
    }

    if (intr == 2) {                      /* CdlComplete */
        if (CD_ringIdx == -1) {
            CD_ringIdx = 0;
            RS_Cdinfo |= 2;
        }
        goto advance;
    }

    if (intr < 3) {
        if (intr != 1)                    /* intr 0 -> nothing to do but advance */
            goto advance;

        /* intr == 1 : CdlDataReady -- a sector is in the drive buffer */
        if ((RS_Cdinfo & 1) == 0) {
            CdFlush();
            CdSync(0, 0);
        } else if ((RS_Cdinfo & 4) != 0) {   /* stop requested (CD_Stopread) */
            done = 1;
            RS_Cdinfo &= ~4;
            CdFlush();
            CdSync(0, 0);
        } else {
            madr = (RS_Cdinfo & 8) ? (void *)CD_sectorCache : rs->curDst;
            CdGetSector(hdr, 3);          /* 12-byte sector address header */
            CdGetSector(madr, 0x200);     /* 0x800 bytes of user data */
            CdGetSector(sub, 0x46);       /* trailing bytes */
            CdDataSync(0);
            if (CdPosToInt(hdr) == CD_cachedSector) {     /* the sector we were expecting */
                CD_timeout = timerhz * 6;
                if ((Cdinfo & 8) != 0) {  /* partial -> copy the wanted slice out of the cache */
                    Cdinfo = (Cdinfo & ~8) | 0x10;
                    blockmove(&CD_sectorCache[rs->curOff], rs->curDst, rs->curLen);
                    rs->curOff = 0;
                }
                if (rs->remLen > 0) {     /* advance to the next chunk/sector (oracle: fall-through,
                                              same block-order-inverted shape as CD_Read) */
                    rs->curDst = (char *)rs->curDst + rs->curLen;
                    if (rs->remLen < 0x800) { rs->curLen = rs->remLen; Cdinfo |= 8; }
                    else                    { rs->curLen = 0x800; }
                    rs->remLen -= rs->curLen;
                } else {
                    done = 1;
                }
            } else {                      /* wrong sector -> retry up to 4 ring slots */
                CD_ringIdx++;
                CD_curSector = CD_cachedSector;
                if (CD_ringIdx > 3) {
                    CD_ringIdx = -1;
                    com = 0x09;           /* CdlPause */
                    param = 0;
                    result = 0;
                    goto issue;
                }
                Cdinfo |= 2;
            }
        }

        if (done) {                       /* request satisfied -> fire the completion callback */
            Cdinfo &= ~1;
            CD_timeout = 0;
            CD_lastSector = CD_cachedSector;
            deltimer((void *)CD_timerfunc);
            if (CD_completionCallback != 0) {
                g_currentthread = 2;
                savegp(gpctx);
                CD_completionCallback(1);
                restoregp(gpctx[0]);
                g_currentthread = 0;
            }
        }
        goto advance;
    }

    /* intr >= 3 */
    if (intr != 5 || (RS_Cdinfo & 1) == 0)   /* only CdlDiskError while actively reading is interesting */
        goto advance;
    CdControl(0x01, 0, &hdr[0].minute);   /* CdlNop -- read the drive status */
    CD_ringIdx++;
    CD_curSector = CD_cachedSector;
    if (CD_ringIdx < 4) {
        RS_Cdinfo |= 2;
        goto advance;
    }
    CD_ringIdx = -1;
    com = 0x09;                           /* CdlPause */
    param = 0;
    result = 0;
    goto issue;

advance:
    CD_cachedSector++;
    if ((Cdinfo & 2) != 0) {
        Cdinfo = (Cdinfo & ~0x12) | 1;    /* clear in-progress|copied, mark reading */
        if (CD_cachedSector != CD_curSector) {   /* seek to the requested sector */
            CdFlush();
            CdSync(0, 0);
            CD_cachedSector = CD_curSector;
            CdIntToPos(CD_curSector, pos);
            CdControl(0x1B, pos, result);
        }
    }
    if ((Cdinfo & 1) != 0 || (CD_cachedSector - CD_lastSector < 0x15)) {
        CdReadyCallback(CdReadyHandler);  /* still streaming / within prefetch window -> re-arm */
        return;
    }
    /* prefetched too far past the last delivered sector -> rewind the read head */
    CD_cachedSector = CD_lastSector;
    CdIntToPos(CD_lastSector, pos);
    com   = 0x1B;                          /* CdlReadN */
    param = pos;
issue:
    CdControl(com, param, result);
    CdReadyCallback(CdReadyHandler);       /* re-install ourselves */
}
#undef RS_Cdinfo

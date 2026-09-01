/* eaclib/psx/eacpsxz/cdfs.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 13/14 PASS ***
 *   Source obj : nfs4\eaclib\psx\cdfs.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *
 *   COMPILED AS C by USER RULING (2026-07-25, uniformity over diff count): cc1plus (C++) measured
 *   strictly better per-fn diff counts than cc1 (C) on this TU -- loaddirinfo 115->139 (w26-a1
 *   dual-compile audit). Migrated anyway for source-uniformity across syslib/eaclib. Do NOT revert
 *   to .cpp without a user decision; see recon/syslib/psx/libcd/cdread.c,
 *   recon/syslib/psx/libcd/iso9660.c and recon/syslib/psx/libgpu/FONT.c for the sibling KEEP-CPP-
 *   turned-uniform TUs (same ruling, same date).
 *   14 fns @[0x800F9AE8 .. 0x800FA920].  EA CD-ROM filesystem (fs 1): the CD_* backend fileroot calls.
 *   Dual-source reconstruction: Ghidra `C:\Temp\claud\nfs4-f.exe.c` (primary) verified vs disasm-v3.
 *
 *   A CD context struct lives @0x80146CC4:  +0x00 Cdinfo (state flags), +0x04 CD_maxOpen, +0x08
 *   CD_dirEntryCount, +0x20 read-state, +0x34 CD_handleTable, +0x38 CD_dirEntryArray.  An open file is a
 *   1-based index into CD_handleTable[]; each slot holds a pointer to the file's ISO9660 directory entry
 *   (0x14 bytes: name[0xC], start sector @+0xC, size @+0x10).
 *
 *   PROGRESS (`python tools/verify_asm.py cdfs.c <fn>`, w32-a1 2026-07-26 sweep):
 *     [PASS]  CD_Close, CD_Stopread, CD_Getinfo, readsectorB, dircompare, CD_Restore, CD_Init,
 *             CD_timerfunc, CD_Restart, CD_Open, loaddirinfo, CD_systaskfunc, CdReadyHandler -- 13/14
 *             CD_Restart: a volatile cached-sector view pins the second store before the callback.
 *             CD_Open: a guarded do/while removes the redundant bound precheck; a distinct copied
 *             bound preserves the oracle's post-guard register move. No asm pins (HARD RULE).
 *             loaddirinfo: void return, rotated entry-count loop, direct parameter countdown
 *             reuse, reloaded filename length after memcpy, one live CD-context base, unsigned
 *             recursive size shift, record advance in the loop-test delay slot.
 *             CD_systaskfunc (w32-a1, 26 -> PASS): (1) the switch has a THIRD, higher-valued,
 *             EMPTY case label -- that is what puts gcc on its balanced-tree dispatch path (full
 *             derivation at the switch); (2) case-2 body BEFORE case-5 body in source order;
 *             (3) the disc-type decrement needs its own `unsigned` local so it stays in $v0;
 *             (4) its addtimer() call passes ONE argument (the oracle leaves $a1 stale across an
 *             intervening jal) -- isolated fn-ptr cast, methodology-3.12 #18.
 *
 *   w32-a1 2026-07-26 -- THE TU-WIDE ROOT CAUSES (these three moved everything):
 *     (a) `cachedSector` (ctx+0x0C) is **volatile**, like `info`.  The oracle RE-READS it after
 *         every store (`lw;nop;addiu;sw` then a fresh `lw` for the next use) instead of keeping
 *         the incremented value in a register; the un-fillable load-delay `nop`s between it and
 *         the neighbouring volatile `Cdinfo` accesses are the giveaway.  CdReadyHandler 109->70.
 *     (b) `timerhz` and `g_currentthread` are reached as UNSIZED ARRAYS (methodology-3.12 #5):
 *         EVERY oracle access is the SEPARATE-temp form `lui $rX,%hi; lw/sw $rY,%lo(sym)($rX)`,
 *         which a scalar `extern int` cannot emit (a scalar load self-temps; a scalar store folds
 *         to the assembler's `$at` macro).  CdReadyHandler 25->4 and CD_Read -5 in one edit.
 *     (c) Flag updates that read-modify-write a volatile word are ONE STATEMENT PER BIT: the
 *         oracle emits `Cdinfo &= ~8; Cdinfo |= 0x10;` as two separate load/modify/store pairs,
 *         not the fused `Cdinfo = (Cdinfo & ~8) | 0x10;`.
 *     [PASS] CdReadyHandler (w33-a1, 4 -> 0): the last 4 diffs were the emission ORDER of the two
 *             param save/copy pairs (oracle `sw s3;move s3,a1; sw s1;move s1,a0`, ours the
 *             reverse).  NOT a floor -- it is a PROTOTYPE fact.  *** NARROW-PARAM LEVER ***:
 *             `intr` is declared `unsigned char`, not `int` (IDA types it `unsigned __int8`).  In
 *             gcc-2.8 `assign_parms`, a parameter whose declared mode is NARROWER than the
 *             incoming promoted mode has its copy emitted into the deferred `conversion_insns`
 *             sequence, which is flushed AFTER every plain parm copy -- so the `s3<-a1` (result)
 *             copy gets a LOWER luid than the `s1<-a0` (intr) copy, the exact reverse of the
 *             declaration order.  sched2 then breaks its all-priority-1 ready-list tie by
 *             DESCENDING luid, which puts the s3 pair first.  Derivation: cc1 `-dR` sched2 trace,
 *             block 0 `ready list at T-12: 6 4` -- one tie, one insn pair, the whole 4-diff delta.
 *             (Earlier levers, all diff-neutral at 4 and now moot: done-in-declaration; `done = 0`
 *             before/after the disarm call; `switch (intr & 0xFF)` vs the `(unsigned char)` cast;
 *             declaration reordering (rs before madr/done); `result[0]` vs `*result`.)
 *     [PASS]  CD_Read -- w47-a5: the w34-a3 "STRONG floor" below FELL (163/163, 2 -> 0).  The
 *             diagnosis (a sched2 LAUNCH_PRIORITY tie: retail issues the curOff FEEDER before
 *             the a1 argument load) was correct, and that is exactly why source ORDER is inert:
 *             the boost wins every ready-list tie.  A zero-insn USE FENCE is a BARRIER, not a
 *             hint.  Two cooperating levers, both needed:
 *               (1) fence the CACHE-BASE materialization (`char *cache = CD_sectorCache;` +
 *                   `__asm__("" : : "r"(cache));`) -- retail issues `addiu v0,s1,60` BEFORE
 *                   `lw a0,8(s0)`, so the pin goes on the BASE, not on the offset (fencing the
 *                   offset instead gets the loads right but inverts the addu operands: 6);
 *               (2) ACCUMULATE THE ADDRESS INTO THE INDEX (`off = rs->curOff; off += (int)cache;`
 *                   then `blockmove((void *)off, ...)`) -- the catalog's SampleLength row: the
 *                   index's register becomes the addu DEST and the call argument, giving
 *                   retail's `addu a0,a0,v0`; the array form `&cache[off]` yields `addu a0,v0,a0`.
 *             The three w34 falsifications stand as written -- all three are ORDER hints, none
 *             is a barrier, and none touches the addu operand roles.
 *     [was]   CD_Read (198->64->31->12->2 diffs; insn parity 163/163).  w34-a3: the residual-2 is
 *             the sched2 LAUNCH_PRIORITY tie on the cached-sector blockmove's argument loads --
 *             retail issues `lw a0,8(s0)` (curOff, which still needs the `addu a0,a0,v0` that ends
 *             up in the jal delay slot) BEFORE `lw a1,0xC(s0)`, ours the reverse, because $a1's
 *             load IS an argument setter (0x7f000001 launch boost) while $a0's load is only a
 *             FEEDER of one.  Falsified this wave (all three byte-identical to the base, so the
 *             floor is STRONG by the >=3-forms rubric): a named `int off = rs->curOff;` statement
 *             before the call, a named `char *src = &CD_sectorCache[rs->curOff];` before the call,
 *             and the byte-base spelling `(char *)CD_sectorCache + rs->curOff`.  Earlier waves: the
 *             `&CD_handleTable[dev-1]` slot idiom (same as the PASSing CD_Getinfo -- it yields the
 *             oracle's full address materialization `sll;addiu -4;addu` instead of a `-4(base)`
 *             load displacement); the directory entry RE-READ from the slot at both uses, with the
 *             second read taken into a block-local BEFORE the sign correction (that placement is
 *             what restores insn parity).
 *             w33-a1 12 -> 2, TWO levers, both derived from the cc1 `-dR`/`-dS` RTL traces:
 *             (1) *** BASE-POINTER-BLOCK vs FIRST-STORE-BLOCK ***.  The oracle materializes the
 *             `&CD_ctx` base in the block BEFORE the `offset < 0` sign correction (so reorg can
 *             steal the `addiu s1,s2,%lo` into the `bgez` delay slot) but its FIRST STORE through
 *             that base (`ringIdx = 0`) is AFTER the join.  A scheduler can never do that -- it
 *             cannot move an insn across a basic-block boundary -- so the two must be separate
 *             SOURCE statements in separate blocks: an explicit `CD_ctx_t *ctx = &CD_ctx;` local
 *             declared in the pre-correction block, with `ctx->ringIdx = 0;` moved after the `if`.
 *             (`CD_ringIdx = 0` as one statement forces base+store into the same block: 12 diffs;
 *             moving the whole statement after the correction sinks the base too: 14 diffs.)
 *             (2) *** NAMED ACCUMULATOR, split load / add ***: `startSector = *(int *)(e+0xC);
 *             ... startSector += offset >> 0xB; ctx->curSector = startSector;` gives the oracle's
 *             `addu v1,v1,v0` (dest = the LOADED value's register).  Written as one `A + B`
 *             expression the dest always coalesces onto the FIRST operand's register and swapping
 *             the operands only swaps which input gets v0/v1 (16 diffs) -- the accumulate form is
 *             the only spelling that reaches the oracle's register triple.  It also lets the
 *             ringIdx store schedule between the `sra` and the `addu`, exactly as the oracle does.
 *             RESIDUAL 2 (documented floor, mechanism known): the blockmove call loads `a0` before
 *             `a1` in the oracle, ours the reverse.  Root cause is in cc1's PRE-reload scheduler:
 *             the `a0` arg needs an `addu a0,a0,v0`, so its two feeder insns get sched.c's
 *             LAUNCH_PRIORITY (0x7f000001) boost while the plain `lw a1,12(s0)` keeps priority 1
 *             and therefore loses every ready-list tie and is emitted first.  Not source-
 *             reachable: 8 spellings tried (pointer-add vs index, hoisted src/off/dst/len locals,
 *             int-cast add, flat CD_* macros) all reproduce the identical pre-sched1 RTL.
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

/* ---- helpers ---- */
extern int   toupper(int c);                                  /* @0x8010907C (libc C37)      */
extern void *bsearch(const void *key, const void *base, int n, int size,
                         int (*cmp)(const void *, const void *)); /* @0x801091DC (libc)          */
extern int   dircompare(const void *a, const void *b);        /* @0x800FA344 (cdfs, below)   */
extern char *strncpy(char *d, const char *s, int n);          /* @0x800F6104 (libc C26)      */

/* ---- CD read-state (ctx+0x20 sub-struct) + sector cache + the read machinery CD_Read arms ---- */
extern int   timerhz[];          /* timer frequency (UNSIZED array -- methodology-§3.12 #5:
                                  * EVERY oracle timerhz load is the SEPARATE-temp form
                                  * `lui $rX,%hi; lw $rY,%lo(timerhz)($rX)`, which a scalar
                                  * extern cannot emit -- it folds to the self-temp
                                  * `lui $rX; lw $rX,%lo($rX)`.)                            */
extern int   g_currentthread[];  /* execution context id (UNSIZED array -- methodology-
                                  * §3.12 lever #5: the oracle materializes its address in a
                                  * SEPARATE reg (`lui $s0,%hi; sw $v0,%lo($s0)` / `lui $v0;lw $v1,%lo($v0)`),
                                  * which a scalar extern cannot emit -- a scalar store folds to the
                                  * assembler's `$at` macro form and a scalar load self-temps.)      */
extern void  CD_timerfunc(void); /* @0x800F9C44 (cdfs read watchdog/poll, below)             */

extern void  addtimer(void *fn, void *arg);   /* @0x800EAFE8 (eaclib)                        */
extern void  deltimer(void *fn);              /* @0x800EB048 (eaclib)                        */
extern void  blockmove(void *src, void *dst, int n);  /* @0x800E62DC                          */
extern int   savegp(void *ctx);               /* save $gp around a cross-module callback     */
extern void  restoregp(int saved);

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
 *   VOLATILE: `info` (the IRQ-polled sync-flags word) AND `cachedSector` are volatile -- readsectorB's bare
 *   spin `while((Cdinfo&3)!=0);` re-reads it every iteration (a non-volatile field would fold
 *   to `while(true)`), and CdReadyHandler mutates it behind the compiler's back.  `cachedSector`
 *   is the read HEAD the IRQ advances, and is volatile for the same reason (w32-a1): the oracle
 *   re-loads it from memory at every use instead of keeping the just-incremented value in a
 *   register, and leaves un-fillable load-delay nops around it (CdReadyHandler 109->70 diffs).
 *   The remaining DATA fields are ordinary: proven by CD_timerfunc PASS (timeout non-volatile)
 *   and by a read-state-cluster-volatile test that REGRESSED CD_Read 198->255 / CdReadyHandler
 *   325->367 -- volatility here is per-field, not per-struct.
 *   Same shape SOTN uses (libcd cdread.c `volatile cdreadStruct`) and NFS4's own `volatile
 *   CdrEnv _cdr` -- one struct, sync-word volatile, accessed via the gcc-CSE'd base. */
struct CD_ctx_t {
    volatile int info;                 /* +0x00  Cdinfo (IRQ-polled sync flags; bit2==stop-req) */
    int   maxOpen;                     /* +0x04  CD_maxOpen                                    */
    int   dirEntryCount;               /* +0x08  CD_dirEntryCount                              */
    volatile int cachedSector;         /* +0x0C  CD_cachedSector  (EXPERIMENT a1)              */
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
typedef struct CD_ctx_t CD_ctx_t;
CD_ctx_t Cdinfo; /* @0x80146CC4: retail SYM/MAP public CD context object */
/* Flat-name -> struct-member accessor macros (call sites unchanged; each expands to an
 * absolute-addressed struct field, killing the gp-rel divergence). */
#define CD_info               Cdinfo.info
#define CD_maxOpen            Cdinfo.maxOpen
#define CD_dirEntryCount      Cdinfo.dirEntryCount
#define CD_cachedSector       Cdinfo.cachedSector
#define CD_lastSector         Cdinfo.lastSector
#define CD_curSector          Cdinfo.curSector
#define CD_timeout            Cdinfo.timeout
#define CD_ringIdx            Cdinfo.ringIdx
#define CD_curLen             Cdinfo.curLen
#define CD_remLen             Cdinfo.remLen
#define CD_curOff             Cdinfo.curOff
#define CD_curDst             Cdinfo.curDst
#define CD_completionCallback Cdinfo.completionCallback
#define CD_handleTable        Cdinfo.handleTable
#define CD_dirEntryArray      Cdinfo.dirEntryArray
#define CD_sectorCache        Cdinfo.sectorCache

/* Canonical PsyQ 4.3 LIBCD.H location: BCD minute/second/sector + track. */
typedef struct {
    unsigned char minute;
    unsigned char second;
    unsigned char sector;
    unsigned char track;
} CdlLOC;

/* Private cdfs read-state view shared by CD_Read and the ready callback. */
typedef struct CDReadState {
    int curLen;
    int remLen;
    int curOff;
    void *curDst;
} CDReadState;

/* Ready-callback stack record: three sector headers, payload tail, position,
 * and the two-word savegp context. */
typedef struct CDReadyScratch {
    CdlLOC hdr[3];
    unsigned char sub[284];
    unsigned char pos[8];
    int gpctx[2];
} CDReadyScratch;

/* ---- syslib / PsyQ libcd backend (toolchain-provided; declared, not reconstructed) ---- */
extern int  CdInit(void);                                                  /* @0x800F908C */
extern void CdReset(int mode);                                             /* @0x800F77AC */
extern void CdSetDebug(int level);                                         /* @0x800F7838 */
extern int  CdGetToc(CdlLOC *toc);                                         /* @0x800F929C */
extern int  CdControlB(unsigned char com, unsigned char *p, unsigned char *r); /* @0x800F7B24 */
extern int  CdControl(unsigned char com, unsigned char *p, unsigned char *r);  /* @0x800F78B4 */
extern int  CdSync(int mode, unsigned char *r);                            /* @0x800F784C */
extern int  CdFlush(void);                                                 /* @0x800F7818 */
extern void CdReadyCallback(void (*fn)(unsigned char, unsigned char *));             /* @0x800F78A0 */
extern void CdIntToPos(int i, unsigned char *p);                           /* @0x800F7CF4 */
extern int  CdPosToInt(CdlLOC *p);                                         /* syslib SYS  */
extern int  CdGetSector(void *madr, int size);                             /* syslib SYS  */
extern int  CdDataSync(int mode);                                          /* syslib SYS  */
extern int  CdDiskReady(int mode);                                         /* syslib TYPE */
extern int  CdGetDiskType(void);                                           /* syslib TYPE */
extern void VSync(int mode);                                               /* @0x800F231C */

extern void addsystemtask(void *fn, void *a, void *b); /* @ systask  */
extern void delsystemtask(void *fn);                   /* @ systask  */
extern void addexit(void *fn);                         /* @0x800F1CF8 (exit) */
extern void blockclear(void *dst, int n);              /* @0x800F17A0 (blkfill) */
extern int  strncmp(const char *a, const char *b, int n); /* @0x800EB1D0 (syslib C24) */
extern void *memcpy(void *d, const void *s, int n);       /* @0x800EAAC4 (syslib C42) */
extern void qsort(void *base, int n, int sz, int (*cmp)(const void *, const void *)); /* @0x800E5D8C */

/* ---- cdfs internal forward decls (mutually recursive CD machinery) ---- */
extern unsigned char *readsectorB(void);                       /* @0x800FA154 */
extern void loaddirinfo(int startSector, int numSectors, int maxEntries); /* @0x800FA1A8 */
extern int   CD_Restart(int startSector);                      /* @0x800FA4A8 */
extern int   CD_systaskfunc(void);                             /* @0x800F9AE8 */
extern void  CdReadyHandler(unsigned char intr, unsigned char *result);  /* @0x800F9CA4 */

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

/* CD_systaskfunc @0x800F9AE8 : disc-swap recovery system task.  Polls CdDiskReady; on a stable disc
 *   (or a timed-out error) it resets the drive, re-arms the read mode + CdReadyHandler, and resumes the
 *   in-flight transfer if one was pending. */
extern int CD_systaskfunc(void)
{
    unsigned char result[8];
    unsigned char pos[8];
    unsigned char mode[8];
    int           ready;
    int           done = 0;

    ready = CdDiskReady(1);
    /* 🔑 THE SWITCH HAD **THREE** CASE LABELS, and the third one's value is > 5.
     *   The oracle dispatch is gcc's BALANCED-TREE form -- `li 5; beq ->case5; slti $v1,6;
     *   beqz ->merge; li 2; bne ->merge; <case-2 body inline>` -- i.e. a tree ROOTED AT 5 with
     *   a left child {2} and the redundant high-bound test.  gcc-2.8's balance_case_nodes only
     *   splits (and thus roots at the middle value) when the case list has MORE THAN TWO nodes;
     *   with exactly {2,5} it leaves the list linear and emits `li 2; beq; li 5; bne` with NO
     *   bound test -- which is what every 2-case spelling of this function produced (85 insns,
     *   22 diffs, and the w19-a8 "case-order swap is worse" note).  Adding a THIRD case label
     *   whose value is above 5 and whose body is empty makes the middle node 5, produces the
     *   oracle's dispatch exactly, and is a semantic NO-OP (the switch has no default, so that
     *   value fell out of the switch before too).  Values 6/7/8 were measured to emit BYTE-
     *   IDENTICAL code, so the retail constant is not recoverable from the image -- only the
     *   fact that a third, higher-valued, empty case existed.  (Index-type casts -- (unsigned),
     *   (unsigned char), (short) -- were tested as alternative explanations and all fail.)
     *   Case BODY order also matters: the oracle lays the case-2 body down first (fall-through
     *   from the dispatch) and case 5 after it, so `case 2:` must precede `case 5:` in source. */
    switch (ready) {
    case 6:                                /* (see above) empty third case -- dispatch shape only */
        break;
    case 2: {                              /* CdlComplete -> a disc settled */
        /* the decrement must live in its OWN local: folding it into the comparison lets gcc
         * coalesce the `t-1` temp into done's reg ($s0) and write $s0 twice, where the oracle
         * keeps the decrement in the call-result reg ($v0) and stores $s0 once. */
        unsigned t = CdGetDiskType() - 1;
        done = t < 2;                     /* disc type 1 or 2 == a usable disc */
        break;
    }
    case 5:                                /* CdlDiskError -> run down the watchdog */
        /* @0x800F9B48-B74: BUG FIX (was M01) -- re-traced the delay slots: the `sw $v0,0x18($a0)`
         * at .L800F9B6C sits in the INNER `bnez $v0,.L800F9B78`'s delay slot, which (like every
         * branch delay slot) executes on BOTH paths.  So CD_timeout IS stored back unconditionally
         * whenever it was nonzero on entry -- for old_timeout==1 the store lands 0 (+ done=1 falls
         * through); for old_timeout>=2 the store lands old_timeout-1 (silently, done stays 0).  Only
         * old_timeout==0 skips this whole branch and re-arms to timerhz*5 instead. */
        if (CD_timeout == 0)
            CD_timeout = timerhz[0] * 5;     /* re-arm */
        else {
            CD_timeout = CD_timeout - 1;
            if (CD_timeout == 0)
                done = 1;
        }
        break;
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
        ctx = &Cdinfo;
        CdIntToPos(ctx->cachedSector, pos);
        CdControl(0x1B, pos, result);
        CdReadyCallback(CdReadyHandler);
        if (ctx->remLen > 0) {            /* a transfer was in progress -> resume it */
            ctx->ringIdx = 0;
            ctx->timeout = timerhz[0] * 6;
            /* ONE-ARGUMENT call at this site (methodology-§3.12 #18, isolated fn-ptr cast):
             * the oracle's `jal addtimer` here sets ONLY $a0 -- $a1 is left stale even though a
             * `jal CdReadyCallback` clobbered it two calls earlier, so no second argument was
             * passed.  (CD_Read's site genuinely passes `dest`, which already lives in $a1
             * there, so the shared 2-arg declaration stays correct for it.) */
            ((void (*)(void *))addtimer)((void *)CD_timerfunc);
        }
    }
    return 0;
}

/* CD_timerfunc @0x800F9C44 : read watchdog (timer callback).  When the countdown reaches zero it queues
 *   the disc-swap recovery system task and removes itself from the timer list. */
extern void CD_timerfunc(void)
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
extern void CdReadyHandler(unsigned char intr, unsigned char *result)
{
    CDReadyScratch scratch;
#define hdr   scratch.hdr
#define sub   scratch.sub
#define pos   scratch.pos
#define gpctx scratch.gpctx
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
    CDReadState *rs = (void *)&Cdinfo.curLen;
#define RS_Cdinfo (*(volatile int *)((char *)rs - 0x20))

    CdReadyCallback(0);                   /* disarm while we run */
    done = 0;

    if ((*result & 0x10) != 0) {          /* shell open / hard error -> hand off to the recovery task */
        deltimer((void *)CD_timerfunc);
        addsystemtask((void *)CD_systaskfunc, 0, 0);
        return;
    }

    switch (intr) {
    case 2:                               /* CdlComplete */
        if (CD_ringIdx == -1) {
            CD_ringIdx = 0;
            RS_Cdinfo |= 2;
        }
        goto advance;

    case 1:
        /* intr == 1 : CdlDataReady -- a sector is in the drive buffer */
        if ((RS_Cdinfo & 1) != 0) {
            if ((RS_Cdinfo & 4) != 0) {      /* stop requested (CD_Stopread) */
                done = 1;
                RS_Cdinfo &= ~4;
            } else {
                madr = (RS_Cdinfo & 8) ? (void *)CD_sectorCache : rs->curDst;
                CdGetSector(hdr, 3);          /* 12-byte sector address header */
                CdGetSector(madr, 0x200);     /* 0x800 bytes of user data */
                CdGetSector(sub, 0x46);       /* trailing bytes */
                CdDataSync(0);
                if (CdPosToInt(hdr) != CD_cachedSector) {     /* wrong sector -> retry up to 4 ring slots */
                    CD_ringIdx++;
                    CD_curSector = CD_cachedSector;
                    if (CD_ringIdx < 4) {
                        CD_info |= 2;
                    } else {
                        CD_ringIdx = -1;
                        /* the CdlPause issue is spelled OUT-OF-LINE in BOTH ring-overflow arms
                         * (here + case 5): the oracle DUPLICATES the `a0=9,a1=0,a2=0` setup in each
                         * and cross-jump-merges only the shared `jal CdControl` tail.  A shared
                         * com/param/result trio + `goto issue` merges the setup too (-3 insns). */
                        CdControl(0x09, 0, 0);
                        CdReadyCallback(CdReadyHandler);
                        return;
                    }
                } else {                      /* the sector we were expecting */
                    CD_timeout = timerhz[0] * 6;
                    if ((CD_info & 8) != 0) {  /* partial -> copy the wanted slice out of the cache */
                        CD_info &= ~8;
                        CD_info |= 0x10;
                        blockmove(&CD_sectorCache[rs->curOff], rs->curDst, rs->curLen);
                        rs->curOff = 0;
                    }
                    if (rs->remLen > 0) {     /* advance to the next chunk/sector (oracle: fall-through,
                                                  same block-order-inverted shape as CD_Read) */
                        rs->curDst = (char *)rs->curDst + rs->curLen;
                        if (rs->remLen < 0x800) { rs->curLen = rs->remLen; CD_info |= 8; }
                        else                    { rs->curLen = 0x800; }
                        rs->remLen -= rs->curLen;
                    } else {
                        done = 1;
                    }
                }
                goto cdrh_doneTest;
            }
        }
        /* 🔴 REAL CFG BUG FIXED (w65-a1, 04Q class-d / 11C class): branch word 65
         * -- ours `j +104` vs retail `j +99`.  Retail's STOP-REQUESTED arm
         * (Cdinfo & 4, i.e. CD_Stopread) does NOT jump to the `done` test: it
         * falls into this CdFlush/CdSync block, the same one the "not reading"
         * path (`beqz (Cdinfo & 1)` above) branches to.  Our nested if/else sent
         * it straight to the done test, so a read aborted mid-flight never
         * flushed the drive FIFO nor waited for the command to settle -- the
         * next CdControl then ran against a dirty FIFO.  Same 300 instructions
         * either way, which is why every gate was green: only the jump WORD
         * differs.  The goto above is the literal expression of retail's CFG. */
        CdFlush();
        CdSync(0, 0);
cdrh_doneTest:

        if (done) {                       /* request satisfied -> fire the completion callback */
            CD_info &= ~1;
            CD_timeout = 0;
            CD_lastSector = CD_cachedSector;
            deltimer((void *)CD_timerfunc);
            if (CD_completionCallback != 0) {
                /* methodology-§3.12 lever #16 (hold-global-addr-across-call): the oracle parks
                 * &g_currentthread in a CALLEE-SAVED reg ($s0) across savegp/the callback/restoregp
                 * and stores through it twice; a bare `g_currentthread = N` on both sides
                 * rematerializes the address with a fresh `lui $at` per store (+2 insns). */
                int *curThread = g_currentthread;
                *curThread = 2;
                savegp(gpctx);
                CD_completionCallback(1);
                restoregp(gpctx[0]);
                *curThread = 0;
            }
        }
        goto advance;

    case 5: {
        CD_ctx_t *ctx = (CD_ctx_t *)((char *)rs - 0x20);
        /* only CdlDiskError while actively reading is interesting */
        if ((ctx->info & 1) == 0)
            goto advance;
        CdControl(0x01, 0, &hdr[0].minute);   /* CdlNop -- read the drive status */
        ctx->ringIdx++;
        ctx->curSector = ctx->cachedSector;
        if (ctx->ringIdx < 4) {
            ctx->info |= 2;
            goto advance;
        }
        ctx->ringIdx = -1;
        CdControl(0x09, 0, 0);                /* CdlPause -- duplicated setup, see case 1 */
        CdReadyCallback(CdReadyHandler);
        return;
    }

    default:
        goto advance;
    }

advance:
    CD_cachedSector++;
    if ((CD_info & 2) != 0) {
        CD_info &= ~2;                     /* clear in-progress */
        CD_info &= ~0x10;                  /* clear copied */
        CD_info |= 1;                      /* mark reading */
        if (CD_cachedSector != CD_curSector) {   /* seek to the requested sector */
            CdFlush();
            CdSync(0, 0);
            CD_cachedSector = CD_curSector;
            CdIntToPos(CD_curSector, pos);
            CdControl(0x1B, pos, result);
        }
    }
    if ((CD_info & 1) != 0 || (CD_cachedSector - CD_lastSector < 0x15)) {
        CdReadyCallback(CdReadyHandler);  /* still streaming / within prefetch window -> re-arm */
        return;
    }
    /* prefetched too far past the last delivered sector -> rewind the read head */
    CD_cachedSector = CD_lastSector;
    CdIntToPos(CD_lastSector, pos);
    CdControl(0x1B, pos, result);          /* CdlReadN */
    CdReadyCallback(CdReadyHandler);       /* re-install ourselves */
}
#undef gpctx
#undef pos
#undef sub
#undef hdr
#undef RS_Cdinfo

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
extern unsigned char *readsectorB(void)
{
    int busy;

    CD_curLen  = 0x800;
    CD_ringIdx = 0;
    CD_info    = 0xA;                     /* read-in-progress (2) | partial (8) */
    CD_curDst = CD_sectorCache;           /* ctx+0x3C == &CD_sectorCache (0x80146D00) -- unconditional */
    if ((CD_info & 3) != 0) {
        do {
            busy = (CD_info & 3);         /* spin until the CD IRQ completes this sector */
        } while (busy != 0);
    }
    return CD_sectorCache;
}

/* loaddirinfo @0x800FA1A8 : recursively walk an ISO9660 directory, appending every FILE record to the
 *   global directory-entry array.  Skips the "." and ".." records of the first sector; recurses into
 *   subdirectory records.  Stops when the directory's sectors run out or CD_dirEntryCount hits
 *   `maxEntries` (a budget shared across the recursion).  The return value (a fixed address) is unused. */
extern void loaddirinfo(int startSector, int numSectors, int maxEntries)
{
    CD_ctx_t      *ctx = &Cdinfo;
    int            limit = maxEntries;
    int            savedSector = ctx->curSector;
    unsigned char *p;

    ctx->curSector = startSector;
    p = readsectorB();                    /* load the directory's first sector into the cache */
    numSectors = numSectors - 1;
    p = p + p[0];                         /* skip the "." self record (record 0) */

    goto test_entry_count;
next_entry:
        if (p[0] == 0) {                  /* zero reclen -> no more records in this sector */
            if (numSectors == 0)
                goto done;
            ctx->curSector = ctx->curSector + 1;
            p = readsectorB();            /* load the next directory sector (start at its record 0) */
            numSectors--;
        }

        if ((p[0x19] & 2) != 0) {         /* flags bit1 == directory -> recurse */
            int subExtent = rd_le32(p + 2);
            unsigned int subSize = (unsigned int)rd_le32(p + 10);
            loaddirinfo(subExtent, subSize >> 0xB, limit);
            readsectorB();                /* recursion reused the cache -> reload our own sector */
        } else {                          /* a FILE -> append a 0x14-byte directory entry */
            /* the slot address (CD_dirEntryArray + CD_dirEntryCount*0x14) is RECOMPUTED at each of
             * the 4 uses below, not cached in a local -- oracle independently rematerializes
             * count*0x14+base for the memcpy, the NUL-term, the extent store, and the size store
             * (4 near-identical lw/sll/addu/lw/sll/addu blocks; verified vs the .s). */
            memcpy((unsigned char *)(ctx->dirEntryCount * 0x14 + (int)ctx->dirEntryArray),
                   p + 0x21, p[0x20] - 2);            /* drop the ";1" version suffix */
            ((unsigned char *)ctx->dirEntryArray + ctx->dirEntryCount * 0x14)[p[0x20] - 2] = 0;  /* NUL-term */
            *(int *)((unsigned char *)ctx->dirEntryArray + ctx->dirEntryCount * 0x14 + 0xC)
                = rd_le32(p + 2);                      /* extent (start sector) */
            *(int *)((unsigned char *)ctx->dirEntryArray + ctx->dirEntryCount * 0x14 + 0x10)
                = rd_le32(p + 10);                     /* file size in bytes */
            ctx->dirEntryCount = ctx->dirEntryCount + 1;
        }
test_entry_count:
        p = p + p[0];
        if (ctx->dirEntryCount < limit)
            goto next_entry;

done:
    CD_curSector = savedSector;
}

/* dircompare @0x800FA344 : qsort/bsearch comparator -- compares the 0xC-byte names of two dir entries. */
extern int dircompare(const void *a, const void *b)
{
    return strncmp((const char *)a, (const char *)b, 0xC);
}

/* CD_Restore @0x800FA364 : addexit() cleanup -- reset the drive and clear the CD context block. */
extern void CD_Restore(void)
{
    CdReset(0);
    blockclear(&Cdinfo, 0x83C);           /* ctx header (0x3C) + sector cache (0x800) = 0x83C */
}

/* CD_Init @0x800FA394 : mount the CD filesystem.  Brings up libcd, reads the Primary Volume Descriptor
 *   (sector 0x10), walks its root directory into the caller-provided buffer, sorts the entry array, and
 *   registers the at-exit drive-reset.  `buffer` holds `maxOpen` handle pointers followed by the
 *   `numEntries`-slot (0x14-byte) directory array.  Returns the number of entries found (0 on failure). */
extern int CD_Init(int maxOpen, int numEntries, void *buffer, void (*callback)(int))
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
extern int CD_Restart(int startSector)
{
    unsigned char pos[8];
    unsigned char mode[8];
    int           rc;

    (void)CD_info;                        /* oracle @0x800FA4B4: lui/lw Cdinfo, result discarded --
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

/* CD_Open @0x800FA554 : open `name` on the CD; writes the 1-based handle to *outp.  Finds a free slot,
 *   upper-cases the name, binary-searches the directory, and parks the matching entry in the slot.
 *   Returns 1 if found, 0 if not.  (`flags` is unused -- the CD is read-only.) */
extern int CD_Open(char *name, int flags, int *outp)
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
        int bound = limit;
        h = CD_handleTable;
        do {                                            /* find the first free slot */
            if (*h == 0)
                goto slot_done;
            slot++;
            h++;
        } while (slot < bound);
    }
slot_done:
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
extern int CD_Close(int handle)
{
    CD_handleTable[handle - 1] = 0;
    return 0;
}

/* CD_Read @0x800FA678 : arm a read of `len` bytes from file `dev` at `offset` into `dest`.  Sets up the
 *   sector-ring read state (clamping `len` to the file and to the 0x800 sector boundary) and starts the
 *   watchdog timer; the transfer itself proceeds asynchronously via CD_timerfunc/CdReadyHandler.  If the
 *   target sector happens to already be in the sector cache (same execution context), it is copied
 *   immediately -- completing the read (calling the completion callback) or advancing to the next sector.
 *   Returns the (clamped) byte count, or 0 if the CD is busy. */
extern int CD_Read(int dev, int dest, int offset, int len)
{
    /* same slot idiom as CD_Getinfo (which PASSes): `&CD_handleTable[dev-1]` yields the oracle's
     * full address materialization `sll $a0,$a0,2; addiu $a0,$a0,-4; addu $a0,$v0,$a0`, and the
     * directory ENTRY is RE-READ from the slot at each of its two uses (`lw $v0,0($a0)` twice)
     * rather than cached in a local -- a cached copy lives in a register across the intervening
     * volatile Cdinfo RMWs (registers are not invalidated) and loses the oracle's second load. */
    void **slot = &CD_handleTable[dev - 1];
    int   q, remaining;
    /* read-state sub-struct pointer (curLen/remLen/curOff/curDst, ctx+0x20) -- materialized HERE
     * (right after the busy-check, oracle @0x800FA6C0 "addiu s0,v1,0x20" lands in the beqz's delay
     * slot) so gcc hoists the base as early as the oracle does, instead of lazily at first field use. */
    CDReadState *rs = (void *)&Cdinfo.curLen;

    if ((CD_info & 3) != 0)                             /* CD busy -> reject */
        return 0;

    remaining = *(int *)((char *)*slot + 0x10) - offset; /* clamp len to bytes left in the file */
    if (remaining < len)
        len = remaining;

    q = offset;
    if (q < 0)
        q += 0x7FF;
    rs->curOff = offset - ((q >> 0xB) << 0xB);           /* byte offset within the 0x800 sector */
    rs->curDst = (void *)dest;      /* the oracle fills the curOff-test's delay slot with this */
    if (rs->curOff != 0 || len < 0x800)
        CD_info |= 8;                                   /* partial-sector transfer */
    if (rs->curOff + len > 0x800)
        q = 0x800 - rs->curOff;                         /* clamp this chunk to the sector boundary */
    else
        q = len;
    rs->curLen = q;
    rs->remLen = len - q;

    { CD_ctx_t *ctx = &Cdinfo; /* the ctx base is materialized HERE, in the pre-sign-correction
                                * block, but its first STORE is after the join -- see the note
                                * above CD_Read for why that is the whole 12-diff residual. */
      char *e = (char *)*slot;   /* re-read; the oracle loads it BEFORE the sign correction */
      int   startSector;
      if (offset < 0)
          offset += 0x7FF;
      startSector    = *(int *)(e + 0xC);
      ctx->ringIdx   = 0;
      startSector   += offset >> 0xB;
      ctx->curSector = startSector; } /* start sector + offset / 0x800 */
    CD_info |= 2;                                       /* read in progress */
    CD_timeout   = timerhz[0] * 6;
    addtimer((void *)CD_timerfunc, (void *)dest);

    if (CD_cachedSector == CD_curSector && (CD_info & 0x10) && g_currentthread[0] == 2) {
        { char *cache = (char *)CD_sectorCache;
          int off;
          __asm__("" : : "r"(cache));  /* w47-a5: sched fixpoint -- pin the cache-base addiu first */
          off = rs->curOff;
          off += (int)cache;
          blockmove((void *)off, rs->curDst, rs->curLen); }  /* sector already cached */
        if (rs->remLen > 0) {                            /* more to read -> advance to the next sector */
            rs->curOff = 0;
            rs->curDst = (char *)rs->curDst + rs->curLen;
            if (rs->remLen < 0x800) { rs->curLen = rs->remLen; CD_info |= 8; }
            else                    { rs->curLen = 0x800;      CD_info &= ~8; }
            rs->remLen  -= rs->curLen;
            CD_curSector += 1;
        } else {                                        /* whole request satisfied -> complete now */
            int gpctx[2];
            CD_timeout = 0;
            CD_info &= ~2;
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

/* CD_Stopread @0x800FA904 : request the in-flight CD read to stop (sets Cdinfo bit 2). */
extern int CD_Stopread(int dev)
{
    /* Cdinfo (info) is volatile (the IRQ + readsectorB's spin re-read it), so a bare
     * `return Cdinfo |= 4;` would RE-READ info after the store to source the return
     * value (an extra `lw`).  The oracle reads once, ORs, writes, and returns the
     * COMPUTED value -> keep it in a temp and return that (no re-read). */
    int v = CD_info | 4;
    (void)dev;
    CD_info = v;
    return v;
}

/* CD_Getinfo @0x800FA920 : query an open CD file -- optionally copy its 0xC-byte name into `namebuf`
 *   and write its size to *sizeout; returns the size. */
extern int CD_Getinfo(int handle, int namebuf, int *sizeout)
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


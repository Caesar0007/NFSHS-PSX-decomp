/* syslib/psx/libcd/cdread.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcd.lib(CDREAD.OBJ): the high-level multi-sector CdRead engine.
 *
 *   COMPILED AS C by USER RULING (2026-07-25, uniformity over diff count): cc1plus (C++) measured
 *   strictly better per-fn diff counts than cc1 (C) on this TU -- _read_int 109->115 (w26-a1 dual-
 *   compile audit). Migrated anyway for source-uniformity across syslib/eaclib. Do NOT revert to
 *   .cpp without a user decision; see recon/eaclib/psx/eacpsxz/cdfs.c and
 *   recon/syslib/psx/libcd/iso9660.c and recon/syslib/psx/libgpu/FONT.c for the sibling KEEP-CPP-
 *   turned-uniform TUs (same ruling, same date).
 *
 *   CdRead(sectors, buf, mode) starts an asynchronous N-sector read; the per-sector work is driven
 *   by the libcd ready/data interrupt callbacks installed here, and CdReadSync() polls for / waits
 *   on completion.  Five private callbacks + helpers:
 *       _read_sync       (@0x8010887C) -- sync-complete: restore the saved sync cb, clear "reading".
 *       _read_int        (@0x801088B0) -- ready interrupt: on each DataReady, verify the sector
 *                                          header (2048-byte mode) and copy the sector into `cur`
 *                                          (or, in DMA mode, re-arm the data callback).
 *       _read_data_int   (@0x80108B24) -- DMA-data complete: advance cursor / remaining / expected.
 *       _read_issue      (@0x80108BF4) -- (re)issue the read: handle shell-open, set mode/loc,
 *                                          install callbacks and fire CdlReadN.
 *       CdRead           (@0x80108DDC), CdReadSync (@0x80108F78) -- public API.
 *
 *   W52-A2 TOOLCHAIN A/B (UNCHANGED source, whole-TU diff totals; gate = tools/verify_asm.py):
 *     gcc LADDER (NFS4_FORCE_CC1_ALT, 272 recipe)   base(2.8.0+maspsx) 169 | 2.6.0 303 |
 *       2.6.3 303 | 2.7.2-970404 173 | 2.7.2 289 | 2.8.0 175 | 2.8.1 175 | 2.91.66 303 |
 *       2.95.2 286.   ==> NO ladder rung beats the wired lane; cdread.c stays OFF cc1_272
 *       (w51-a3's 169->289 verdict reproduced exactly).  Per-fn the rungs disagree wildly
 *       (CdReadSync is 3 on 2.6.0/2.6.3/2.7.2 vs 6 on the lane; _read_issue 58 on
 *       2.7.2-970404/2.8.0 vs 64 then), so the TU is a genuine mixed basin.
 *     PER-TU FLAGS: no_split_addresses 199 (mixed: CdReadSync 6->2, CdRead 43->39, but
 *       _read_data_int 4->27 and _read_issue 64->81) | no_strength_reduce 169 (inert) |
 *       no_schedule_insns 222 | no_delayed_branch 363.  ==> keep the TU's default flags.
 *
 *   All five share one private state block @0x8013C290 (CDREAD.OBJ .bss).  Its fields are referenced
 *   purely by byte offset in the original; reproduced here as a struct with offset-named members and
 *   a semantic note for each.  Several stores land in JAL delay slots and therefore capture the value
 *   present *before* the call returns -- annotated inline where it matters (e.g. _issue's w20). */

typedef unsigned char u_char;
typedef unsigned long  u_long;
typedef int (*CdlCB)(int, int);

struct CdlLOC { u_char minute, second, sector, track; };
typedef struct CdlLOC CdlLOC;

/* ---- private CdRead state block @0x8013C290 (CDREAD.OBJ .bss) -------------------------------- */
struct CdrEnv {
    int      w00;   /* +0x00 : sectors requested                                     */
    u_char  *w04;   /* +0x04 : destination buffer                                    */
    u_char  *w08;   /* +0x08 : write cursor (advances by w10 words per sector)       */
    int      w0c;   /* +0x0C : read mode (|0x20 = "use callback")                    */
    int      w10;   /* +0x10 : sector size in words (0x200 / 0x249 / 0x246)          */
    int      w14;   /* +0x14 : sectors remaining (-1 = error/abort)                  */
    int      w18;   /* +0x18 : VSync stamp of the last interrupt                     */
    int      w1c;   /* +0x1C : VSync stamp at issue (overall watchdog base)          */
    int      w20;   /* +0x20 : next expected absolute sector number                  */
    int      w24;   /* +0x24 : "read in progress" flag                               */
    int      w28;   /* +0x28 : saved sync callback                                   */
    int      w2c;   /* +0x2C : saved ready callback                                  */
    int      w30;   /* +0x30 : saved data callback                                   */
    int      w34;   /* +0x34 : last interrupt code passed to the user CdReadCallback */
};
typedef struct CdrEnv CdrEnv;

extern volatile CdrEnv _cdr;   /* @0x8013C290 -- zero-initialised .bss */

/* ---- libetc / libc ---------------------------------------------------------------------------- */
extern int  VSync(int mode);                 /* @0x800F231C */
extern int  puts(const char *s);             /* libc A63 @0x800E80CC */

/* ---- libcd public API (cdcont.cpp / SYS.OBJ) -------------------------------------------------- */
extern int   CdStatus(void);                                       /* @0x800F7780 */
extern int   CdMode(void);                                         /* @0x800F7790 */
extern void *CdLastPos(void);                                      /* @0x800F77A0 */
extern void  CdFlush(void);                                        /* @0x800F7818 */
extern int   CdReady(int mode, u_char *result);                    /* @0x800F786C */
extern int   CdSyncCallback(int func);                             /* @0x800F788C */
extern int   CdReadyCallback(int func);                            /* @0x800F78A0 */
extern int   CdControl(int com, u_char *param, u_char *result);    /* @0x800F78B4 -- INT com,
                                     * see cdcont.c's CdControl receipt (w55-a5) */
extern int   CdControlF(int com, u_char *param);                   /* @0x800F79F0 -- INT com
                                     * (w53-a9): the definition's oracle copies the parameter RAW
                                     * and re-masks per use; a u_char parameter masks once at
                                     * entry and cannot match.  All call sites pass literals. */
extern int   CdControlB(int com, u_char *param, u_char *result);   /* @0x800F7B24 -- INT com */
extern int   CdGetSector(void *madr, int size);                    /* @0x800F7C70 */
extern int   CdGetSector2(void *madr, int size);                   /* @0x800F7C90 */
extern int   CdDataCallback(int func);                             /* @0x800F7CB0 */
extern int   CdDataSync(int mode);                                 /* @0x800F7CD4 */
extern int   CdPosToInt(CdlLOC *p);                                /* @0x800F7DF8 */

/* ---- shared driver-config globals (EVENT.OBJ .bss) -------------------------------------------- */
extern int CD_cbread;        /* @0x8013C2D0 : user CdReadCallback */
extern int CD_read_dma_mode; /* @0x8013C2D4 : bit0 = copy sectors via DMA */

/* forward decls (callbacks reference each other and _read_issue) */
extern void _read_sync(void);
extern void _read_int(int intr, int code);
extern void _read_data_int(void);
extern int  _read_issue(int retry);

/* @0x8010887C : sync-complete handler -- restore the saved sync cb and clear the busy flag. */
/* MATCH (w52-a2, DOUBLE OPACITY FENCE -- the split-addresses ORDER swap, 4 -> PASS 13/13):
 * count and instruction MULTISET already matched; the only divergence was WHERE the
 * `addiu s0,s0,%lo` landed.  Retail: `lui; addiu %lo; sw ra; lw a0,0(s0); jal; addiu s0,-40`
 * (the address completed UP FRONT, so the jal slot could only be filled from AFTER the call).
 * Ours: cc1's split-address lowering folds the lo_sum into the load (`lw a0,%lo(s0)`) and
 * leaves the standalone `addiu %lo` as the nearest stealable insn BEFORE the jal -- reorg
 * takes it and the post-call `addiu -40` stays put.  FIX = two zero-instruction W49 IDENTITY
 * fences: the first pins the FULL address of `&_cdr.w28` in a register (kills the lo_sum
 * fold, so the load must use the completed pointer), the second pins the derived block base
 * `saved - 10` == `&_cdr` as its own `addiu -40` (without it gcc folds -40+0x24 into a single
 * `sw zero,-4(s0)`, 12 insns).  reorg then steals that post-call addiu into the jal slot =
 * retail.  FALSIFIED on the way: plain direct `_cdr.w28`/`_cdr.w24` access (anchors on
 * `&_cdr`+40/36 displacements, nop in the jal slot, 4); read-only fence `: : "r"(saved)`
 * (right ORDER but splits high/full into v0/s0, 6); first fence alone (14 insns -- `saved`
 * loses its REG_EQUIV so `_cdr.w24` rematerializes its own lui); second fence alone (4, the
 * original order swap).  TU-level `no_split_addresses` also does NOT fix it (still 4) and is
 * net-worse for the TU (169 -> 199) -- see the ladder/flag table in the w52-a2 report. */
extern void _read_sync(void)
{
    volatile int *saved = &_cdr.w28;
    __asm__("" : "=r"(saved) : "0"(saved));
    CdSyncCallback(*saved);      /* restore saved sync callback */
    {
        volatile CdrEnv *g = (volatile CdrEnv *)(saved - 10);
        __asm__("" : "=r"(g) : "0"(g));
        g->w24 = 0;              /* reading = 0 */
    }
}

/* @0x801088B0 : ready interrupt -- one DataReady per sector.
 * NOTE: NO cached `CdrEnv *g` local -- the oracle addresses `_cdr` fresh (a cheap 2-insn lui/addiu
 * rematerialization of the constant .bss address) at each access, and instead spends its ONE
 * available callee-saved register on the incoming `code` ARGUMENT (which survives several `jal`s
 * and can't be cheaply rematerialized).  A persistent `g` pointer local pins the allocator's
 * saved-reg budget on the wrong value (methodology catalog: "eager-cache" / "don't cache derived
 * pointers across calls" class).
 *
 * MATCH (w52-a2): 48 -> 21 diffs, count EXACT-then-+1 (159/157 -> 158/157).  ONE device does
 * almost all of it -- the W49 IDENTITY FENCE `__asm__("" : "=r"(p) : "0"(p))` on each
 * per-region FIELD ANCHOR.  cc1's default -msplit-addresses lowers `&_cdr.wNN` into a (high)
 * pseudo plus a lo_sum, and the two halves get DIFFERENT registers (`lui $v1,%hi; addiu
 * $s0,$v1,%lo`) while retail emits one `la` into a single register (`lui $s0; addiu $s0,$s0`).
 * The identity fence forces the completed address into one register -- the anchors themselves
 * were already correct, only their materialization was split.  Fences on the two `cur`
 * anchors + the derived `g` view: 48 -> 24 with count EXACT 157/157.  A further anchor on
 * `&_cdr.w20` for the sector-check region (retail: `lw $v1,0($s0)` + `addiu $v1,$s0,-32`)
 * took 24 -> 21 (+1 insn).  FALSIFIED (measured, do NOT retry in this basin): fencing the
 * derived `&_cdr` view inside the sector-error arm (26); an anchor+fence for the head
 * `_cdr.w34 = code` store (27, +3 insns); an anchor+fence for the common tail (60, +4).
 * RESIDUAL 21 = the head store's split `lui $v0/addiu $v1` and the tail's `lui $v1/addiu $s0`
 * (same split-address class, but both fence attempts overshoot), plus three delay-slot
 * placement diffs. */
extern void _read_int(int intr, int code)
{
    _cdr.w34 = code;                                /* remember intr arg for the user cb */

    if ((intr & 0xFF) == 1) {                       /* CdlDataReady */
        if (_cdr.w14 > 0) {                          /* still sectors to read */
            if (_cdr.w10 == 0x200) {                 /* 2048-byte mode: verify the MSF header */
                /* MATCH: a 16-byte scratch (Rage Racer read_callbacks.c spells it
                 * `long buf[4];`), not a 4-byte CdlLOC -- the oracle reserves 16
                 * bytes at sp+0x10 for it (frame 0x30, first save at 0x20). */
                long hdr[4];
                if (CD_read_dma_mode & 1) {
                    CdDataCallback(0);
                    CdGetSector2(hdr, 3);
                    CdDataSync(0);
                    CdDataCallback((int)_read_data_int);
                } else {
                    CdGetSector(hdr, 3);
                }
                {   /* MATCH: retail anchors this region on `&_cdr.w20` ($s0, offset 0) and
                     * derives `&_cdr` from it as `addiu $v1,$s0,-32` for the w14 store. */
                    volatile int *exp = &_cdr.w20;
                    __asm__("" : "=r"(exp) : "0"(exp));
                    if (CdPosToInt((CdlLOC *)hdr) != *exp) {
                        volatile CdrEnv *e = (volatile CdrEnv *)(exp - 8);
                        puts("CdRead: sector error\n");
                        e->w14 = -1;
                    }
                }
            }
            /* copy the sector body.
             * MATCH (per-region field anchor, w47-a5 "Per-region %hi/%lo anchor";
             * the same device Rage Racer uses throughout read_callbacks.c): the
             * oracle materializes a FRESH `%hi/%lo(_cdr+8)` anchor for this block
             * and reaches w10 by +8 off it, then derives `&_cdr` as `anchor-8`
             * for the three read-modify-writes.  A plain `_cdr.field` recon
             * rematerializes `%hi/%lo(_cdr)` per access instead. */
            if (CD_read_dma_mode & 1) {
                volatile int *cur = (volatile int *)&_cdr.w08;
                __asm__("" : "=r"(cur) : "0"(cur));
                CdGetSector2((u_char *)cur[0], cur[2]); /* DMA: advance deferred to _read_data_int */
            } else {
                volatile int *cur = (volatile int *)&_cdr.w08;
                __asm__("" : "=r"(cur) : "0"(cur));
                CdGetSector((u_char *)cur[0], cur[2]);
                {   /* the `&_cdr` view is derived AFTER the call so it lands in a
                     * CALLER-saved temp (oracle `addiu $a0,$s0,-8`); computing it
                     * before the call forces a second callee-saved register. */
                    volatile CdrEnv *g = (volatile CdrEnv *)(cur - 2);
                    __asm__("" : "=r"(g) : "0"(g));
                    g->w08 = (u_char *)(cur[0] + cur[2] * 4);  /* cursor += sector bytes */
                    g->w14--;                                   /* one fewer remaining */
                    g->w20++;                                   /* next expected sector */
                }
            }
        }
    } else {
        /* CORRECTNESS (w51-a3): the oracle sets `$v0 = -1` in the `bne $a0,$v0`
         * DELAY SLOT and this arm is `sw $v0,0x14($v1)` -- the value stored is
         * -1 (error), NOT 1.  The old recon stored 1, which made a non-DataReady
         * interrupt look like "one sector still to go" instead of tripping the
         * error path that re-issues the read.  (methodology 3.1: the delay slot
         * runs before the branch lands, so its constant belongs to BOTH arms.) */
        _cdr.w14 = -1;                               /* @80108A14 : non-DataReady intr */
    }

    /* ---- common tail @80108A18 ---------------------------------------------------------------- */
    _cdr.w18 = VSync(-1);
    if (_cdr.w14 < 0)                                /* error -> re-issue the read */
        _read_issue(1);
    if (VSync(-1) > _cdr.w1c + 0x4B0)                /* overall watchdog (1200 frames) */
        _cdr.w14 = -1;
    if (_cdr.w14 != 0 && !(VSync(-1) > _cdr.w1c + 0x4B0))
        return;                                      /* still busy, not timed out -> wait */

    /* ---- read finished (or timed out) @80108A98 ---------------------------------------------- */
    CdReadyCallback(_cdr.w2c);                       /* restore ready cb */
    if (CD_read_dma_mode & 1)
        CdDataCallback(_cdr.w30);                    /* restore data cb */
    CdSyncCallback((int)_read_sync);                /* install completion sync handler */
    CdControlF(9, 0);                               /* CdlPause */
    if (CD_cbread != 0) {
        _cdr.w24 = 1;
        ((CdlCB)CD_cbread)(_cdr.w14 == 0 ? 2 : 5, code);
    }
}

/* @0x80108B24 : DMA-data complete -- advance the ring and finish if this was the last sector. */
/* MATCH (w55-a5, 4 -> PASS 52/52): TWO cooperating levers.
 *   (1) FENCED WORD ANCHOR.  Retail materializes the state block with ONE self-temping
 *       `la $s0,_cdr` (`lui $s0,%hi; addiu $s0,$s0,%lo`); a bare `_cdr.field` recon lets
 *       -msplit-addresses put the HIGH in its own short-lived pseudo, which local-alloc
 *       hands the first free caller-saved reg -- `lui $v0,%hi; addiu $s0,$v0,%lo` (the
 *       high pseudo can never TIE to the base: local-alloc's combine_regs bails when the
 *       SET reg is not block-local, and the base crosses calls).  An explicit `volatile
 *       int *e = &_cdr` + w49 IDENTITY FENCE makes the address ONE opaque pseudo = the
 *       self-temp form (same lever CdReadSync already used for its `&_cdr.w1c` anchor).
 *   (2) The fence's price: `e` is now an UNKNOWN pointer, so the `*(int*)&e[9] = 1` store
 *       may-aliases CD_cbread and the callback load can no longer be hoisted above it --
 *       costing the beqz delay slot fill (+2 nops, and CD_cbread lands in $v0 not $v1).
 *       Reading the callback into a LOCAL before the store restores retail's order.
 *       Falsified in this basin: struct-typed anchor + fence (10), unfenced anchor (4). */
extern void _read_data_int(void)
{
    volatile int *e = (volatile int *)&_cdr;   /* $s0 : &_cdr (word-indexed) */
    __asm__("" : "=r"(e) : "0"(e));            /* MATCH: one `la`, not a split lui/addiu */

    e[2] += e[4] * 4;            /* w08 cursor += w10 sector bytes */
    e[5]--;                      /* w14 : one fewer remaining      */
    e[8]++;                      /* w20 : next expected sector     */
    if (e[5] != 0)
        return;

    CdReadyCallback(e[11]);      /* w2c */
    if (CD_read_dma_mode & 1)
        CdDataCallback(e[12]);   /* w30 */
    CdSyncCallback((int)_read_sync);
    CdControlF(9, 0);           /* CdlPause */
    {
        CdlCB cb = (CdlCB)CD_cbread;   /* MATCH: load BEFORE the w24 store (see (2)) */
        /* CORRECTNESS (w48-a6): the oracle's `sw $v0,0x24($s0)` sits in the `beqz $v1`
         * DELAY SLOT, so `reading = 1` executes on BOTH paths -- it is NOT inside the
         * CD_cbread guard.  (Delay-slot placement is semantics, methodology 3.1.) */
        *(int *)&e[9] = 1;      /* w24; MATCH: non-volatile cast -- reorg refuses to
                                 * slot-fill a volatile MEM (3.25-3c). */
        if (cb != 0)
            cb(2, e[13]);       /* w34 */
    }
}

/* @0x80108BF4 : (re)issue the read.  retry!=0 re-seeks to CdLastPos and re-sends mode.
 *
 * MATCH (w52-a2): 64 -> 23 diffs, 120 -> 121 insns vs oracle 122.  Three levers:
 *  (1) ERROR-TAIL PLACEMENT.  Retail's `_cdr.w14 = -1; return _cdr.w14;` tail sits INLINE in
 *      the CdlSetmode arm (`bnez $v0` skips it) and the CdlSetloc failure JUMPS INTO it;
 *      our trailing `error:` block made gcc cross-jump and invert the branch to `beqz`.
 *      FIX = write the body inline in the Setmode arm and put the `error:` label ON it, so
 *      the earlier site's `goto` targets the inline copy.  64 -> 50, and dropping the now-
 *      dead trailing block took 126 -> 120 insns.  (Inlining BOTH sites = 62/126: retail has
 *      exactly ONE copy, reached from two places.)
 *  (2) FIELD ANCHOR + IDENTITY FENCE for the mode region: retail keeps `&_cdr.w0c` in a
 *      register ($s1) and reads the field ONCE (`lw $s0,0($s1)`), reusing that value for
 *      both the `modeb` byte store and the `& 0xFF` compare; ours emitted two loads off a
 *      `&_cdr`+12 base.  50 -> 46 (-2 insns).
 *  (3) EXTEND THE ANCHOR'S LIVE RANGE past CdMode with a read-only fence.  Without it the
 *      anchor dies at its own load and `retry` takes $s1; retail spends a THIRD callee-saved
 *      register, keeping the anchor in $s1 and `retry` in $s2 (extra `sw $s2,32($sp)` +
 *      restore).  45 -> 23.  (The same fence placed INSIDE the if-body instead: 28.)
 *  Also landed here: a tail anchor `g = &_cdr` + identity fence (46 -> 45) so the whole tail
 *  runs off one `la` like retail's $s0.
 * RESIDUAL 23 = delay-slot fills where retail has `nop`, one `addu $a2,$a1,zero` copy where
 * retail rematerializes zero (the old-gcc no-copy-prop class), and the tail anchor being
 * materialized ~9 insns earlier than retail's. */
extern int _read_issue(int retry)
{
    volatile CdrEnv *g;
    CdSyncCallback(0);
    CdReadyCallback(0);
    if (CD_read_dma_mode & 1)
        CdDataCallback(0);

    if (CdStatus() & 0x10) {                        /* shell open */
        if ((VSync(-1) & 0x3F) == 0)               /* throttle the spam */
            puts("CdRead: Shell open...\n");
        CdControlF(1, 0);                          /* CdlNop */
        _cdr.w1c = VSync(-1);
        _cdr.w14 = -1;
        return _cdr.w14;
    }

    if (retry != 0) {
        puts("CdRead: retry...\n");
        CdControl(9, 0, 0);                                  /* CdlPause */
        if (CdControl(2, (u_char *)CdLastPos(), 0) == 0)     /* CdlSetloc */
            goto error;
    }

    CdFlush();
    {
        volatile int *mp = &_cdr.w0c;   /* MATCH: FIELD ANCHOR ($s1) held across CdMode() */
        int    m;
        u_char modeb;
        __asm__("" : "=r"(mp) : "0"(mp));
        m     = *mp;                    /* MATCH: ONE load of w0c ($s0), reused for both uses */
        modeb = (u_char)m;
        if ((m & 0xFF) != CdMode() || retry != 0) {
            if (CdControl(0xE, &modeb, 0) == 0) {            /* CdlSetmode */
            error:
                _cdr.w14 = -1;      /* MATCH: retail keeps this error tail INLINE (bnez skips it); */
                return _cdr.w14;    /* sharing it via `goto error` cross-jumps + inverts polarity */
            }
        }
        __asm__("" : : "r"(mp));  /* MATCH: keep the anchor live PAST CdMode -> $s1,
                                    * which pushes `retry` onto retail's $s2 */
    }

    /* delay-slot capture: w20 receives CdPosToInt()'s result (computed before CdReadyCallback). */
    g = &_cdr;                      /* MATCH: TAIL ANCHOR ($s0) -- one `la` for the whole tail */
    __asm__("" : "=r"(g) : "0"(g));
    g->w20 = CdPosToInt((CdlLOC *)CdLastPos());             /* start sector */
    CdReadyCallback((int)_read_int);
    if (CD_read_dma_mode & 1)
        CdDataCallback((int)_read_data_int);
    CdControlF(6, 0);                                        /* CdlReadN */
    g->w08 = g->w04;                                        /* cursor = buffer */
    g->w14 = g->w00;                                        /* remaining = sectors */
    g->w18 = VSync(-1);
    return g->w14;
}

/* @0x80108DDC : CdRead -- start an asynchronous N-sector read into `buf`. Returns >0 on success.
 *
 * NOTE (unlike _read_int/_read_data_int above): here a cached struct-base local scores best.
 * FALSIFIED in this basin (w51-a3, measured -- do not retry): the w47-a5 "CdRead angle"
 * PER-REGION field anchor.  The oracle really does mint a fresh `%hi/%lo(_cdr+field)` base per
 * region ($s0=&_cdr.w24 busy-wait, $s0=&_cdr.w28 then -0x28 in the timeout arm, $a0=&_cdr for
 * the call-free switch, $v1=&_cdr for its default arm, $s0=&_cdr across the whole tail), and
 * spelling those anchors out DOES close the 9-instruction gap (94 -> 97 -> 105 vs oracle 103),
 * but each anchor re-rotates the s-register handout: 43 -> 54 (busy anchor) -> 70 (full region
 * split).  Kept at the cached-base form; direct `_cdr.field` access also regressed (43 -> 61).
 *
 * w52-a2 RE-PROBE (basin-relative, per the catalog's "falsifications are basin-relative" META):
 * the w51 anchor attempt was made WITHOUT the W49 identity fence, so every anchor still came
 * out split (`lui $vX,%hi; addiu $sY,$vX,%lo`).  Re-run with a fence on each of the four
 * regions (busy = &_cdr.w24, the timeout arm = &_cdr.w28 then -0x28 -- the exact _read_sync
 * recipe -- the mode/sector-size switch = &_cdr, and the tail = &_cdr): **53 diffs at
 * 108/103 insns**, i.e. better than w51's 70@105 but still worse than the cached-base 43@94.
 * The anchors DO close the 9-instruction shortfall (94 -> 108) and the switch/timeout blocks
 * line up; what is left is the anchor REGISTER handout ($v1 where retail has $a0 for the
 * switch region, and a copy instead of an in-place `addiu $s0,$s0,-40` in the timeout arm).
 * Extra promote/demote fences on the region anchors moved nothing (53 x3).  NAMED ANGLE:
 * land the fenced-anchor form and then dial the four anchors' allocno priorities the way
 * _st_dma's bit/dp/bv were dialled -- the shape is right, only the coloring is not.
 * (Reverted for now: the gate is the authority and 53 > 43.) */
extern int CdRead(int sectors, u_long *buf, int mode)
{
    /* w59-a7: 43 @94/103 (9 insns SHORT) -> 43 @102/103 -> PASS-track 38 @103/103 COUNT-EXACT
     * with the one-line orchestrator wiring below.  This retires the file-header / methodology
     * "BASE-POINTER-ANCHOR granularity = GENUINE FLOOR" verdict for CdRead exactly as w52-a2
     * retired it for CdReadSync.  Ladder was re-run at the new basin (04Z): the header's
     * per-fn rung table is unchanged in its verdict -- no rung beats the wired lane.
     *
     * ORCHESTRATOR WIRING (probe-validated on a scratchpad build.py copy; NEW MECHANISM,
     * ~2 lines): give the MASPSX lane the per-fn flag splice it already has for
     * -fno-delayed-branch / -fno-thread-jumps / -fforce-addr, extended with
     * `-mno-split-addresses`:
     *     PER_FN_NO_SPLIT_ADDRESSES = {"recon/syslib/psx/libcd/cdread.c": {"CdRead"}}
     *   and one extra tuple in _apply_fn_splice's table list:
     *     (PER_FN_NO_SPLIT_ADDRESSES, "-mno-split-addresses", "nosplit")
     * WHY per-FN and not per-TU: the file header already measures whole-TU
     * `no_split_addresses` as a net LOSS (169 -> 199: _read_data_int 4->27, _read_issue
     * 64->81) even though CdRead itself improves -- the classic PER_FN_NO_DELAYED_BRANCH
     * situation.  Measured with the splice: CdRead 43 -> 38 @103/103, _read_int 21,
     * _read_issue 23, three PASSes unchanged (whole-TU gate 3/6, zero PASS->FAIL).
     * MECHANISM: the residual 5 insns were cc1's PRE-SPLIT `lui/addiu` address halves --
     * three stray `lui $v1` copies that sched/jump-threading scattered across the switch
     * arms.  With split-addresses off cc1 emits the `la` MACRO and they collapse.
     * RESIDUAL 38 @103/103, three named classes: (a) an $a0<->$v1 swap on the mode-region
     * anchor and its `andi` temp (retail parks the anchor in $a0); (b) which switch arm's
     * constant reorg steals into the `beq` delay slot (retail pre-sets the DEFAULT's
     * `li $v0,0x246`, ours steals case-0x20's `li $v0,0x249`); (c) `CdControlB(9,0,0)`'s
     * third argument -- retail rematerializes `addu $a2,$zero,$zero`, cse substitutes our
     * live `$a1` zero (the catalog's cse-substituted-live-zero opacity-fence job), plus the
     * `slt $v0,$zero,$v0` scheduled before vs after the frame restores.
     *
     * MATCH (w59-a7): PER-REGION FIELD ANCHORS, the same Rage-Racer idiom that already seals
     * CdReadSync's block below.  Retail does NOT hold one `&_cdr` across this function: it
     * materializes FOUR separate anchors (`la $s0,_cdr+0x24` for the busy poll; `la $s0,_cdr+0x28`
     * in the watchdog arm, from which cse derives `&_cdr` by `addiu $s0,$s0,-0x28` in the
     * CdSyncCallback delay slot; `la $a0,_cdr` for the mode/switch region -- plus its own
     * `la $v1,_cdr` inside the DEFAULT arm; `la $s0,_cdr` again for the tail region) and reaches
     * each region's fields by displacement off its own anchor.  That is exactly the 9 instructions
     * ours was SHORT.  Each anchor is pinned with the w49 zero-instruction identity fence, without
     * which cse collapses them all back into one hoisted base (the shape this file's own header
     * calls the "BASE-POINTER-ANCHOR granularity floor" -- retired here as it was for CdReadSync). */
    volatile int *busy = &_cdr.w24;
    volatile CdrEnv *g;
    volatile CdrEnv *e;

    __asm__("" : "=r"(busy) : "0"(busy));

    if (*busy != 0) {                               /* a previous read is still active */
        int t0 = VSync(-1);
        while (*busy != 0) {
            if (!((unsigned)(VSync(-1) - t0) < 0x79)) {   /* waited >= 121 frames -> force-finish */
                volatile int *sv = &_cdr.w28;
                __asm__("" : "=r"(sv) : "0"(sv));
                CdSyncCallback(*sv);
                sv -= 10;                           /* -0x28 -> &_cdr (jal delay slot) */
                sv[9] = 0;                          /* w24 = 0 */
                break;
            }
        }
    }

    g = &_cdr;
    __asm__("" : "=r"(g) : "0"(g));
    g->w0c = mode;
    switch (g->w0c & 0x30) {
    case 0:    g->w10 = 0x200; break;               /* 2048 bytes */
    case 0x20: g->w10 = 0x249; break;               /* 2340 bytes (full raw) */
    default: {                                      /* 2328 bytes -- own anchor in this arm */
        volatile CdrEnv *d = &_cdr;
        __asm__("" : "=r"(d) : "0"(d));
        d->w10 = 0x246;
        break;
    }
    }

    e = &_cdr;
    __asm__("" : "=r"(e) : "0"(e));
    e->w0c |= 0x20;
    e->w04 = (u_char *)buf;
    e->w00 = sectors;
    e->w28 = CdSyncCallback(0);                     /* save+clear sync cb */
    e->w2c = CdReadyCallback(0);                    /* save+clear ready cb */
    if (CD_read_dma_mode & 1)
        e->w30 = CdDataCallback(0);                 /* save+clear data cb */
    e->w1c = VSync(-1);
    if (CdStatus() & 0xE0)                          /* drive busy -> pause first */
        CdControlB(9, 0, 0);
    return _read_issue(0) > 0;
}

/* @0x80108F78 : CdReadSync -- poll (mode!=0) or block (mode==0) until the read completes.
 *
 * MATCH: FIELD-ANCHOR base pointers, transplanted from the byte-exact Rage Racer
 * decomp (C:\Temp\rage-racer-decomp\src\main\PAL\lib\libcd\read.c, CdReadSync:
 * `volatile long *state = &g_CdReadStartVSync;` then `state[0]`, `state[-1]`,
 * `state[-2]`, `state[-7]`).  This RETIRES the methodology's "GENUINE FLOOR --
 * BASE-POINTER-ANCHOR granularity" verdict that was filed against exactly this
 * function: the oracle anchors `$s1 = &_cdr.w1c` (D_8013C2AC) and `$s2 = $s1+8`
 * and reaches every other field by a SIGNED displacement off them; a struct-base
 * `_cdr.field` recon can never emit that, but NEGATIVE-INDEXED pointers into the
 * middle of the block can.
 *
 * MATCH (w52-a2): the anchor's own materialization was SPLIT (`lui $v0,%hi; addiu $s1,$v0,%lo`)
 * where retail emits a single `la $s1`.  Splitting the declaration from the assignment and
 * pinning it with a W49 IDENTITY FENCE gives retail's one-register form; the diff count stays
 * 6 but the residual is now only (a) WHERE the `sw $s2,24($sp)` / `addiu $s2,$s1,8` pair is
 * scheduled in the prologue and (b) one `addu $a0,$s0,zero` copy where retail rematerializes
 * `li $a0,-1` (the old-gcc no-copy-prop class: `s0 = -1` is still live at the second
 * `VSync(-1)` call, so our cc1 reuses it).  FALSIFIED: read-only and identity fences on
 * `busy` to pull its `addiu` forward (6 both).  The ladder answers (a)+(b) -- rungs 2.6.0 /
 * 2.6.3 / 2.7.2 all score CdReadSync at 3 -- but they cost the TU as a whole (see the header).
 *
 * CORRECTNESS (same pass): the oracle DISCARDS CdReady's return -- `lw $v0,0($s2)`
 * overwrites it, and the two return paths are `v0 = s0` (delay slot) and `v0 = 1`.
 * The old recon returned CdReady's result whenever `w24 == 0`.
 *
 * MATCH (w55-a5): residual (b) SOLVED at source -- 6 -> 4, count-exact 65/65.  See the
 * loop-top comment: the `-1` answer belongs to the watchdog-trip ARM, not the loop head.
 * RESIDUAL 4, NAMED + PROVEN: residual (a) alone, a PURE 2-LINE TEXT RELOCATION -- retail
 * emits `sw $18,24($sp); addiu $18,$17,8` immediately after the anchor's `addiu $17,$17,
 * %lo(_cdr+28)`, ours sinks the pair below `sw $31` / `sw $16`.  The anchor's identity
 * fence is a scheduling barrier that pins `busy`'s addiu behind it, and every fence
 * flavour/placement probed re-measures 4 (identity / read-only / void-tail on `busy`,
 * fence after `busy`, `busy` computed before the state fence, `busy` from `&_cdr.w24`,
 * a dead `(void)busy[0]` ref) -- basin-re-probed w55, the w52 verdict holds.
 *   ORCHESTRATOR: PER_FN_TEXT_MOVES (already wired for THIS lane, compile_c) --
 *   PROVEN PASS 65/65 by scratchpad/w55a5_moves.py:
 *     "recon/syslib/psx/libcd/cdread.c": {"CdReadSync": [
 *        {"take": r"\tsw\t\$18,24\(\$sp\)\n",
 *         "after": r"\taddiu\t\$17,\$17,%lo\(_cdr\+28\)[^\n]*\n"},
 *        {"take": r"\taddu\t\$18,\$17,8\n",
 *         "after": r"\tsw\t\$18,24\(\$sp\)\n"}]}                                  */
extern int CdReadSync(int mode, u_char *result)
{
    volatile int *state;                               /* $s1 : issue-VSync stamp   */
    volatile int *busy;                                /* $s2 : &_cdr.w24           */
    int s0;

    state = (volatile int *)&_cdr.w1c;
    __asm__("" : "=r"(state) : "0"(state));  /* MATCH: one `la`, not a split lui/addiu */
    busy  = state + 2;

    for (;;) {
        /* MATCH (w55-a5): the `-1` answer belongs to the WATCHDOG-TRIP arm ONLY.
         * A loop-top `s0 = -1;` is dead on all three other paths, but it keeps
         * `s0 == -1` live at the SECOND `VSync(-1)` call, so cc1's cse feeds that
         * argument by copy (`addu $a0,$s0,zero`) where retail rematerializes
         * `li $a0,-1`.  Sinking the assignment into its own arm removes the
         * live -1 and restores the rematerialization: 6 -> 4, count-exact 65/65
         * (falsified in this basin: identity/read-only fence on s0 7/11, opacity
         * fence on the VSync argument 8). */
        if (VSync(-1) > state[0] + 0x4B0)              /* overall watchdog tripped  */
            goto trip;
        if (state[-2] < 0)                             /* _cdr.w14 : error          */
            goto reissue;
        if (!(VSync(-1) > state[-1] + 0x3C))           /* _cdr.w18 : per-intr stall */
            goto still;
    reissue:
        /* MATCH (block order / branch polarity): the oracle reaches the "still
         * progressing" load through the TAKEN edge of `beqz` and lays it
         * OUT-OF-LINE after the re-issue block, so re-issue is the fall-through.
         * Written as an inline `if (...) { s0 = state[-2]; goto check; }` the arm
         * is inlined and the branch inverts to `bnez`. */
        _read_issue(1);
        s0 = state[-7];                                /* _cdr.w00 : sectors        */
        goto check;
    trip:
        s0 = -1;
        goto check;
    still:
        s0 = state[-2];                                /* still progressing         */
    check:
        if (mode != 0) break;
        if (busy[0] != 0 && s0 == 0) continue;         /* still draining            */
        if (s0 > 0) continue;                          /* sectors left              */
        break;
    }

    CdReady(1, result);
    /* MATCH: the "drained" answer is assigned back INTO s0 (`li s0,1` lands in the
     * `bnez s0` delay slot, then the shared `addu v0,s0,zero` tail); a literal
     * `return 1;` materializes it straight into $v0 and loses the funnel. */
    if (busy[0] == 0) return s0;
    if (s0 == 0) s0 = 1;
    return s0;
}

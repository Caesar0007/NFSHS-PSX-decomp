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
extern int   CdControl(u_char com, u_char *param, u_char *result); /* @0x800F78B4 */
extern int   CdControlF(u_char com, u_char *param);                /* @0x800F79F0 */
extern int   CdControlB(u_char com, u_char *param, u_char *result);/* @0x800F7B24 */
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
extern void _read_sync(void)
{
    volatile int *saved = &_cdr.w28;
    CdSyncCallback(*saved);      /* restore saved sync callback */
    _cdr.w24 = 0;                /* reading = 0 */
}

/* @0x801088B0 : ready interrupt -- one DataReady per sector.
 * NOTE: NO cached `CdrEnv *g` local -- the oracle addresses `_cdr` fresh (a cheap 2-insn lui/addiu
 * rematerialization of the constant .bss address) at each access, and instead spends its ONE
 * available callee-saved register on the incoming `code` ARGUMENT (which survives several `jal`s
 * and can't be cheaply rematerialized).  A persistent `g` pointer local pins the allocator's
 * saved-reg budget on the wrong value (methodology catalog: "eager-cache" / "don't cache derived
 * pointers across calls" class). */
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
                if (CdPosToInt((CdlLOC *)hdr) != _cdr.w20) { /* read landed on the wrong sector */
                    puts("CdRead: sector error\n");
                    _cdr.w14 = -1;
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
                CdGetSector2((u_char *)cur[0], cur[2]); /* DMA: advance deferred to _read_data_int */
            } else {
                volatile int *cur = (volatile int *)&_cdr.w08;
                CdGetSector((u_char *)cur[0], cur[2]);
                {   /* the `&_cdr` view is derived AFTER the call so it lands in a
                     * CALLER-saved temp (oracle `addiu $a0,$s0,-8`); computing it
                     * before the call forces a second callee-saved register. */
                    volatile CdrEnv *g = (volatile CdrEnv *)(cur - 2);
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
extern void _read_data_int(void)
{
    _cdr.w08 += _cdr.w10 * 4;   /* cursor += sector bytes */
    _cdr.w14--;                  /* one fewer remaining    */
    _cdr.w20++;                  /* next expected sector   */
    if (_cdr.w14 != 0)
        return;

    CdReadyCallback(_cdr.w2c);
    if (CD_read_dma_mode & 1)
        CdDataCallback(_cdr.w30);
    CdSyncCallback((int)_read_sync);
    CdControlF(9, 0);           /* CdlPause */
    /* CORRECTNESS (w48-a6): the oracle's `sw $v0,0x24($s0)` sits in the `beqz $v1` DELAY SLOT,
     * so `reading = 1` executes on BOTH paths -- it is NOT inside the CD_cbread guard.
     * (Delay-slot placement is semantics, methodology 3.1 / w47 FILE_callbackop.) */
    *(int *)&_cdr.w24 = 1;   /* MATCH: non-volatile cast -- reorg refuses to slot-fill a volatile
                              * MEM, and this store IS the oracle's beqz delay slot (3.25-3c). */
    if (CD_cbread != 0)
        ((CdlCB)CD_cbread)(2, _cdr.w34);
}

/* @0x80108BF4 : (re)issue the read.  retry!=0 re-seeks to CdLastPos and re-sends mode. */
extern int _read_issue(int retry)
{
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
        u_char modeb = (u_char)_cdr.w0c;
        if ((_cdr.w0c & 0xFF) != CdMode() || retry != 0) {
            if (CdControl(0xE, &modeb, 0) == 0)              /* CdlSetmode */
                goto error;
        }
    }

    /* delay-slot capture: w20 receives CdPosToInt()'s result (computed before CdReadyCallback). */
    _cdr.w20 = CdPosToInt((CdlLOC *)CdLastPos());           /* start sector */
    CdReadyCallback((int)_read_int);
    if (CD_read_dma_mode & 1)
        CdDataCallback((int)_read_data_int);
    CdControlF(6, 0);                                        /* CdlReadN */
    _cdr.w08 = _cdr.w04;                                    /* cursor = buffer */
    _cdr.w14 = _cdr.w00;                                    /* remaining = sectors */
    _cdr.w18 = VSync(-1);
    return _cdr.w14;

error:
    _cdr.w14 = -1;
    return _cdr.w14;
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
 * split).  Kept at the cached-base form; direct `_cdr.field` access also regressed (43 -> 61). */
extern int CdRead(int sectors, u_long *buf, int mode)
{
    volatile CdrEnv *g = &_cdr;

    if (g->w24 != 0) {                              /* a previous read is still active */
        int t0 = VSync(-1);
        while (g->w24 != 0) {
            if (!((unsigned)(VSync(-1) - t0) < 0x79)) {   /* waited >= 121 frames -> force-finish */
                CdSyncCallback(g->w28);
                g->w24 = 0;
                break;
            }
        }
    }

    g->w0c = mode;
    switch (g->w0c & 0x30) {
    case 0:    g->w10 = 0x200; break;               /* 2048 bytes */
    case 0x20: g->w10 = 0x249; break;               /* 2340 bytes (full raw) */
    default:   g->w10 = 0x246; break;               /* 2328 bytes */
    }
    g->w0c |= 0x20;
    g->w04 = (u_char *)buf;
    g->w28 = CdSyncCallback(0);                     /* save+clear sync cb */
    g->w00 = sectors;
    g->w2c = CdReadyCallback(0);                    /* save+clear ready cb */
    if (CD_read_dma_mode & 1)
        g->w30 = CdDataCallback(0);                 /* save+clear data cb */
    g->w1c = VSync(-1);
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
 * CORRECTNESS (same pass): the oracle DISCARDS CdReady's return -- `lw $v0,0($s2)`
 * overwrites it, and the two return paths are `v0 = s0` (delay slot) and `v0 = 1`.
 * The old recon returned CdReady's result whenever `w24 == 0`. */
extern int CdReadSync(int mode, u_char *result)
{
    volatile int *state = (volatile int *)&_cdr.w1c;   /* $s1 : issue-VSync stamp   */
    volatile int *busy  = state + 2;                   /* $s2 : &_cdr.w24           */
    int s0;

    for (;;) {
        s0 = -1;
        if (VSync(-1) > state[0] + 0x4B0)              /* overall watchdog tripped  */
            goto check;
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

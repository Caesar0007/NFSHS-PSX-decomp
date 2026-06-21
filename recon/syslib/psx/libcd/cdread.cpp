/* syslib/psx/libcd/cdread.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcd.lib(CDREAD.OBJ): the high-level multi-sector CdRead engine.
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

extern "C" { CdrEnv _cdr; }   /* @0x8013C290 -- zero-initialised .bss */

/* ---- libetc / libc ---------------------------------------------------------------------------- */
extern "C" int  VSync(int mode);                 /* @0x800F231C */
extern "C" int  puts(const char *s);             /* libc A63 @0x800E80CC */

/* ---- libcd public API (cdcont.cpp / SYS.OBJ) -------------------------------------------------- */
extern "C" int   CdStatus(void);                                       /* @0x800F7780 */
extern "C" int   CdMode(void);                                         /* @0x800F7790 */
extern "C" void *CdLastPos(void);                                      /* @0x800F77A0 */
extern "C" void  CdFlush(void);                                        /* @0x800F7818 */
extern "C" int   CdReady(int mode, u_char *result);                    /* @0x800F786C */
extern "C" int   CdSyncCallback(int func);                             /* @0x800F788C */
extern "C" int   CdReadyCallback(int func);                            /* @0x800F78A0 */
extern "C" int   CdControl(u_char com, u_char *param, u_char *result); /* @0x800F78B4 */
extern "C" int   CdControlF(u_char com, u_char *param);                /* @0x800F79F0 */
extern "C" int   CdControlB(u_char com, u_char *param, u_char *result);/* @0x800F7B24 */
extern "C" int   CdGetSector(void *madr, int size);                    /* @0x800F7C70 */
extern "C" int   CdGetSector2(void *madr, int size);                   /* @0x800F7C90 */
extern "C" int   CdDataCallback(int func);                             /* @0x800F7CB0 */
extern "C" int   CdDataSync(int mode);                                 /* @0x800F7CD4 */
extern "C" int   CdPosToInt(CdlLOC *p);                                /* @0x800F7DF8 */

/* ---- shared driver-config globals (EVENT.OBJ .bss) -------------------------------------------- */
extern "C" int CD_cbread;        /* @0x8013C2D0 : user CdReadCallback */
extern "C" int CD_read_dma_mode; /* @0x8013C2D4 : bit0 = copy sectors via DMA */

/* forward decls (callbacks reference each other and _read_issue) */
static void _read_sync(void);
static void _read_int(int intr, int code);
static void _read_data_int(void);
static int  _read_issue(int retry);

/* @0x8010887C : sync-complete handler -- restore the saved sync cb and clear the busy flag. */
static void _read_sync(void)
{
    CdSyncCallback(_cdr.w28);    /* restore saved sync callback */
    _cdr.w24 = 0;                /* reading = 0 */
}

/* @0x801088B0 : ready interrupt -- one DataReady per sector. */
static void _read_int(int intr, int code)
{
    CdrEnv *g = &_cdr;

    g->w34 = code;                                  /* remember intr arg for the user cb */

    if ((intr & 0xFF) == 1) {                       /* CdlDataReady */
        if (g->w14 > 0) {                           /* still sectors to read */
            if (g->w10 == 0x200) {                  /* 2048-byte mode: verify the MSF header */
                CdlLOC hdr;
                if (CD_read_dma_mode & 1) {
                    CdDataCallback(0);
                    CdGetSector2(&hdr, 3);
                    CdDataSync(0);
                    CdDataCallback((int)_read_data_int);
                } else {
                    CdGetSector(&hdr, 3);
                }
                if (CdPosToInt(&hdr) != g->w20) {   /* read landed on the wrong sector */
                    puts("CdRead: sector error\n");
                    g->w14 = -1;
                }
            }
            /* copy the sector body */
            if (CD_read_dma_mode & 1) {
                CdGetSector2(g->w08, g->w10);       /* DMA: advance deferred to _read_data_int */
            } else {
                CdGetSector(g->w08, g->w10);
                g->w08 += g->w10 * 4;               /* cursor += sector bytes */
                g->w14--;                           /* one fewer remaining */
                g->w20++;                           /* next expected sector */
            }
        }
    } else {
        g->w14 = 1;                                 /* @80108A14 : non-DataReady intr */
    }

    /* ---- common tail @80108A18 ---------------------------------------------------------------- */
    g->w18 = VSync(-1);
    if (g->w14 < 0)                                 /* error -> re-issue the read */
        _read_issue(1);
    if (g->w1c + 0x4B0 < VSync(-1))                 /* overall watchdog (1200 frames) */
        g->w14 = -1;
    if (g->w14 != 0 && !(g->w1c + 0x4B0 < VSync(-1)))
        return;                                     /* still busy, not timed out -> wait */

    /* ---- read finished (or timed out) @80108A98 ---------------------------------------------- */
    CdReadyCallback(g->w2c);                        /* restore ready cb */
    if (CD_read_dma_mode & 1)
        CdDataCallback(g->w30);                     /* restore data cb */
    CdSyncCallback((int)_read_sync);                /* install completion sync handler */
    CdControlF(9, 0);                               /* CdlPause */
    if (CD_cbread != 0) {
        g->w24 = 1;
        ((CdlCB)CD_cbread)(g->w14 != 0 ? 5 : 2, g->w34);
    }
}

/* @0x80108B24 : DMA-data complete -- advance the ring and finish if this was the last sector. */
static void _read_data_int(void)
{
    CdrEnv *g = &_cdr;

    g->w08 += g->w10 * 4;       /* cursor += sector bytes */
    g->w14--;                   /* one fewer remaining    */
    g->w20++;                   /* next expected sector   */
    if (g->w14 != 0)
        return;

    CdReadyCallback(g->w2c);
    if (CD_read_dma_mode & 1)
        CdDataCallback(g->w30);
    CdSyncCallback((int)_read_sync);
    CdControlF(9, 0);           /* CdlPause */
    if (CD_cbread != 0) {
        g->w24 = 1;
        ((CdlCB)CD_cbread)(2, g->w34);
    }
}

/* @0x80108BF4 : (re)issue the read.  retry!=0 re-seeks to CdLastPos and re-sends mode. */
static int _read_issue(int retry)
{
    CdrEnv *g = &_cdr;

    CdSyncCallback(0);
    CdReadyCallback(0);
    if (CD_read_dma_mode & 1)
        CdDataCallback(0);

    if (CdStatus() & 0x10) {                        /* shell open */
        if ((VSync(-1) & 0x3F) == 0)               /* throttle the spam */
            puts("CdRead: Shell open...\n");
        CdControlF(1, 0);                          /* CdlNop */
        g->w1c = VSync(-1);
        g->w14 = -1;
        return g->w14;
    }

    if (retry != 0) {
        puts("CdRead: retry...\n");
        CdControl(9, 0, 0);                                  /* CdlPause */
        if (CdControl(2, (u_char *)CdLastPos(), 0) == 0)     /* CdlSetloc */
            goto error;
    }

    CdFlush();
    {
        u_char modeb = (u_char)g->w0c;
        if ((g->w0c & 0xFF) != CdMode() || retry != 0) {
            if (CdControl(0xE, &modeb, 0) == 0)              /* CdlSetmode */
                goto error;
        }
    }

    /* delay-slot capture: w20 receives CdPosToInt()'s result (computed before CdReadyCallback). */
    g->w20 = CdPosToInt((CdlLOC *)CdLastPos());             /* start sector */
    CdReadyCallback((int)_read_int);
    if (CD_read_dma_mode & 1)
        CdDataCallback((int)_read_data_int);
    CdControlF(6, 0);                                        /* CdlReadN */
    g->w08 = g->w04;                                        /* cursor = buffer */
    g->w14 = g->w00;                                        /* remaining = sectors */
    g->w18 = VSync(-1);
    return g->w14;

error:
    g->w14 = -1;
    return g->w14;
}

/* @0x80108DDC : CdRead -- start an asynchronous N-sector read into `buf`. Returns >0 on success. */
extern "C" int CdRead(int sectors, u_long *buf, int mode)
{
    CdrEnv *g = &_cdr;

    if (g->w24 != 0) {                              /* a previous read is still active */
        int t0 = VSync(-1);
        while (g->w24 != 0) {
            if (!(VSync(-1) - t0 < 0x79)) {        /* waited >= 121 frames -> force-finish */
                CdSyncCallback(g->w28);
                g->w24 = 0;
                break;
            }
        }
    }

    g->w0c = mode;
    {
        int sel = g->w0c & 0x30;
        if (sel == 0)         g->w10 = 0x200;       /* 2048 bytes */
        else if (sel == 0x20) g->w10 = 0x249;       /* 2340 bytes (full raw) */
        else                  g->w10 = 0x246;       /* 2328 bytes */
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

/* @0x80108F78 : CdReadSync -- poll (mode!=0) or block (mode==0) until the read completes. */
extern "C" int CdReadSync(int mode, u_char *result)
{
    CdrEnv *g = &_cdr;
    int s0;

    for (;;) {
        if (g->w1c + 0x4B0 < VSync(-1)) {           /* overall watchdog tripped */
            s0 = -1;
            if (g->w14 >= 0 && !(g->w18 + 0x3C < VSync(-1))) {
                s0 = g->w14;                        /* still progressing */
            } else {
                _read_issue(1);                     /* stalled -> re-issue */
                s0 = g->w00;
            }
        } else {
            s0 = g->w14;
        }

        if (mode != 0) break;
        if (g->w24 != 0 && s0 == 0) continue;       /* still draining */
        if (s0 > 0) continue;                       /* sectors left */
        break;
    }

    {
        int r = CdReady(1, result);
        if (g->w24 == 0) return r;
        if (s0 != 0) return s0;
        return 1;
    }
}

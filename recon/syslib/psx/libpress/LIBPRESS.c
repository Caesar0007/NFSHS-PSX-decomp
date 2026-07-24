/* syslib/psx/libpress/LIBPRESS.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libpress.lib(LIBPRESS.OBJ) @0x800F89C8..0x800F8EC0 -- the MDEC (Motion DECoder) driver:
 *   the public Dec* API over an internal engine that feeds run/level data to MDEC via DMA ch0
 *   (MDECin) and reads the decoded macroblocks back via DMA ch1 (MDECout).
 *
 *   MDEC + DMA registers are reached as literal MMIO (the original indirects through a const
 *   pointer table @0x80136C08, every entry of which holds the fixed hardware address below). */

typedef unsigned long  u_long;
typedef unsigned short u_short;

/* @0x80136C08 : the HW-register pointer table.  EVERY MDEC/DMA register in this obj is reached
 * INDIRECTLY through one of these pointer cells (confirmed against every oracle .s in this file --
 * each access is `lui/lw D_80136Cxx; ...; lw/sw 0(reg)`, never a direct lui+ori of the literal
 * address).  Modeled per-cell (matching the pre-existing MDEC1_ptr convention) rather than as one
 * array, since each cell is referenced by its own fixed VA across the functions below. */
static volatile u_long *D0_MADR_ptr __attribute__((section(".bss")));  /* @0x80136C08 */
static volatile u_long *D0_BCR_ptr  __attribute__((section(".bss")));  /* @0x80136C0C */
static volatile u_long *D0_CHCR_ptr __attribute__((section(".bss")));  /* @0x80136C10 */
static volatile u_long *D1_MADR_ptr __attribute__((section(".bss")));  /* @0x80136C14 */
static volatile u_long *D1_BCR_ptr  __attribute__((section(".bss")));  /* @0x80136C18 */
static volatile u_long *D1_CHCR_ptr __attribute__((section(".bss")));  /* @0x80136C1C */
static volatile u_long *MDEC0_ptr   __attribute__((section(".bss")));  /* @0x80136C38 */
static volatile u_long *MDEC1_ptr   __attribute__((section(".bss")));  /* @0x80136C3C */
static volatile u_long *DPCR_ptr    __attribute__((section(".bss")));  /* @0x80136C40 */
/* MDEC_in_sync/MDEC_out_sync's poll loops need MDEC1/D1_CHCR's *volatile-pointer* variable itself
 * (not just its target) reloaded EVERY iteration -- a per-use-site local `volatile T *volatile p`
 * alias achieves that without forcing every OTHER accessor of the same cell to pay a reload too
 * (see the two poll loops below). */

#define D0_MADR (*D0_MADR_ptr)   /* DMA ch0 (MDECin)  address   -- HW: 0x1F801080 */
#define D0_BCR  (*D0_BCR_ptr)    /*                   block ctl -- HW: 0x1F801084 */
#define D0_CHCR (*D0_CHCR_ptr)   /*                   channel ctl -- HW: 0x1F801088 */
#define D1_MADR (*D1_MADR_ptr)   /* DMA ch1 (MDECout) address   -- HW: 0x1F801090 */
#define D1_BCR  (*D1_BCR_ptr)    /*                             -- HW: 0x1F801094 */
#define D1_CHCR (*D1_CHCR_ptr)   /*                             -- HW: 0x1F801098 */
#define MDEC0   (*MDEC0_ptr)     /* MDEC data / command port    -- HW: 0x1F801820 */
#define MDEC1   (*MDEC1_ptr)     /* MDEC status / control       -- HW: 0x1F801824 */
#define DPCR    (*DPCR_ptr)      /* DMA priority/enable         -- HW: 0x1F8010F0 */

extern void ResetCallback(void);             /* libetc INTR.obj @0x800F284C */
extern int  DMACallback(int ch, int func);   /* libetc INTR.obj @0x800F28AC */
extern int  printf(const char *fmt, ...);    /* libc   C63.obj */

/* @0x80136AF8 : MDEC "set quantization tables" command (0x40000001) + 32 words of Y/C matrix. */
static const u_long _mdec_iqtab[33] = {
    0x40000001, 0x13101002, 0x16161310, 0x16161616, 0x1b1a181a, 0x1a1a1b1b, 0x1b1b1a1a, 0x1d1d1d1b,
    0x1d222222, 0x1b1b1d1d, 0x20201d1d, 0x26252222, 0x22232325, 0x28262623, 0x30302828, 0x38382e2e,
    0x5345453a, 0x13101002, 0x16161310, 0x16161616, 0x1b1a181a, 0x1a1a1b1b, 0x1b1b1a1a, 0x1d1d1d1b,
    0x1d222222, 0x1b1b1d1d, 0x20201d1d, 0x26252222, 0x22232325, 0x28262623, 0x30302828, 0x38382e2e,
    0x5345453a
};
/* @0x80136B7C : MDEC "set IDCT scale table" command (0x60000000) + 32 words of cosine matrix. */
static const u_long _mdec_idcttab[33] = {
    0x60000000, 0x5a825a82, 0x5a825a82, 0x5a825a82, 0x5a825a82, 0x6a6d7d8a, 0x18f8471c, 0xb8e3e707,
    0x82759592, 0x30fb7641, 0x89becf04, 0xcf0489be, 0x764130fb, 0xe7076a6d, 0xb8e38275, 0x7d8a471c,
    0x959218f8, 0xa57d5a82, 0x5a82a57d, 0xa57d5a82, 0x5a82a57d, 0x8275471c, 0x6a6d18f8, 0xe7079592,
    0xb8e37d8a, 0x89be30fb, 0xcf047641, 0x7641cf04, 0x30fb89be, 0xb8e318f8, 0x82756a6d, 0x95927d8a,
    0xe707471c
};

/* forward decls (engine internals) */
static int     MDEC_in_sync(int mode);
static int     MDEC_out_sync(int mode);
static int     MDEC_status(const char *who);
static u_long *_MDEC_in_dma(u_long *buf, unsigned size);
static u_long *_MDEC_out_dma(u_long buf, unsigned size);
static int     MDEC_rest(u_long mode);
extern int      _MDEC_get_reg1(void);

/* ---------------------------------- public API ---------------------------------- */

/* @0x800F89C8 : reset the MDEC (mode 0 also reinstalls the interrupt callbacks). */
extern void DecDCTReset(int mode)
{
    if (mode == 0)
        ResetCallback();
    MDEC_rest((u_long)mode);
}

/* @0x800F89FC : start decoding -- patch the run/level header flags then DMA it into MDEC. */
extern void DecDCTin(u_long *runlevel, int mode)
{
    if ((mode & 1) != 0) *runlevel &= 0xf7ffffffu;
    else                 *runlevel |= 0x08000000u;
    if ((mode & 2) != 0) *runlevel |= 0x02000000u;
    else                 *runlevel &= 0xfdffffffu;
    _MDEC_in_dma(runlevel, (u_short)*runlevel);
}

/* @0x800F8A78 : start reading `size` words of decoded output into `cell` via DMA ch1. */
extern int DecDCTout(int *cell, long size)
{
    return (int)(long)_MDEC_out_dma((u_long)(long)cell, (unsigned)size);
}

/* @0x800F8A98 : wait for / poll the MDECin transfer (mode 0 blocks, else returns the FIFO bit). */
extern int DecDCTinSync(int mode)
{
    if (mode != 0)
        return ((unsigned)_MDEC_get_reg1() >> 0x1d) & 1;
    return MDEC_in_sync(0);
}

/* @0x800F8AD4 : install the MDECout (DMA channel 1) completion callback. */
extern int DecDCToutCallback(int func)
{
    return DMACallback(1, func);
}

/* ---------------------------------- engine ---------------------------------- */

/* @0x800F8AF8 : reset the MDEC + DMA channels; mode 0 also reloads the quant/IDCT tables.
 * VERIFY (2026-07-25 survey): 28 diffs, ours 62 / oracle 60 insns -- NOT yet cracked.
 * 🔴 KEY LEAD for a future pass: in the oracle, `li v0,0x80000000` (the MDEC software-reset
 * command word case 1 stores first) is materialized in the DELAY SLOT of the `beq a1,v0,case1`
 * dispatch branch @0x800F8B10 (a free always-executed slot, only actually consumed on the
 * taken/case-1 side) and stays live in $v0 all the way into the case-1 block -- case 1 never
 * recomputes it. Our build instead fills that SAME delay slot with the case-1 constant too in
 * SOME configurations but not this one (it currently fills it with the `default:` printf
 * format-string address instead, per the switch's case order), so case 1 must reload it fresh.
 * Tried: reordering the switch cases (case 1 before case 0) -- flips which delay-slot filler
 * wins but net WORSE (72 diffs, though it does reach an exact 60==60 insn count) and reverted.
 * Case 1's tail (the dead D1_CHCR re-read + MDEC1=0x60000000 store) also differs: oracle reloads
 * D1_CHCR_ptr/MDEC1_ptr into v0/v1 and overwrites v0 directly with 0x60000000 before the final
 * store; ours reloads MDEC1_ptr into a0 instead of v1 and needs an extra `move v1,v0` before the
 * store -- a downstream coloring cascade from the same root cause. Untried: an explicit shared-
 * prefix restructure where case 1 falls into case 0's body (both cases open with the identical
 * MDEC1=0x80000000; D0_CHCR=0; D1_CHCR=0; triplet) instead of two independent case blocks. */
static int MDEC_rest(u_long mode)
{
    switch (mode) {
    case 0:
        MDEC1 = 0x80000000;   /* @0x800F8B24-28: MDEC software-reset command, must precede reconfigure (H49) */
        D0_CHCR = 0;
        D1_CHCR = 0;
        MDEC1 = 0x60000000;
        _MDEC_in_dma((u_long *)_mdec_iqtab, 0x20);
        return (int)(long)_MDEC_in_dma((u_long *)_mdec_idcttab, 0x20);
    case 1:
        MDEC1 = 0x80000000;   /* @0x800F8B7C-88: MDEC software-reset ($v0 from delay slot @0x800F8B10) (H49) */
        D0_CHCR = 0;
        D1_CHCR = 0;
        (void)D1_CHCR;         /* @0x800F8BBC: dead re-read of D1_CHCR (volatile, discarded) -- oracle bytes */
        MDEC1 = 0x60000000;
        return 0x60000000;
    default:
        return printf("MDEC_rest:bad option(%d)\n", (int)mode);
    }
}

/* @0x800F8BE8 : feed `buf` (cmd word + payload) to MDEC over DMA channel 0. */
static u_long *_MDEC_in_dma(u_long *buf, unsigned size)
{
    MDEC_in_sync((int)(long)buf);
    DPCR |= 0x88;
    D0_MADR = (u_long)(long)(buf + 1);
    D0_BCR  = ((size >> 5) << 16) | 0x20;
    MDEC0   = *buf;
    {
        volatile u_long *p = D0_CHCR_ptr;
        *p = 0x1000201;
        return (u_long *)p;
    }
}

/* @0x800F8C78 : read decoded output from MDEC into `buf` over DMA channel 1. */
static u_long *_MDEC_out_dma(u_long buf, unsigned size)
{
    MDEC_out_sync((int)buf);
    DPCR |= 0x88;
    D1_CHCR = 0;                              /* @0x800F8CB0-BC: stop ch1 before reprogramming MADR/BCR */
    D1_MADR = buf;
    D1_BCR  = ((size >> 5) << 16) | 0x20;
    {
        volatile u_long *p = D1_CHCR_ptr;
        *p = 0x1000200;
        return (u_long *)p;
    }
}

/* MDEC_in_sync/MDEC_out_sync re-fetch the table pointer ITSELF fresh every poll iteration in the
 * oracle (not just its target) -- a per-site cast-to-volatile-pointer-of-volatile-pointer view of
 * the cell forces that reload without making every OTHER accessor of the same global pay for it. */
#define MDEC1_POLL   (*(*(volatile u_long *volatile *)&MDEC1_ptr))
#define D1CHCR_POLL  (*(*(volatile u_long *volatile *)&D1_CHCR_ptr))

/* @0x800F8D04 : spin until the MDEC input FIFO drains (busy bit 29), or time out. */
static int MDEC_in_sync(int mode)
{
    volatile int n = 0x100000;
    while ((MDEC1_POLL & 0x20000000) != 0) {
        if (--n == -1) {
            MDEC_status("MDEC_in_sync");
            return -1;
        }
    }
    return 0;
}

/* @0x800F8D98 : spin until the MDECout DMA (ch1) finishes, or time out. */
static int MDEC_out_sync(int mode)
{
    volatile int n = 0x100000;
    while ((D1CHCR_POLL & 0x1000000) != 0) {
        if (--n == -1) {
            MDEC_status("MDEC_out_sync");
            return -1;
        }
    }
    return 0;
}

/* @0x800F8E2C : read the MDEC status register via the HW-pointer table entry. */
extern int _MDEC_get_reg1(void)
{
    return (int)*MDEC1_ptr;
}

/* @0x800F8E44 : report a timeout and force-reset the MDEC + DMA channels. */
static int MDEC_status(const char *who)
{
    printf("%s timeout:\n", who);
    MDEC1 = 0x80000000;
    D0_CHCR = 0;
    D1_CHCR = 0;
    (void)D1_CHCR;         /* dead re-read of D1_CHCR (volatile, discarded) -- oracle bytes */
    MDEC1 = 0x60000000;
    return 0;
}

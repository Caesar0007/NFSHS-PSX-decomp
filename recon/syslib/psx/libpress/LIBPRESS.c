/* syslib/psx/libpress/LIBPRESS.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libpress.lib(LIBPRESS.OBJ) @0x800F89C8..0x800F8EC0 -- the MDEC (Motion DECoder) driver:
 *   the public Dec* API over an internal engine that feeds run/level data to MDEC via DMA ch0
 *   (MDECin) and reads the decoded macroblocks back via DMA ch1 (MDECout).
 *
 *   MDEC + DMA registers are reached as literal MMIO (the original indirects through a const
 *   pointer table @0x80136C08, every entry of which holds the fixed hardware address below). */

typedef unsigned long  u_long;
typedef unsigned short u_short;

#define MDEC0   (*(volatile u_long *)0x1F801820)   /* MDEC data / command port   */
#define MDEC1   (*(volatile u_long *)0x1F801824)   /* MDEC status / control      */

/* @0x80136C3C : pointer to MDEC1 register (0x1F801824); part of the HW-register
 * pointer table @0x80136C08.  _MDEC_get_reg1 loads this pointer absolutely, then
 * dereferences it -- NOT a direct lui+ori of the literal address. */
static volatile u_long *MDEC1_ptr __attribute__((section(".bss")));  /* @0x80136C3C */
#define D0_MADR (*(volatile u_long *)0x1F801080)   /* DMA ch0 (MDECin)  address  */
#define D0_BCR  (*(volatile u_long *)0x1F801084)   /*                   block ctl */
#define D0_CHCR (*(volatile u_long *)0x1F801088)   /*                   channel ctl */
#define D1_MADR (*(volatile u_long *)0x1F801090)   /* DMA ch1 (MDECout) address  */
#define D1_BCR  (*(volatile u_long *)0x1F801094)
#define D1_CHCR (*(volatile u_long *)0x1F801098)
#define DPCR    (*(volatile u_long *)0x1F8010F0)   /* DMA priority/enable        */

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
    if ((mode & 1) == 0) *runlevel |= 0x08000000u;
    else                 *runlevel &= 0xf7ffffffu;
    if ((mode & 2) == 0) *runlevel &= 0xfdffffffu;
    else                 *runlevel |= 0x02000000u;
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
    if (mode == 0)
        return MDEC_in_sync(0);
    return (MDEC1 >> 0x1d) & 1;
}

/* @0x800F8AD4 : install the MDECout (DMA channel 1) completion callback. */
extern int DecDCToutCallback(int func)
{
    return DMACallback(1, func);
}

/* ---------------------------------- engine ---------------------------------- */

/* @0x800F8AF8 : reset the MDEC + DMA channels; mode 0 also reloads the quant/IDCT tables. */
static int MDEC_rest(u_long mode)
{
    if (mode == 0) {
        MDEC1 = 0x80000000;   /* @0x800F8B24-28: MDEC software-reset command, must precede reconfigure (H49) */
        D0_CHCR = 0;
        D1_CHCR = 0;
        MDEC1 = 0x60000000;
        _MDEC_in_dma((u_long *)_mdec_iqtab, 0x20);
        return (int)(long)_MDEC_in_dma((u_long *)_mdec_idcttab, 0x20);
    }
    if (mode == 1) {
        MDEC1 = 0x80000000;   /* @0x800F8B7C-88: MDEC software-reset ($v0 from delay slot @0x800F8B10) (H49) */
        D0_CHCR = 0;
        D1_CHCR = 0;
        MDEC1 = 0x60000000;
        return 0x60000000;
    }
    return printf("MDEC_rest:bad option(%d)\n", (int)mode);
}

/* @0x800F8BE8 : feed `buf` (cmd word + payload) to MDEC over DMA channel 0. */
static u_long *_MDEC_in_dma(u_long *buf, unsigned size)
{
    MDEC_in_sync((int)(long)buf);
    DPCR |= 0x88;
    D0_MADR = (u_long)(long)(buf + 1);
    D0_BCR  = ((size >> 5) << 16) | 0x20;
    MDEC0   = *buf;
    D0_CHCR = 0x1000201;
    return (u_long *)&D0_CHCR;
}

/* @0x800F8C78 : read decoded output from MDEC into `buf` over DMA channel 1. */
static u_long *_MDEC_out_dma(u_long buf, unsigned size)
{
    MDEC_out_sync((int)buf);
    DPCR |= 0x88;
    D1_MADR = buf;
    D1_BCR  = ((size >> 5) << 16) | 0x20;
    D1_CHCR = 0x1000200;
    return (u_long *)&D1_CHCR;
}

/* @0x800F8D04 : spin until the MDEC input FIFO drains (busy bit 29), or time out. */
static int MDEC_in_sync(int mode)
{
    int n = 0x100000;
    do {
        if ((MDEC1 & 0x20000000) == 0)
            return 0;
        n--;
    } while (n != -1);
    MDEC_status("MDEC_in_sync");
    return -1;
}

/* @0x800F8D98 : spin until the MDECout DMA (ch1) finishes, or time out. */
static int MDEC_out_sync(int mode)
{
    int n = 0x100000;
    do {
        if ((D1_CHCR & 0x1000000) == 0)
            return 0;
        n--;
    } while (n != -1);
    MDEC_status("MDEC_out_sync");
    return -1;
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
    D0_CHCR = 0;
    D1_CHCR = 0;
    MDEC1 = 0x60000000;
    return 0;
}

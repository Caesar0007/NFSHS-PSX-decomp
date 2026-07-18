/* syslib/psx/libetc/INTR_DMA.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra; verified vs disasm).
 *   obj INTR_DMA.obj ; libetc.lib.  DMA-interrupt setup + dispatch: startIntrDMA @0x801066AC installs _dma_isr
 *   as the IRQ-3 (DMA) handler and returns the per-channel DMA-callback setter (DMACallback); _dma_isr
 *   @0x801066F8 services each pending channel (DICR @0x1F8010F4 bits 24-30) and reports DMA bus errors;
 *   DMACallback @0x80106878 registers/enables a channel callback.  dma_cb table @0x8013BD24.  The obj-local
 *   _bzero_w (@0x80106924) is `static` (each PsyQ obj carries its own copy).
 */
#define DICR  (*(volatile unsigned int *)0x1F8010F4)

extern "C" void InterruptCallback(int idx, void (*h)());   /* INTR */
extern "C" int  printf(const char *fmt, ...);              /* C63 */
extern "C" void _dma_isr(void);
static int _dma_set_callback(int ch, int func);   /* @0x80106878 : obj-local; only reached via the pointer startIntrDMA returns */

static int dma_cb[8];   /* @0x8013BD24 : per-channel DMA callbacks */

/* HIDDEN-PHANTOM FIX (w14-a2): oracle name is the bare "_bzero_w" (no __F mangling suffix), but
 * this `static` C++ fn got C++-mangled to _bzero_w__FPii, a NAME MISMATCH invisible to the gate
 * ("NOT IN OBJECT" forever). `static`+`extern "C"` can't combine as adjacent storage-class
 * specifiers on this compiler -- wrap in an `extern "C" { }` block instead. */
extern "C" {
static void _bzero_w(int *p, int n)   /* @0x80106924 */
{
    int i = n - 1;
    if (n != 0) {
        do { *p = 0; i = i - 1; p = p + 1; } while (i != -1);
    }
}
}   /* extern "C" */

extern "C" void *startIntrDMA(int priority)   /* @0x801066AC */
{
    _bzero_w(dma_cb, 8);
    DICR = 0;
    InterruptCallback(3, _dma_isr);
    return (void *)_dma_set_callback;
}

extern "C" void _dma_isr(void)   /* @0x801066F8 */
{
    unsigned int pending = DICR >> 0x18 & 0x7f;
    if (pending != 0) {
        do {
            int *cb = dma_cb;
            for (int i = 0; (pending != 0 && i < 7); i = i + 1) {
                if ((pending & 1) != 0) {
                    DICR = DICR & (1 << (i + 0x18U & 0x1f) | 0xffffffU);
                    if (*cb) ((void (*)())*cb)();
                }
                cb = cb + 1;
                pending = pending >> 1;
            }
            pending = DICR >> 0x18 & 0x7f;
        } while (pending != 0);
    }
    if (((DICR & 0xff000000) == 0x80000000) || ((DICR & 0x8000) != 0)) {
        printf("DMA bus error: code=%08x\n", DICR);
        int i;
        for (i = 0; i < 7; i++)              /* MADR[0..6]; oracle $s0=0..6, base+$s0*0x10 @0x8010681c-684c */
            printf("MADR[%d]=%08x\n", i, *(volatile unsigned int *)(0x1F801080 + i * 0x10));
    }
}

static int _dma_set_callback(int ch, int func)   /* @0x80106878 (obj-local; installed by startIntrDMA) */
{
    int *p = &dma_cb[ch];
    int old = *p;
    if (func != old) {
        if (func == 0) {
            *p = 0;
            DICR = (DICR & 0xffffff | 0x800000) & ~(1 << (ch + 0x10U & 0x1f));
        } else {
            *p = func;
            DICR = DICR & 0xffffff | 1 << (ch + 0x10U & 0x1f) | 0x800000U;
        }
    }
    return old;
}

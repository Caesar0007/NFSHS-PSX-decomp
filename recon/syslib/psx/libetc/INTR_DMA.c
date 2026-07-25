/* syslib/psx/libetc/INTR_DMA.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra; verified vs disasm).
 *   obj INTR_DMA.obj ; libetc.lib.  DMA-interrupt setup + dispatch: startIntrDMA @0x801066AC installs _dma_isr
 *   as the IRQ-3 (DMA) handler and returns the per-channel DMA-callback setter (DMACallback); _dma_isr
 *   @0x801066F8 services each pending channel (DICR @0x1F8010F4 bits 24-30) and reports DMA bus errors;
 *   DMACallback @0x80106878 registers/enables a channel callback.  dma_cb table @0x8013BD24.  The obj-local
 *   _bzero_w (@0x80106924) is `static` (each PsyQ obj carries its own copy).
 *
 * w25-a2 SURVEY (-fno-delayed-branch splice project, methodology sec 3.25.3b): startIntrDMA
 *   (14 diffs) and _dma_isr (16-24 diffs) both carry PARTIAL signature fingerprints (jal-arg-setup
 *   split across the delay slot vs oracle computing the full arg BEFORE the jal; epilogue lw
 *   ra/addiu sp/jr ra reordering). Empirically whole-TU `-fno-delayed-branch` test (w25-a2,
 *   reverted, not committed): startIntrDMA 14->10 diffs (improves, does NOT reach PASS -- a
 *   residual `addiu v0,v0,0` return-value-materialization reorder survives); _dma_isr 16->25-33
 *   diffs (WORSE -- a second, unrelated lever entangles: ours materializes some addresses via an
 *   intermediate register then copies into the dest [e.g. lui s1,0; addiu a0,s1,0] where the
 *   oracle materializes directly into the dest [lui a0,0; addiu a0,a0,0], a rematerialize-into-
 *   dest / address-CSE class, NOT delay-slot filling -- see catalog "F additions"). NEITHER fn is
 *   a clean per-function splice candidate today: apply only after the address-CSE lever is solved
 *   separately, then re-test with a1's per-fn splice mechanism (whole-TU flag is not authoritative
 *   for the final per-fn residual, but is a valid proxy since gcc codegens per-function).
 */
extern void InterruptCallback(int idx, void (*h)());   /* INTR */
extern int  printf(const char *fmt, ...);              /* C63 */
extern void _dma_isr(void);
static int _dma_set_callback(int ch, int func);   /* @0x80106878 : obj-local; only reached via the pointer startIntrDMA returns */

extern volatile unsigned int *g_dicr_ptr;   /* @0x8013BD20 : = 0x1F8010F4 */
extern int dma_cb[8];                        /* @0x8013BD24 : per-channel DMA callbacks */
extern volatile unsigned int *g_madr_ptr;   /* @0x8013BD44 : = 0x1F801080 */

#define DICR (*g_dicr_ptr)

/* HIDDEN-PHANTOM FIX (w14-a2): oracle name is the bare "_bzero_w" (no __F mangling suffix), but
 * this `static` C++ fn got C++-mangled to _bzero_w__FPii, a NAME MISMATCH invisible to the gate
 * ("NOT IN OBJECT" forever). `static`+`extern "C"` can't combine as adjacent storage-class
 * specifiers on this compiler -- wrap in an `extern "C" { }` block instead. */

static void _bzero_w(int *p, int n)   /* @0x80106924 */
{
    int i = n - 1;
    if (n != 0) {
        do { *p = 0; i = i - 1; p = p + 1; } while (i != -1);
    }
}
   /* extern "C" */

extern void *startIntrDMA(void)   /* @0x801066AC */
{
    _bzero_w(dma_cb, 8);
    DICR = 0;
    InterruptCallback(3, _dma_isr);
    return (void *)_dma_set_callback;
}

extern void _dma_isr(void)   /* @0x801066F8 */
{
    unsigned int pending;
    int i;

    while ((pending = (DICR >> 24) & 0x7f) != 0) {
        for (i = 0; pending != 0 && i < 7; ++i, pending >>= 1) {
            if (pending & 1) {
                DICR &= 0xffffff | (1 << (i + 24));
                if (dma_cb[i] != 0) {
                    ((void (*)())dma_cb[i])();
                }
            }
        }
    }

    if ((DICR & 0xff000000) == 0x80000000)
        goto dma_error;
    if ((DICR & 0x8000) == 0)
        return;

dma_error:
    printf("DMA bus error: code=%08x\n", DICR);
    for (i = 0; i < 7; i++)
        printf("MADR[%d]=%08x\n", i, g_madr_ptr[4 * i]);
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

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
/* @0x80106878 : the per-channel DMA-callback setter startIntrDMA hands back.  NOT `static`:
 * the oracle materialises its address as `lui %hi(func_80106878); addiu %lo(func_80106878)`,
 * i.e. the symbol has its OWN global entry (a file-static would take a .text SECTION-relative
 * reloc with a nonzero addend -- methodology 3.12 #12).  It also carries the project label
 * `func_80106878` (configs/symbol_addrs.txt + src/.../INTR_DMA.c's INCLUDE_ASM); naming it
 * anything else leaves the oracle symbol unpaired -- objdiff reported it 0% and verify_asm
 * `NOT IN OBJECT` while the body was in fact byte-exact under the local name
 * `_dma_set_callback` (W52-A9; same hidden-phantom class as the _bzero_w note above). */
int func_80106878(int ch, int func);

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
    /* MATCH (w48-a7, methodology 3.25-3c): the oracle puts this store in the
     * `jal InterruptCallback` DELAY SLOT.  gcc's reorg refuses to slot-fill a volatile MEM, so
     * the volatile qualifier alone cost the fill -- cast it away for this one store. */
    *(unsigned int *)g_dicr_ptr = 0;
    InterruptCallback(3, _dma_isr);
    return (void *)func_80106878;
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

/* W52-A9 receipts on the body (63 -> 46 diffs, ours 41 / oracle 43):
 *   - the ARMS are inverted vs the old recon: retail's `beqz $a0,.L801068E0` makes the
 *     func != 0 (install) arm the FALL-THROUGH, so the source tests `if (func != 0)`.
 *   - the `& 0x1f` on the shift COUNT was a Ghidra transcription artifact (sllv masks to 5
 *     bits in hardware); writing it emits a real `andi rX,rX,31` retail does not have
 *     (catalog SC "andi ...,31 before a variable shift -- delete it").
 *   Residual: retail COPIES both params (`addu a2,a0,zero` = ch, `addu a0,a1,zero` = func)
 *   and keeps `old` in $a3, staging `addu v0,a3,zero` in two branch delay slots; ours keeps
 *   ch/func in their incoming regs (hence 2 insns short).  Falsified levers: explicit local
 *   copies of both params, and an early `if (func == old) return old;` funnel -- both
 *   coalesce back to identical code (46 diffs each). */
int func_80106878(int ch, int func)   /* @0x80106878 (installed by startIntrDMA) */
{
    int *p = &dma_cb[ch];
    int old = *p;
    if (func != old) {
        if (func != 0) {
            *p = func;
            DICR = DICR & 0xffffff | 1 << (ch + 0x10) | 0x800000;
        } else {
            *p = 0;
            DICR = (DICR & 0xffffff | 0x800000) & ~(1 << (ch + 0x10));
        }
    }
    return old;
}

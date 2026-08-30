/* syslib/psx/libetc/INTR_DMA.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra; verified vs disasm).
 *   obj INTR_DMA.obj ; libetc.lib.  DMA-interrupt setup + dispatch: startIntrDMA @0x801066AC installs trapIntrDMA
 *   as the IRQ-3 (DMA) handler and returns the per-channel DMA-callback setter (setIntrDMA); trapIntrDMA
 *   @0x801066F8 services each pending channel (DICR @0x1F8010F4 bits 24-30) and reports DMA bus errors;
 *   setIntrDMA @0x80106878 registers/enables a channel callback.  dma_cb table @0x8013BD24.  The obj-local
 *   DMA_memclr (@0x80106924) is `static` (each PsyQ obj carries its own copy).
 *
 *   CANONICAL PSYQ NAME RECEIPT (2026-08-24): PsyQ 4.3's extracted INTR_DMA.obj is one 672-byte
 *   startIntrDMA text member, so its archive index exposes only that public name.  Independent SDK
 *   reconstructions preserve the original internal source order and names as startIntrDMA,
 *   trapIntrDMA, setIntrDMA, DMA_memclr; their bodies and offsets match this retail member exactly.
 *   NFS4's address-only linker labels are retained below with asm-name aliases, while the C identifiers
 *   now carry the canonical source spellings.
 *
 * w25-a2 SURVEY (-fno-delayed-branch splice project, methodology sec 3.25.3b): startIntrDMA
 *   (14 diffs) and trapIntrDMA (16-24 diffs) both carry PARTIAL signature fingerprints (jal-arg-setup
 *   split across the delay slot vs oracle computing the full arg BEFORE the jal; epilogue lw
 *   ra/addiu sp/jr ra reordering). Empirically whole-TU `-fno-delayed-branch` test (w25-a2,
 *   reverted, not committed): startIntrDMA 14->10 diffs (improves, does NOT reach PASS -- a
 *   residual `addiu v0,v0,0` return-value-materialization reorder survives); trapIntrDMA 16->25-33
 *   diffs (WORSE -- a second, unrelated lever entangles: ours materializes some addresses via an
 *   intermediate register then copies into the dest [e.g. lui s1,0; addiu a0,s1,0] where the
 *   oracle materializes directly into the dest [lui a0,0; addiu a0,a0,0], a rematerialize-into-
 *   dest / address-CSE class, NOT delay-slot filling -- see catalog "F additions"). NEITHER fn is
 *   a clean per-function splice candidate today: apply only after the address-CSE lever is solved
 *   separately, then re-test with a1's per-fn splice mechanism (whole-TU flag is not authoritative
 *   for the final per-fn residual, but is a valid proxy since gcc codegens per-function).
 */
typedef void (*Callback)(void);

extern void InterruptCallback(int idx, void (*h)(void));   /* INTR */
extern int  printf(const char *fmt, ...);              /* C63 */
extern void trapIntrDMA(void) __asm__("_dma_isr");
/* @0x80106878 : the per-channel DMA-callback setter startIntrDMA hands back.  NOT `static`:
 * the oracle materialises its address as `lui %hi(setIntrDMA); addiu %lo(setIntrDMA)`,
 * i.e. the symbol has its OWN global entry (a file-static would take a .text SECTION-relative
 * reloc with a nonzero addend -- methodology 3.12 #12).  It also carries the project label
 * `setIntrDMA` (configs/symbol_addrs.txt + src/.../INTR_DMA.c's INCLUDE_ASM); naming it
 * anything else leaves the oracle symbol unpaired -- objdiff reported it 0% and verify_asm
 * `NOT IN OBJECT` while the body was in fact byte-exact under a source-level name
 * (W52-A9; same hidden-phantom class as the DMA_memclr note above). */
Callback setIntrDMA(int ch, Callback func);  /* renamed from setIntrDMA (user order 2026-08-30) */

extern volatile unsigned int *g_dicr_ptr __asm__("D_8013BD20");   /* @0x8013BD20 : = 0x1F8010F4 */
/* W66-A3 (link): the 8-word run at 0x8013BD24 is emitted by the splat blob
 * (asm/data/data_8010CCD4_r18.data.s, dlabel D_8013BD24) -- alias the recon
 * spelling onto it rather than minting a second, unplaced object.  Name-only:
 * the reloc changes, the bytes do not (the two neighbours already do this). */
extern Callback dma_cb[8] __asm__("D_8013BD24");  /* @0x8013BD24 : per-channel DMA callbacks */
extern volatile unsigned int *g_madr_ptr __asm__("D_8013BD44");   /* @0x8013BD44 : = 0x1F801080 */

#define DICR (*g_dicr_ptr)

/* HIDDEN-PHANTOM FIX (w14-a2): oracle label is the bare "_bzero_w" (no __F mangling suffix), but
 * this `static` C++ fn got C++-mangled without an explicit asm name, a NAME MISMATCH invisible to the gate
 * ("NOT IN OBJECT" forever). `static`+`extern "C"` can't combine as adjacent storage-class
 * specifiers on this compiler.  The alias preserves that retail label while restoring PsyQ's
 * canonical source identifier. */

static void DMA_memclr(int *p, int n) __asm__("_bzero_w");
static void DMA_memclr(int *p, int n)   /* @0x80106924 */
{
    int i = n - 1;
    if (n != 0) {
        do { *p = 0; i = i - 1; p = p + 1; } while (i != -1);
    }
}
   /* extern "C" */

extern void *startIntrDMA(void)   /* @0x801066AC */
{
    DMA_memclr(dma_cb, 8);
    /* MATCH (w48-a7, methodology 3.25-3c): the oracle puts this store in the
     * `jal InterruptCallback` DELAY SLOT.  gcc's reorg refuses to slot-fill a volatile MEM, so
     * the volatile qualifier alone cost the fill -- cast it away for this one store. */
    *(unsigned int *)g_dicr_ptr = 0;
    InterruptCallback(3, trapIntrDMA);
    return (void *)setIntrDMA;
}

extern void trapIntrDMA(void)   /* @0x801066F8 */
{
    unsigned int pending;
    int i;

    while ((pending = (DICR >> 24) & 0x7f) != 0) {
        for (i = 0; pending != 0 && i < 7; ++i, pending >>= 1) {
            if (pending & 1) {
                DICR &= 0xffffff | (1 << (i + 24));
                if (dma_cb[i] != 0) {
                    dma_cb[i]();
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
 *   W53-A12: 46 -> 36 diffs via the INDEX FORM (methodology 3.12 #1, second effect).
 *   Dropping the hoisted `int *p = &dma_cb[ch]` cursor and writing `dma_cb[ch]` at each
 *   of the three sites flips which local joins the ABI arg web: retail's `func` copy
 *   (`addu $a2,$a1,$zero` in ours) appears, and the `sll`/base materialisation order
 *   matches.  Count is unchanged (41 vs 43) -- this is a coloring, not a size, win.
 *   Residual (36): the remaining half of the rotation.  Retail is {ch -> $a2, func -> $a0,
 *   old -> $a3}, ours is {ch -> $a0, func -> $a2, old -> $a3}: an exact ch<->func swap,
 *   plus retail's THREE `addu $v0,$a3,$zero` return-funnel copies (two of them in branch
 *   delay slots) against our one.
 *   FALSIFIED at this basin: an early `if (func == old) return old;` + per-arm `return old;`
 *   funnel (75 -- gcc cross-jumps the three returns straight back together), grouping the
 *   OR as `1 << (ch+0x10) | 0x800000` (36, neutral), a `ch + 0x10` shift temp (56, and one
 *   insn SHORTER), identity fences on ch and on func before and after the decls, a
 *   read-only fence on ch, and the pre-decl placements of all of those (46 each -- the
 *   fences are inert here because nothing in the fn prefers or conflicts on the contested
 *   regs).  NAMED NEXT ANGLE: ch must LOSE $a0 and func must LOSE $a1, which (per the
 *   GTDF2/FIXDFSI finding this wave) is a CONFLICT-SET question, not an allocno dial --
 *   the productive instrument is the -dg/-dl dump plus allocsim on the block-local qtys
 *   that own $a0/$a1 in the two arms, i.e. a 3-QTY-LAW dial on the DICR read-modify-write
 *   blocks rather than any further reshaping of the parameters.  Not a floor. */
/* W77-A6 + W78-A14 source facts PORTED onto the canonical file (user order
 * 2026-08-30): (a) per-arm DICR pointer read BEFORE the dma_cb store (func
 * stays live across it -> retail entry copy); (b) two-STATEMENT base mutate
 * `slot = dma_cb; slot += ch;` (only spelling emitting retail's la/sll/addu
 * base-mutate); (c) `bits` as its OWN statement (fold-const associate: leg
 * rewrites any single-expression form). Neutral on the 272 lane (8 @41/43);
 * coupled with the 2.8.0+no_split_addresses lane = 2 @43/43. Full receipts:
 * scratchpad/w77/A6_receipt.md + scratchpad/w78/A14_receipt.md. */
Callback setIntrDMA(int ch, Callback func)   /* @0x80106878 (installed by startIntrDMA) */
{
    Callback *slot;
    Callback old;

    /* (b) the two-STATEMENT base mutate -- NOT `&dma_cb[ch]`: it is the only
     * spelling that emits retail's `la $v1,SYM; sll $v0,$a2,2; addu $v1,$v0,$v1`
     * (base materialised first, the add mutating the base register).  Worth
     * 8 diffs; do NOT fold these two statements back into one expression. */
    slot = dma_cb;
    slot += ch;
    old = *slot;
    if (func != old) {
        if (func != 0) {
            /* (a) the DICR pointer is read BEFORE the dma_cb store, so `func`
             * stays live across it and lands in $a0 (retail's entry copy) --
             * do NOT move `*slot = func;` above this decl. */
            volatile unsigned int *p = g_dicr_ptr;
            unsigned int d, bits;
            *slot = func;
            d = *p & 0xffffff;
            /* `bits` must stay its OWN statement: fold-const's associate: leg
             * (split_tree, fold-const.c:4349) rewrites `A | (bit | K)` to
             * `(A|K) | bit` inside a single expression (w77-a6). */
            bits = (1 << (ch + 0x10)) | 0x800000;
            *p = d | bits;
        } else {
            volatile unsigned int *p = g_dicr_ptr;
            *slot = 0;
            *p = (*p & 0xffffff | 0x800000) & ~(1 << (ch + 0x10));
        }
    }
    return old;
}

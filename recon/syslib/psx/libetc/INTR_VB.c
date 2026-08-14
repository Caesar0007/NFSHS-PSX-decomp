/* syslib/psx/libetc/INTR_VB.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra; verified vs disasm, IDA unreliable
 *   for libetc).  obj INTR_VB.obj ; libetc.lib.  Vblank-interrupt setup: startIntrVSync @0x80106534 installs
 *   trapIntrVSync as the IRQ-0 (vblank) handler and returns the per-slot vsync-callback setter; trapIntrVSync
 *   @0x8010658C bumps Vcount and fans out to the 8 registered vblank callbacks.  The @0x801065F8 slot-setter
 *   is renamed _vsync_setcb (Ghidra named it "VSyncCallback" -- collides with the INTR.obj public API; it is
 *   only ever called via the pointer startIntrVSync returns).
 *
 * w25-a2 SURVEY (-fno-delayed-branch splice project, methodology sec 3.25.3b): startIntrVSync
 *   (8-11 diffs) carries the jal-arg-in-slot fingerprint (ours splits the arg-setup addiu into the
 *   jal's delay slot; oracle computes the arg fully before the jal, matching PsyQ syslib's
 *   `-fno-delayed-branch` identity). Empirically whole-TU flag test (w25-a2, reverted, not
 *   committed): 11->8 diffs -- IMPROVES but does not reach PASS; residual `addiu v0,v0,0`
 *   return-value reorder (same shape as startIntrDMA's residual in INTR_DMA.cpp) survives. NOT yet
 *   a clean per-function splice target -- revisit once that residual lever is understood, then
 *   re-test with a1's per-fn splice mechanism.
 */

/* w48-a7 PHANTOM FIX: the two helpers were reconstructed under DESCRIPTIVE names
 * (trapIntrVSync / _vsync_setcb) while the project's symbol map + every oracle .s call them
 * startIntrVSync_helper_1 / _2 -- so the gate reported NOT IN OBJECT for both, forever, and the
 * worklist rendered that as "0.00%".  Renamed to the oracle names (descriptive role kept in the
 * comments below).  A THIRD oracle symbol, startIntrVSync_helper_3, was missing entirely: it is
 * INTR_VB.obj's OWN copy of the word-clear helper (byte-identical to INTR.obj's and
 * INTR_DMA.obj's private _bzero_w), which startIntrVSync jal's -- the recon had been calling
 * INTR.obj's copy across the object boundary instead. */

/* owning-TU def (extern-declared, never defined; BSS) */
 int vsync_cb[8];
extern void  InterruptCallback(int idx, void (*h)());     /* INTR */
extern void  startIntrVSync_helper_1(void);               /* the vblank trap handler */
extern int   startIntrVSync_helper_2(int idx, int cb);    /* the per-slot callback setter */
extern void  startIntrVSync_helper_3(int *p, int nwords); /* this obj's private word-clear */

/* MATCH: both fns that touch Vcount reach it via lui/%hi+%lo ABSOLUTE addressing in the oracle
 * (never %gp_rel), so it must stay a bare `extern` decl here (no local definition/initializer) --
 * an owned tentative-def would flip it gp-relative under -G4 (lever #6), which the oracle does NOT
 * want. True storage lives elsewhere in the image; kept `extern` pending that data-mat pass. */
extern int Vcount;            /* @0x80137D10 */
extern int vsync_cb[8];       /* @0x80137CF0 : 8 vblank callbacks */
extern volatile unsigned int *g_rcnt_ptr;   /* @0x80137D14 : = 0x1F801114 (RCnt vblank-timing mode reg) */

extern void *startIntrVSync(int priority)   /* @0x80106534 */
{
    /* MATCH: oracle reaches the RCnt reg through the g_rcnt_ptr indirection (lui;lw the pointer
     * VALUE @0x80137D14), NOT a materialized literal MMIO constant. */
    *g_rcnt_ptr = 0x100;
    Vcount = 0;
    startIntrVSync_helper_3(vsync_cb, 8);
    InterruptCallback(0, startIntrVSync_helper_1);
    return (void *)startIntrVSync_helper_2;
}

/* @0x8010658C -- the vblank TRAP handler: bump Vcount, fan out to the 8 registered callbacks. */
extern void startIntrVSync_helper_1(void)   /* @0x8010658C */
{
    int i = 0;
    void (**cb)();
    Vcount = Vcount + 1;
    cb = (void (**)())vsync_cb;
    /* residual: ours colors {Vcount->v0,vsync_cb-hi->v1} vs oracle {v0,v1} swapped -- pure
     * commutative-temp coloring tie, immune to decl-order/statement-order (tried both); insn
     * count exact 27==27. Same class as the catalog's "commutative-operand register-slot
     * selection" STRONG floor. */
    do {
        if (*cb) (*cb)();
        i = i + 1;
        cb = cb + 1;
    } while (i < 8);
}

/* @0x801065F8 -- the per-slot vblank-callback SETTER; the pointer startIntrVSync returns.
 * (Ghidra named it "VSyncCallback", which collides with the INTR.obj public API.) */
extern int startIntrVSync_helper_2(int idx, int cb)   /* @0x801065F8 */
{
    int old = vsync_cb[idx];
    if (cb != old) vsync_cb[idx] = cb;
    return old;
}

/* @0x80106624 -- INTR_VB.obj's private word-clear (the same routine INTR.obj/INTR_DMA.obj each
 * carry as their own `_bzero_w`); only ever reached by the jal in startIntrVSync below. */
extern void startIntrVSync_helper_3(int *p, int n)   /* @0x80106624 */
{
    int i = n - 1;
    if (n != 0) { do { *p = 0; i = i - 1; p = p + 1; } while (i != -1); }
}

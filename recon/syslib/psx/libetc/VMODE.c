/* syslib/psx/libetc/VMODE.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3; IDA mis-decompiled BOTH fns via
 *   its "write to const memory" const-folding bug -> disasm is authoritative).
 *   obj VMODE.obj ; libetc.lib.  SetVideoMode @0x800F1770 (returns the PREVIOUS mode, stores new in the
 *   jr delay slot), GetVideoMode @0x800F1784 (returns current).  Backed by g_videomode @0x80134838.
 *
 *   g_videomode sits at offset 0 of a 36-byte BSS block (D_80134838, 9 words). The block exceeds the
 *   -G4 small-data threshold (>4 bytes total) so the oracle uses absolute lui/lw, not gp-relative.
 *   MATCH: declare as int[9] to force absolute addressing; g_videomode[0] is the actual videomode field.
 */
extern int g_videomode[9];     /* BSS block @0x80134838 -- 9 words, forces out of sdata */

extern int SetVideoMode(int mode)   /* @0x800F1770 */
{
    int old = g_videomode[0];
    g_videomode[0] = mode;
    /* residual: oracle materializes &g_videomode TWICE independently (dest-as-scratch v0 for
     * the load, separate $at for the store) where we CSE one base (v1) for both -- tried
     * volatile (regressed: blocks the sw-in-delay-slot fold too) and a byte-cast store (no
     * effect, backend CSEs past the syntax). Accept as floor.
     * w25-a2 SURVEY (-fno-delayed-branch splice project): re-confirmed UNRELATED to the
     * methodology sec 3.25.3b delayed-branch identity -- no epilogue/jal-arg-slot lines in the
     * diff at all (no branches/calls in this leaf fn), and whole-TU `-fno-delayed-branch` test
     * (reverted) made it WORSE (7->8 diffs), not better. Not a splice candidate. */
    return old;
}

extern int GetVideoMode(void)   /* @0x800F1784 */
{
    return g_videomode[0];
}

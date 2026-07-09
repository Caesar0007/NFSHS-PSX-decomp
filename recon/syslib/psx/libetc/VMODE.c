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
    return old;
}

extern int GetVideoMode(void)   /* @0x800F1784 */
{
    return g_videomode[0];
}

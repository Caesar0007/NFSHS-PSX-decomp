/* syslib/psx/libetc/VMODE.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3; IDA mis-decompiled BOTH fns via
 *   its "write to const memory" const-folding bug -> disasm is authoritative).
 *   obj VMODE.obj ; libetc.lib.  SetVideoMode @0x800F1770 (returns the PREVIOUS mode, stores new in the
 *   jr delay slot), GetVideoMode @0x800F1784 (returns current).  Backed by g_videomode @0x80134838.
 *
 *   g_videomode sits at offset 0 of a 36-byte BSS block (D_80134838, 9 words). The block exceeds the
 *   -G4 small-data threshold (>4 bytes total) so the oracle uses absolute lui/lw, not gp-relative.
 *   MATCH: declare as int[9] to force absolute addressing; g_videomode is the actual videomode field.
 */
extern int g_videomode;        /* @0x80134838 (offset 0 of a 9-word BSS block) */

extern int SetVideoMode(int mode)   /* @0x800F1770 */
{
    int old = g_videomode;
    g_videomode = mode;
    /* MATCH (w51-a7): the oracle materializes &g_videomode TWICE INDEPENDENTLY -- dest-as-scratch
     * `lui $v0` for the load, `$at` for the store -- which is exactly what gas emits for the two
     * plain symbol MACROS `lw $v0,sym` / `sw $a0,sym`.  The old `int g_videomode[9]` shape (added
     * to force absolute addressing at -G4) let gcc CSE ONE `la $v1,sym` base for both accesses;
     * declaring the SCALAR restores the macro form.  Safe because this TU is in the gcc-2.7.2
     * lane, which compiles at -G0 -- there is no small-data/gp-rel risk to guard against.
     * (The prior "accept as floor" verdict was measured only in the 2.8/-G4 basin.) */
    return old;
}

extern int GetVideoMode(void)   /* @0x800F1784 */
{
    return g_videomode;
}

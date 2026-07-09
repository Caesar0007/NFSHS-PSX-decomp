/* syslib/psx/libgte/REG11.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(REG11.OBJ): SetFarColor -- load the GTE far-colour (fog colour) into
 *   control registers 21/22/23 (RFC/GFC/BFC), each pre-shifted left by 4 (4.12 fixed point). */

/* @0x800F27BC : far colour -> GTE control regs 21 (RFC), 22 (GFC), 23 (BFC). */
extern void SetFarColor(int r, int g, int b)
{
    r <<= 4;
    g <<= 4;
    b <<= 4;
#if defined(__mips__)
    __asm__ volatile("ctc2 %0,$21" : : "r"(r));
    __asm__ volatile("ctc2 %0,$22" : : "r"(g));
    __asm__ volatile("ctc2 %0,$23" : : "r"(b));
#else
    (void)r; (void)g; (void)b;
#endif
}

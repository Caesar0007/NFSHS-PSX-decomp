/* syslib/psx/libgte/REG13.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(REG13.OBJ): SetGeomScreen -- set the GTE projection-plane distance H
 *   (control register 26), i.e. the perspective "screen" distance for RTPS/RTPT. */

/* @0x800EAB9C : H = GTE control register 26 (projection distance). */
extern "C" void SetGeomScreen(int h)
{
#if defined(__mips__)
    __asm__ volatile("ctc2 %0,$26" : : "r"(h));
#else
    (void)h;
#endif
}

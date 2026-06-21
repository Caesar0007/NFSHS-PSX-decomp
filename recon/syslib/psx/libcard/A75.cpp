/* syslib/psx/libcard/A75.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(A75.OBJ): StartCARD2 -- BIOS B0:0x4B (StartCard) tail-call thunk. */

/* @0x8010CBA0 : StartCARD2 -- BIOS B0:0x4B thunk. */
extern "C" void StartCARD2(void)
{
#if defined(__mips__)
    __asm__ volatile("li $10,0xB0\n\t jr $10\n\t li $9,0x4B\n\t");
#endif
}

/* syslib/psx/libapi/A12.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A12.obj ; libapi.lib.  EnableEvent -- PSX kernel API trampoline (BIOS 0xB0:0xC).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) long EnableEvent(long event)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xB0
	 jr $10
	 li $9,0xC
	 .set reorder"); }
#else
extern "C" long EnableEvent(long event)
{
    return 0;
}
#endif

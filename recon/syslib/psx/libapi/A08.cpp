/* syslib/psx/libapi/A08.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A08.obj ; libapi.lib.  OpenEvent -- PSX kernel API trampoline (BIOS 0xB0:0x8).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) long OpenEvent(unsigned long cls, long spec, long mode, long (*func)())
{ __asm__ __volatile__(".set noreorder
	 li $10,0xB0
	 jr $10
	 li $9,0x8
	 .set reorder"); }
#else
extern "C" long OpenEvent(unsigned long cls, long spec, long mode, long (*func)())
{
    return 0;
}
#endif

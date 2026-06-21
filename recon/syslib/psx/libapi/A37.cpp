/* syslib/psx/libapi/A37.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A37.obj ; libapi.lib.  ExitCriticalSection -- PSX kernel API trampoline (SYSCALL a0=0x2).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) void ExitCriticalSection(void)
{ __asm__ __volatile__(".set noreorder
	 li $4,0x2
	 syscall 0
	 jr $31
	 nop
	 .set reorder"); }
#else
extern "C" void ExitCriticalSection(void)
{
}
#endif

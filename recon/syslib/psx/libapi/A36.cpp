/* syslib/psx/libapi/A36.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A36.obj ; libapi.lib.  EnterCriticalSection -- PSX kernel API trampoline (SYSCALL a0=0x1).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) int EnterCriticalSection(void)
{ __asm__ __volatile__(".set noreorder
	 li $4,0x1
	 syscall 0
	 jr $31
	 nop
	 .set reorder"); }
#else
extern "C" int EnterCriticalSection(void)
{
    return 0;
}
#endif

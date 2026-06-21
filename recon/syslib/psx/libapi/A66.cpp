/* syslib/psx/libapi/A66.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A66.obj ; libapi.lib.  firstfile2 -- PSX kernel API trampoline (BIOS 0xB0:0x42).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) void *firstfile2(const char *name, void *dir)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xB0
	 jr $10
	 li $9,0x42
	 .set reorder"); }
#else
extern "C" void *firstfile2(const char *name, void *dir)
{
}
#endif

/* syslib/psx/libapi/A24.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A24.obj ; libapi.lib.  ResetEntryInt -- PSX kernel API trampoline (BIOS 0xB0:0x18).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) void ResetEntryInt(void)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xB0
	 jr $10
	 li $9,0x18
	 .set reorder"); }
#else
extern "C" void ResetEntryInt(void)
{
}
#endif

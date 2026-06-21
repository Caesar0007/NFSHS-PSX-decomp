/* syslib/psx/libapi/A25.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A25.obj ; libapi.lib.  HookEntryInt -- PSX kernel API trampoline (BIOS 0xB0:0x19).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) void HookEntryInt(void *h)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xB0
	 jr $10
	 li $9,0x19
	 .set reorder"); }
#else
extern "C" void HookEntryInt(void *h)
{
}
#endif

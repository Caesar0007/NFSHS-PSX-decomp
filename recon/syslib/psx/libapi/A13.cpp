/* syslib/psx/libapi/A13.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A13.obj ; libapi.lib.  DisableEvent -- PSX kernel API trampoline (BIOS 0xB0:0xD).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) long DisableEvent(long event)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xB0
	 jr $10
	 li $9,0xD
	 .set reorder"); }
#else
extern "C" long DisableEvent(long event)
{
    return 0;
}
#endif

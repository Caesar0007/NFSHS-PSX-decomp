/* syslib/psx/libapi/A07.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A07.obj ; libapi.lib.  DeliverEvent -- PSX kernel API trampoline (BIOS 0xB0:0x7).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) void DeliverEvent(unsigned long ev, long spec)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xB0
	 jr $10
	 li $9,0x7
	 .set reorder"); }
#else
extern "C" void DeliverEvent(unsigned long ev, long spec)
{
}
#endif

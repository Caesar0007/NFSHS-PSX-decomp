/* syslib/psx/libapi/C68.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C68.obj ; libapi.lib.  FlushCache -- PSX kernel API trampoline (BIOS 0xA0:0x44).  MIPS-target
 *   asm (jumps to BIOS); x86 fallback stub (real impl in PSX BIOS / OpenBIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) void FlushCache(void)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xA0
	 jr $10
	 li $9,0x44
	 .set reorder"); }
#else
extern "C" void FlushCache(void)
{
}
#endif

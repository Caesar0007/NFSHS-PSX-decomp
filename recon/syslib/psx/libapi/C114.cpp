/* syslib/psx/libapi/C114.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C114.obj ; libapi.lib.  _96_remove -- PSX kernel API trampoline (BIOS 0xA0:0x72).  MIPS-target
 *   asm (jumps to BIOS); x86 fallback stub (real impl in PSX BIOS / OpenBIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) void _96_remove(void)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xA0
	 jr $10
	 li $9,0x72
	 .set reorder"); }
#else
extern "C" void _96_remove(void)
{
}
#endif

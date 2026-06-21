/* syslib/psx/libapi/C73.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C73.obj ; libapi.lib.  GPU_cw -- PSX kernel API trampoline (BIOS 0xA0:0x49).  MIPS-target
 *   asm (jumps to BIOS); x86 fallback stub (real impl in PSX BIOS / OpenBIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) void GPU_cw(unsigned long cw)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xA0
	 jr $10
	 li $9,0x49
	 .set reorder"); }
#else
extern "C" void GPU_cw(unsigned long cw)
{
}
#endif

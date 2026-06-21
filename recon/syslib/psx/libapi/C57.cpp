/* syslib/psx/libapi/C57.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C57.obj ; libapi.lib.  InitHeap -- PSX kernel API trampoline (BIOS 0xA0:0x39).  MIPS-target
 *   asm (jumps to BIOS); x86 fallback stub (real impl in PSX BIOS / OpenBIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) void InitHeap(unsigned long *head, unsigned long size)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xA0
	 jr $10
	 li $9,0x39
	 .set reorder"); }
#else
extern "C" void InitHeap(unsigned long *head, unsigned long size)
{
}
#endif

/* syslib/psx/libapi/L03.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj L03.obj ; libapi.lib.  SysDeqIntRP -- PSX kernel API trampoline (BIOS 0xC0:0x3).  MIPS-target
 *   asm (jumps to BIOS); x86 fallback stub (real impl in PSX BIOS / OpenBIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) void *SysDeqIntRP(int pri, long *rp)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xC0
	 jr $10
	 li $9,0x3
	 .set reorder"); }
#else
extern "C" void *SysDeqIntRP(int pri, long *rp)
{
    return 0;
}
#endif

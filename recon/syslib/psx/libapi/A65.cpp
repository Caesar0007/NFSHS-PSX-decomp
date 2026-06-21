/* syslib/psx/libapi/A65.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A65.obj ; libapi.lib.  format -- PSX kernel API trampoline (BIOS 0xB0:0x41).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) int format(const char *dev)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xB0
	 jr $10
	 li $9,0x41
	 .set reorder"); }
#else
extern "C" int format(const char *dev)
{
    return 0;
}
#endif

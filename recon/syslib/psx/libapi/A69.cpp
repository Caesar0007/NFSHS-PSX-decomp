/* syslib/psx/libapi/A69.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A69.obj ; libapi.lib.  erase -- PSX kernel API trampoline (BIOS 0xB0:0x45).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) int erase(const char *name)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xB0
	 jr $10
	 li $9,0x45
	 .set reorder"); }
#else
extern "C" int erase(const char *name)
{
    return 0;
}
#endif

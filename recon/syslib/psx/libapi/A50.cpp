/* syslib/psx/libapi/A50.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A50.obj ; libapi.lib.  open -- PSX kernel API trampoline (BIOS 0xB0:0x32).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) int open(const char *name, int mode)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xB0
	 jr $10
	 li $9,0x32
	 .set reorder"); }
#else
extern "C" int open(const char *name, int mode)
{
    return 0;
}
#endif

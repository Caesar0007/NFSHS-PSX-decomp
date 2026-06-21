/* syslib/psx/libapi/A51.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A51.obj ; libapi.lib.  lseek -- PSX kernel API trampoline (BIOS 0xB0:0x33).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) int lseek(int fd, int offset, int whence)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xB0
	 jr $10
	 li $9,0x33
	 .set reorder"); }
#else
extern "C" int lseek(int fd, int offset, int whence)
{
    return 0;
}
#endif

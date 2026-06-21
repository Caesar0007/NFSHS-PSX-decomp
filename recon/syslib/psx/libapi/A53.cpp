/* syslib/psx/libapi/A53.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A53.obj ; libapi.lib.  write -- PSX kernel API trampoline (BIOS 0xB0:0x35).  Faithful MIPS-target asm
 *   (jumps to the BIOS / issues the syscall); x86 fallback is a stub (real impl lives in the PSX BIOS).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) int write(int fd, void *buf, int n)
{ __asm__ __volatile__(".set noreorder
	 li $10,0xB0
	 jr $10
	 li $9,0x35
	 .set reorder"); }
#else
extern "C" int write(int fd, void *buf, int n)
{
    return 0;
}
#endif

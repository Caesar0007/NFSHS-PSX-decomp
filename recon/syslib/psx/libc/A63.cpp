/* syslib/psx/libc/A63.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A63.obj ; libc.lib.  puts @0x800E80CC -- BIOS trampoline (B0:0x3F -> std_out_puts).  Faithful
 *   MIPS-target asm; x86 fallback is a stub (real impl is the PSX BIOS TTY).
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) void puts(const char *s)
{ __asm__ __volatile__(".set noreorder\n\t li $10,0xB0\n\t jr $10\n\t li $9,0x3F\n\t .set reorder"); }
#else
extern "C" void puts(const char *s) { (void)s; }
#endif

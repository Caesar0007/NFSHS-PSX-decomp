/* syslib/psx/libc/C63.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C63.obj ; libc.lib.  printf @0x801028AC -- BIOS trampoline (A0:0x3F -> printf).  Variadic; the
 *   trampoline passes $4..$7 + stack args straight to the BIOS.  MIPS-target asm; x86 fallback stub.
 */
#if defined(__mips__)
extern "C" __attribute__((naked)) int printf(const char *fmt, ...)
{ __asm__ __volatile__(".set noreorder\n\t li $10,0xA0\n\t jr $10\n\t li $9,0x3F\n\t .set reorder"); }
#else
extern "C" int printf(const char *fmt, ...) { (void)fmt; return 0; }
#endif

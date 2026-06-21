/* syslib/psx/libc/C19.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C19.obj ; libc.lib.  setjmp @0x8010668C -- BIOS trampoline (A0:0x13 -> SaveState).  Saves the
 *   caller context into `env`.  MIPS-target asm; x86 fallback stub (returns 0 = "first return").
 */
#if defined(__mips__)
extern "C" __attribute__((naked, returns_twice)) int setjmp(long *env)
{ __asm__ __volatile__(".set noreorder\n\t li $10,0xA0\n\t jr $10\n\t li $9,0x13\n\t .set reorder"); }
#else
extern "C" int setjmp(long *env) { (void)env; return 0; }
#endif

/* syslib/psx/libsn/FSINIT.cpp -- RECONSTRUCTED (disasm-v3). obj FSINIT.obj ; libsn.lib.
 * PCinit @0x80106CC4 -- SN devkit host FS init via `break 0x101`.  MIPS-target asm; x86 fallback stub. */
#if defined(__mips__)
extern "C" __attribute__((naked)) int PCinit(void)
{ __asm__ __volatile__(".set noreorder\n\t break 0x101\n\t jr $31\n\t nop\n\t .set reorder"); }
#else
extern "C" int PCinit(void) { return 0; }   /* SN-devkit only */
#endif

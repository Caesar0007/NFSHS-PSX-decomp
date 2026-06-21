/* syslib/psx/libsn/CLOSE.cpp -- RECONSTRUCTED (disasm-v3). obj CLOSE.obj ; libsn.lib.
 * PCclose @0x80106D40 -- host close via `break 0x104` (a1=fd). */
#if defined(__mips__)
extern "C" __attribute__((naked)) int PCclose(int fd)
{ __asm__ __volatile__(".set noreorder\n\t move $5,$4\n\t break 0x104\n\t jr $31\n\t nop\n\t .set reorder"); }
#else
extern "C" int PCclose(int fd) { (void)fd; return 0; }
#endif

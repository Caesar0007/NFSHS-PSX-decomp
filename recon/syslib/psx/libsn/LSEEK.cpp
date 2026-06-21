/* syslib/psx/libsn/LSEEK.cpp -- RECONSTRUCTED (disasm-v3). obj LSEEK.obj ; libsn.lib.
 * PClseek @0x80106D1C -- host lseek via `break 0x107`; returns offset (v1) on success, -1 on error. */
#if defined(__mips__)
extern "C" __attribute__((naked)) int PClseek(int fd, int offset, int mode)
{ __asm__ __volatile__(".set noreorder\n\t move $7,$6\n\t move $6,$5\n\t move $5,$4\n\t break 0x107\n\t"
                       "beqz $2,1f\n\t move $2,$3\n\t li $2,-1\n\t 1: jr $31\n\t nop\n\t .set reorder"); }
#else
extern "C" int PClseek(int fd, int offset, int mode) { (void)fd;(void)offset;(void)mode; return -1; }
#endif

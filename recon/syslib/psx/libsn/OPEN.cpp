/* syslib/psx/libsn/OPEN.cpp -- RECONSTRUCTED (disasm-v3). obj OPEN.obj ; libsn.lib.
 * PCopen @0x80106CA4 -- host open via `break 0x103`; returns handle (v1) on success, -1 on error. */
#if defined(__mips__)
extern "C" __attribute__((naked)) int PCopen(const char *name, int mode)
{ __asm__ __volatile__(".set noreorder\n\t move $6,$5\n\t move $5,$4\n\t break 0x103\n\t"
                       "beqz $2,1f\n\t move $2,$3\n\t li $2,-1\n\t 1: jr $31\n\t nop\n\t .set reorder"); }
#else
extern "C" int PCopen(const char *name, int mode) { (void)name; (void)mode; return -1; }
#endif

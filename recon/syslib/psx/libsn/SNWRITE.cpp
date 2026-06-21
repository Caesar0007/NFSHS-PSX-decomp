/* syslib/psx/libsn/SNWRITE.cpp -- RECONSTRUCTED (disasm-v3). obj SNWRITE.obj ; libsn.lib.
 * _SN_write @0x8010C720 -- low-level host write via `break 0x106` (args in $4..$7 from PCwrite). */
#if defined(__mips__)
extern "C" __attribute__((naked)) int _SN_write(int chan, int fd, int len, int buff)
{ __asm__ __volatile__(".set noreorder\n\t break 0x106\n\t jr $31\n\t nop\n\t .set reorder"); }
#else
extern "C" int _SN_write(int chan, int fd, int len, int buff) { (void)chan;(void)fd;(void)len;(void)buff; return -1; }
#endif

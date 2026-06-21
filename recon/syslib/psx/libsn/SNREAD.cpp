/* syslib/psx/libsn/SNREAD.cpp -- RECONSTRUCTED (disasm-v3). obj SNREAD.obj ; libsn.lib.
 * _SN_read @0x8010C708 -- low-level host read via `break 0x105` (= break 0,261).  Args already in
 * $4..$7 from PCread; returns handle/count (v1) on success, -1 on error (same break-then-test shape
 * as PCopen).  FILE-SCOPE __asm__ so NO C epilogue is appended (oracle's own `jr ra; nop`). */
#if defined(__mips__)
__asm__("\t.set push\n\t.set noreorder\n"
        "\t.globl _SN_read\n_SN_read:\n"
        "\tbreak 0x105\n"
        "\tbeqz  $v0, 1f\n"
        "\t addu $v0, $v1, $zero\n"
        "\taddiu $v0, $zero, -1\n"
        "1:\tjr   $ra\n"
        "\t nop\n"
        "\t.set pop\n");
#else
extern "C" int _SN_read(int chan, int fd, int len, int buff) { (void)chan;(void)fd;(void)len;(void)buff; return -1; }
#endif

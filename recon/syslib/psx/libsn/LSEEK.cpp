/* syslib/psx/libsn/LSEEK.cpp -- RECONSTRUCTED (disasm-v3). obj LSEEK.obj ; libsn.lib.
 * PClseek @0x80106D1C -- host lseek via `break 0x107` (= break 0,263); returns offset (v1) on
 * success, -1 on error.  FILE-SCOPE __asm__ so NO C epilogue is appended (oracle's `jr ra;nop`). */
#if defined(__mips__)
__asm__("\t.set push\n\t.set noreorder\n"
        "\t.globl PClseek\nPClseek:\n"
        "\taddu  $a3, $a2, $zero\n"
        "\taddu  $a2, $a1, $zero\n"
        "\taddu  $a1, $a0, $zero\n"
        "\tbreak 0x107\n"
        "\tbeqz  $v0, 1f\n"
        "\t addu $v0, $v1, $zero\n"
        "\taddiu $v0, $zero, -1\n"
        "1:\tjr   $ra\n"
        "\t nop\n"
        "\t.set pop\n");
#else
extern "C" int PClseek(int fd, int offset, int mode) { (void)fd;(void)offset;(void)mode; return -1; }
#endif

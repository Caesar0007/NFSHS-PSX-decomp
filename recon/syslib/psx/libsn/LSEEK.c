/* syslib/psx/libsn/LSEEK.c -- RECONSTRUCTED (disasm-v3). obj LSEEK.obj ; libsn.lib.
 * PClseek @0x80106D1C -- host lseek via `break 0x107` (= break 0,263); returns offset (v1) on
 * success, -1 on error.  FILE-SCOPE __asm__ so NO C epilogue is appended (oracle's `jr ra;nop`). */
#if defined(__mips__)
__asm__("\t.set noreorder\n"
        "\t.globl PClseek\nPClseek:\n"
        "\taddu  $7, $6, $0\n"
        "\taddu  $6, $5, $0\n"
        "\taddu  $5, $4, $0\n"
        "\tbreak 0x107\n"
        "\tbeqz  $2, 1f\n"
        "\t addu $2, $3, $0\n"
        "\taddiu $2, $0, -1\n"
        "1:\tjr   $31\n"
        "\t nop\n"
        "\t.set reorder\n\t.set at\n");
#else
extern int PClseek(int fd, int offset, int mode) { (void)fd;(void)offset;(void)mode; return -1; }
#endif

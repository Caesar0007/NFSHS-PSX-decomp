/* syslib/psx/libsn/CREAT.c -- RECONSTRUCTED (disasm-v3). obj CREAT.obj ; libsn.lib.
 * PCcreat @0x80106CD0 -- host creat via `break 0x102` (= break 0,258); a1=name, a2=0; handle (v1)
 * on success else -1.  FILE-SCOPE __asm__ so NO C epilogue is appended (oracle's `jr ra;nop`). */
#if defined(__mips__)
__asm__("\t.set noreorder\n"
        "\t.globl PCcreat\nPCcreat:\n"
        "\taddu  $5, $4, $0\n"
        "\taddu  $6, $0, $0\n"
        "\tbreak 0x102\n"
        "\tbeqz  $2, 1f\n"
        "\t addu $2, $3, $0\n"
        "\taddiu $2, $0, -1\n"
        "1:\tjr   $31\n"
        "\t nop\n"
        "\t.set reorder\n\t.set at\n");
#else
extern int PCcreat(const char *name, int mode) { (void)name; (void)mode; return -1; }
#endif

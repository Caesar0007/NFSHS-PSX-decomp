/* syslib/psx/libsn/CREAT.c -- RECONSTRUCTED (disasm-v3). obj CREAT.obj ; libsn.lib.
 * PCcreat @0x80106CD0 -- host creat via `break 0x102` (= break 0,258); a1=name, a2=0; handle (v1)
 * on success else -1.  FILE-SCOPE __asm__ so NO C epilogue is appended (oracle's `jr ra;nop`). */
#if defined(__mips__)
__asm__("\t.set push\n\t.set noreorder\n"
        "\t.globl PCcreat\nPCcreat:\n"
        "\taddu  $a1, $a0, $zero\n"
        "\taddu  $a2, $zero, $zero\n"
        "\tbreak 0x102\n"
        "\tbeqz  $v0, 1f\n"
        "\t addu $v0, $v1, $zero\n"
        "\taddiu $v0, $zero, -1\n"
        "1:\tjr   $ra\n"
        "\t nop\n"
        "\t.set pop\n");
#else
extern int PCcreat(const char *name, int mode) { (void)name; (void)mode; return -1; }
#endif

/* syslib/psx/libsn/OPEN.cpp -- RECONSTRUCTED (disasm-v3). obj OPEN.obj ; libsn.lib.
 * PCopen @0x80106CA4 -- host open via `break 0x103` (= break 0,259); returns handle (v1) on
 * success, -1 on error.  FILE-SCOPE __asm__ (BIOS_THUNK style) so NO C-function epilogue is
 * appended -- the oracle's own `jr ra; nop` is the function's return. */
#if defined(__mips__)
__asm__("\t.set push\n\t.set noreorder\n"
        "\t.globl PCopen\nPCopen:\n"
        "\taddu  $a2, $a1, $zero\n"
        "\taddu  $a1, $a0, $zero\n"
        "\tbreak 0x103\n"
        "\tbeqz  $v0, 1f\n"
        "\t addu $v0, $v1, $zero\n"
        "\taddiu $v0, $zero, -1\n"
        "1:\tjr   $ra\n"
        "\t nop\n"
        "\t.set pop\n");
#else
extern "C" int PCopen(const char *name, int mode) { (void)name; (void)mode; return -1; }
#endif

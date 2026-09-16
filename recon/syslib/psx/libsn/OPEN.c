/* syslib/psx/libsn/OPEN.c -- RECONSTRUCTED (disasm-v3). obj OPEN.obj ; libsn.lib.
 * PCopen @0x80106CA4 -- host open via `break 0x103` (= break 0,259); returns handle (v1) on
 * success, -1 on error.  FILE-SCOPE __asm__ (BIOS_THUNK style) so NO C-function epilogue is
 * appended -- the oracle's own `jr ra; nop` is the function's return. */
#if defined(__mips__)
__asm__("\t.set noreorder\n"
        "\t.globl PCopen\nPCopen:\n"
        "\taddu  $6, $5, $0\n"
        "\taddu  $5, $4, $0\n"
        "\tbreak 0x103\n"
        "\tbeqz  $2, 1f\n"
        "\t addu $2, $3, $0\n"
        "\taddiu $2, $0, -1\n"
        "1:\tjr   $31\n"
        "\t nop\n"
        "\t.set reorder\n\t.set at\n");
#else
extern int PCopen(const char *name, int mode) { (void)name; (void)mode; return -1; }
#endif

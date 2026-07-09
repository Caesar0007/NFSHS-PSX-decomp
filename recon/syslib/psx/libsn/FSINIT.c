/* syslib/psx/libsn/FSINIT.c -- RECONSTRUCTED (disasm-v3). obj FSINIT.obj ; libsn.lib.
 * PCinit @0x80106CC4 -- SN devkit host FS init via `break 0x101` (= break 0,257).
 * FILE-SCOPE __asm__ (BIOS_THUNK / SOTN psxsdk style) so NO C-function epilogue (`jr ra;nop;nop`)
 * is appended -- the oracle's own `jr ra; nop` is the function's return.  x86 fallback stub below. */
#if defined(__mips__)
__asm__("\t.set push\n\t.set noreorder\n"
        "\t.globl PCinit\nPCinit:\n"
        "\tbreak 0x101\n"
        "\tjr    $ra\n"
        "\t nop\n"
        "\t.set pop\n");
#else
extern int PCinit(void) { return 0; }   /* SN-devkit only */
#endif

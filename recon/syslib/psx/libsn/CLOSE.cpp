/* syslib/psx/libsn/CLOSE.cpp -- RECONSTRUCTED (disasm-v3). obj CLOSE.obj ; libsn.lib.
 * PCclose @0x80106D40 -- host close via `break 0x104` (= break 0,260); a1=fd.
 * FILE-SCOPE __asm__ so NO C epilogue is appended (oracle's own `jr ra; nop`). */
#if defined(__mips__)
__asm__("\t.set push\n\t.set noreorder\n"
        "\t.globl PCclose\nPCclose:\n"
        "\taddu  $a1, $a0, $zero\n"
        "\tbreak 0x104\n"
        "\tjr    $ra\n"
        "\t nop\n"
        "\t.set pop\n");
#else
extern "C" int PCclose(int fd) { (void)fd; return 0; }
#endif

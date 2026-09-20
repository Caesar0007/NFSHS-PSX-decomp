/* bios_thunk.h -- BIOS A0/B0/C0 syscall stub macro (RULE 7: only true BIOS calls
 * stay thunks). A PSX BIOS syscall stub is genuinely assembly -- there is no C
 * source for it. The original library (PsyQ libapi/libcard/...) ships each as a raw
 * tail-call: `addiu $t2,$zero,<section>; jr $t2; addiu $t1,$zero,<id>; nop` (the BIOS
 * dispatcher at <section> reads $t1 to pick the function). Emit it as a FILE-SCOPE
 * __asm__ (SOTN psxsdk style) so NO C-function epilogue (`jr ra`) is appended.
 * Proven byte-exact in this build (cc1plus 2.7.2 + maspsx): StartCARD2 = 4 insns PASS.
 *
 *   Usage (one line per stub):  BIOS_THUNK(StartCARD2, 0xB0, 0x4B);
 */
#ifndef _BIOS_THUNK_H_
#define _BIOS_THUNK_H_

#if defined(__mips__)
#define BIOS_THUNK(name, section, id)                                          \
    __asm__("\t.set noreorder\n"                                  \
            "\t.globl " #name "\n" #name ":\n"                                 \
            "\taddiu $10, $0, " #section "\n"                               \
            "\tjr    $10\n"                                                     \
            "\t addiu $9, $0, " #id "\n"                                    \
            "\t.set reorder\n\t.set at\n")
/* NB: the stub is 3 words (`addiu; jr; addiu[delay]`); splat sizes it 0xC and puts the
 * trailing alignment `nop` AFTER `endlabel` (inter-function padding, not the function). */
/* A BIOS stub retail's final link REMOVED as unreferenced (recon/link_stripped.h): the same three
 * words, emitted into the discarded `.text.strip` input section and typed as a function so
 * tools/link_stripped_check.py can see it. */
#define BIOS_THUNK_LINK_STRIPPED(name, section, id)                            \
    __asm__("\t.section .text.strip,\"ax\",@progbits\n\t.set noreorder\n"      \
            "\t.globl " #name "\n\t.type " #name ",@function\n" #name ":\n"    \
            "\taddiu $10, $0, " #section "\n"                               \
            "\tjr    $10\n"                                                     \
            "\t addiu $9, $0, " #id "\n"                                    \
            "\t.size " #name ",.-" #name "\n"                                  \
            "\t.set reorder\n\t.set at\n\t.text\n")
#else
#define BIOS_THUNK(name, section, id)
#define BIOS_THUNK_LINK_STRIPPED(name, section, id)
#endif

#endif /* _BIOS_THUNK_H_ */

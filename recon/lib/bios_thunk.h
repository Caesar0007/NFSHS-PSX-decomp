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
    __asm__("\t.set push\n\t.set noreorder\n"                                  \
            "\t.globl " #name "\n" #name ":\n"                                 \
            "\taddiu $t2, $zero, " #section "\n"                               \
            "\tjr    $t2\n"                                                     \
            "\t addiu $t1, $zero, " #id "\n"                                    \
            "\tnop\n"                                                          \
            "\t.set pop\n")
#else
#define BIOS_THUNK(name, section, id)
#endif

#endif /* _BIOS_THUNK_H_ */

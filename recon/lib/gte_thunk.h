/* gte_thunk.h -- handwritten GTE (COP2) control-register setter macro.
 * Several PsyQ libgte register setters are genuine HANDWRITTEN assembly (the oracle
 * marks them ".set noreorder / Handwritten function / handwritten instruction"):
 * they move the incoming argument straight from $a0 into a GTE control register and
 * return, with NO sign/zero-extension and NO C prologue/epilogue. Reconstruct them as
 * a FILE-SCOPE __asm__ (same proven idiom as bios_thunk.h) so the value reaches the
 * coprocessor exactly as the original (`ctc2 $a0,$N; jr $ra; nop`) -- this is the true
 * source form, not a register pin. The host gets a portable C no-op stub.
 *
 *   Usage (one line per setter):  GTE_CTC_THUNK(SetDQA, 27);
 */
#ifndef _GTE_THUNK_H_
#define _GTE_THUNK_H_

#if defined(__mips__)
/* ctc2 $a0,$<creg>; jr $ra; nop  -- the literal handwritten sequence (arg type is
 * irrelevant: the value is taken raw from $a0 with no extension). */
#define GTE_CTC_THUNK(name, creg, argtype)                                     \
    __asm__("\t.set push\n\t.set noreorder\n"                                  \
            "\t.globl " #name "\n" #name ":\n"                                 \
            "\tctc2 $a0, $" #creg "\n"                                         \
            "\tjr   $ra\n"                                                      \
            "\t nop\n"                                                          \
            "\t.set pop\n")
#else
#define GTE_CTC_THUNK(name, creg, argtype)                                     \
    extern "C" void name(argtype v) { (void)v; } /* GTE absent on host */
#endif

#endif /* _GTE_THUNK_H_ */

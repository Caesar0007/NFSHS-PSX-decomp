#ifndef DECOMP_INCLUDE_ASM_H
#define DECOMP_INCLUDE_ASM_H

/*
 * INCLUDE_ASM / INCLUDE_RODATA — pull an as-yet-unmatched function (or its
 * rodata) from a raw .s file into a real translation unit.
 *
 * maspsx-aware: each __asm__ statement is wrapped in a throwaway function
 * named __maspsx_include_asm_hack_* and every line carries `# maspsx-keep`
 * so maspsx preserves it verbatim (gcc with non-zero -G reorders functions
 * after data, which would otherwise break a bare top-level __asm__).
 *
 * splat passes FOLDER as a full repo-relative path, e.g.
 *   INCLUDE_ASM("asm/nonmatchings/main", AICop_CleanUp__Fv);
 *
 * Under SPLAT / M2CTX / PERMUTER / SKIP_ASM the macros become no-ops so the
 * C side can be analyzed / diffed without the asm.
 */

#if !defined(SPLAT) && !defined(M2CTX) && !defined(PERMUTER) && !defined(SKIP_ASM)

#define INCLUDE_ASM(FOLDER, NAME)                                              \
    void __maspsx_include_asm_hack_##NAME() {                                  \
        __asm__(".text # maspsx-keep \n"                                       \
                "\t.align\t2 # maspsx-keep\n"                                  \
                "\t.set noreorder # maspsx-keep\n"                             \
                "\t.set noat # maspsx-keep\n"                                  \
                ".include \"" FOLDER "/" #NAME ".s\" # maspsx-keep\n"          \
                "\t.set reorder # maspsx-keep\n"                               \
                "\t.set at # maspsx-keep\n");                                  \
    }

#define INCLUDE_RODATA(FOLDER, NAME)                                           \
    __asm__(".section .rodata\n\t.include \"" FOLDER "/" #NAME ".s\"\n"        \
            ".section .text\n")

/* make glabel/jlabel/dlabel/endlabel/nonmatching available to the .include'd .s */
__asm__(".include \"macro.inc\"\n\t.set reorder\n\t.set at\n");

#else
#define INCLUDE_ASM(FOLDER, NAME)
#define INCLUDE_RODATA(FOLDER, NAME)
#endif

#endif /* DECOMP_INCLUDE_ASM_H */

#ifndef PSX_GTE_SAFETY_H
#define PSX_GTE_SAFETY_H

/**
 * Geometry Transformation Engine (GTE) Coprocessor 2 context save / restore macros.
 * Prevents GTE register clobbering across interrupt service routines on PSX.
 */

#define PSX_GTE_SAVE_CONTROL_REGS(dest_buf) \
    __asm__ volatile ( \
        "cfc2 $t0, $0\n" \
        "cfc2 $t1, $1\n" \
        "sw $t0, 0(%0)\n" \
        "sw $t1, 4(%0)\n" \
        : : "r" (dest_buf) : "$t0", "$t1", "memory" \
    )

#endif /* PSX_GTE_SAFETY_H */

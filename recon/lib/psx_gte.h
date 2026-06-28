/* psx_gte.h -- canonical PsyQ libgte inline COP2 / GTE macros (vendored subset).
 *
 * These are the SHARED PsyQ inline_c.h GTE macros, byte-identical across the Silent
 * Hill / SOTN / Soul Reaver / Vagrant Story decomps (their include/psyq/inline_c.h):
 * real cop2 inline-asm under __mips__, portable no-op/zero stubs for the host
 * -m32 -fsyntax-only seal gate (the GTE is absent off-PSX; the host build is
 * compile-only and never executed).
 *
 * Authority for the exact register numbers + cop2 op-words is the NFS4 oracle disasm
 * (verified against DrawW_NightColorCalc @0x800C609C). NOTE: gte_rt() assembles the
 * REAL mvmva command word 0x4A480012 ("mvmva 1,0,0,0,0") that maspsx + GNU as emit --
 * NOT Silent Hill's aspsx placeholder ".word 0x000000ff" (aspsx rewrites that; GNU as
 * does not, so the literal cop2 word is required here).
 */
#ifndef PSX_GTE_H
#define PSX_GTE_H

#if defined(__mips__)

/* Load vector V0 (VX0,VY0 / VZ0) from a packed short[3] at p -> GTE data regs 0,1. */
#define gte_ldv0(p)             __asm__ volatile (                              \
    "lwc2 $0, 0(%0)\n\t"                                                        \
    "lwc2 $1, 4(%0)"                                                            \
    : : "r"(p))

/* Rotate-only transform: mvmva 1,0,0,0,0 (IR/MAC = RotMatrix * V0, sf=12).
 * The two nops cover the GTE-data-load latency before the cop2 op reads V0. */
#define gte_rt()                __asm__ volatile (                              \
    "nop\n\t"                                                                   \
    "nop\n\t"                                                                   \
    ".word 0x4A480012")

/* Store the lower (unclamped) MAC1-3 result to a long[3] at p. */
#define gte_stlvnl(p)           __asm__ volatile (                             \
    "swc2 $25, 0(%0)\n\t"                                                       \
    "swc2 $26, 4(%0)\n\t"                                                       \
    "swc2 $27, 8(%0)"                                                           \
    : : "r"(p) : "memory")

/* Load a rotation matrix (short m[3][3] at offsets 0x0..0x10) -> ctrl regs 0..4. */
#define gte_SetRotMatrix(m)     __asm__ volatile (                             \
    "lw   $12, 0(%0)\n\t"                                                       \
    "lw   $13, 4(%0)\n\t"                                                       \
    "ctc2 $12, $0\n\t"                                                          \
    "ctc2 $13, $1\n\t"                                                          \
    "lw   $12, 8(%0)\n\t"                                                       \
    "lw   $13, 12(%0)\n\t"                                                      \
    "lw   $14, 16(%0)\n\t"                                                      \
    "ctc2 $12, $2\n\t"                                                          \
    "ctc2 $13, $3\n\t"                                                          \
    "ctc2 $14, $4"                                                             \
    : : "r"(m) : "$12", "$13", "$14")

/* Load a translation vector (long t[3] at offsets 0x14/0x18/0x1C) -> ctrl regs 5/6/7. */
#define gte_SetTransMatrix(m)   __asm__ volatile (                             \
    "lw   $12, 20(%0)\n\t"                                                      \
    "lw   $13, 24(%0)\n\t"                                                      \
    "ctc2 $12, $5\n\t"                                                          \
    "lw   $14, 28(%0)\n\t"                                                      \
    "ctc2 $13, $6\n\t"                                                          \
    "ctc2 $14, $7"                                                             \
    : : "r"(m) : "$12", "$13", "$14")

#else /* host build: GTE absent -- compile-only stubs */

#define gte_ldv0(p)             ((void)(p))
#define gte_rt()                ((void)0)
#define gte_stlvnl(p)           ((void)(p))
#define gte_SetRotMatrix(m)     ((void)(m))
#define gte_SetTransMatrix(m)   ((void)(m))

#endif /* __mips__ */

#endif /* PSX_GTE_H */

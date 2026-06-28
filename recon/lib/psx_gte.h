/* psx_gte.h -- canonical PsyQ libgte inline COP2 / GTE macros (vendored).
 *
 * The SHARED PsyQ inline_c.h GTE macros, as used across the Silent Hill / SOTN /
 * Soul Reaver / Vagrant Story decomps: real cop2 inline-asm under __mips__, portable
 * no-op/zero stubs for the host -m32 -fsyntax-only seal gate (no GTE off-PSX; the host
 * build is compile-only and never executed).
 *
 * Load/store/matrix forms are copied verbatim from Silent Hill's include/psyq/inline_c.h
 * (the canonical PsyQ register encodings). The GTE *compute* ops differ in ONE respect:
 * SH writes aspsx PLACEHOLDER command words (.word 0x0000007f ...) that the aspsx
 * assembler rewrites; NFS4 builds with maspsx + GNU as, which do NOT rewrite them, so we
 * assemble the REAL cop2 instruction words. Every word below was read out of the NFS4
 * oracle disassembly (asm/nonmatchings/**), which is authoritative (e.g. avsz3=0x4B58002D
 * and nclip=0x4B400006 here, NOT the 0x4Axxxxxx values some references list).
 *
 * GTE data regs: VXY0=0 VZ0=1 VXY1=2 VZ1=3 VXY2=4 VZ2=5 RGB=6 OTZ=7 IR0=8 IR1-3=9/10/11
 *   SXY0-2=12/13/14 SXYP=15 SZ0-3=16/17/18/19 RGB0-2=20/21/22 MAC0-3=24/25/26/27 LZCS=30.
 * GTE ctrl regs: R11R12..=0..4 (rot) TRX/Y/Z=5/6/7 L11..=8..12 RBK/GBK/BBK=13/14/15
 *   LR/LG/LB=16..24 RFC/GFC/BFC=21/22/23 OFX/OFY=24/25 H=26 DQA/DQB=27/28 ZSF3/4=29/30 FLAG=31.
 */
#ifndef PSX_GTE_H
#define PSX_GTE_H

#if defined(__mips__)

/* ---------- vector loads (memory -> GTE data regs, via lwc2) ---------- */
#define gte_ldv0(p)   __asm__ volatile ("lwc2 $0, 0(%0)\n\tlwc2 $1, 4(%0)" : : "r"(p))
#define gte_ldv1(p)   __asm__ volatile ("lwc2 $2, 0(%0)\n\tlwc2 $3, 4(%0)" : : "r"(p))
#define gte_ldv2(p)   __asm__ volatile ("lwc2 $4, 0(%0)\n\tlwc2 $5, 4(%0)" : : "r"(p))
#define gte_ldv3(p0,p1,p2) __asm__ volatile (                                  \
    "lwc2 $0, 0(%0)\n\tlwc2 $1, 4(%0)\n\tlwc2 $2, 0(%1)\n\t"                    \
    "lwc2 $3, 4(%1)\n\tlwc2 $4, 0(%2)\n\tlwc2 $5, 4(%2)"                        \
    : : "r"(p0), "r"(p1), "r"(p2))
#define gte_ldVXY0(p) __asm__ volatile ("lwc2 $0, 0(%0)" : : "r"(p))
#define gte_ldVZ0(p)  __asm__ volatile ("lwc2 $1, 0(%0)" : : "r"(p))
#define gte_ldVXY1(p) __asm__ volatile ("lwc2 $2, 0(%0)" : : "r"(p))
#define gte_ldVZ1(p)  __asm__ volatile ("lwc2 $3, 0(%0)" : : "r"(p))
#define gte_ldVXY2(p) __asm__ volatile ("lwc2 $4, 0(%0)" : : "r"(p))
#define gte_ldVZ2(p)  __asm__ volatile ("lwc2 $5, 0(%0)" : : "r"(p))
#define gte_ldIR0(p)  __asm__ volatile ("lwc2 $8, 0(%0)" : : "r"(p))
/* load a short[3] vector into IR1-3 (via CPU regs) */
#define gte_ldsv(p)   __asm__ volatile (                                       \
    "lhu $12, 0(%0)\n\tlhu $13, 2(%0)\n\tlhu $14, 4(%0)\n\t"                    \
    "mtc2 $12, $9\n\tmtc2 $13, $10\n\tmtc2 $14, $11"                           \
    : : "r"(p) : "$12", "$13", "$14")
/* set the translation vector from three already-loaded CPU regs */
#define gte_ldtr(r0,r1,r2) __asm__ volatile (                                  \
    "ctc2 %0, $5\n\tctc2 %1, $6\n\tctc2 %2, $7"                                 \
    : : "r"(r0), "r"(r1), "r"(r2))

/* ---------- result stores (GTE data regs -> memory, via swc2) ---------- */
#define gte_stlvnl(p) __asm__ volatile (                                       \
    "swc2 $25, 0(%0)\n\tswc2 $26, 4(%0)\n\tswc2 $27, 8(%0)"                     \
    : : "r"(p) : "memory")
/* store IR1-3 as shorts (via CPU regs) */
#define gte_stsv(p)   __asm__ volatile (                                       \
    "mfc2 $12, $9\n\tmfc2 $13, $10\n\tmfc2 $14, $11\n\t"                        \
    "sh $12, 0(%0)\n\tsh $13, 2(%0)\n\tsh $14, 4(%0)"                          \
    : : "r"(p) : "$12", "$13", "$14", "memory")
#define gte_stsxy(p)  __asm__ volatile ("swc2 $14, 0(%0)" : : "r"(p) : "memory")
#define gte_stsxy3(p0,p1,p2) __asm__ volatile (                                \
    "swc2 $12, 0(%0)\n\tswc2 $13, 0(%1)\n\tswc2 $14, 0(%2)"                     \
    : : "r"(p0), "r"(p1), "r"(p2) : "memory")
#define gte_stSXY0(p) __asm__ volatile ("swc2 $12, 0(%0)" : : "r"(p) : "memory")
#define gte_stSXY1(p) __asm__ volatile ("swc2 $13, 0(%0)" : : "r"(p) : "memory")
#define gte_stSXY2(p) __asm__ volatile ("swc2 $14, 0(%0)" : : "r"(p) : "memory")
#define gte_stsz(p)   __asm__ volatile ("swc2 $19, 0(%0)" : : "r"(p) : "memory")
#define gte_stOTZ(p)  __asm__ volatile ("swc2 $7, 0(%0)"  : : "r"(p) : "memory")
#define gte_stMAC0(p) __asm__ volatile ("swc2 $24, 0(%0)" : : "r"(p) : "memory")
/* store the FLAG control reg */
#define gte_stflg(p)  __asm__ volatile (                                       \
    "cfc2 $12, $31\n\tnop\n\tsw $12, 0(%0)"                                     \
    : : "r"(p) : "$12", "memory")

/* ---------- matrix / control-reg setup ---------- */
/* rotation matrix (short m[3][3] at +0..+0x10) -> ctrl 0..4 */
#define gte_SetRotMatrix(m) __asm__ volatile (                                 \
    "lw   $12, 0(%0)\n\tlw   $13, 4(%0)\n\tctc2 $12, $0\n\tctc2 $13, $1\n\t"    \
    "lw   $12, 8(%0)\n\tlw   $13, 12(%0)\n\tlw   $14, 16(%0)\n\t"               \
    "ctc2 $12, $2\n\tctc2 $13, $3\n\tctc2 $14, $4"                             \
    : : "r"(m) : "$12", "$13", "$14")
/* translation vector (long t[3] at +0x14/0x18/0x1C) -> ctrl 5/6/7 */
#define gte_SetTransMatrix(m) __asm__ volatile (                               \
    "lw   $12, 20(%0)\n\tlw   $13, 24(%0)\n\tctc2 $12, $5\n\t"                  \
    "lw   $14, 28(%0)\n\tctc2 $13, $6\n\tctc2 $14, $7"                         \
    : : "r"(m) : "$12", "$13", "$14")
/* move a CPU value into GTE control reg r (literal) */
#define gte_ctc2(v,r) __asm__ volatile ("ctc2 %0, $%1" : : "r"(v), "i"(r))
/* set the projection screen offset (OFX/OFY, ctrl 24/25), pre-shifted <<16 */
#define gte_SetGeomOffset(x,y) __asm__ volatile (                              \
    "sll $12, %0, 16\n\tsll $13, %1, 16\n\tctc2 $12, $24\n\tctc2 $13, $25"      \
    : : "r"(x), "r"(y) : "$12", "$13")

/* ---------- GTE compute ops (real cop2 words from the NFS4 oracle) ----------
 * The two leading nops cover the GTE-data-load latency (every oracle compute op is
 * preceded by `nop; nop`). The `_b` ("blind") variants omit them for back-to-back use. */
#define gte_rt()      __asm__ volatile ("nop\n\tnop\n\t.word 0x4A480012") /* mvmva 1,0,0,0,0 */
#define gte_rtir()    __asm__ volatile ("nop\n\tnop\n\t.word 0x4A49E012") /* mvmva 1,0,3,3,0 (rot IR) */
#define gte_rtps()    __asm__ volatile ("nop\n\tnop\n\t.word 0x4A180001")
#define gte_rtpt()    __asm__ volatile ("nop\n\tnop\n\t.word 0x4A280030")
#define gte_nclip()   __asm__ volatile ("nop\n\tnop\n\t.word 0x4B400006")
#define gte_avsz3()   __asm__ volatile ("nop\n\tnop\n\t.word 0x4B58002D")
#define gte_avsz4()   __asm__ volatile ("nop\n\tnop\n\t.word 0x4B68002E")
#define gte_dpcs()    __asm__ volatile ("nop\n\tnop\n\t.word 0x4A780010")
#define gte_dpct()    __asm__ volatile ("nop\n\tnop\n\t.word 0x4AF8002A")
#define gte_rtps_b()  __asm__ volatile (".word 0x4A180001")
#define gte_nclip_b() __asm__ volatile (".word 0x4B400006")
#define gte_avsz4_b() __asm__ volatile (".word 0x4B68002E")
/* parameterized mvmva: word = 0x4A400012 | sf<<19 | mx<<17 | v<<15 | cv<<13 | lm<<10
 * (real cop2 encoding; verified: (1,0,0,0,0)=0x4A480012, (1,0,3,3,0)=0x4A49E012). */
#define gte_mvmva_core(w) __asm__ volatile ("nop\n\tnop\n\t.word %0" : : "i"(w))
#define gte_mvmva(sf,mx,v,cv,lm) gte_mvmva_core(0x4A400012 |                    \
    ((sf)<<19) | ((mx)<<17) | ((v)<<15) | ((cv)<<13) | ((lm)<<10))

#else /* host build: GTE absent -- compile-only stubs */

#define gte_ldv0(p)            ((void)(p))
#define gte_ldv1(p)            ((void)(p))
#define gte_ldv2(p)            ((void)(p))
#define gte_ldv3(p0,p1,p2)     do { (void)(p0); (void)(p1); (void)(p2); } while (0)
#define gte_ldVXY0(p)          ((void)(p))
#define gte_ldVZ0(p)           ((void)(p))
#define gte_ldVXY1(p)          ((void)(p))
#define gte_ldVZ1(p)           ((void)(p))
#define gte_ldVXY2(p)          ((void)(p))
#define gte_ldVZ2(p)           ((void)(p))
#define gte_ldIR0(p)           ((void)(p))
#define gte_ldsv(p)            ((void)(p))
#define gte_ldtr(r0,r1,r2)     do { (void)(r0); (void)(r1); (void)(r2); } while (0)
#define gte_stlvnl(p)          ((void)(p))
#define gte_stsv(p)            ((void)(p))
#define gte_stsxy(p)           ((void)(p))
#define gte_stsxy3(p0,p1,p2)   do { (void)(p0); (void)(p1); (void)(p2); } while (0)
#define gte_stSXY0(p)          ((void)(p))
#define gte_stSXY1(p)          ((void)(p))
#define gte_stSXY2(p)          ((void)(p))
#define gte_stsz(p)            ((void)(p))
#define gte_stOTZ(p)           ((void)(p))
#define gte_stMAC0(p)          ((void)(p))
#define gte_stflg(p)           ((void)(p))
#define gte_SetRotMatrix(m)    ((void)(m))
#define gte_SetTransMatrix(m)  ((void)(m))
#define gte_ctc2(v,r)          do { (void)(v); (void)(r); } while (0)
#define gte_SetGeomOffset(x,y) do { (void)(x); (void)(y); } while (0)
#define gte_rt()               ((void)0)
#define gte_rtir()             ((void)0)
#define gte_rtps()             ((void)0)
#define gte_rtpt()             ((void)0)
#define gte_nclip()            ((void)0)
#define gte_avsz3()            ((void)0)
#define gte_avsz4()            ((void)0)
#define gte_dpcs()             ((void)0)
#define gte_dpct()             ((void)0)
#define gte_rtps_b()           ((void)0)
#define gte_nclip_b()          ((void)0)
#define gte_avsz4_b()          ((void)0)
#define gte_mvmva_core(w)      ((void)(w))
#define gte_mvmva(sf,mx,v,cv,lm) do { (void)(sf); (void)(mx); (void)(v); (void)(cv); (void)(lm); } while (0)

#endif /* __mips__ */

#endif /* PSX_GTE_H */

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
/* "m"-form loads (2026-07-09b): input-memory-operand variants -- gcc emits the FULL
 * base+displacement address (`lwc2 $0,0xD0(rN)`, rN = base+idx*stride CSE'd and
 * REUSED by neighbouring byte-field reads), matching EA's member-array codegen. */
#define gte_ldVXY0m(x) __asm__ volatile ("lwc2 $0, %0" : : "m"(x))
#define gte_ldVZ0m(x)  __asm__ volatile ("lwc2 $1, %0" : : "m"(x))
#define gte_ldVXY1m(x) __asm__ volatile ("lwc2 $2, %0" : : "m"(x))
#define gte_ldVZ1m(x)  __asm__ volatile ("lwc2 $3, %0" : : "m"(x))
#define gte_ldVXY2m(x) __asm__ volatile ("lwc2 $4, %0" : : "m"(x))
#define gte_ldVZ2m(x)  __asm__ volatile ("lwc2 $5, %0" : : "m"(x))
/* load CVECTOR -> RGB (reg 6). rgb3/rgb3c: load FIFO rgb0/1/2 (regs 20/21/22) from 3
 * pointers / one continuous base, also reloading RGB(6) from the last (PsyQ gte_ldrgb3*). */
#define gte_ldrgb(p)   __asm__ volatile ("lwc2 $6, 0(%0)" : : "r"(p))
#define gte_ldrgb3(a,b,c) __asm__ volatile (                                   \
    "lwc2 $20, 0(%0)\n\tlwc2 $21, 0(%1)\n\tlwc2 $22, 0(%2)\n\tlwc2 $6, 0(%2)"   \
    : : "r"(a), "r"(b), "r"(c))
#define gte_ldrgb3c(p) __asm__ volatile (                                      \
    "lwc2 $20, 0(%0)\n\tlwc2 $21, 4(%0)\n\tlwc2 $22, 8(%0)\n\tlwc2 $6, 8(%0)"   \
    : : "r"(p))
/* load a short[3] vector into IR1-3 (via CPU regs) */
#define gte_ldsv(p)   __asm__ volatile (                                       \
    "lhu $12, 0(%0)\n\tlhu $13, 2(%0)\n\tlhu $14, 4(%0)\n\t"                    \
    "mtc2 $12, $9\n\tmtc2 $13, $10\n\tmtc2 $14, $11"                           \
    : : "r"(p) : "$12", "$13", "$14")
/* set the translation vector from three already-loaded CPU regs */
#define gte_ldtr(r0,r1,r2) __asm__ volatile (                                  \
    "ctc2 %0, $5\n\tctc2 %1, $6\n\tctc2 %2, $7"                                 \
    : : "r"(r0), "r"(r1), "r"(r2))
/* zero the translation vector directly via $zero (the hand-written `ctc2 $0,$5/6/7`
 * the oracle uses -- gte_ldtr(0,0,0) would instead materialize 0 into 3 temps first). */
#define gte_ldtr0()   __asm__ volatile ("ctc2 $0, $5\n\tctc2 $0, $6\n\tctc2 $0, $7")
/* load 3 screen-XY words into SXY0/SXY1/SXY2 via mtc2 from CPU regs
 * (oracle emits $12, then $14, then $13 -- SXY0, SXY2, SXY1). */
#define gte_ldsxy3(a,b,c) __asm__ volatile (                                   \
    "mtc2 %0, $12\n\tmtc2 %2, $14\n\tmtc2 %1, $13"                             \
    : : "r"(a), "r"(b), "r"(c))

/* ---------- result stores (GTE data regs -> memory, via swc2) ---------- */
#define gte_stlvnl(p) __asm__ volatile (                                       \
    "swc2 $25, 0(%0)\n\tswc2 $26, 4(%0)\n\tswc2 $27, 8(%0)"                     \
    : : "r"(p) : "memory")
/* lone MAC1 / MAC2 / MAC3 stores (PsyQ gte_stlvnl0/1/2) */
#define gte_stlvnl0(p) __asm__ volatile ("swc2 $25, 0(%0)" : : "r"(p) : "memory")
#define gte_stlvnl1(p) __asm__ volatile ("swc2 $26, 0(%0)" : : "r"(p) : "memory")
#define gte_stlvnl2(p) __asm__ volatile ("swc2 $27, 0(%0)" : : "r"(p) : "memory")
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
/* PACKET-targeted SXY/RGB stores (DMPSX Inlinref Tables 1-30/1-38, added 2026-07-09):
 * ONE packet base + the POLY_* fixed field offsets -- the oracle form in the EA render
 * loop (DrawC_Prim: `swc2 $12,8(a1); $13,16(a1); $14,24(a1)` == gte_stsxy3_ft3(prim)).
 * Offsets = canonical PsyQ POLY layouts (FT3 8/16/24 verified against the DrawC oracle). */
#define gte_stsxy3_f3(p)  __asm__ volatile ("swc2 $12, 8(%0)\n\tswc2 $13, 12(%0)\n\tswc2 $14, 16(%0)" : : "r"(p) : "memory")
#define gte_stsxy3_ft3(p) __asm__ volatile ("swc2 $12, 8(%0)\n\tswc2 $13, 16(%0)\n\tswc2 $14, 24(%0)" : : "r"(p) : "memory")
#define gte_stsxy3_g3(p)  __asm__ volatile ("swc2 $12, 8(%0)\n\tswc2 $13, 16(%0)\n\tswc2 $14, 24(%0)" : : "r"(p) : "memory")
#define gte_stsxy3_gt3(p) __asm__ volatile ("swc2 $12, 8(%0)\n\tswc2 $13, 20(%0)\n\tswc2 $14, 32(%0)" : : "r"(p) : "memory")
#define gte_stsxy3_f4(p)  __asm__ volatile ("swc2 $12, 8(%0)\n\tswc2 $13, 12(%0)\n\tswc2 $14, 16(%0)" : : "r"(p) : "memory")
#define gte_stsxy3_ft4(p) __asm__ volatile ("swc2 $12, 8(%0)\n\tswc2 $13, 16(%0)\n\tswc2 $14, 24(%0)" : : "r"(p) : "memory")
#define gte_stsxy3_g4(p)  __asm__ volatile ("swc2 $12, 8(%0)\n\tswc2 $13, 16(%0)\n\tswc2 $14, 24(%0)" : : "r"(p) : "memory")
#define gte_stsxy3_gt4(p) __asm__ volatile ("swc2 $12, 8(%0)\n\tswc2 $13, 20(%0)\n\tswc2 $14, 32(%0)" : : "r"(p) : "memory")
#define gte_strgb3_g3(p)  __asm__ volatile ("swc2 $20, 4(%0)\n\tswc2 $21, 12(%0)\n\tswc2 $22, 20(%0)" : : "r"(p) : "memory")
#define gte_strgb3_gt3(p) __asm__ volatile ("swc2 $20, 4(%0)\n\tswc2 $21, 16(%0)\n\tswc2 $22, 28(%0)" : : "r"(p) : "memory")
#define gte_strgb3_g4(p)  __asm__ volatile ("swc2 $20, 4(%0)\n\tswc2 $21, 12(%0)\n\tswc2 $22, 20(%0)" : : "r"(p) : "memory")
#define gte_strgb3_gt4(p) __asm__ volatile ("swc2 $20, 4(%0)\n\tswc2 $21, 16(%0)\n\tswc2 $22, 28(%0)" : : "r"(p) : "memory")
#define gte_stsz(p)   __asm__ volatile ("swc2 $19, 0(%0)" : : "r"(p) : "memory")   /* lone SZ3 */
/* SZ stores: there is NO lone PsyQ macro for SZ1 or SZ2 -- they come only as a trio.
 * gte_stsz3 = SZ1/SZ2/SZ3 to three pointers; gte_stsz3c = to one base at +0/4/8;
 * gte_stsz4 = SZ0..SZ3 to four pointers; gte_stsz4c = to one base at +0/4/8/12. */
#define gte_stsz3(a,b,c) __asm__ volatile (                                    \
    "swc2 $17, 0(%0)\n\tswc2 $18, 0(%1)\n\tswc2 $19, 0(%2)"                     \
    : : "r"(a), "r"(b), "r"(c) : "memory")
#define gte_stsz3c(p)  __asm__ volatile (                                      \
    "swc2 $17, 0(%0)\n\tswc2 $18, 4(%0)\n\tswc2 $19, 8(%0)"                     \
    : : "r"(p) : "memory")
#define gte_stsz4(a,b,c,d) __asm__ volatile (                                  \
    "swc2 $16, 0(%0)\n\tswc2 $17, 0(%1)\n\tswc2 $18, 0(%2)\n\tswc2 $19, 0(%3)"  \
    : : "r"(a), "r"(b), "r"(c), "r"(d) : "memory")
#define gte_stsz4c(p)  __asm__ volatile (                                      \
    "swc2 $16, 0(%0)\n\tswc2 $17, 4(%0)\n\tswc2 $18, 8(%0)\n\tswc2 $19, 12(%0)" \
    : : "r"(p) : "memory")
#define gte_stOTZ(p)  __asm__ volatile ("swc2 $7, 0(%0)"  : : "r"(p) : "memory")
/* "m"-FORM stores (2026-07-09): output-memory-operand variants -- gcc emits the FULL
 * base+displacement addressing itself (`swc2 $24,0xC4($t0)` off a live struct base),
 * matching the EA-expander sites where the "r"-form would materialize an address first.
 * Pass the LVALUE (sd->bfct), not its address. */
#define gte_stMAC0m(x) __asm__ volatile ("swc2 $24, %0" : "=m"(x))
#define gte_stOTZm(x)  __asm__ volatile ("swc2 $7, %0"  : "=m"(x))
#define gte_stSXY0m(x) __asm__ volatile ("swc2 $12, %0" : "=m"(x))
#define gte_stSXY1m(x) __asm__ volatile ("swc2 $13, %0" : "=m"(x))
#define gte_stSXY2m(x) __asm__ volatile ("swc2 $14, %0" : "=m"(x))
#define gte_stMAC0(p) __asm__ volatile ("swc2 $24, 0(%0)" : : "r"(p) : "memory")
/* store the FLAG control reg */
#define gte_stflg(p)  __asm__ volatile (                                       \
    "cfc2 $12, $31\n\tnop\n\tsw $12, 0(%0)"                                     \
    : : "r"(p) : "$12", "memory")
/* generic LONE store: GTE data reg `reg` (a literal) -> memory at p+0. Use for result
 * regs that have no dedicated bundled macro (a lone MAC1-3, SZ0-2, etc.); for the
 * consecutive MAC1-3 / SXY0-2 triples prefer gte_stlvnl / gte_stsxy3 (immediate offsets). */
#define gte_swc2(reg,p) __asm__ volatile ("swc2 $%1, 0(%0)" : : "r"(p), "i"(reg) : "memory")

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
/* translation vector from a VECTOR (+0/+4/+8) -> ctrl 5/6/7; oracle groups the
 * three lw THEN the three ctc2 (Flare_Sun @0x800CF2D0). */
#define gte_SetTransVector(p) __asm__ volatile (                               \
    "lw   $12, 0(%0)\n\tlw   $13, 4(%0)\n\tlw   $14, 8(%0)\n\t"                 \
    "ctc2 $12, $5\n\tctc2 $13, $6\n\tctc2 $14, $7"                             \
    : : "r"(p) : "$12", "$13", "$14")
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
#define gte_ldVXY0m(x)         ((void)(x))
#define gte_ldVZ0m(x)          ((void)(x))
#define gte_ldVXY1m(x)         ((void)(x))
#define gte_ldVZ1m(x)          ((void)(x))
#define gte_ldVXY2m(x)         ((void)(x))
#define gte_ldVZ2m(x)          ((void)(x))
#define gte_ldrgb(p)           ((void)(p))
#define gte_ldrgb3(a,b,c)      do { (void)(a); (void)(b); (void)(c); } while (0)
#define gte_ldrgb3c(p)         ((void)(p))
#define gte_ldsv(p)            ((void)(p))
#define gte_ldtr(r0,r1,r2)     do { (void)(r0); (void)(r1); (void)(r2); } while (0)
#define gte_ldtr0()            ((void)0)
#define gte_ldsxy3(a,b,c)      do { (void)(a); (void)(b); (void)(c); } while (0)
#define gte_stlvnl(p)          ((void)(p))
#define gte_stlvnl0(p)         ((void)(p))
#define gte_stlvnl1(p)         ((void)(p))
#define gte_stlvnl2(p)         ((void)(p))
#define gte_stsv(p)            ((void)(p))
#define gte_stsxy(p)           ((void)(p))
#define gte_stsxy3(p0,p1,p2)   do { (void)(p0); (void)(p1); (void)(p2); } while (0)
#define gte_stSXY0(p)          ((void)(p))
#define gte_stSXY1(p)          ((void)(p))
#define gte_stSXY2(p)          ((void)(p))
#define gte_stsxy3_f3(p)       ((void)(p))
#define gte_stsxy3_ft3(p)      ((void)(p))
#define gte_stsxy3_g3(p)       ((void)(p))
#define gte_stsxy3_gt3(p)      ((void)(p))
#define gte_stsxy3_f4(p)       ((void)(p))
#define gte_stsxy3_ft4(p)      ((void)(p))
#define gte_stsxy3_g4(p)       ((void)(p))
#define gte_stsxy3_gt4(p)      ((void)(p))
#define gte_strgb3_g3(p)       ((void)(p))
#define gte_strgb3_gt3(p)      ((void)(p))
#define gte_strgb3_g4(p)       ((void)(p))
#define gte_strgb3_gt4(p)      ((void)(p))
#define gte_stsz(p)            ((void)(p))
#define gte_stsz3(a,b,c)       do { (void)(a); (void)(b); (void)(c); } while (0)
#define gte_stsz3c(p)          ((void)(p))
#define gte_stsz4(a,b,c,d)     do { (void)(a); (void)(b); (void)(c); (void)(d); } while (0)
#define gte_stsz4c(p)          ((void)(p))
#define gte_stOTZ(p)           ((void)(p))
#define gte_stMAC0m(x)         ((void)(x))
#define gte_stOTZm(x)          ((void)(x))
#define gte_stSXY0m(x)         ((void)(x))
#define gte_stSXY1m(x)         ((void)(x))
#define gte_stSXY2m(x)         ((void)(x))
#define gte_stMAC0(p)          ((void)(p))
#define gte_stflg(p)           ((void)(p))
#define gte_swc2(reg,p)        do { (void)(reg); (void)(p); } while (0)
#define gte_SetRotMatrix(m)    ((void)(m))
#define gte_SetTransMatrix(m)  ((void)(m))
#define gte_SetTransVector(p)  ((void)(p))
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

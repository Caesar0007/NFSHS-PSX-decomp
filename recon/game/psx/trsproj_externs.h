#include "../../lib/libfns.h"
/* trsproj_externs.h -- externs referenced by trsproj.cpp (GAME/PSX/TRSPROJ.CPP transform+projection) */
#ifndef TRSPROJ_EXTERNS_H
#define TRSPROJ_EXTERNS_H

/* ---- PsyQ libgte.h GTE (COP2) inline macros (mirror <libgte.h>) ----
 * On MIPS these expand to the genuine COP2 ctc2 sequence the oracle inlines
 * (".set noreorder / handwritten instruction"); host build gets a no-op stub.
 * gte_SetTransMatrix(m): load m->t[0..2] (offsets 0x14/0x18/0x1C) into GTE
 * control regs 5/6/7 (TRX/TRY/TRZ) -- exact order lw,lw,ctc2,lw,ctc2,ctc2. */
#define gte_SetRotMatrix(m)     ((void)(m))
#if defined(__mips__)
#define gte_SetTransMatrix(m)   __asm__ volatile (                            \
    "lw   $12, 20(%0)\n\tlw   $13, 24(%0)\n\tctc2 $12, $5\n\t"                 \
    "lw   $14, 28(%0)\n\tctc2 $13, $6\n\tctc2 $14, $7"                         \
    : : "r"(m) : "$12", "$13", "$14")
#else
#define gte_SetTransMatrix(m)   ((void)(m))
#endif
#define gte_SetGeomScreen(h)    ((void)(h))
extern "C" void SetGeomScreen(long h);   /* real libgte REG13 function (oracle: jal SetGeomScreen) */
#define gte_ldv0(v)             ((void)(v))
#define gte_mvmva(args...)          ((void)0)
#define gte_stlvnl(p)           ((void)(p))
#if defined(__mips__)
#define gte_ctc2(v,r)           __asm__ volatile ("ctc2 %0, $%1" : : "r"(v), "i"(r))
/* gte_SetGeomOffset(x,y): GTE OFX(creg 24)=x<<16, OFY(creg 25)=y<<16 (two ctc2). */
#define gte_SetGeomOffset(x,y)  do { gte_ctc2((x) << 16, 24); gte_ctc2((y) << 16, 25); } while (0)
#else
#define gte_ctc2(v,r)           ((void)0)
#define gte_SetGeomOffset(x,y)  ((void)0)
#endif

/* ---- globals (SYM Globals.jsonl) ---- */
/* TrsProj_precision (0x8013db9c) is TrsProj.obj-OWNED -> DEFINED in trsproj.cpp (=10), not externed. */
extern long              Camera_gGeomScreen;    /* 0x8013c7dc */
extern GameSetup_tData   GameSetup_gData;       /* 0x801131ec */

/* ---- eaclib transform (fixed-point matrix*vector; func_800EAED8) ---- */

#endif /* TRSPROJ_EXTERNS_H */

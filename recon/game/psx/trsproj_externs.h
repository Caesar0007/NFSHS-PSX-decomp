#include "../../lib/libfns.h"
/* trsproj_externs.h -- externs referenced by trsproj.cpp (GAME/PSX/TRSPROJ.CPP transform+projection) */
#ifndef TRSPROJ_EXTERNS_H
#define TRSPROJ_EXTERNS_H

/* ---- PsyQ libgte.h GTE (COP2) inline macros (mirror <libgte.h>; no-op for the host syntax check) ---- */
#define gte_SetRotMatrix(m)     ((void)(m))
#define gte_SetTransMatrix(m)   ((void)(m))
#define gte_SetGeomScreen(h)    ((void)(h))
#define SetGeomScreen(h)        gte_SetGeomScreen(h)   /* source spelling (syslib::libgte::REG13) */
#define gte_SetGeomOffset(x,y)  ((void)0)
#define gte_ldv0(v)             ((void)(v))
#define gte_mvmva(args...)          ((void)0)
#define gte_stlvnl(p)           ((void)(p))
#define gte_ctc2(v,r)           ((void)0)

/* ---- globals (SYM Globals.jsonl) ---- */
/* TrsProj_precision (0x8013db9c) is TrsProj.obj-OWNED -> DEFINED in trsproj.cpp (=10), not externed. */
extern long              Camera_gGeomScreen;    /* 0x8013c7dc */
extern GameSetup_tData   GameSetup_gData;       /* 0x801131ec */

/* ---- eaclib transform (fixed-point matrix*vector; func_800EAED8) ---- */

#endif /* TRSPROJ_EXTERNS_H */

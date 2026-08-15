#include "../../lib/libfns.h"
/* Canonical PsyQ libgte inline COP2 macros are vendored in psx_gte.h (real cop2 asm:
 * gte_SetRotMatrix/SetTransMatrix/SetGeomOffset/ctc2/ldv0/mvmva/stlvnl ...). The file's
 * own former no-op stub block (far-miss) was DELETED in favour of these. */
#include "../../lib/psx_gte.h"
/* trsproj_externs.h -- externs referenced by trsproj.cpp (GAME/PSX/TRSPROJ.CPP transform+projection) */
#ifndef TRSPROJ_EXTERNS_H
#define TRSPROJ_EXTERNS_H

extern "C" void SetGeomScreen(long h);   /* real libgte REG13 function (oracle: jal SetGeomScreen) */

/* ---- globals (SYM Globals.jsonl) ---- */
/* TrsProj_precision (0x8013db9c) is TrsProj.obj-OWNED -> DEFINED in trsproj.cpp (=10), not externed. */
extern long              Camera_gGeomScreen;    /* 0x8013c7dc */
extern GameSetup_tData   GameSetup_gData;       /* 0x801131ec */

/* ---- eaclib transform (fixed-point matrix*vector; func_800EAED8) ---- */

#endif /* TRSPROJ_EXTERNS_H */

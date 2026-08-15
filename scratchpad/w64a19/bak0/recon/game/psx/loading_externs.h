/* loading_externs.h -- externs for game/psx/loading.cpp (NFS4 PSX load-screen + progress bar) */
#ifndef _GAME_PSX_LOADING_EXTERNS_H_
#define _GAME_PSX_LOADING_EXTERNS_H_

#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- globals ---- */
extern char          *loading_languageNames[]; /* 0x80120d00 */
extern char          *smallShapeFile;          /* 0x8013d9d0  Loadb.psh progress tiles */
extern int            totalAvailMem;           /* 0x8013d9dc */
extern GameSetup_tData GameSetup_gData;         /* 0x801131ec */
extern char          *Paths_Paths[];           /* 0x80116468 */

/* ---- eaclib / syslib / Draw helpers ---- */
extern void  Draw_SetEnvironment(int w, int h, int a, int b, int c, int d, int e, int f);
extern void  Draw_DrawDirectScreen(shapetbl *s, int x, int y);

#endif

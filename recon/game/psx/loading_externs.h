/* loading_externs.h -- externs for game/psx/loading.cpp (NFS4 PSX load-screen + progress bar) */
#ifndef _GAME_PSX_LOADING_EXTERNS_H_
#define _GAME_PSX_LOADING_EXTERNS_H_

/* ---- globals ---- */
extern char          *loading_languageNames[] __asm__("D_80120D00"); /* 0x80120d00 */
extern char          *smallShapeFile;          /* 0x8013d9d0  Loadb.psh progress tiles */
extern int            totalAvailMem;           /* 0x8013d9dc */
extern GameSetup_tData GameSetup_gData;
extern char          *Paths_Paths[];           /* 0x80116468 */

/* ---- eaclib / syslib / Draw helpers ---- */
extern void  Draw_SetEnvironment(int w, int h, int edraw, int edisplay, int erase, int r, int g, int b);
extern void  Draw_DrawDirectScreen(shapetbl *s, int x, int y);
extern "C" int sprintf(...);
extern "C" int loadshapeadr(...);
extern "C" void *shapepointer(...);
extern "C" void *locateshapez(...);
extern "C" int purgememadr(...);
extern "C" int largestunused(...);

#endif

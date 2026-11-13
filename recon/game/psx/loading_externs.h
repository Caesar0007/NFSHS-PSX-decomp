/* loading_externs.h -- externs for game/psx/loading.cpp (NFS4 PSX load-screen + progress bar) */
#ifndef _GAME_PSX_LOADING_EXTERNS_H_
#define _GAME_PSX_LOADING_EXTERNS_H_

/* ---- globals ---- */
extern char          *smallShapeFile;          /* 0x8013d9d0  Loadb.psh progress tiles */
extern int            totalAvailMem;           /* 0x8013d9dc */
extern int GameSetup_gData[650]; /* word view (2600 bytes): retail loading.obj records no GameSetup_tData */
extern char          *Paths_Paths[];           /* 0x80116468 */

/* ---- eaclib / syslib / Draw helpers ---- */
extern void  Draw_SetEnvironment(int w, int h, int edraw, int edisplay, int erase, int r, int g, int b);
extern void  Draw_DrawDirectScreen(shapetbl *s, int x, int y);
extern "C" int sprintf(char *buffer, char *fmt, ...);
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_shape.h"
#include "eaclib/psx/eacpsxz/memstd.h"
}

#endif

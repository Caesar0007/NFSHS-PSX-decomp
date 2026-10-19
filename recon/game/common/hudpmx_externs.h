/* hudpmx_externs.h -- cross-TU decls for game/common/hudpmx.cpp (NFS4 HUD pixmap/shape loader).
 *   Types in nfs4_types.h. HudPmx OWNS gHudFont/gShpfile/loadShapeXOff/gShapeNames/gHudNumberUV/gShapes. */
#ifndef HUDPMX_EXTERNS_H
#define HUDPMX_EXTERNS_H

/* ---- cross-TU globals ---- */
extern GameSetup_tData  GameSetup_gData;          /* gmesetup.obj */
extern dashhud_info     DashHUD_gInfo;             /* dashHUD.obj */
extern char           *Paths_Paths[50];          /* paths.obj */
extern u_short         gFontClut;                /* font.obj */

/* ---- cross-TU fns ---- */
extern void  Font_LoadFont(char *buf, int w, int h, char flag);                /* font.obj */
extern void  Font_GetUVWH(char ch, int *u, int *v, int *w, int *h, int *yo);  /* font.obj */
extern int   Texture_LoadPmx(char *a, char *b, int c, int d, int e, int f, int g, Draw_tPixMap *pm);  /* texture.obj */
extern void  Texture_ResetPaletteSharing(void);                                /* texture.obj */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/locatshp.h"
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/nsync.h"
}
extern "C" {
int sprintf(char *buffer, const char *format, ...);
}

#endif /* HUDPMX_EXTERNS_H */

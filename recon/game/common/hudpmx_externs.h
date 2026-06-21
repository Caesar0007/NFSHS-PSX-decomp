#include "../../lib/libfns.h"
/* hudpmx_externs.h -- cross-TU decls for game/common/hudpmx.cpp (NFS4 HUD pixmap/shape loader).
 *   Types in nfs4_types.h. HudPmx OWNS gHudFont/gShpfile/loadShapeXOff/gShapeNames/gHudNumberUV/gShapes. */
#ifndef HUDPMX_EXTERNS_H
#define HUDPMX_EXTERNS_H

/* ---- cross-TU globals ---- */
extern GameSetup_tData GameSetup_gData;          /* gmesetup.obj */
extern dashhud_info    DashHUD_gInfo;            /* dashHUD.obj */
extern char           *Paths_Paths[50];          /* paths.obj */
extern u_short         gFontClut;                /* font.obj */
extern char           *Track_gShapeNamePtrs[];   /* track.obj (shape-name ptr list) */
extern char           *Track_gShapeNamePtrs_end[];
extern char           *_Track_gShapeNamePtrs_end[];
extern char           *Track_gTachNamePtrs[];    /* track.obj (tachometer name ptrs) */
extern char           *gShapeNamePtrs_subList[]; /* track.obj */

/* ---- cross-TU fns ---- */
extern void  Font_LoadFont(char *buf, int w, int h, int flag);                 /* font.obj */
extern void  Font_GetUVWH(int ch, void *a, void *b, void *c, void *d, void *e);/* font.obj */
extern int   Texture_LoadPmx(char *a, char *b, int c, int d, int e, int f, int g, Draw_tPixMap *pm);  /* texture.obj */
extern void  Texture_ResetPaletteSharing(void);                                /* texture.obj */
                              /* eaclib EACPSXZ locatshp */
                                /* eaclib EACPSXZ nsync */
                               /* eaclib EACPSXZ nsync */
                                             /* eaclib EACPSXZ memstd */
                         /* libc */

#endif /* HUDPMX_EXTERNS_H */

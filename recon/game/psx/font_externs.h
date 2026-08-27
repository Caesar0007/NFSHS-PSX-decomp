/* font_externs.h -- extern decls for game/psx/font.cpp (NFS4 PSX text/font rasterizer).
 * Types come from the font.obj-specific type surface, not the monolithic game
 * header, so full-debug output retains retail's per-object visibility. */
#ifndef FONT_EXTERNS_H
#define FONT_EXTERNS_H

#include "font_obj_types.h"

/* ---- font module state globals (SYM) ---- */
extern int       font_clutx;              /* 0x8013d854 */
extern int       font_cluty;              /* 0x8013d858 */
extern u_long    font_tint;               /* 0x8013d85c */
extern u_long    font_abr;                /* 0x8013d860 */
extern u_short   gFontClut;               /* 0x8013d864 */
extern u_char    gFontSpaceWidth;         /* 0x8013d866 */
extern u_short   font_currentTPage;       /* 0x8013d868 */
extern cluttbl   shpfontclut;             /* 0x8011fdb0  (48 bytes) */
extern long      colourRGB[16];           /* 0x8011fd70  (ARY LONG, 64 bytes) */
extern u_char    currentfont[0xa0];       /* 0x80135ba0  (active font header buffer) */

/* ---- render packet/palette ring (shared) ---- */
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

/* ---- PsyQ libgpu ---- */
extern "C" {
extern int       DrawSync(int mode);
extern u_short   GetTPage(int tp, int abr, int x, int y);
extern void      SetDrawMode(DR_MODE *p, int dfe, int dtd, int tpage, RECT *tw);
extern void      SetSemiTrans(void *p, int abe);
}

/* ---- game texture manager ---- */
extern void      Texture_GetClutId(int id, int *px, int *py);
extern void      Texture_MenuReleaseClutId(short id);
extern void      Texture_Vramf(shapetbl *s, int x, int y, int w, int h);

/* ---- eaclib (EACPSXZ) text/mem helpers ---- */
extern "C" {
extern unsigned int geti(void *p, char nbytes);  /* read n-byte field */
extern void         setfont(int fontId);
extern void         waitdraw(void);
extern void        *resizememadr(void *ptr, int size);
}

#endif

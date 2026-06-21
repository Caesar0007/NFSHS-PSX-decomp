#include "../../lib/libfns.h"
/* font_externs.h -- extern decls for game/psx/font.cpp (NFS4 PSX text/font rasterizer).
 * Types come from ../../nfs4_types.h (charactertbl, cluttbl, shapetbl, DR_MODE, RECT). */
#ifndef FONT_EXTERNS_H
#define FONT_EXTERNS_H

/* glyph blitter function pointer: (x, y, fontPixmap, w, h, charactertbl*, tpage) -> void */
typedef void fn_void(int, int, void *, int, int, charactertbl *, int);

/* ---- font module state globals (SYM) ---- */
extern int       font_clutx;              /* 0x8013d854 */
extern int       font_cluty;              /* 0x8013d858 */
extern u_long    font_tint;               /* 0x8013d85c */
extern u_long    font_abr;                /* 0x8013d860 */
extern u_short   gFontClut;               /* 0x8013d864 */
extern u_char    gFontSpaceWidth;         /* 0x8013d866 */
extern u_short   font_currentTPage;       /* 0x8013d868 */
extern fn_void  *gCurrentBlitter;         /* 0x8013ddec  (PTR FCN VOID) */
extern cluttbl   shpfontclut;             /* 0x8011fdb0  (48 bytes) */
extern long      colourRGB[16];           /* 0x8011fd70  (ARY LONG, 64 bytes) */
extern u_char    currentfont[0xa0];       /* 0x80135ba0  (active font header buffer) */

/* ---- render packet/palette ring (shared) ---- */
extern char     *Render_gPacketPtr;
extern char     *Render_gPalettePtr;

/* ---- PsyQ libgpu ---- */

/* ---- game texture manager ---- */
extern void      Texture_GetClutId(int id, int *px, int *py);
extern void      Texture_MenuReleaseClutId(short id);
extern void      Texture_Vramf(shapetbl *s, int x, int y, int w, int h);

/* ---- eaclib (EACPSXZ) text/mem helpers ---- */
    /* read n-byte big-endian field */

#endif

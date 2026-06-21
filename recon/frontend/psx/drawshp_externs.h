/* frontend/psx/drawshp_externs.h - reconstructed extern decls (libgpu + PSXFront/mmeffect/
 * FETextRender game fns + render cursors). NOT an original header; for standalone C++ compile. */
#ifndef _FRONTEND_PSX_DRAWSHP_EXTERNS_H_
#define _FRONTEND_PSX_DRAWSHP_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern u_char *Render_gPacketPtr;    /* GPU packet build cursor (byte-arith) */
extern u_char *Render_gPalettePtr;   /* GPU packet build cursor (byte-arith) */
extern tTexture_ShapeInfo *gHelpShapes;   /* shape table (PSXFront) */

extern "C" {  /* PsyQ libgpu */
}

/* game-side C++ helpers (cfront-mangled in originals; normal C++ linkage) */
void FETextRender_MenuTextPositionedJustify(short id, short x, short y, short j,
                                            tMenuTextState st, tMenuTextType ty);
void DrawShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended *extra);
void PSXDrawSquare(int col, int x, int y, int w, int h);
void PSXDrawTransSquare(int col, int x, int y, int w, int h, short opacity);
void PSXDrawTransGouraudSquare(int x, int y, int w, int h, int opacity, int c1, int c2, int c3, int c4);
void FeDraw_SetABRMode(int abr);

#endif
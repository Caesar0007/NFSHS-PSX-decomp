/* drawshp.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_FRONTEND_PSX_DRAWSHP_TYPES_H
#define NFS4_FRONTEND_PSX_DRAWSHP_TYPES_H
#ifndef NFS4_FE_COLOR_LATE
#include "../../game/common/color_types.h"
#endif
/* Scratchpad render cursors are fixed-address lvalues, not owned globals. */
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

#include "drawshp_linef2.h"





#include "shared/POLY_G4.h"











#include "shared/kernpair.h"











#include "shared/tTexture_ShapeInfo.h"










#include "shared/tDrawShapeExtended.h"





/* The call ABI needs these enum identities only in the external symbol name;
 * drawshp.obj does not retain either completed enum definition. */
#include "shared/tMenuTextState.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */
#include "shared/tMenuTextType.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */



typedef kernpair KERN;
typedef int (*getcode)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

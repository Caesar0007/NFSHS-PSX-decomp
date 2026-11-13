/* mmeffect.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_FRONTEND_PSX_MMEFFECT_TYPES_H
#define NFS4_FRONTEND_PSX_MMEFFECT_TYPES_H
#ifndef NFS4_FE_COLOR_LATE
#include "../../game/common/color_types.h"
#endif
/* Scratchpad render cursors are fixed-address lvalues, not owned globals. */
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (header-truth 8a) */












#include "shared/kernpair.h"





#include "shared/tTexture_ShapeInfo.h"










struct tMenu;
struct tScreen;
struct tMenuCommand;
#include "shared/tActiveLine.h"
#include "shared/fe_menu_game_surface.h"

#include "shared/tShapeInformation.h"








/* this owner defines neither tPlayer nor tInputKeyType: the int spellings it always used */


#include "frontend/common/fescreen.h"









typedef kernpair KERN;
typedef int (*getcode)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

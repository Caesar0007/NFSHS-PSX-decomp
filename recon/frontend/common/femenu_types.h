#ifndef NFS4_FRONTEND_COMMON_FEMENU_TYPES_H   /* Owner-specific type surface for FEMenu.obj. */
#define NFS4_FRONTEND_COMMON_FEMENU_TYPES_H
#ifndef NFS4_FE_COLOR_LATE
#include "../../game/common/color_types.h"
#endif
#include "fe_input_enums.h"

struct tMenu;

#define NFS4_TMENUCOMMANDTYPE_DEFINED
#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (header-truth 8a) */












#include "shared/tMenuCommand.h"
#define NFS4_FE_CORE_CARS_LATE   /* retail FEMenu.obj: car tail last (fe_core_cars.h below) */
#define NFS4_FE_CORE_FEMENU_METHODS
#define NFS4_FE_CORE_TMENU_AFTER_ITEMS   /* tMenu comes after the item classes below */
#define NFS4_FE_CORE_FELINES_LATE   /* retail FEMenu: tTexture_ShapeInfo/kernpair after tScreen, not with the frontend core */
#define NFS4_FELINES_KERNPAIR_LATE
#include "fe_core_types.h"
#undef NFS4_FE_CORE_FEMENU_METHODS

#include "shared/POLY_F4.h"

#define NFS4_FE_CORE_FEMENU_METHODS
#define NFS4_FE_CORE_TMENU_KEY_TU   /* FEMenu.obj owns tMenu's virtuals */
#include "screendisplay_menuitems.h"   /* the shared FEMENU.H menu-item classes, then tMenu (NFS4_FE_CORE_TMENU_AFTER_ITEMS); no private copies (header-truth 4d) */



























#undef NFS4_FE_CORE_FEMENU_METHODS

/* retail FEMenu.obj order: tMenu, then tScreen and the dialog family (tMenu::fScreen sees tScreen incomplete) */
#include "felines_types.h"   /* retail: tTexture_ShapeInfo, tActiveLine, tShapeInformation, (tScreen), kernpair */
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
#include "fescreen.h"
#include "felines_kern.h"
#include "fedialog.h"

#include "feapp_class.h"   /* class tFEApplication (FEApp->DisplayHelp) */

/* FEMenu uses these enum values only as cross-TU arguments.  Its linked SYM
 * does not retain either foreign enum tag, so source-spelling macros plus the
 * exact linkage alias in femenu_externs.h preserve the call ABI without
 * inventing local type records. */
#include "shared/tMenuTextState.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */
#include "shared/tMenuTextType.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */


#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

/* Canonical PsyQ 4.3 LIBGPU primitive tag and macro expansion. */
typedef struct {
    unsigned addr : 24;
    unsigned len : 8;
    u_char r0, g0, b0, code;
} P_TAG;
#define getaddr(p) ((u_long)(((P_TAG *)(p))->addr))
#define setaddr(p, value) (((P_TAG *)(p))->addr = (u_long)(value))
#define addPrim(ot, p) setaddr((p), getaddr(ot)), setaddr((ot), (p))
#include "fe_core_cars.h"   /* retail: car types at the end of FEMenu.obj */
#endif

/* Owner-specific type surface for FECredits.obj. */
#ifndef NFS4_FRONTEND_COMMON_FECREDITS_TYPES_H
#define NFS4_FRONTEND_COMMON_FECREDITS_TYPES_H
#ifndef NFS4_FE_COLOR_LATE
#include "../../game/common/color_types.h"
#endif
#include "fe_core_types.h"

#define MIN(a,b) (((a) > (b)) ? (b) : (a))
#define MAX(a,b) (((a) > (b)) ? (a) : (b))

#include "screendisplay_menuitems.h"   /* the shared FEMENU.H menu-item classes (+ tMenu after them when keyed); no private copies (header-truth 4b) */










#include "../../game/common/draw_leaf_types.h"
#define NFS4_FELINES_KERNPAIR_LATE   /* retail FECredits: tTexture_ShapeInfo, tActiveLine, tShapeInformation, (tScreen), kernpair */
#include "felines_types.h"
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
struct tMenu;
#include "fescreen.h"
#include "felines_kern.h"
#include "shared/tDrawShapeExtended.h"
#include "fedialog.h"
#include "shared/tCredit.h"



#include "shared/tCreditManager.h"   /* one tCreditManager definition (header-truth 4t) */

















#include "shared/tTVState.h"





#include "shared/tTVConfig.h"

#include "shared/tScreenMainState.h"







#include "shared/tVideoTransition.h"
#include "shared/tVideo.h"
/* Compiler-layout carrier needed for field offsets; this foreign owner tag is
 * not retained by FECredits.obj's linked SYM. */
#include "screenmain.h"

#include "fe_core_cars.h"

#include "femenuextended_classes.h"   /* the FEMENUEXTENDED.H menu family: no private copies (header-truth 4p) */










#include "fecheats_cheatcode.h"   /* the real tCheatCode enum (was a macro fake; header-truth 4-C.2) */

#endif

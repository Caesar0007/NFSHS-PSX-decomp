/* Owner-specific type surface for ScreenPost.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENPOST_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENPOST_TYPES_H
#define NFS4_SCREENDISPLAY_FELINES_AFTER_LEAF   /* retail ScreenPost: core + draw leaf, then tTexture_ShapeInfo (after Draw_PrimStruct) */
#define NFS4_FE_CORE_FELINES_AT_LEAF   /* felines only at the after-leaf site (fe_core_types.h skips its early include) */
#define NFS4_SCREENDISPLAY_SCREEN_AFTER_ACTIVELINE   /* retail: tActiveLine, tShapeInformation, tScreen consecutive */
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: tListIteratorCar/CarColor after tCarManager, tListIteratorTrack after tTrackManager */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType after tOwnedCarInfo (INV-B fe_core_cars hook) */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup after tPersonalities (INV-B fe_core_cars hook) */
#define NFS4_CORE_CCOORD16   /* retail: MATRIX core first, then the frontend core, then PCOORD16..Draw_* */
#define NFS4_DRAW_LEAF_CORE_ONLY
#include "../../game/common/draw_leaf_types.h"
#include "fe_player_types.h"
#define NFS4_FE_INPUT_NO_PLAYER   /* retail ScreenPost: tPlayer, tInputKeyType, then tMenuCommandType */
#include "fe_input_enums.h"
#undef NFS4_FE_INPUT_NO_PLAYER
struct tMenu;
#define NFS4_TMENUCOMMANDTYPE_DEFINED
#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (header-truth 8a) */











#include "shared/tMenuCommand.h"
#define NFS4_FE_COLOR_LATE
#define NFS4_SCREENDISPLAY_COLOR_BEFORE_CARS
/* physadr: the complete SDK type (retail size 4) */
#define NFS4_SCREENMEMCARD_SCREENPOST_SURFACE
#define NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
#define NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE "screentournselect_types.h"   /* retail: standings classes right after tShapeInformation (INV-B pass) */
#include "screentournselect_types.h"
#undef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
#undef NFS4_SCREENMEMCARD_SCREENPOST_SURFACE
/* The linked SYM keeps the public array typedef but attributes the completed
 * element body elsewhere.  CC1PL requires the exact 20-byte body to form it. */
#include "shared/tRecordBuffer.h"
typedef tRecordBuffer tSaveRecords[187];
#endif

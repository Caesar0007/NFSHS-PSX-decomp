#define NFS4_TU_FRONT   /* owner identity (shared/tpdef_keys.h) */
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: list iterators right after tCarManager / tTrackManager */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_SCREENDISPLAY_CARS_AFTER_SCREEN   /* retail: car graph right after tScreen (screendisplay_types.h) */
#define NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS   /* retail: car graph early, track/tournament graph after the menu family (screendisplay_carblock.h) */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_SCREENDISPLAY_COLOR_BEFORE_CARS   /* color.obj graph before the car/track graph (screendisplay_types.h) */
#define NFS4_SCREENDISPLAY_DIALOGS_NO_DSE   /* no tDrawShapeExtended in this graph */
#define NFS4_SCREENDISPLAY_DIALOGS_EARLY   /* retail: dialogs before the car/track graph (screendisplay_types.h) */
#define NFS4_CORE_PADS_FIRST   /* retail type order (nfs4_types.h) */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_FE_CORE_CARS_SAVEINFO   /* retail: tSaveCarInfo right after tOwnedCarInfo */
#define NFS4_FE_TRACK_SAVEINFO   /* retail: tSaveTrackInfo / tSaveTournament inside the track graph */
#define NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE "fe3d_leaf.h"   /* retail: FE3d records right after tActiveLine/tShapeInformation */
#define NFS4_CORE_CCOORD16   /* retail: CCOORD16 right after COORD16 */
#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* census: retail records every tMenu/tMenuItem inline member (fe_core_tmenu.h) */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType after tOwnedCarInfo */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup before tfrontEnd */
#include "felines_types.h"   /* retail Front: pads, MATRIX core, draw leaf, tTexture_ShapeInfo, kernpair, then the frontend core */
#include "front_types.h"
#include "front_externs.h"

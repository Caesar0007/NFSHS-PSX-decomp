#define NFS4_TU_FEMENUDEFS   /* owner identity (shared/tpdef_keys.h) */
#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* census: retail records every tMenu/tMenuItem inline member (fe_core_tmenu.h) */
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: list iterators right after tCarManager / tTrackManager */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_SCREENDISPLAY_CARS_AFTER_MENUS   /* retail: tMenuNFS4/options family before the car/track graph (screendisplay_carblock.h) */
#define NFS4_CORE_PADS_EARLY   /* retail: controller pads before linedef (nfs4_types.h) */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail core place (color_types.h does the same) */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* draw_leaf phase 1 only; screendisplay_types.h emits PCOORD16 .. Draw_* after tScreen */
#define NFS4_FE_CORE_CARS_SAVEINFO   /* retail: tSaveCarInfo / tCarClassType after tOwnedCarInfo, tCarLineup after tPersonalities */
#define NFS4_FE_CORE_CARS_CLASSTYPE
#define NFS4_FE_CORE_CARS_LINEUP
#define NFS4_FE_TRACK_SAVEINFO   /* retail: tSaveTrackInfo / tSaveTournament inside the track graph */
#define NFS4_SCREENDISPLAY_ITERS_CARS_CHAIN "fe_track_types.h"   /* retail FEMenuDefs: the track graph right after the car iterators */
#define NFS4_SCREENDISPLAY_HOOK_AFTER_VIDEO "femenudefs_after_video.h"   /* retail: tGlobalMenuDefs + memory-card records right after tVideo */
#define NFS4_SCREENCARSELECT_TAIL_HOOK_AFTER_COLOR "femenudefs_mission.h"   /* retail: mission records right after Car_tObj */
#define NFS4_SCREENCARSELECT_HOOK_AFTER_STANDINGS "femenudefs_tail.h"   /* retail: FE3d .. tScreenUserName between the standings and the congrats classes */
#define NFS4_CORE_LINEDEF_LATE   /* retail: pads, linedef, SHAPETABLEENTRY after tActiveLine (nfs4_types.h / game_common_min_types.h skip them) */
#define NFS4_SCREENDISPLAY_HOOK_BEFORE_LEAF2 "femenudefs_core_late.h"   /* retail: tActiveLine, pads, linedef, SHAPETABLEENTRY right after tScreen */
#define NFS4_FE_CORE_FELINES_LATE   /* retail: tTexture_ShapeInfo/kernpair after the menu items, not with the frontend core */
#define NFS4_SCREENDISPLAY_SCREEN_AFTER_TOURNAMENT   /* retail: tShapeInformation + tScreen definition after tListIteratorTournament */
#include "../../game/common/draw_leaf_types.h"
#include "femenudefs_types.h"
#include "../../game/common/color_types.h"
#include "femenudefs_externs.h"

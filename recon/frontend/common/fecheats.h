#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: full tMenu/tMenuItem inline-member sets */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail FECheats: tCarClassType right after tOwnedCarInfo */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail FECheats: tfrontEnd right after tCarLineup */
#define NFS4_FECHEATS_TCHEAT_IN_CPP   /* retail FECheats: tCheat is the object's LAST tag (after Car_tObj): defined in fecheats.cpp */
#define NFS4_FECHEATS_OWNER   /* FECheats.obj itself (fememcard also includes fecheats_types.h) */
#define NFS4_FE_TRACK_NO_PLAYER
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "fecheats_tracks_hook.h"   /* retail FECheats: tTrackClassType/tTrackInformation/tTrackManager right after tCarManager */
#define NFS4_FE_CORE_TMENUCOMMAND_EARLY   /* retail: tMenu forward copy right after tMenuCommandType (fe_core_types.h) */
#include "fecheats_cheatcode.h"   /* retail: tCheatCode first */
#define NFS4_CORE_PADS_EARLY   /* retail: controller pads before linedef (nfs4_types.h) */
#define NFS4_FE_LIST_NO_RANGE_INDEXED   /* retail fecheats object: tListIterator, Indexed, Range */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail core place (color_types.h does the same) */
#include "../../game/common/draw_leaf_types.h"
#include "fecheats_types.h"
#include "../../game/common/color_types.h"
#include "fecheats_externs.h"

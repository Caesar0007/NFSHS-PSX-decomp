#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: full tMenu/tMenuItem inline-member sets */
#ifndef NFS4_FRONTEND_COMMON_SCREENTRACKRECORDS_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTRACKRECORDS_TYPES_H   /* Owner-specific type surface for ScreenTrackRecords.obj. */
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: tListIteratorCar/CarColor after tCarManager, tListIteratorTrack after tTrackManager */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screentrackrecords_after_track.h"   /* retail: iterators, tMenuTextState, FLARE_PIECE_DEF after tTrackManager */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType after tOwnedCarInfo (INV-B fe_core_cars hook) */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup after tPersonalities (INV-B fe_core_cars hook) */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail core place (color_types.h does the same) */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* draw_leaf phase 1 only; screendisplay_types.h emits PCOORD16 .. Draw_* after tScreen */
#include "../../game/common/draw_leaf_types.h"
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_FE_CORE_FELINES_LATE   /* retail: MATRIX core, FE menu core, PCOORD16..Draw_*, then tTexture_ShapeInfo.. */
#define NFS4_FE_CORE_CARS_LATE
#include "fe_core_types.h"
#include "screendisplay_menuitems.h"   /* retail: the three menu items right after tMenuItemInteractive */
#undef NFS4_DRAW_LEAF_CORE_ONLY
#include "../../game/common/draw_leaf_types.h"
#include "shared/tTexture_ShapeInfo.h"   /* retail: tTexture_ShapeInfo, tActiveLine, tShapeInformation, tScreen, FE3d, kernpair */
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
struct tMenu; struct tDrawShapeExtended;
#include "fescreen.h"
typedef COORD16 FE3d_zVertex;
typedef CVECTOR FE3d_zColor;
typedef SVECTOR FE3d_zNormal;
#include "shared/FE3d_zUV.h"
#include "shared/FE3d_zFacet.h"
#include "shared/FE3d_zObj.h"
#include "felines_types.h"   /* kernpair/KERN + font typedefs after FE3d (retail) */
#define NFS4_FE3D_TYPES_DONE
#include "shared/tDrawShapeExtended.h"
#define NFS4_SCREENDISPLAY_CARS_AFTER_MENUS   /* retail: menu family, owner records, tracks, then the car graph */
#define NFS4_SCREENDISPLAY_OWNER_BEFORE_CARS "screentrackrecords_types.h"   /* second pass below */
/* Reuse the exact shared render/frontend graph while excluding input enums,
 * songs, saved-game and memory-card records, and dialogs. */
#define NFS4_SCREENMEMCARD_FEAPP_SURFACE
#define NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE
#include "screenmemcard_types.h"
#undef NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE
#undef NFS4_SCREENMEMCARD_FEAPP_SURFACE
#include "../../game/common/color_types.h"   /* NFS4_FE_COLOR_LATE: color.obj graph after the frontend graph */
#elif !defined(NFS4_SCREENTRACKRECORDS_OWNER_DONE)   /* second pass (screendisplay owner hook) */
#define NFS4_SCREENTRACKRECORDS_OWNER_DONE
/* These foreign enum tags are absent from this owner graph. */
/* tMenuTextState: emitted after tListIteratorTrack (screentrackrecords_after_track.h, retail order) */





#include "shared/tMenuTextType.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */

#include "shared/FLARE_PIECE_DEF.h"




struct tRecordBuffer;

#include "screentrackrecords.h"

/* SYM completes this record after tScreenTrackRecords. */
#include "shared/tRecordBuffer.h"



typedef tRecordBuffer tSaveRecords[187];
#define NFS4_FE_TRACK_NO_PLAYER   /* retail: tracks right after tRecordBuffer, before the car graph */
#include "fe_track_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER

#endif

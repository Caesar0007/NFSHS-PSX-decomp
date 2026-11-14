#define NFS4_FE_CORE_TMENUCOMMAND_EARLY   /* retail: tMenu forward copy right after tMenuCommandType (fe_core_types.h) */
#define NFS4_FE_CORE_TMENU_AFTER_ITEMS   /* retail: tMenu (+ tScreen forward copy) after tMenuItemGoToMenuButton (screendisplay_menuitems.h) */
/* Owner-specific type surface for ScreenTrophyRoom.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENTROPHYROOM_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTROPHYROOM_TYPES_H
#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: the full tMenu/tMenuItem inline-member sets (TPDEF x16 in every frontend object) */
#define NFS4_FELINES_KERNPAIR_LATE   /* kernpair emitted by screentrophyroom.h after tScreenTrophyRoom */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType after tOwnedCarInfo (INV-B fe_core_cars hook) */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup after tPersonalities (INV-B fe_core_cars hook) */
#define NFS4_CORE_CCOORD16   /* retail: MATRIX core, PCOORD16..pads, input enums, tMenuCommand*, FE menu core, Draw_* */
#include "../../game/common/draw_leaf_core.h"
#if !defined(NFS4_DRAW_LEAF_CORE_ONLY) && !defined(NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H)   /* this object lists the draw leaf itself (retail record order) */
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H
#include "../../game/common/draw_leaf_a_pads.h"
#include "../../frontend/common/screentrophyroom_types.h"   /* own types at this point */
#include "../../game/common/draw_leaf_b_pixmap.h"
#include "../../game/common/draw_leaf_c_cache.h"
#include "../../game/common/draw_leaf_d_carvertex.h"
#endif
#include "../../game/common/draw_leaf_types.h"
#include "felines_types.h"
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
#define NFS4_FE_COLOR_LATE
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"   /* iterators, then (chain) color + AudioMus */
#define NFS4_SCREENDISPLAY_ITERS_CARS_CHAIN "screentrophyroom_types.h"
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: tListIteratorCar/CarColor after tCarManager, tListIteratorTrack after tTrackManager */
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"



#include "shared/tMenuTextState.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */

#include "shared/tMenuTextType.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */


#include "fescreen.h"
#include "screentrophyroom.h"
#include "shared/tDrawShapeExtended.h"
/* Reuse the exact shared graph while excluding memory-card, saved-game,
 * FE3d, and dialog-only records.  AudioMus_tSongEntry remains present. */
#define NFS4_SCREENMEMCARD_FEAPP_SURFACE
#define NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE
#include "screenmemcard_types.h"
#undef NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE
#undef NFS4_SCREENMEMCARD_FEAPP_SURFACE
/* Foreign enum tags absent from this owner remain source constants. */
/* Remaining foreign menu view needs owning-SYM source restoration. */
struct tGlobalMenuDefs;   /* incomplete here: owner object records it; members reached by offset */
#elif defined(NFS4_FE_CORE_CARS_IN_HOOK) && !defined(NFS4_SCREENTROPHYROOM_CARS_DONE)   /* fe_core_cars hook */
#define NFS4_SCREENTROPHYROOM_CARS_DONE
#include "../../game/common/color_types.h"
#include "shared/AudioMus_tSongEntry.h"
#elif !defined(NFS4_SCREENTROPHYROOM_PADS_DONE)   /* second pass (draw_leaf hook after the pads) */
#define NFS4_SCREENTROPHYROOM_PADS_DONE
#include "fe_input_enums.h"
struct tMenu;
#define NFS4_TMENUCOMMANDTYPE_DEFINED
#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (header-truth 8a) */











#include "shared/tMenuCommand.h"
#define NFS4_FE_CORE_FELINES_LATE
#define NFS4_FE_CORE_CARS_LATE
#include "fe_core_types.h"
#include "screendisplay_menuitems.h"   /* retail: the three menu items right after tMenuItemInteractive */
#endif

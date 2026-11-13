#if !defined(NFS4_FRONTEND_COMMON_SCREENDISPLAY_TYPES_H) || defined(NFS4_SCREENDISPLAY_IN_MENUS_PASS)   /* the second entry = the MENUS_LATE pass (lines from the menu family on) */
#define NFS4_FRONTEND_COMMON_SCREENDISPLAY_TYPES_H   /* Owner-specific type surface for ScreenDisplay.obj. */
#if !defined(NFS4_TYPES_H) && !defined(_FE_SCREENS_FEMENUOPTIONS_H_) && !defined(NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE) && !defined(NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE) && !(defined(NFS4_FRONTEND_COMMON_FEDIALOG_TYPES_H) && !defined(NFS4_SCREENDISPLAY_CARS_AFTER_SCREEN))   /* owners reaching this graph before the platform core (screendisplay, screenusername, screencongrats, screencontroller, front, screenmain); measured worse elsewhere */
#include "screendisplay_keys.h"
#endif
#define NFS4_FE_CORE_CARS_LATE   /* retail: car/track graph after the screen records (fe_core_cars.h below) */
#include "fe_core_types.h"
#ifndef NFS4_SCREENDISPLAY_IN_MENUS_PASS
#include "screendisplay_menuitems.h"   /* tMenuItemLeftRightChoice / Slider / GoToMenuButton (an owner may include it earlier: retail right after tMenuItemInteractive) */
#ifdef NFS4_SCREENDISPLAY_HOOK_AFTER_MENUITEMS   /* owner records right after tMenuItemGoToMenuButton (retail femenuextended/fecheats: tActiveLine) */
#include NFS4_SCREENDISPLAY_HOOK_AFTER_MENUITEMS
#endif
#ifndef NFS4_SCREENDISPLAY_FELINES_AFTER_LEAF
#include "felines_types.h"   /* no-op unless NFS4_FE_CORE_FELINES_LATE (fe core emitted before the core types) */
#endif
#if !defined(NFS4_SCREENDISPLAY_SCREEN_AFTER_ACTIVELINE) && !defined(NFS4_SCREENDISPLAY_SCREEN_AFTER_TOURNAMENT)   /* else: tActiveLine, tShapeInformation, tScreen consecutive (retail), below */
#include "shared/tShapeInformation.h"
#endif
#include "fescreen_virtual_types.h"
struct tMenu; struct tDrawShapeExtended;
#if !defined(NFS4_SCREENDISPLAY_SCREEN_AFTER_ACTIVELINE) && !defined(NFS4_SCREENDISPLAY_SCREEN_AFTER_TOURNAMENT)
#include "fescreen.h"
#endif
#ifdef NFS4_SCREENDISPLAY_HOOK_BEFORE_LEAF2   /* owner records between tScreen (fescreen.h) and draw_leaf phase 2 (FEMenuDefs: tActiveLine, pads, linedef) */
#include NFS4_SCREENDISPLAY_HOOK_BEFORE_LEAF2
#endif
#undef NFS4_DRAW_LEAF_CORE_ONLY   /* draw_leaf phase 2 here: retail PCOORD16 .. Draw_* right after tScreen */
#include "../../game/common/draw_leaf_types.h"
#ifdef NFS4_SCREENDISPLAY_FELINES_AFTER_LEAF   /* retail screenmain group: core + draw leaf, then tTexture_ShapeInfo (felines_types.h) */
#include "felines_types.h"   /* no-op unless NFS4_FE_CORE_FELINES_LATE (fe core emitted before the core types) */
#endif
#ifdef NFS4_SCREENDISPLAY_CARS_AFTER_SCREEN   /* retail front: car graph right after tScreen, before tActiveLine */
#include "screendisplay_carblock.h"
#endif
#ifdef NFS4_SCREENDISPLAY_HOOK_BEFORE_ACTIVELINE   /* owner records between the car tail (CARS_AFTER_SCREEN) and tActiveLine (Front: tFront_ProcessingType) */
#include NFS4_SCREENDISPLAY_HOOK_BEFORE_ACTIVELINE
#endif
#include "shared/tActiveLine.h"
#ifdef NFS4_SCREENDISPLAY_SCREEN_AFTER_ACTIVELINE
#include "shared/tShapeInformation.h"
#include "fescreen.h"
#endif
#ifdef NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE   /* owner records right after tActiveLine (screenpost) */
#include NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE
#endif
#ifndef NFS4_SCREENDISPLAY_NO_OWNER_RECORDS
#include "screendisplay.h"
#endif
#ifdef NFS4_SCREENDISPLAY_DIALOGS_EARLY   /* retail: kernpair/tDrawShapeExtended + dialogs before the car/track graph */
#ifndef NFS4_SCREENDISPLAY_DIALOGS_NO_DSE   /* FEDialog/Front graphs have no tDrawShapeExtended */
#include "shared/tDrawShapeExtended.h"
#endif
#include "fedialog.h"
#ifdef NFS4_SCREENDISPLAY_HOOK_AFTER_EARLY_DIALOGS   /* owner records right after the early dialogs (retail screentracks/screenpinkslips/screenmain: tFEApplication after tDialogYesNo) */
#include NFS4_SCREENDISPLAY_HOOK_AFTER_EARLY_DIALOGS
#endif
#endif
#ifdef NFS4_SCREENDISPLAY_COLOR_BEFORE_CARS   /* retail (pinkslips/tracks): color.obj graph before the car/track graph */
#include "../../game/common/color_types.h"
#endif
#ifdef NFS4_SCREENDISPLAY_HOOK_AFTER_COLOR   /* owner records right after the early color.obj graph (ScreenController: tScreenControllerConfig) */
#define NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR
#include NFS4_SCREENDISPLAY_HOOK_AFTER_COLOR
#undef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR
#endif
#if !defined(NFS4_SCREENDISPLAY_CARS_AFTER_MENUS) && !defined(NFS4_SCREENDISPLAY_CARS_AFTER_SCREEN)   /* else emitted later (after the menu family) or earlier (after tScreen) */
#include "screendisplay_carblock.h"
#endif
#ifdef NFS4_SCREENDISPLAY_COLOR_AFTER_CARS   /* retail (screencongrats): color.obj graph right after the car graph */
#include "../../game/common/color_types.h"
#endif
#ifdef NFS4_SCREENDISPLAY_HOOK_AFTER_CARCOLOR   /* owner records between the color graph (COLOR_AFTER_CARS) and the track part (ScreenCongrats) */
#define NFS4_SCREENDISPLAY_IN_HOOK_AFTER_CARCOLOR
#include NFS4_SCREENDISPLAY_HOOK_AFTER_CARCOLOR
#undef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_CARCOLOR
#endif
#ifdef NFS4_SCREENDISPLAY_TRACKS_AFTER_COLOR   /* with TRACKS_AFTER_MENUS: the carblock track part right here */
#include "screendisplay_carblock.h"
#endif





































































































#endif
#undef NFS4_FE_CORE_CARS_LATE   /* Track/tournament records are retained without the foreign tPlayer enum or their member-method surfaces in this owner.  The track surface also owns the retail tListIteratorIndexed record used below. */
#if !defined(NFS4_SCREENDISPLAY_MENUS_LATE) || defined(NFS4_SCREENDISPLAY_IN_MENUS_PASS)   /* MENUS_LATE (ScreenCongrats): this part only in the pass from screencarselect_tail.h */

#ifdef NFS4_SCREENDISPLAY_HOOK_BEFORE_NFS4MENU   /* owner records between the car/track block and the tMenuNFS4 family */
#include NFS4_SCREENDISPLAY_HOOK_BEFORE_NFS4MENU
#endif
#include "femenuextended_classes.h"   /* the FEMENUEXTENDED.H menu family (one definition) */






















































































































#include "femenuoptions_classes.h"   /* the FEMENUOPTIONS.H menu family (one definition) */
























































































































































#ifdef NFS4_SCREENDISPLAY_OWNER_BEFORE_CARS   /* owner records after the menu family, before the car graph */
#include NFS4_SCREENDISPLAY_OWNER_BEFORE_CARS
#endif
#include "screendisplay_carblock.h"   /* NFS4_SCREENDISPLAY_CARS_AFTER_MENUS site (no-op otherwise: guarded) */
#ifndef NFS4_SCREENDISPLAY_TV_LATE   /* else after the dialogs (late site below) */
#include "shared/tTVState.h"   /* the enum (owners with an earlier mission/TV block include it before) */
#endif
#ifdef NFS4_SCREENDISPLAY_COLOR_AFTER_MENUCARS   /* retail FeMenuOptions: color.obj graph after the late car block */
#include "../../game/common/color_types.h"
#endif
#ifndef NFS4_SCREENDISPLAY_TV_LATE
#include "shared/tTVConfig.h"
#endif









#include "fedialog.h"
#ifdef NFS4_SCREENDISPLAY_FEDIALOG_METHODS   /* FEDialog.obj: retail order is Base, Help, MessageString, ... */
#endif
#ifdef NFS4_SCREENDISPLAY_FEDIALOG_METHODS   /* ..., MessageString, BackUpOnly, NoInputMessage, Interactive, ... */
#endif
#ifdef NFS4_SCREENDISPLAY_HOOK_AFTER_DIALOGS   /* owner records right after the dialogs (FeMenuOptions: tFEApplication) */
#define NFS4_SCREENDISPLAY_IN_HOOK_AFTER_DIALOGS
#include NFS4_SCREENDISPLAY_HOOK_AFTER_DIALOGS
#undef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_DIALOGS
#endif
#ifdef NFS4_SCREENDISPLAY_TV_LATE   /* retail FeMenuOptions: track/tournament part + TV after the dialogs */
#include "screendisplay_carblock.h"
#include "shared/tTVState.h"
#include "shared/tTVConfig.h"
#endif
#include "shared/tCredit.h"



#include "screenmain_state.h"   /* tScreenMainState (moved verbatim; ScreenMain emits it early) */







#include "shared/tVideoTransition.h"








#include "shared/tVideo.h"
#ifdef NFS4_SCREENDISPLAY_AUDIOMUS_AFTER_VIDEO   /* retail FeMenuOptions: AudioMus song records right after tVideo */
#include "shared/AudioMus_tSongEntry.h"
#include "shared/AudioMus_tSongList.h"
#endif
#ifdef NFS4_SCREENDISPLAY_HOOK_AFTER_VIDEO   /* owner records right after tVideo (FEApp: color.obj graph, AudioMus, SND*) */
#include NFS4_SCREENDISPLAY_HOOK_AFTER_VIDEO
#endif
#ifndef NFS4_SCREENDISPLAY_NO_OWNER_RECORDS
/* Only this offset is used by ScreenDisplay.  The real aggregate owner is
 * reconstructed in FEMenuDefs; keep this compiler-boundary view explicit. */
struct tGlobalMenuDefs;   /* incomplete here: owner object records it; members reached by offset */
#endif

struct SndBnk_t;
struct SPEECHINFO;
#endif
#endif

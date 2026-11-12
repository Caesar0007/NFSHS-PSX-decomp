#if !defined(NFS4_FRONTEND_COMMON_FEMENUOPTIONS_TYPES_H) || defined(NFS4_SCREENDISPLAY_IN_HOOK_AFTER_DIALOGS)
#ifndef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_DIALOGS   /* else: the screendisplay_types.h after-dialogs hook pass (tFEApplication only) */
#define NFS4_FRONTEND_COMMON_FEMENUOPTIONS_TYPES_H   /* Owner-specific type surface for FeMenuOptions.obj. */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* draw_leaf phase 1 only; screendisplay_types.h emits PCOORD16 .. Draw_* after tScreen */
#define NFS4_FE_CORE_FELINES_LATE   /* retail FeMenuOptions: frontend core before the MATRIX core (fe_core_types.h) */
#define NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS   /* retail FeMenuOptions: track/tournament graph after the menu family */
#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* census: retail records every tMenu/tMenuItem inline member (fe_core_tmenu.h) */
#define NFS4_FEMENUOPTIONS_OWNER   /* screendisplay_types.h: tOptionsMenu / tInsideBoxMenu inline copies LINK_STRIPPED */
#define NFS4_SCREENDISPLAY_HOOK_AFTER_DIALOGS "femenuoptions_types.h"   /* retail FeMenuOptions: tFEApplication right after the dialogs */
#include "fe_input_enums.h"   /* retail FeMenuOptions: tPlayer, tInputKeyType before tMenuCommandType */
#define NFS4_TMENUCOMMANDTYPE_DEFINED
enum tMenuCommandType {
    kMenu_Command_None = 0,
    kMenu_Command_GoToMenu = 1,
    kMenu_Command_GoToMenuOneWay = 2,
    kMenu_Command_GoToMenuTwoPlayer = 3,
    kMenu_Command_BackupMenu = 4,
    kMenu_Command_StartRace = 5,
    kMenu_Command_Start2PlayerRace = 6,
    kMenu_Command_ReStartRace = 7,
    kMenu_Command_StartReplay = 8,
    kMenu_Command_ClearRecords = 9
}; struct tMenu;
#include "shared/tMenuCommand.h"
#include "../../link_stripped.h"
/* physadr: the complete SDK type (retail size 4) */
#define NFS4_FEMENUOPTIONS_SURFACE
#define NFS4_FE_CORE_FEMENU_METHODS
#define NFS4_SCREENCONTROLLER_RESETSHAKE_INLINE   /* tScreenControllerConfig `this` pair in the slider ProcessInput */
#define NFS4_FE_CORE_MENUITEM_SETENABLED   /* tMenuItem::Enable()/Disable() -- retail's tMenuItem `this` pairs */
#define NFS4_FE_LIST_RANGE_INLINE   /* tListIterator range accessors -- retail's tListIterator `this` pairs */
#include "screencontroller_types.h"
#undef NFS4_FE_CORE_FEMENU_METHODS
#undef NFS4_FEMENUOPTIONS_SURFACE
/* Replace ScreenController's narrow foreign views with the records and exact
 * member slices required by FeMenuOptions. */
#undef tFEApplication
#undef tGlobalMenuDefs
/* These enum tags are not retained by FeMenuOptions.obj. */
#define tMenuTextState int
#define textState_Unselected 0
#define textState_Selected 1
#define textState_Hilighted 2
#define tMenuTextType int
#define textType_Options 6
#include "shared/DR_AREA.h"
#include "shared/POLY_G4.h"
#include "shared/AudioMus_tSongEntry.h"
#include "shared/AudioMus_tSongList.h"
/* The linked owner retains this public array typedef while attributing the
 * already-seen element body elsewhere. */
#include "shared/tRecordBuffer.h"

typedef tRecordBuffer tSaveRecords[187];
#endif
#ifndef NFS4_FEMENUOPTIONS_FEAPP_DONE
#include "feapp_class.h"   /* class tFEApplication: no private copy (header-truth 4j) */

























#define NFS4_FEMENUOPTIONS_FEAPP_DONE
#endif
#ifndef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_DIALOGS
#include "screenaudio.h"   /* the real tScreenAudio (no codegen view; header-truth 4-B.3) */







#include "femenudefs_globalmenudefs.h"   /* the real tGlobalMenuDefs (no codegen view; header-truth 4-B.2) */




#line 204 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
static inline void _femenuoptions_dtor_fade(tMenuItemLeftRightFade *p) { p->~tMenuItemLeftRightFade(); }
#line 404 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
static inline void _femenuoptions_dtor_btnfade(tMenuItemGoToMenuButtonFade *p) { p->~tMenuItemGoToMenuButtonFade(); }
#line 93 "recon/frontend/common/femenuoptions_types.h"
#endif

#endif

/* Owner-specific type surface for FEApp.obj. */
#if !defined(NFS4_FRONTEND_COMMON_FEAPP_TYPES_H) || defined(NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR)
#ifndef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR   /* else: the screendisplay_types.h after-color/after-dialogs hook pass (tAppCommand, tFEApplication) */
#define NFS4_FRONTEND_COMMON_FEAPP_TYPES_H
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_SCREENDISPLAY_HOOK_AFTER_COLOR "feapp_types.h"   /* retail FEApp: tAppCommand + tFEApplication right after the dialogs */
#define NFS4_SCREENDISPLAY_HOOK_AFTER_VIDEO "feapp_after_video.h"   /* retail: color.obj graph, AudioMus, SND* after tVideo */
#define NFS4_SCREENDISPLAY_ITERS_CARS_CHAIN "fe_track_types.h"   /* retail FEApp: the track graph right after the car iterators */
#define NFS4_FE_CORE_CARS_SAVEINFO   /* retail: tSaveCarInfo / tCarClassType after tOwnedCarInfo, tCarLineup after tPersonalities */
#define NFS4_FE_CORE_CARS_CLASSTYPE
#define NFS4_FE_CORE_CARS_LINEUP
#define NFS4_FE_TRACK_SAVEINFO   /* retail: tSaveTrackInfo / tSaveTournament inside the track graph */
#include "fe_input_enums.h"   /* retail FEApp: tInputKeyType before tMenuCommandType */
/* FEApp.obj emits tMenuCommand while tMenu is still opaque. */
struct tMenu;
#define NFS4_TMENUCOMMANDTYPE_DEFINED
#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (header-truth 8a) */











#include "shared/tMenuCommand.h"
#define NFS4_SCREENMEMCARD_FEAPP_SURFACE
#define NFS4_SCREENDISPLAY_FEDIALOG_METHODS
#include "screenmemcard_types.h"
#undef NFS4_SCREENDISPLAY_FEDIALOG_METHODS
#undef NFS4_SCREENMEMCARD_FEAPP_SURFACE
#include "shared/tMenuTextType.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */
#include "shared/tMenuTextState.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */



#define RaceType_SingleRace 0
#define RaceType_PinkSlips 6
#define PinkSlipsNoError 0
#include "shared/DR_AREA.h"
#include "shared/SNDSYSCAP.h"
#include "shared/SNDSYSSET.h"
#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"
#endif
#ifdef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR
#include "shared/tAppCommand.h"




#endif

#ifndef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR
#include "cls_tScreenTournamentStandings.h"   /* class tScreenTournamentStandings: no private copy (header-truth 4v) */














#include "cls_tScreenTournamentStandings3item.h"   /* class tScreenTournamentStandings3item: no private copy (header-truth 4v) */




#include "cls_tScreenUserName.h"   /* class tScreenUserName: no private copy (header-truth 4v) */












#else
#include "feapp_class.h"   /* class tFEApplication (shared with every includer) */






































#endif
#ifndef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR

/* GameSetup_tData is recorded only in its owners (gmesetup/replay); FEApp keeps it
 * incomplete and stores GameSetup_gData.replayMode (int @0x24) through int*.
 * The tGlobalMenuDefs view below is an unresolved source model (removing it costs
 * the 2nd TPDEF tMenuItemGoToMenuNFS4Button its field re-emission supplies). */
struct GameSetup_tData;



#include "femenudefs_globalmenudefs.h"   /* the real tGlobalMenuDefs (no codegen view; header-truth 4-B.2) */













#endif
#endif

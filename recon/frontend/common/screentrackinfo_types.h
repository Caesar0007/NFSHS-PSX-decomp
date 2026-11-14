#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* Owner-specific type surface for ScreenTrackInfo.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENTRACKINFO_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTRACKINFO_TYPES_H
#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE
#include "fe_input_enums.h"
#define NFS4_TMENUCOMMANDTYPE_DEFINED
#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (was a reduced enumerator list; header-truth 8a) */




struct tMenu;
#include "shared/tMenuCommand.h"
#endif
#define NFS4_FE_CORE_FELINES_LATE   /* retail ScreenTrackInfo: frontend core + menu items before the MATRIX core */
#define NFS4_FE_CORE_CARS_LATE   /* retail: car/track/tournament records after tShapeInformation/tActiveLine */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType right after tOwnedCarInfo (fe_core_cars.h) */
#include "fe_core_types.h"
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup before tfrontEnd (fe_core_cars.h) */
#include "shared/tMenuTextState.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */
#include "shared/tMenuTextType.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */





#include "screendisplay_menuitems.h"   /* the shared FEMENU.H menu-item classes (+ tMenu after them when keyed); no private copies (header-truth 4c) */































#undef NFS4_DRAW_LEAF_CORE_ONLY   /* ScreenAudio: draw_leaf phase 2 (PCOORD16 .. Draw_*) after the menu core */
#define NFS4_FELINES_KERNPAIR_LATE   /* retail: tTexture_ShapeInfo, tActiveLine, tShapeInformation, then kernpair */
#include "felines_types.h"
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
#include "fescreen.h"
#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE   /* ScreenAudio keeps TV after the tournament records */
#include "felines_kern.h"
#include "shared/tTVState.h"   /* retail: TV after kernpair, before the cars */
#include "shared/tTVConfig.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"   /* retail: tListIteratorTrack right after tTrackManager */
#else   /* ScreenAudio: retail AudioMus + tScreenAudio right after tShapeInformation/tActiveLine */
#include "shared/AudioMus_tSongEntry.h"
#include "shared/AudioMus_tSongList.h"
#include "screenaudio.h"
#include "felines_kern.h"   /* retail ScreenAudio: kernpair right after tScreenAudio */
#endif
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"   /* retail: tListIteratorCar/Color right after tCarManager */
#include "fe_core_cars.h"
#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE   /* ScreenAudio: track/tournament records after its menu family (below) */
#define NFS4_FE_TRACK_NO_PLAYER   /* track/tournament records without an extra player surface */
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
#endif









#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE
#include "fetourn_manager_class.h"   /* class tTournamentManager: one definition (header-truth 4l) */































#include "felist_tournament_iter.h"   /* tListIteratorTournament: one definition (header-truth 4s) */


#endif

#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE   /* retail: tVideoWall + tScreenTrackInfo before the tMenuNFS4 family */
#include "shared/tVideoWall.h"   /* one tVideoWall definition (header-truth 4t) */





#include "screentrackinfo.h"
#endif
#include "femenuextended_classes.h"   /* the FEMENUEXTENDED.H menu family: no private copies (header-truth 4q) */































































#include "femenuoptions_classes.h"   /* the FEMENUOPTIONS.H menu family: no private copies (header-truth 4r) */



































































































































































































#ifdef NFS4_SCREENTRACKINFO_AUDIO_SURFACE   /* retail ScreenAudio: tracks + tournaments after the menu family (same text as above) */
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
#include "fetourn_manager_class.h"   /* class tTournamentManager: one definition (header-truth 4l) */




























#define NFS4_SCREENDISPLAY_ITERS_TRACK
#include "screendisplay_carblock_iters.h"   /* tListIteratorTrack: one definition (header-truth 4s) */
#undef NFS4_SCREENDISPLAY_ITERS_TRACK
#include "felist_tournament_iter.h"   /* tListIteratorTournament: one definition (header-truth 4s) */


#endif

#ifdef NFS4_SCREENTRACKINFO_AUDIO_SURFACE
#include "shared/tTVState.h"
#include "shared/tTVConfig.h"
#endif



#include "fedialog.h"
#include "shared/tCredit.h"

#include "shared/tScreenMainState.h"







#include "shared/tVideoTransition.h"
#include "shared/tVideo.h"

#endif

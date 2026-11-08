#define NFS4_SCREENDISPLAY_DIALOGS_EARLY   /* retail: dialogs before the car/track graph (screendisplay_types.h) */
#ifndef _FE_SCREENS_SCREENCARSELECT_H_
#define _FE_SCREENS_SCREENCARSELECT_H_
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail core place (color_types.h does the same) */
#define NFS4_PRIM_DR_AREA   /* retail ScreenCarSelect: DR_AREA right after DR_MODE */
#define NFS4_FE_CORE_CARS_SAVEINFO   /* retail: tSaveCarInfo after tOwnedCarInfo */
#define NFS4_FE_TRACK_SAVEINFO   /* retail: tSaveTrackInfo/tSaveTournament inside the track/tournament graph */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType after tOwnedCarInfo */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup before tfrontEnd */
#define NFS4_SCREENDISPLAY_CARS_AFTER_MENUS   /* retail: car/track/tournament graph after the tMenuNFS4 family */
#define NFS4_FE_CORE_FELINES_LATE   /* retail: tTexture_ShapeInfo/kernpair after the Draw_* records, not with the frontend core */
#define NFS4_SCREENCARSELECT_TAIL_LATE   /* retail: AudioMus_tSongEntry after the color graph */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* draw_leaf phase 1 only; screendisplay_types.h emits PCOORD16 .. Draw_* after tScreen */
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: tListIteratorCar/CarColor after tCarManager, tListIteratorTrack after tTrackManager (FRONTORD3 keys) */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_SCREENDISPLAY_ITERS_CARS_CHAIN "fe_track_types.h"   /* retail: track records right after tListIteratorCarColor */
#define NFS4_SCREENDISPLAY_FELINES_AFTER_LEAF   /* retail: tTexture_ShapeInfo after Draw_CarVertex */
#define NFS4_SCREENDISPLAY_SCREEN_AFTER_ACTIVELINE
#define NFS4_FELINES_KERNPAIR_LATE   /* retail: kernpair after tShapeInformation */
#define NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE "felines_kern.h"
#define NFS4_FEDIALOG_FEAPP_DONE   /* ORDERG key: fedialog_types.h skips its default tFEApplication ... */
#define NFS4_SCREENDISPLAY_HOOK_AFTER_EARLY_DIALOGS "screencarselect_feapp_hook.h"   /* ... and screendisplay_types.h emits it right after the early dialogs (retail: tFEApplication after tDialogYesNo) */
#define NFS4_FE_CORE_CARS_HOOK_BEFORE_MANAGER "screencarselect_carstat.h"   /* retail: tCarStatType right after tCarNameLength (FRONTORD3 hook) */
#include "../../game/common/draw_leaf_types.h"
#include "screencarselect_types.h"
#include "../../game/common/color_types.h"
#include "screencarselect_externs.h"
#endif

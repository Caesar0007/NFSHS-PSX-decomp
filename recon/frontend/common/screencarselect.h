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
#include "../../game/common/draw_leaf_types.h"
#include "screencarselect_types.h"
#include "../../game/common/color_types.h"
#include "screencarselect_externs.h"
#endif

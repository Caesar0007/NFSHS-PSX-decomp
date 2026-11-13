#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: full tMenu/tMenuItem inline-member sets (TPDEF x16 per frontend object; FESCR) */
#ifndef NFS4_FRONTEND_COMMON_SCREENTRACKS_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTRACKS_TYPES_H   /* Owner-specific type surface for ScreenTracks.obj. */
#define NFS4_SCREENTRACKS_OWNER   /* screentracks.h: this object owns tScreenTrackSelect (inline copies LINK_STRIPPED) */
#define NFS4_CORE_PADS_EARLY   /* retail: controller pads before linedef (nfs4_types.h) */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_SCREENDISPLAY_COLOR_BEFORE_CARS   /* color.obj graph right before the car/track graph */
#define NFS4_SCREENPINKSLIPS_TRACKS_SURFACE
#define NFS4_CORE_CCOORD16   /* retail: CCOORD16 at its core place */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType after tOwnedCarInfo */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup before tfrontEnd */
#define NFS4_SCREENDISPLAY_HOOK_BEFORE_NFS4MENU "screentracks_early.h"   /* retail: mission + TV before the tMenuNFS4 family */
/* tTVState comes from shared/tTVState.h (screentracks_early.h; screendisplay_types.h includes the same unit) */
#define NFS4_PRIM_POLY_FT4   /* retail: POLY_FT4 right after DISPENV (nfs4_types.h) */
#define NFS4_CORE_HOOK_AFTER_CD "shared/core_snd_after_cd.h"   /* retail: SND records right after the CD stream (nfs4_types.h) */
#define NFS4_SCREENDISPLAY_DIALOGS_EARLY   /* retail: dialogs after tActiveLine, before the color graph */
#define NFS4_SCREENDISPLAY_DIALOGS_NO_DSE   /* retail ScreenTracks records no tDrawShapeExtended */
#define NFS4_SCREENDISPLAY_HOOK_BEFORE_ACTIVELINE "fe_core_cars.h"   /* retail: car tail right before tActiveLine (menu items before it) */
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: list iterators right after tCarManager / tTrackManager */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_SCREENDISPLAY_SCREEN_AFTER_ACTIVELINE   /* retail: tActiveLine, tShapeInformation, tScreen consecutive */
#define NFS4_SCREENDISPLAY_HOOK_AFTER_EARLY_DIALOGS "screenpinkslips_feapp.h"   /* retail: tFEApplication right after the early dialogs */
#include "screenpinkslips_types.h"
#undef NFS4_SCREENPINKSLIPS_TRACKS_SURFACE
#include "shared/tMenuTextType.h"   /* the real enum (was constant macros; header-truth 4-C.2) */
#include "shared/tMenuTextState.h"   /* the real enum (was constant macros; header-truth 4-C.2) */
#include "shared/POLY_FT4.h"
typedef enum VIDEOSTATE {
    VIDEOSTATE_IDLE = 0,
    VIDEOSTATE_SPOOLING = 1,
    VIDEOSTATE_READY = 2,
    VIDEOSTATE_PLAYING = 3
} VIDEOSTATE;
#include "screentracks_videowall.h"   /* emitted earlier via screentracks_early.h (retail order) */












#include "screentracks.h"

/* tGlobalMenuDefs is recorded only in FEMenuDefs.obj; ScreenTracks reaches its members
   (iteratorTrack @0xc88, itemTraffic @0xf4c, itemLocalSpeech @0xf70) through the
   member types its own object records, so the class stays incomplete here. */
struct tGlobalMenuDefs;




#endif

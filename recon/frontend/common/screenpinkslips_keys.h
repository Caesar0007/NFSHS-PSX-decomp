/* screenpinkslips_keys.h -- ScreenPinkSlips.obj type-order keys (retail order), included by screenpinkslips_types.h
 * for the pinkslips surface only (ScreenTracks sets its own keys). */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_SCREENDISPLAY_COLOR_BEFORE_CARS   /* color.obj graph right before the track graph */
#define NFS4_CORE_HOOK_AFTER_CD "shared/core_snd_after_cd.h"   /* retail: SND records right after the CD stream (nfs4_types.h) */
#define NFS4_CORE_CCOORD16   /* retail: CCOORD16 at its core place */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType after tOwnedCarInfo */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup before tfrontEnd */
#define NFS4_SCREENDISPLAY_HOOK_BEFORE_NFS4MENU "screenpinkslips_early.h"   /* mission, TV, tScreenPinkSlips, dialogs */
#define NFS4_SCREENDISPLAY_HOOK_BEFORE_ACTIVELINE "fe_core_cars.h"   /* retail: car tail right before tActiveLine (menu items before it) */
#define NFS4_SCREENDISPLAY_SCREEN_AFTER_ACTIVELINE   /* retail: tActiveLine, tShapeInformation, tScreen consecutive */
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: list iterators right after tCarManager / tTrackManager */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"

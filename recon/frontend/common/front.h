#define NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS   /* retail: car graph early, track/tournament graph after the menu family (screendisplay_carblock.h) */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_SCREENDISPLAY_COLOR_BEFORE_CARS   /* color.obj graph before the car/track graph (screendisplay_types.h) */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* draw_leaf phase 1 only; screendisplay_types.h emits PCOORD16 .. Draw_* after tScreen */
#define NFS4_SCREENDISPLAY_DIALOGS_NO_DSE   /* no tDrawShapeExtended in this graph */
#define NFS4_SCREENDISPLAY_DIALOGS_EARLY   /* retail: dialogs before the car/track graph (screendisplay_types.h) */
#define NFS4_CORE_PADS_FIRST   /* retail type order (nfs4_types.h) */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#include "front_types.h"
#include "front_externs.h"

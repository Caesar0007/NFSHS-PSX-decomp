/* screendisplay_keys.h -- ScreenDisplay.obj type-order keys.  screendisplay.cpp includes screendisplay_types.h before any
 * other header (NFS4_TYPES_H still undefined), every other owner reaches it after the platform core. */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* retail: frontend menu core before PCOORD16 .. Draw_* (phase 2 after tScreen) */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType after tOwnedCarInfo */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup before tfrontEnd */
#define NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS   /* retail: track/tournament records after the tMenuNFS4 family */
#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* census: retail records every tMenu/tMenuItem inline member (fe_core_tmenu.h) */
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: list iterators right after tCarManager / tTrackManager */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"

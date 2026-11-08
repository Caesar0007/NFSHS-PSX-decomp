#define NFS4_TU_FEAPP   /* owner identity (shared/tpdef_keys.h) */
#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* census: retail records every tMenu/tMenuItem inline member (fe_core_tmenu.h) */
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: list iterators right after tCarManager / tTrackManager */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_SCREENDISPLAY_CARS_AFTER_MENUS   /* retail: tMenuNFS4/options family before the car/track graph (screendisplay_carblock.h) */
#define NFS4_SCREENDISPLAY_DIALOGS_EARLY   /* retail: dialogs before the car/track graph (screendisplay_types.h) */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail core place (color_types.h does the same) */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* draw_leaf phase 1 only; screendisplay_types.h emits PCOORD16 .. Draw_* after tScreen */
#include "../../game/common/draw_leaf_types.h"
#include "feapp_types.h"
#include "../../game/common/color_types.h"
#include "feapp_externs.h"
/* same spelling as front_externs.h: retail RunPostGame records a record-less inline pair at its dummyCars read (996) */
static inline Car_tStats *Cars_NewCarStatsList(void) { return Cars_gNewCarStatsList; }

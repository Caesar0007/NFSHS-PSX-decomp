#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: full tMenu/tMenuItem inline-member sets (FESCR2) */
/* screentournselect_keys.h -- ScreenTournSelect.obj type-order keys (tournselect surface only; included by
 * screentournselect_types.h inside its tournselect-only block). */
#define NFS4_SCREENDISPLAY_DIALOGS_EARLY   /* retail: dialogs before the car/track graph (screendisplay_types.h) */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType after tOwnedCarInfo */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup before tfrontEnd */
#define NFS4_SCREENDISPLAY_HOOK_BEFORE_NFS4MENU "screentournselect_early.h"   /* retail: TV + tScreenTournSelect before the tMenuNFS4 family */
#define NFS4_FE_CORE_FELINES_LATE   /* retail: tTexture_ShapeInfo/kernpair after the Draw_* records */
#define NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE "felines_kern.h"   /* retail: kernpair right after tScreen */
#define NFS4_SCREENDISPLAY_HOOK_AFTER_EARLY_DIALOGS "screentournselect_tv.h"   /* retail: tTVState, tTVConfig right after the early dialogs */
#define NFS4_SCREENDISPLAY_FELINES_AFTER_LEAF   /* retail: core + draw leaf, then tTexture_ShapeInfo */
#define NFS4_SCREENDISPLAY_SCREEN_AFTER_ACTIVELINE   /* retail: tActiveLine, tShapeInformation, tScreen consecutive */
#define NFS4_FELINES_KERNPAIR_LATE   /* kernpair via the after-activeline hook */
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: list iterators right after tCarManager / tTrackManager */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"

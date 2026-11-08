/* screencontroller_keys.h -- ScreenController.obj owner keys (moved verbatim from screencontroller.h; FeMenuOptions skips them). */
#define NFS4_SCREENDISPLAY_DIALOGS_EARLY   /* retail: dialogs before the car/track graph (screendisplay_types.h) */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_SCREENDISPLAY_COLOR_BEFORE_CARS   /* color.obj graph after the dialogs, before the car/track graph */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* draw_leaf phase 1 only; screendisplay_types.h emits PCOORD16 .. Draw_* after tScreen */
#define NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS   /* retail: track/tournament graph after the menu family (screendisplay_carblock.h) */
#define NFS4_CORE_CCOORD16   /* retail: CCOORD16 right after COORD16 */
#define NFS4_COLOR_HOOK_AFTER_CAR "shared/Force_tGlobal.h"   /* retail ScreenController: Force_tGlobal right after Car_tObj (color_types.h) */
#define NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE "screencontroller_after_activeline.h"   /* retail: FE3d then kernpair right after tScreen */
#define NFS4_SCREENDISPLAY_HOOK_AFTER_COLOR "screencontroller.h"   /* retail: Force_tGlobal + tScreenControllerConfig after color.obj graph, before the cars */
#define NFS4_SCREENDISPLAY_FELINES_AFTER_LEAF   /* retail: core + draw leaf, then tTexture_ShapeInfo (screendisplay_types.h) */
#define NFS4_SCREENDISPLAY_SCREEN_AFTER_ACTIVELINE   /* retail: tActiveLine, tShapeInformation, tScreen consecutive */
#define NFS4_FELINES_KERNPAIR_LATE   /* kernpair chained from screencontroller_after_activeline.h (after FE3d) */

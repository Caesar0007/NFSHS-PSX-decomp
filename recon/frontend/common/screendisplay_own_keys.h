/* screendisplay_own_keys.h -- ScreenDisplay.obj-only type-order keys (screendisplay_keys.h is shared with ScreenMain/
 * ScreenController).  Retail: Draw_CarVertex, tTexture_ShapeInfo, tActiveLine, tShapeInformation, tScreenDisplay, kernpair. */
#define NFS4_FE_CORE_FELINES_LATE
#define NFS4_SCREENDISPLAY_FELINES_AFTER_LEAF
#define NFS4_SCREENDISPLAY_SCREEN_AFTER_ACTIVELINE
#define NFS4_FELINES_KERNPAIR_LATE
#define NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE "screendisplay_owner_kern.h"
#include "screendisplay_keys.h"   /* the shared keys (screendisplay_types.h then skips them: NFS4_TYPES_H defined) */
#include "../../game/common/draw_leaf_types.h"   /* retail: the MATRIX core first (phase 1) */

/* feapp_keys.h -- FEApp.obj type-order keys (kept out of feapp.h so its inline body lines stay fixed). */
#define NFS4_CORE_LINEDEF_LATE   /* retail: linedef, SHAPETABLEENTRY right after tScreen (nfs4_types.h / game_common_min_types.h skip them) */
#define NFS4_SCREENDISPLAY_HOOK_BEFORE_LEAF2 "core_linedef_late.h"
#define NFS4_FE_CORE_FELINES_LATE   /* retail: tTexture_ShapeInfo after Draw_CarVertex, not with the frontend core */
#define NFS4_SCREENDISPLAY_FELINES_AFTER_LEAF
#define NFS4_SCREENDISPLAY_SCREEN_AFTER_ACTIVELINE   /* tActiveLine, tShapeInformation after tTexture_ShapeInfo */
#define NFS4_FELINES_KERNPAIR_LATE   /* retail: kernpair after tShapeInformation */
#define NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE "felines_kern.h"

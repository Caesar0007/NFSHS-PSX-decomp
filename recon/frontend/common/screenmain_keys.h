/* screenmain_keys.h -- ScreenMain.obj owner keys (per-TU unit, included from screenmain_types.h). */
#define NFS4_PRIM_POLY_G4   /* retail: POLY_G4 right after DISPENV (nfs4_types.h) */
#define NFS4_SCREENDISPLAY_FELINES_AFTER_LEAF   /* retail: core + draw leaf, then tTexture_ShapeInfo (screendisplay_types.h) */
#define NFS4_SCREENDISPLAY_SCREEN_AFTER_ACTIVELINE   /* retail: tActiveLine, tShapeInformation, tScreen consecutive */
#define NFS4_FELINES_KERNPAIR_LATE   /* kernpair chained from screenmain_tv.h (after tTVConfig) */
#define NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE "screenmain_tv.h"   /* retail: tTVState, tTVConfig, kernpair right after tScreen */

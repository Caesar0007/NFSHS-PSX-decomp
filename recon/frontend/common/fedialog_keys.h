/* fedialog_keys.h -- FEDialog.obj type-order keys (fedialog_types.h, FEDialog TU only). */
#define NFS4_CORE_PADS_FIRST   /* retail FEDialog: pads, MATRIX core, draw leaf, tTexture_ShapeInfo, kernpair, then the frontend core */
#define NFS4_CORE_CCOORD16
#define NFS4_FE_CORE_CARS_SAVEINFO   /* retail: tSaveCarInfo / tCarClassType after tOwnedCarInfo, tCarLineup after tPersonalities */
#define NFS4_FE_CORE_CARS_CLASSTYPE
#define NFS4_FE_CORE_CARS_LINEUP
#define NFS4_FE_TRACK_SAVEINFO   /* retail: tSaveTrackInfo / tSaveTournament inside the track graph */
#define NFS4_SCREENDISPLAY_CARS_AFTER_MENUS   /* car graph from the options hook below, not at screendisplay site 1 */
#define NFS4_SCREENDISPLAY_HOOK_BEFORE_OPTIONS "fedialog_feapp_hook.h"   /* retail: tFEApplication + car graph between tMenuOptions and the options family */

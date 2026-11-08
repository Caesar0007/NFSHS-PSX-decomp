/* Owner-specific type surface for ScreenUserName.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENUSERNAME_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENUSERNAME_TYPES_H
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: tListIteratorCar/CarColor after tCarManager, tListIteratorTrack after tTrackManager */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: the full tMenu/tMenuItem inline-member sets (TPDEF x16 in every frontend object) */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType after tOwnedCarInfo (INV-B fe_core_cars hook) */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup after tPersonalities (INV-B fe_core_cars hook) */
#define NFS4_FE_CORE_FELINES_LATE   /* retail: FE menu core BEFORE the MATRIX core, then FE3d, then ScreenDisplay graph */
#define NFS4_FE_CORE_CARS_LATE
#include "fe_core_types.h"
#include "screendisplay_menuitems.h"   /* retail: the three menu items right after tMenuItemInteractive */
#include "../../game/common/draw_leaf_types.h"   /* MATRIX .. Draw_* (felines_types.h did this before) */
#include "shared/tTexture_ShapeInfo.h"   /* retail: tTexture_ShapeInfo, tActiveLine, tShapeInformation, then screenusername_screen.h */
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
#include "screenusername_screen.h"   /* tScreen, FE3d, kernpair (retail order) */

#define NFS4_SCREENDISPLAY_NO_OWNER_RECORDS   /* ScreenDisplay's shared graph, not its owner records */
#define NFS4_SCREENDISPLAY_CARS_AFTER_MENUS   /* retail: menu family, tScreenUserName, then the car/track graph */
#define NFS4_SCREENDISPLAY_OWNER_BEFORE_CARS "screenusername_types.h"   /* second pass below emits the owner class */
#include "screendisplay_types.h"
#elif !defined(NFS4_SCREENUSERNAME_OWNER_DONE)   /* second pass (screendisplay owner hook) */
#define NFS4_SCREENUSERNAME_OWNER_DONE
struct tScreenUserName : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground(); void Initialize();
    tOptionsMenu *callingMenu; short fTextFade; bool fInTransition; char fRowList[10][9];
    void DrawVerticalLine(short, short, short); void DrawHorizontalLine(short, short, short);
#line 97 "C:/nfs4/FRONTEND/COMMON/SCREENUSERNAME.H"
};
#line 32 "recon/frontend/common/screenusername_types.h"
#endif

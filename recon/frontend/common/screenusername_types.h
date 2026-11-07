/* Owner-specific type surface for ScreenUserName.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENUSERNAME_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENUSERNAME_TYPES_H
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType after tOwnedCarInfo (INV-B fe_core_cars hook) */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup after tPersonalities (INV-B fe_core_cars hook) */
#define NFS4_FE_CORE_FELINES_LATE   /* retail: FE menu core BEFORE the MATRIX core, then FE3d, then ScreenDisplay graph */
#define NFS4_FE_CORE_CARS_LATE
#include "fe_core_types.h"
#include "felines_types.h"
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
typedef COORD16 FE3d_zVertex; typedef CVECTOR FE3d_zColor; typedef SVECTOR FE3d_zNormal;
#include "shared/FE3d_zUV.h"
#include "shared/FE3d_zFacet.h"
#include "shared/FE3d_zObj.h"
#define NFS4_SCREENDISPLAY_NO_OWNER_RECORDS   /* ScreenDisplay's shared graph, not its owner records */
#define NFS4_SCREENDISPLAY_CARS_AFTER_MENUS   /* retail: menu family, tScreenUserName, then the car/track graph */
#define NFS4_SCREENDISPLAY_OWNER_BEFORE_CARS "screenusername_types.h"   /* second pass below emits the owner class */
#include "screendisplay_types.h"
#elif !defined(NFS4_SCREENUSERNAME_OWNER_DONE)   /* second pass (screendisplay owner hook) */
#define NFS4_SCREENUSERNAME_OWNER_DONE
struct tScreenUserName : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    tOptionsMenu *callingMenu;
    short fTextFade;
    bool fInTransition;
    char fRowList[10][9];
    void DrawVerticalLine(short, short, short); void DrawHorizontalLine(short, short, short);
#line 97 "C:/nfs4/FRONTEND/COMMON/SCREENUSERNAME.H"
};
#line 32 "recon/frontend/common/screenusername_types.h"
#endif

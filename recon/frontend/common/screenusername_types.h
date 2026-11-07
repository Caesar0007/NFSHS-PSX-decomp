/* Owner-specific type surface for ScreenUserName.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENUSERNAME_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENUSERNAME_TYPES_H
#define NFS4_FE_CORE_FELINES_LATE   /* retail: FE menu core BEFORE the MATRIX core, then FE3d, then ScreenDisplay graph */
#define NFS4_FE_CORE_CARS_LATE
#include "fe_core_types.h"
#include "felines_types.h"
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
typedef COORD16 FE3d_zVertex;
typedef CVECTOR FE3d_zColor;
typedef SVECTOR FE3d_zNormal;
#include "shared/FE3d_zUV.h"
#include "shared/FE3d_zFacet.h"
#include "shared/FE3d_zObj.h"
#define NFS4_SCREENDISPLAY_NO_OWNER_RECORDS   /* ScreenDisplay's shared graph, not its owner records */
#include "screendisplay_types.h"
#undef NFS4_SCREENDISPLAY_NO_OWNER_RECORDS
struct tScreenUserName : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    tOptionsMenu *callingMenu;
    short fTextFade;
    bool fInTransition;
    char fRowList[10][9];

    void DrawVerticalLine(short, short, short);
    void DrawHorizontalLine(short, short, short);
#line 97 "C:/nfs4/FRONTEND/COMMON/SCREENUSERNAME.H"
};
#line 32 "recon/frontend/common/screenusername_types.h"

#endif

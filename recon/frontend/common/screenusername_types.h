/* Owner-specific type surface for ScreenUserName.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENUSERNAME_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENUSERNAME_TYPES_H

/* ScreenUserName retains ScreenDisplay's exact shared frontend graph but not
 * that owner's class or foreign-global compiler view. */
#define NFS4_SCREENDISPLAY_NO_OWNER_RECORDS
#include "screendisplay_types.h"
#undef NFS4_SCREENDISPLAY_NO_OWNER_RECORDS

typedef COORD16 FE3d_zVertex;
typedef CVECTOR FE3d_zColor;
typedef SVECTOR FE3d_zNormal;

#include "shared/FE3d_zUV.h"



#include "shared/FE3d_zFacet.h"






#include "shared/FE3d_zObj.h"








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
};

#endif

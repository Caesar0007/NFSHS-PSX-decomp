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

struct FE3d_zUV {
    u_char u, v;
};

struct FE3d_zFacet {
    u_short vertexId0, vertexId1, vertexId2, uvId0, uvId1, uvId2;
    SVECTOR normal[3];
    CVECTOR color;
    u_char flag, pad1, pad2, pad3;
};

struct FE3d_zObj {
    int numVertex, numUV, numFacet;
    u_char textureId, textureWidth, textureHeight, pad1;
    COORD16 *vertex;
    FE3d_zUV *uv;
    COORD16 *Nvertex;
    FE3d_zFacet *facet;
};

struct tScreenUserName : public tScreen {
    tOptionsMenu *callingMenu;
    short fTextFade;
    bool fInTransition;
    char fRowList[10][9];

    void Initialize();
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawVerticalLine(short, short, short);
    void DrawHorizontalLine(short, short, short);
    void DrawBackground();
};

#endif

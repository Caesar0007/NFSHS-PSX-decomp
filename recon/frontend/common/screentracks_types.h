/* Owner-specific type surface for ScreenTracks.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENTRACKS_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTRACKS_TYPES_H

#define NFS4_SCREENPINKSLIPS_TRACKS_SURFACE
#include "screenpinkslips_types.h"
#undef NFS4_SCREENPINKSLIPS_TRACKS_SURFACE

#define textState_Unselected 0
#define textType_TrackRecords 11

#include "shared/POLY_FT4.h"

typedef enum VIDEOSTATE {
    VIDEOSTATE_IDLE = 0,
    VIDEOSTATE_SPOOLING = 1,
    VIDEOSTATE_READY = 2,
    VIDEOSTATE_PLAYING = 3
} VIDEOSTATE;

struct tVideoWall {
    tTVConfig *fTVs;
    short fFirstTVShape, fNumTVs;
    tTexture_ShapeInfo *fTVShapes;
    short *tvOrder;
    u_long fTVTicks;
    short fTransitionDirection, fFlipAxis, fOffsetX, fOffsetY;
    short fAvailableTextID, fAvailable, fAvailableBright, fValid;
    short fAvailableX, fAvailableY;
    tTexture_ShapeInfo *fIconShapes;
    short fIcon, fIconFrames, fIconX, fIconY;
    bool fUpdated;
};

#include "screentracks.h"

struct ScreenTracks_GlobalMenuDefsCodegenView {
    char _beforeIteratorTrack[0xc88];
    tListIteratorTrack iteratorTrack;
    char _beforeItemTraffic[0xf4c - 0xca0];
    tMenuItemOptionsTwoItemChoice itemTraffic, itemLocalSpeech;
};
#define tGlobalMenuDefs ScreenTracks_GlobalMenuDefsCodegenView

#endif

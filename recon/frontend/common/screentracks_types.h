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

struct tScreenTrackSelect : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    int hVideo, fFrame;
    short fPreviousTrack, fMovieTrack, fBrightness;
    short fDestBrightness, fStartBrightness;
    u_long fStartTicks;
    bool fTicksSet;
    tTVConfig tvConfigs[10];
    tVideoWall fVideoWall;
    bool fTVsInitialized;
    u_long fVideoTicks;

    tScreenTrackSelect();
    void SetBrightness(short);
    inline void SetBrightnessTransition(short bright, short current,
                                        u_long start) {
        fDestBrightness = bright;
        fStartBrightness = current;
        fStartTicks = start;
    }
    void UpdateBrightness(tTrackInformation &);
    void UpdateVideoWall(tTrackInformation &);
    void DrawVideoWall();
};

struct ScreenTracks_GlobalMenuDefsCodegenView {
    char _beforeIteratorTrack[0xc88];
    tListIteratorTrack iteratorTrack;
    char _beforeItemTraffic[0xf4c - 0xca0];
    tMenuItemOptionsTwoItemChoice itemTraffic, itemLocalSpeech;
};
#define tGlobalMenuDefs ScreenTracks_GlobalMenuDefsCodegenView

#endif

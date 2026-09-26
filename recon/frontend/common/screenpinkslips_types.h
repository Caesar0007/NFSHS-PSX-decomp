/* Owner-specific type surface for ScreenPinkSlips.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENPINKSLIPS_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENPINKSLIPS_TYPES_H

#define NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE
#include "screentournselect_types.h"
#undef NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE

#define BOOL int
#define textType_FlybyHelp 1
#define RaceType_HotPursuit 1

struct tMenuCommand;

#include "shared/tRecordBuffer.h"



typedef tRecordBuffer tSaveRecords[187];

#ifndef NFS4_SCREENPINKSLIPS_TRACKS_SURFACE
struct FLARE_PIECE_DEF {
    int distance, size;
    CVECTOR color;
    char type;
};
#endif

struct SNDSYSCAP {
    u_short outputratemin, outputratemax;
    u_char outputchannelsmin, outputchannelsmax;
    u_char inputvoicesmax, input3dvoicesmax, eax, voicemanager;
    char pad[2];
};
struct SNDSYSSET {
    u_short maxbanks, outputrate;
    u_char outputchannels, inputvoices, useeax, use3dacceleration, use3dmixing;
    char pad;
    u_short emulationsubtype;
    u_short spkrcfg3d[4][4];
};
#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"




#include "shared/tMissionTierInfo.h"


#include "shared/tMissionInfo.h"






#include "shared/tStageInfo.h"








#include "shared/tAcademyDefinition.h"





struct tFEApplication {
    unsigned int fCurrentMusic;
    tMenu *fCurrentMenu[2];
    tScreen *fCurrentScreen[2];
    tMenu *fTransitionToMenu[2];
    tScreen *fTransitionToScreen[2];
    tMenu *fParentMenu[2];
    tDialogMessageString messagePopup;
    tMenu *backList[2][16];
    int backDepth[2];
    tInputKeyType fLastKeyPressed[2];
    short fYOffset;
    tDialogHelp helpPopup;
    char fPlayer, fInputPlayer;
    bool waitingForOtherPlayer[2];
    tDialogMessageStringWithTimeout MemCardDialog;
    tDialogNoInputMessage NoInputMemCardDialog;
    bool gotName[2], needName[2];
    int speechToPlay[2];
};

#ifndef NFS4_SCREENPINKSLIPS_TRACKS_SURFACE
struct tScreenPinkSlips : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    tMenu *fMenu;
    int hVideo, fFrame;
    short fPreviousTrack, fBrightness, fDestBrightness, fStartBrightness;
    u_long fStartTicks, fTVTicks;
    char fTransitionDirection;
    tTVConfig fTrackTVs[8];
    tTVConfig fImageTVs[4];
    bool fTVsInitialized;

    tScreenPinkSlips();
    void UpdateVideoWall(tTrackInformation &);
    void DrawVideoWall();
};
#endif

#ifndef NFS4_SCREENPINKSLIPS_TRACKS_SURFACE
struct ScreenPinkSlips_GlobalMenuDefsCodegenView {
    char _beforeIteratorTrack[0xc88];
    tListIteratorTrack iteratorTrack;
    char _beforeItemTraffic[0xf4c - 0xca0];
    tMenuItemOptionsTwoItemChoice itemTraffic, itemLocalSpeech;
};
#define tGlobalMenuDefs ScreenPinkSlips_GlobalMenuDefsCodegenView
#endif

#endif

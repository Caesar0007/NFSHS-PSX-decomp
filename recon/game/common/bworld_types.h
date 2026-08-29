/* bworld.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_BWORLD_TYPES_H
#define NFS4_GAME_COMMON_BWORLD_TYPES_H

/* DrawW.obj supplies the exact 106-definition shared graph.  These fourteen
 * completed records belong only to DrawW and are absent from bworld.obj. */
#define NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
#include "../psx/draww_types.h"
#undef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES

struct Trk_SFX {
    int point[3];
    short type, pad;
};

struct BW_tContextMgr {
    int initialized, count;
    BW_tContext contexts[2];
};

/* Foreign completed tags are absent from bworld.obj's SYM graph even though
 * retail retains member-shaped accesses to their storage.  These private,
 * layout-locked views expose precisely the offsets consumed by this owner. */
struct BWorld_SliceCodegenView {
    int center[3];
    char normal[3], forward[3], right[3];
    u_char acousticType;
    short pavedProfile, leftDrive, rightDrive;
    u_char chunkIndex, laneCount, avgPavedWidthLf, avgPavedWidthRt;
};

struct BWorld_CameraCodegenView {
    BO_tNewtonObj *anchor, *target;
    u_char remaining[264];
};

struct BWorld_GameSetupCodegenView {
    int raceType, numLaps, skill, commMode, tournamentMultiplier, cops;
    int trafficDensity, localCar, catchupLogic, replayMode, instantReplay;
    int mirrorTrack, reverseTrack, measurement, sgge, track, trackSegment;
    int song, Weather, Fog, Damage, Time, randSeed, easter;
    GameSetup_tControllerData controllerData;
    int pinkSlipsForfeit, checkpointType;
    int checkpointHUD[2];
    int dispatchSpeech, reverseCallSpeech, languageSpeech;
    int SceneNumber, SceneStartLap, SceneEndLap;
    GameSetup_tUserSetting userSetting;
    int numPerps, stageOffset, perpArrests, finalPerpArrests;
    GameSetup_tPerpData perpInfo[10];
    int numCars, numPlayerRaceCars, numOpponentRaceCars, opponentCarType;
    GameSetup_tCarData carInfo[9];
};

struct BWorld_TrackSpecCodegenView {
    short fogstate, weatherstate, horizonstate, skystate;
    short nightstate, depthcuestate, worldcolorstate, pad0;
    CFogSpec fogspec;
    CWeatherSpec weatherspec;
    CHorizonSpec horizonspec;
    CSkySpec skyspec;
    CNightSpec nightspec;
    CDepthCueSpec depthcuespec;
    CWorldColor worldcolorspec;
};

struct BWorld_FlareCacheCodegenView {
    Draw_tCacheHeader head;
};

struct BWorld_DrawCacheCodegenView {
    u_char beforeFog[220];
    short startfog, distfog;
    u_char beforeNight[40];
    short night_ZNear;
    u_char night_XDistShift, night_ZDistShift, night_DrawLightning;
    u_char night_LightningType, fogstate, padnight;
};

typedef int CarLogic_tObservations[1][3];
#define RaceType_HotPursuit 1
#define RaceType_Tournament 2
#define RaceType_Id5 5

#endif

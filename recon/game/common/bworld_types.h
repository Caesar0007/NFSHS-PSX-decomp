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

/* Canonical bworldSm.obj aggregate used by this translation unit. */
struct Trk_NewSlice {
    int center[3];
    char normal[3], forward[3], right[3];
    u_char acousticType;
    short pavedProfile, leftDrive, rightDrive;
    u_char chunkIndex, laneCount, avgPavedWidthLf, avgPavedWidthRt;
};

/* Canonical camera.obj aggregate used by this translation unit. */
struct camera_info {
    BO_tNewtonObj *anchor, *target;
    coorddef position, relpos, audioPos;
    int TVHeight;
    matrixtdef rotation;
    int twist;
    coorddef wallLeft, wallRight;
    short mode, camNum;
    char modechange : 1;
    char pitch : 1;
    char jostling : 1;
    char tracking : 1;
    char checkwalls : 1;
    char noLookBack : 1;
    char checkcollisions : 1;
    char splitscreen : 1;
    char intransition, tumbling;
    char direction : 1;
    char zooming : 2;
    char inCar : 1;
    short circleCounter, circleAngle;
    char animNum;
    signed char animHandle;
    char splineMode;
    forceFocus_t forceFocus;
    signed char focusOnAICar;
    int POInhibitor;
    BWorldSm_Pos slicePos;
};

/* Canonical gmesetup.obj aggregate used by this translation unit. */
struct GameSetup_tData {
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

/* Canonical trackspec.obj aggregate used by this translation unit. */
struct CTrackSpec {
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

struct Draw_FlareCache { Draw_tCacheHeader head; };

struct Draw_tGiveShelbyMoreCache {
    Draw_tCacheHeader head;
    MATRIX matB, matNight, matCop, identMat;
    int otz;
    VECTOR tVn0, tVn1, tVn2, tVn3;
    short light, doublelayer, startfog, distfog;
    CCOORD16 *vertices;
    u_char chunkInd, rezInd, garb3, quadCount;
    void *quads;
    int offset;
    Track_tMaterial *materials;
    COORD16 trans;
    Track_tArtresource *artInfo;
    Trk_NewStrip *stripPtr;
    short numStrips;
    char nightFlags, zeroGTETransFlag;
    short night_ZNear;
    u_char night_XDistShift, night_ZDistShift, night_DrawLightning;
    u_char night_LightningType, fogstate, padnight;
    POLY_GT4 GT4Prim;
    u_short tpage, clut;
    short offsubdivid;
    u_char code, magiknum;
    Draw_SVertex v0, v1, v2, v3;
    Draw_SubdivStruct div;
};

typedef int CarLogic_tObservations[1][3];
#define RaceType_HotPursuit 1
#define RaceType_Tournament 2
#define RaceType_Id5 5

#endif

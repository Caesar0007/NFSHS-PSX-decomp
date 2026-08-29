/* R3DCar.obj's exact source-visible extension of the shared DrawC graph. */
#ifndef NFS4_GAME_COMMON_R3DCAR_TYPES_H
#define NFS4_GAME_COMMON_R3DCAR_TYPES_H

#define NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
#include "../psx/drawc_types.h"
#undef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES

/* Retail exposes these fixed scratchpad cells as lvalues, not storage owned by
 * R3DCar.obj. Keep the address-bearing source expressions without importing
 * the broad project type header. */
#define Render_gPalettePtr (*(u_char **)0x1F800000)
#define gScratchLastWord   (*(int *)0x1F8003FC)

struct Texture_pal8bit;

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct DRender_tView {
    int id, player;
    DRender_tCalcView cview;
};

struct Transformer_zScene {
    Transformer_zObj *obj[57];
    Transformer_zOverlay overlay[90];
};

struct R3DCar_tEnvMapInfo {
    int eScaleX, eScaleY, rideHeight, upgradeHeight;
};

/* Completed foreign-owner tags are absent from R3DCar.obj's SYM graph. These
 * private views preserve the exact retail offsets and aggregate MEM shapes
 * used by its already-matched functions without claiming those foreign tags
 * as part of this translation unit's source-visible type surface. */
struct R3DCar_AITuneTrackInfoCodegenView {
    int oneWay, driveSide, roughLapTimeSeconds;
};

struct R3DCar_GameSetupCodegenView {
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

struct R3DCar_CameraInfoCodegenView {
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

struct R3DCar_SimGlobalCodegenView {
    int gameStarted, gameTicks, time32Hz;
    void *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};

struct R3DCar_SimSystemCodegenView {
    int restartGame, endSimGame, pauseSim, keyRelease, quickPauseSim;
    int goalClockTicks, currentClockTicks;
};

struct R3DCar_ReplayCodegenView {
    int pause, speed, end, camera, selection, depressed, changeCamera, statsScreen;
};

struct R3DCar_DrawCEnvMapCodegenView {
    short slice, tex, extra;
};

typedef int Input_tDeviceCall();

#endif

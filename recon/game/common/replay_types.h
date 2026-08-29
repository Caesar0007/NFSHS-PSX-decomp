/* replay.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_REPLAY_TYPES_H
#define NFS4_GAME_COMMON_REPLAY_TYPES_H

#include "color_types.h"

#define RaceType_HotPursuit 1
#define RaceType_Id5 5

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

struct Camera_tCamSlot {
    char mode;
    char track : 1;
    char zoom : 2;
    char splineMode : 3;
    short fov;
    coorddef pos;
    int height, splineOffset;
    COORD16 euler;
    short slice;
};

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

struct tControllerData {
    char steering[32];
    u_char gas[32], brake[32], states[32];
};

struct tReplayInterface {
    int pause, speed, end, camera, selection, depressed, changeCamera;
    int statsScreen;
};

struct tReplayCameraModes {
    int defaultCamera, timeCounter, cameraMode, cutToNextCamera;
};

struct tReplayBuffer {
    GameSetup_tData gameSetup;
    int size;
    char buffer[24576];
};

/* Foreign globals whose completed tags are absent from this retail owner. */
struct Replay_SimGlobalCodegenView {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};

struct Replay_SimSystemCodegenView {
    int restartGame, endSimGame, pauseSim, keyRelease, quickPauseSim;
    int goalClockTicks, currentClockTicks;
};

struct Replay_InputResultsCodegenView {
    char steering;
    u_char gas, brake, flags;
};

struct Replay_CameraInfoCodegenView {
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

#define Sim_tSimGlobalVar Replay_SimGlobalCodegenView
#define Sim_tSimSystemVar Replay_SimSystemCodegenView
#define Input_tResults Replay_InputResultsCodegenView
#define camera_info Replay_CameraInfoCodegenView

typedef int Input_tDeviceCall();

#endif

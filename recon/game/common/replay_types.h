/* replay.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_REPLAY_TYPES_H
#define NFS4_GAME_COMMON_REPLAY_TYPES_H

#include "color_types.h"

#define RaceType_HotPursuit 1
#define RaceType_Id5 5

#include "shared/Sched_tSchedule.h"




typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

#include "shared/Camera_tCamSlot.h"











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

#include "shared/tReplayCameraModes.h"



struct tReplayBuffer {
    GameSetup_tData gameSetup;
    int size;
    char buffer[24576];
};

/* Canonical sim.obj aggregates used by this translation unit. */
#include "shared/Sim_tSimGlobalVar.h"




struct Sim_tSimSystemVar {
    int restartGame, endSimGame, pauseSim, keyRelease, quickPauseSim;
    int goalClockTicks, currentClockTicks;
};

/* Canonical input.obj result aggregate used by this translation unit. */
#include "shared/Input_tResults.h"




/* Canonical camera.obj aggregate used by this translation unit. */
#include "shared/camera_info.h"





























typedef int Input_tDeviceCall();

#endif

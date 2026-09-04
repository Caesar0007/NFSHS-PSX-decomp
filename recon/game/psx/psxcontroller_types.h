/* psxcontroller.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_PSXCONTROLLER_TYPES_H
#define NFS4_GAME_PSX_PSXCONTROLLER_TYPES_H

#define NFS4_GMESETUP_OMIT_OWNER_RECORDS
#include "../common/gmesetup_types.h"
#undef NFS4_GMESETUP_OMIT_OWNER_RECORDS

struct tPadModuleState {
    int initialized;
    PAD_COMMON buf[8];
    struct {
        char bActive, time;
    } state[8];
};

struct GameSetup_tData {
    int raceType, numLaps, skill, commMode, tournamentMultiplier, cops;
    int trafficDensity, localCar, catchupLogic, replayMode, instantReplay;
    int mirrorTrack, reverseTrack, measurement, sgge, track, trackSegment, song;
    int Weather, Fog, Damage, Time, randSeed, easter;
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

#endif

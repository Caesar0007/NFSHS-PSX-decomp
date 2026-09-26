/* input.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_INPUT_TYPES_H
#define NFS4_GAME_COMMON_INPUT_TYPES_H

#include "color_types.h"

#include "shared/Sched_tSchedule.h"




/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"




/* Canonical gmesetup.obj aggregate used by this translation unit. */
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

#include "shared/Input_tDeviceList.h"





#include "shared/Input_tResults.h"




typedef int Input_tDeviceCall(u_long value);

#endif

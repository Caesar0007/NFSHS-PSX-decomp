/* aistate.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AISTATE_TYPES_H
#define NFS4_GAME_COMMON_AISTATE_TYPES_H

#include "color_types.h"

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

#include "shared/Sched_tSchedule.h"




/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"




struct AIPhysic_BrakeInfo { u_char brakeTable_[128]; int deceleration_; };
#include "shared/AIPhysic_ModelConfig_t.h"





#include "shared/trigger_anyTrigger_t.h"
#include "shared/trigger_offroad_t.h"





#include "shared/trigger_roadblock_t.h"
#include "shared/trigger_simple_t.h"
#include "shared/trigger_trafficAccident_t.h"




#include "shared/trigger_pathPosition_t.h"
#include "shared/trigger_trafficPath_t.h"





#include "shared/trigger_t.h"








struct AIDelayCar {
    int delayFactor_;
    Car_tObj *basisCar_, *targetCar_;
    int deltaMeters_, slice_;
    coorddef deltaPosition_, position_;
    int deltaRoadPosition_, roadPosition_, laneIndex_, currentSpeed_;
    AIDelayCar() {}
    AIDelayCar(Car_tObj *basisCar, Car_tObj *targetCar, int delayFactor);
    void SetNewTargetCar(Car_tObj *targetCar);
    void Update();
};

typedef enum cruiseMode_t {
    CRUISE_ATSETSPEED = 0,
    CRUISE_ATFACTOR = 1,
    CRUISE_ATTRAFFICSPEED = 2
} cruiseMode_t;

#include "aistate_classes.h"

struct kernpair { u_short previouscode, code; char kernvalue; char pad[3]; };
typedef kernpair KERN;
typedef int CarLogic_tObservations[1][3];
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

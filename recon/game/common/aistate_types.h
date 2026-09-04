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

typedef struct __nfs4_vtbl_ptr_t {
    short delta, index;
    int (*pfn)(...);
} __nfs4_vtbl_ptr_t;
#define __vtbl_ptr_type __nfs4_vtbl_ptr_t

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

/* Canonical sim.obj aggregate from the retail SYM type graph. */
struct Sim_tSimGlobalVar {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};

struct AIPhysic_BrakeInfo { u_char brakeTable_[128]; int deceleration_; };
struct AIPhysic_ModelConfig_t {
    int dlpos_to_dlvel, max_dlvel, dlvel_to_clacc, max_clacc;
    int dangle_to_dav, max_dav, dav_to_aa, max_aa;
    int vel_limit_range, lat_vel_limit_factor, ang_vel_limit_factor;
};

struct trigger_anyTrigger_t { int type, slice; };
struct trigger_offroad_t {
    int type, slice, dir;
    coorddef position;
    matrixtdef orientation;
    int maxSpeed, releaseTime, endSlice;
};
struct trigger_roadblock_t { int type, slice, dir, numCars, spikeBelt; };
struct trigger_simple_t { int type, slice, dir, side, moving; };
struct trigger_trafficAccident_t {
    int type, slice;
    coorddef position;
    matrixtdef orientation;
};
struct trigger_pathPosition_t { coorddef position; int targetSpeed, waitTime; };
struct trigger_trafficPath_t {
    int type, slice, dir;
    matrixtdef orientation;
    int maxSpeed, releaseTime, numPoints;
    trigger_pathPosition_t *path;
};
union trigger_t {
    trigger_anyTrigger_t any;
    trigger_simple_t simple;
    trigger_roadblock_t roadblock;
    trigger_offroad_t offroad;
    trigger_trafficAccident_t trafficAccident;
    trigger_trafficPath_t trafficPath;
};

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

struct AIState_Base {
    Car_tObj *carObj_;
    __vtbl_ptr_type (*_vf)[4];
    AIState_Base() {}
    AIState_Base(Car_tObj *carObj);
    void StateExecute();
    int TestForRelease();
};

struct AIState_Normal : public AIState_Base {
    AIState_Normal() {}
    AIState_Normal(Car_tObj *carObj);
    void Execute();
};

extern __vtbl_ptr_type AIState_NonActive_vtable[];
struct AIState_NonActive : public AIState_Base {
    AIState_NonActive() {}
    AIState_NonActive(Car_tObj *carObj) : AIState_Base(carObj) {
        _vf = (__vtbl_ptr_type (*)[4])((char *)AIState_NonActive_vtable + 8);
    }
    void Execute();
};

struct AIState_Idle : public AIState_Base {
    int roadPosition_, idleInPlaceFlag_;
    AIState_Idle() {}
    ~AIState_Idle();
    void Execute();
    void SetIdlePosition(int pos);
};

struct AIState_Chase : public AIState_Base {
    AIDelayCar delayCar_;
    int noTurnAroundEndTime_;
    Car_tObj *targetCar_;
    coorddef relPosition_;
    int longTargetRegion_, latTargetRegion_, targetDir_, carDir_;
    int longMetersBetween_, latMetersBetween_, murderMode_, murderEndTime_;
    int inTargetRegion_, nitrousTicks_, nitrousMinForeDistance_, nitrousMinAftDistance_;
    int aggressionLevel_, slowDownEndTime_, barrierTicks32_;
    AIState_Chase() {}
    AIState_Chase(Car_tObj *, Car_tObj *, coorddef *, int, int, int, int, int);
    ~AIState_Chase();
    void SetTarget(Car_tObj *, coorddef *);
    void SetMurderMode(int, int);
    void SetUp();
    void DoSlowNitrous();
    void DoNitrous(int);
    void Execute();
    void FarTargeting();
    int CalculateCloseTargettingAheadSlowDownFactor();
    void CloseTargeting();
    void ApproachTargeting(int);
    void CheckForBarriersAndTargetAroundThem();
    int FindBarrierEndSlice();
};

struct AIState_Offroad : public AIState_Base {
    int startSlice_;
    coorddef startPosition_;
    matrixtdef startOrientation_;
    coorddef startHeading_;
    int targetSlice_;
    coorddef targetPosition_;
    int longMetersBetween_, letGo_, maxSpeedMPS_, releaseTime_;
    AIState_Offroad() {}
    AIState_Offroad(Car_tObj *, int, coorddef *, matrixtdef *, int, int, int);
    ~AIState_Offroad();
    void UnleashIfInRange(Car_tObj *);
    void Execute();
};

struct AIState_Purgatory : public AIState_NonActive {
    AIState_Purgatory() {}
    AIState_Purgatory(Car_tObj *);
    ~AIState_Purgatory();
    int TestForRelease();
    void Execute();
    static void StartUp();
};

struct AIState_RovingTraffic : public AIState_Base {
    trigger_pathPosition_t *path_;
    int numPathPoints_, pathIndex_;
    long waitTick_;
    AIState_RovingTraffic() {}
    AIState_RovingTraffic(Car_tObj *, trigger_t *);
    ~AIState_RovingTraffic();
    void CheckIfCarIsNearbyAndStop(Car_tObj *, int &);
    void Execute();
    int TestForRelease();
};

struct AIState_Donuts : public AIState_Base {
    int donutLookForward_;
    donutMode_t donutMode_;
    AIState_Donuts() {}
    ~AIState_Donuts();
    void Execute();
};

struct AIState_GotoSlice : public AIState_Normal {
    int targetSlice_, stopWhenArrivedAtSlice_;
    AIState_GotoSlice() {}
    AIState_GotoSlice(Car_tObj *, int, int);
    ~AIState_GotoSlice();
    void Execute();
    int InTargetSliceRange(int);
};

struct AIState_Cruise : public AIState_Normal {
    cruiseMode_t cruiseMode_;
    int cruiseSpeed_, cruiseFactor_;
    AIState_Cruise() {}
    AIState_Cruise(Car_tObj *, cruiseMode_t, int);
    ~AIState_Cruise();
    void Execute();
};

struct kernpair { u_short previouscode, code; char kernvalue; char pad[3]; };
typedef kernpair KERN;
typedef int CarLogic_tObservations[1][3];
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

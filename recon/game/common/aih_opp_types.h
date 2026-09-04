/* aih_opp.obj's two-definition delta over the shared AI hierarchy graph. */
#ifndef NFS4_GAME_COMMON_AIH_OPP_TYPES_H
#define NFS4_GAME_COMMON_AIH_OPP_TYPES_H

#include "aih_hierarchy_types.h"

struct AIState_Chase : public AIState_Base {
    AIDelayCar delayCar_;
    int noTurnAroundEndTime_;
    Car_tObj *targetCar_;
    coorddef relPosition_;
    int longTargetRegion_, latTargetRegion_, targetDir_, carDir_;
    int longMetersBetween_, latMetersBetween_, murderMode_, murderEndTime_;
    int inTargetRegion_, nitrousTicks_, nitrousMinForeDistance_;
    int nitrousMinAftDistance_, aggressionLevel_, slowDownEndTime_;
    int barrierTicks32_;
    AIState_Chase() {}
    AIState_Chase(Car_tObj *carObj, Car_tObj *target, coorddef *pt,
                  int a, int b, int c, int d, int e);
    void SetTarget(Car_tObj *target, coorddef *pt);
    void SetMurderMode(int a, int b);
    void SetUp();
    void DoSlowNitrous();
    void DoNitrous(int a);
    void Execute();
    void FarTargeting();
    int CalculateCloseTargettingAheadSlowDownFactor();
    void CloseTargeting();
    void ApproachTargeting(int a);
    void CheckForBarriersAndTargetAroundThem();
    int FindBarrierEndSlice();
};

struct AIHigh_Opponent : public AIHigh_Player {
    AIHigh_tAttackMode attackMode_;
    Car_tObj *lastHumanHitter_;
    int hitCount_, attackTicksLeft_;
    AIHigh_Opponent() {}
    AIHigh_Opponent(Car_tObj *carObj);
    ~AIHigh_Opponent();
    void CheckForWipeOut();
    int DoRearEnder();
    void HighExecute();
    int DoProvokedAttack();
};

/* Canonical foreign aggregates used by this translation unit. */
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
struct Sim_tSimGlobalVar {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};
struct Trk_NewSlice {
    int center[3];
    char normal[3], forward[3], right[3];
    u_char acousticType;
    short pavedProfile, leftDrive, rightDrive;
    u_char chunkIndex, laneCount, avgPavedWidthLf, avgPavedWidthRt;
};

typedef int CarLogic_tObservations[1][3];

#endif

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
    void CheckForWipeOut();
    int DoRearEnder();
    void HighExecute();
    int DoProvokedAttack();
};

/* Completed foreign tags are absent from AIH_OPP.OBJ's retained graph. */
struct AIH_Opp_GameSetupCodegenView {
    int raceType, numLaps, skill, commMode, tournamentMultiplier, cops;
    int trafficDensity, localCar, catchupLogic, replayMode, instantReplay;
    int mirrorTrack, reverseTrack;
};
struct AIH_Opp_SimGlobalCodegenView { int gameStarted, gameTicks; };
struct AIH_Opp_SliceCodegenView {
    int center[3];
    char normal[3], forward[3], right[3];
    u_char acousticType;
    short pavedProfile, leftDrive, rightDrive;
    u_char chunkIndex, laneCount, avgPavedWidthLf, avgPavedWidthRt;
};

#define GameSetup_tData AIH_Opp_GameSetupCodegenView
#define Sim_tSimGlobalVar AIH_Opp_SimGlobalCodegenView
#define Trk_NewSlice AIH_Opp_SliceCodegenView

typedef int CarLogic_tObservations[1][3];

#endif

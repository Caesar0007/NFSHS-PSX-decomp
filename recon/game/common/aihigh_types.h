/* aihigh.obj's exact owner delta over the shared AI hierarchy graph. */
#ifndef NFS4_GAME_COMMON_AIHIGH_TYPES_H
#define NFS4_GAME_COMMON_AIHIGH_TYPES_H

#include "aih_hierarchy_types.h"

typedef enum AIHigh_CopGameType_t {
    COP_GAME_NO = 0,
    COP_GAME_PURSUIT = 1,
    COP_GAME_BTC_1HC = 2,
    COP_GAME_BTC_2HC = 3,
    COP_GAME_BTC_1HC1HP = 4
} AIHigh_CopGameType_t;


#include "aistate_classes.h"

/* Exact foreign class layouts needed by placement construction in this TU;
   their completed tags are omitted by AIHIGH.OBJ's linked debug graph. */
struct AIHigh_BTC_HumanPerp : public AIHigh_BTC_Perp {
    AIHigh_BTC_HumanPerp(Car_tObj *carObj) : AIHigh_BTC_Perp(carObj) {}
    ~AIHigh_BTC_HumanPerp() {}
    void NewStage(AIHigh_BTC_HumanCop *cop);
    void HighExecute();
};
struct AIHigh_BTC_AIPerp : public AIHigh_BTC_Perp {
    int perpMode_;
    int creationTime_, madeContactTime_, timeUntilContact_, escapeDuration_;
    int originalMass_, originalMassInv_;
    Car_tObj *closestCopCarObj_;
    int closestCopCarDistanceMeters_;
    AIHigh_BTC_AIPerp(Car_tObj *carObj);
    ~AIHigh_BTC_AIPerp();
    void AvoidCops();
    void CalculateTimeTillContact();
    void FindClosestCop();
    void HighExecute();
    void NewStage(AIHigh_BTC_HumanCop *cop);
};
struct AIHigh_BTC_Wingman : public AIHigh_BTC_Cop {
    Wingman_Role currentRole_, newRole_;
    AIHigh_BTC_HumanCop *newHumanBoss_;
    int spikeBeltPlaced_, spikeBeltSlice_, spikeBeltInterceptReleaseTime_;
    AIHigh_BTC_Wingman(Car_tObj *carObj, int copIndex);
    void HighExecute();
    int CheckForActivation();
    int UpdateFreezeModeAndPullOverMode();
    void SetupWingman(AIHigh_BTC_HumanCop *humanCop);
    void SetupBlockader(AIHigh_BTC_HumanCop *humanCop, int spikeBeltRequest);
};
struct AIHigh_Traffic : public AIHigh_Base {
    void HighExecute();
    int ignoreCops_, forcePurgatory_;
    SceneElem *accidentData_;
    AIHigh_Traffic(Car_tObj *carObj);
};
struct AIHigh_Human : public AIHigh_Player {
    void HighExecute();
    AIHigh_Human(Car_tObj *carObj);
};
struct AIHigh_Opponent : public AIHigh_Player {
    void HighExecute();
    AIHigh_tAttackMode attackMode_;
    Car_tObj *lastHumanHitter_;
    int hitCount_, attackTicksLeft_;
    AIHigh_Opponent(Car_tObj *carObj);
};
struct AIHigh_Cop : public AIHigh_BasicCop {
    void HighExecute();
    AIHigh_Player *perpTarget_;
    int forcePurgatory_, chaseIndex_, requestSpikeBeltAtSlice_;
    int aggressionLevel_;
    AIHigh_Cop(Car_tObj *carObj, int idx);
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
#define RaceType_HotPursuit 1
#define RaceType_Id5 5

typedef int CarLogic_tObservations[1][3];

#endif

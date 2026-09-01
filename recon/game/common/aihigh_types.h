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

extern __vtbl_ptr_type AIState_None_vtable[];

struct AIState_None : public AIState_Base {
    AIState_None() {}
    AIState_None(Car_tObj *carObj) : AIState_Base(carObj) {
        _vf = (__vtbl_ptr_type (*)[4])AIState_None_vtable;
    }
    void Execute();
};

extern __vtbl_ptr_type AIHigh_None_vtable[];

struct AIHigh_None : public AIHigh_Base {
    AIHigh_None() {}
    AIHigh_None(Car_tObj *carObj) : AIHigh_Base(carObj) {
        _vf = (__vtbl_ptr_type (*)[3])AIHigh_None_vtable;
    }
    ~AIHigh_None();
    void HighExecute();
};

/* Exact foreign class layouts needed by placement construction in this TU;
   their completed tags are omitted by AIHIGH.OBJ's linked debug graph. */
struct AIHigh_BTC_HumanPerp : public AIHigh_BTC_Perp {
    AIHigh_BTC_HumanPerp() {}
    ~AIHigh_BTC_HumanPerp();
    void NewStage(AIHigh_BTC_HumanCop *cop);
    void HighExecute();
};
struct AIHigh_BTC_AIPerp : public AIHigh_BTC_Perp {
    int perpMode_;
    int creationTime_, madeContactTime_, timeUntilContact_, escapeDuration_;
    int originalMass_, originalMassInv_;
    Car_tObj *closestCopCarObj_;
    int closestCopCarDistanceMeters_;
    AIHigh_BTC_AIPerp() {}
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
    AIHigh_BTC_Wingman() {}
    AIHigh_BTC_Wingman(Car_tObj *carObj, int copIndex);
    ~AIHigh_BTC_Wingman();
    void HighExecute();
    int CheckForActivation();
    int UpdateFreezeModeAndPullOverMode();
    void SetupWingman(AIHigh_BTC_HumanCop *humanCop);
    void SetupBlockader(AIHigh_BTC_HumanCop *humanCop, int spikeBeltRequest);
};
struct AIHigh_Traffic : public AIHigh_Base {
    int ignoreCops_, forcePurgatory_;
    SceneElem *accidentData_;
    AIHigh_Traffic() {}
    AIHigh_Traffic(Car_tObj *carObj);
};
struct AIHigh_Human : public AIHigh_Player {
    AIHigh_Human() {}
    AIHigh_Human(Car_tObj *carObj);
};
struct AIHigh_Opponent : public AIHigh_Player {
    AIHigh_tAttackMode attackMode_;
    Car_tObj *lastHumanHitter_;
    int hitCount_, attackTicksLeft_;
    AIHigh_Opponent() {}
    AIHigh_Opponent(Car_tObj *carObj);
};
struct AIHigh_Cop : public AIHigh_BasicCop {
    AIHigh_Player *perpTarget_;
    int forcePurgatory_, chaseIndex_, requestSpikeBeltAtSlice_;
    int aggressionLevel_;
    AIHigh_Cop() {}
    AIHigh_Cop(Car_tObj *carObj, int idx);
};

struct AIHigh_GameSetupCodegenView {
    int raceType;
    char _rest[2596];
};
#define GameSetup_tData AIHigh_GameSetupCodegenView
#define RaceType_HotPursuit 1
#define RaceType_Id5 5

typedef int CarLogic_tObservations[1][3];

#endif

/* aihigh.obj's exact owner delta over the shared AI hierarchy graph. */
#if !defined(NFS4_GAME_COMMON_AIHIGH_TYPES_H)
#define NFS4_GAME_COMMON_AIHIGH_TYPES_H
#define NFS4_AIH_HIERARCHY_WINGMAN "aihigh_types.h"   /* retail aihigh.obj: AIHigh_CopGameType_t right after stateType_t (second pass below) */
#define NFS4_COLOR_CAR_STRUCT_ONLY   /* retail: one TPDEF Car_tObj (color_types.h) */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_AIHIGH_PLAYER_PLAIN   /* aihigh.h: AIHigh_Player stays a plain struct here (retail TPDEF count) */
#include "aih_hierarchy_types.h"








#include "aistate.h"
/* Exact foreign class layouts needed by placement construction in this TU;
   their completed tags are omitted by AIHIGH.OBJ's linked debug graph. */
#line 276 "C:/nfs4/GAME/COMMON/AIHIGH.H"
inline AIHigh_BTC_HumanPerp::AIHigh_BTC_HumanPerp(Car_tObj *carObj) : AIHigh_BTC_Perp(carObj) {}
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
#define NFS4_AIHIGH_TYPE_PART 2
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART
#define NFS4_AIHIGH_TYPE_PART 1
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART

/* GameSetup_tData: not in retail aihigh.obj (GameSetup_gData is read through its word view) */















#define RaceType_HotPursuit 1
#define RaceType_Id5 5

typedef int CarLogic_tObservations[1][3];

#elif !defined(NFS4_AIHIGH_WINGMAN_DONE)   /* second pass: aih_hierarchy_types.h NFS4_AIH_HIERARCHY_WINGMAN */
#define NFS4_AIHIGH_WINGMAN_DONE
enum AIHigh_CopGameType_t {
    COP_GAME_NO = 0,
    COP_GAME_PURSUIT = 1,
    COP_GAME_BTC_1HC = 2,
    COP_GAME_BTC_2HC = 3,
    COP_GAME_BTC_1HC1HP = 4
};
#include "shared/Wingman_Role.h"
#endif

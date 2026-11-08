#ifndef NFS4_GAME_COMMON_AIH_BTCCOP_TYPES_H
#define NFS4_GAME_COMMON_AIH_BTCCOP_TYPES_H   /* aih_btccop.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
/* newton.obj's complete 87-record graph is a strict semantic subset. */
#define NFS4_NEWTON_AS_AI_BTCCOP   /* retail: the cop/physics/kernel types at their aih_btccop places (newton_types.h) */
#include "newton_types.h"

typedef struct AIPhysic_BrakeInfo { u_char brakeTable_[128]; int deceleration_; } AIPhysic_BrakeInfo;
#include "shared/copLevel_t.h"
#include "shared/copGame_t.h"
#include "shared/copType.h"
#include "shared/crimeType.h"
struct AICop_BasicPerpInfo {
    int copsAssigned_[2];
    crimeType crime_;
    inline crimeType Crime() { return crime_; }   /* retail pair on the embedded info (computed `this`, no row) */
};
struct AICop_PerpChaseInfo {
    int engagementTime_;
    copGame_t *copGameInfo_;
    int chaseLevelIndex_, bestChaseLevelIndex_;
    copLevel_t *chaseLevel_;
    int totalEngagementPercent_, blockadeDone_;
    int engagementPercentIncreasePerTick_, copFreeTicks_;
};
#include "shared/AIPhysic_ModelConfig_t.h"

/* This header's original anonymous enum survives in SYM without a typedef. */
enum {
    PERPMODE_CRUISE = 0,
    PERPMODE_FAST = 1,
    PERPMODE_MADECONTACT = 2,
    PERPMODE_TEASE = 3,
    PERPMODE_ESCAPE = 4,
    PERPMODE_CHASEON = 5
};

#include "shared/trigger_anyTrigger_t.h"
#include "shared/trigger_simple_t.h"
#include "shared/trigger_roadblock_t.h"
#include "shared/trigger_offroad_t.h"
#include "shared/trigger_trafficAccident_t.h"
#include "shared/trigger_pathPosition_t.h"
#include "shared/trigger_trafficPath_t.h"
#include "shared/trigger_t.h"

typedef struct AIDelayCar {
    int delayFactor_;
    Car_tObj *basisCar_, *targetCar_;
    int deltaMeters_, slice_;
    coorddef deltaPosition_, position_;
    int deltaRoadPosition_, roadPosition_, laneIndex_, currentSpeed_;
    AIDelayCar(Car_tObj *basisCar, Car_tObj *targetCar, int delayFactor);
    void SetNewTargetCar(Car_tObj *targetCar);
    void Update(); int GetCurrentSpeed() { return currentSpeed_; } /* inferred field getter */ int GetRoadPosition() { return roadPosition_; } /* inferred getter */
} AIDelayCar;

#include "aistate.h"
#include "shared/SceneElem.h"
#include "shared/SceneSortedElem.h"
#include "shared/stateType_t.h"
#include "shared/Wingman_Role.h"

/* AIState_Idle's empty inline ctor lives HERE, not in aistate.h: aistate.obj (Idle's key-function
   TU) carries no out-of-line copy, which cc1plus 2.8 would emit for any inline member it can see. */
inline AIState_Idle::AIState_Idle(Car_tObj *carObj) : AIState_Base(carObj) {}
inline AIState_Idle::AIState_Idle(Car_tObj *carObj, int idleInPlace) : AIState_Base(carObj) {
    idleInPlaceFlag_ = idleInPlace;
}
inline int AIState_Chase::BarrierTicks32() { return barrierTicks32_; }
inline int AIState_Chase::InMurderRange(int minTimeInZone, int minLatMetersDistance, int minLongMetersDistance) {
    return minTimeInZone < inTargetRegion_ && __builtin_abs(latMetersBetween_) < minLatMetersDistance &&
           __builtin_abs(longMetersBetween_) < minLongMetersDistance;
}





































































typedef struct AIHigh_Base {
    Car_tObj *carObj_;
    AIState_Base *state_;
    stateType_t stateType_;
    int schedulingOff_, lastTrafficTriggerCheckSlice_;
    AIHigh_Base(Car_tObj *carObj);
    virtual void HighExecute() = 0;
    virtual ~AIHigh_Base();
    void StateExecute();
    /* member form of AIHigh_SetState: retail pairs record `this` (AIHigh_Base) + newState; safe as an inline MEMBER
       now that aihigh.cpp (the key-function TU) is built with no_implement_inlines */
    inline void SetState(AIState_Base *newState, stateType_t newStateType) {
        if (state_ != (AIState_Base *)0)
            delete state_;
        state_ = newState;
        stateType_ = newStateType;
    }
    inline Car_tObj *CarObj() { return carObj_; }   /* retail pairs record `this` typed AIHigh_Base */ void SetSchedulingOff(int off) { schedulingOff_ = off; } bool SchedulingOff() { return schedulingOff_ != 0; } int ExchangeTrafficTriggerCheckSlice(int newSlice) { int temp = lastTrafficTriggerCheckSlice_; lastTrafficTriggerCheckSlice_ = newSlice; return temp; }
} AIHigh_Base;

/* Non-member inline helpers, not members: retail aihigh.obj (the key-function TU of AIHigh_Base,
   ~AIHigh_Base) carries no out-of-line SetState/GetCarObj copies, and cc1plus 2.8 always emits
   copies of a key-function class's inline MEMBERS there (probe build/psyq/probe/vt3.i). */
static inline void AIHigh_SetState(AIHigh_Base *high, AIState_Base *newState, stateType_t newStateType) {
    AIState_Base *oldState = high->state_;
    if (oldState != (AIState_Base *)0) {
        delete oldState;   /* virtual ~AIState_Base with __in_chrg 3 */
    }
    high->state_ = newState;
    high->stateType_ = newStateType;
}
static inline Car_tObj *AIHigh_GetCarObj(AIHigh_Base *high) { return high->carObj_; }

struct AIHigh_BasicPerp : public AIHigh_Base {
    enum {
        PULLOVER_NONE = 0,
        PULLOVER_WARNING = 1,
        PULLOVER_BUST = 2,
        PULLOVER_EOG = 3
    } pullOverMode_;
    struct { int copIndex, carIndex; } positionVSCopList_[6];
    int copVSPositionList_[6];
    int beatingTicksLeft_, lastPullOverTime_;
    Car_tObj *lastArrestingCop_;
    AICop_BasicPerpInfo basicPerpInfo_;
    int AddChaser(int a, int b, copType ct);
    void RemoveChaser(int a, int b, copType ct);
    int CheckChaserPosition(int a, int b);
    AIHigh_BasicPerp(Car_tObj *carObj);
    ~AIHigh_BasicPerp() {}
    virtual void CheckForCrimes();
    int CheckIfCaught();
    void RemoveCloseCops();
    void Clear();
};

struct AIHigh_Player : public AIHigh_BasicPerp {
    int numWarnings_, numBusts_, newTriggerProb_, lastTriggerCheckSlice_;
    AICop_PerpChaseInfo perpChaseInfo_;
    AIHigh_Player(Car_tObj *carObj);
    ~AIHigh_Player() {}
    void HandleCops();
    int CheckIfABlockadeCanBeSetup();
    void SetupBlockade();
    void CheckForNewLevel(int level);
    void HandleSpeech();
    void MaintainAvailableCops();
    void CleanupBlockaders(int a);
    void HandlePullOver();
};
#include "shared/AIHigh_tAttackMode.h"
struct AIHigh_BTC_HumanCop;
struct AIHigh_BTC_Perp : public AIHigh_BasicPerp {
    int caught_, hudActivated_;
    AIHigh_BTC_HumanCop *originalActivationCop_;
    AIHigh_BTC_Perp(Car_tObj *carObj) : AIHigh_BasicPerp(carObj) {
        caught_ = 1; hudActivated_ = 0; originalActivationCop_ = (AIHigh_BTC_HumanCop *)0;   /* retail StartUp: HumanPerp vptr stored LAST (cross-jumped with the None path) */
    }
    void ReleaseCops();
    void HandleCops();
    int IsFalseArrest();
    int CheckForControlsPressed();
    void HandlePullOver();
    void NotifyCopsOfArrest();
    void NotifyCopsOfArrestComplete();
    void NotifyCopsOfFalseArrest();
    void NotifyHumanCopsOfArrestHud();
    void ClearForNewStage(AIHigh_BTC_HumanCop *cop);
    AIHigh_BTC_HumanCop *CheckForActivation();
};
#include "shared/blockadeMode_t.h"
#include "shared/blockade_t.h"
#include "shared/AIHigh_tDriveAwayMode.h"






typedef struct AIHigh_BasicCop : public AIHigh_Base {
    copType type_;
    int copIndex_;
    blockade_t blockade_;
    AIHigh_tDriveAwayMode driveAway_;
    AIHigh_BasicCop(Car_tObj *carObj, int idx);
    void CheckSpikeBelt();
    void SetupBlockadeElements(blockade_t *blockade);
    void HandleBlockadeSpeech();
    int ShouldIPerformCutOffBlock(int a, Car_tObj *carObj);
} AIHigh_BasicCop;

struct AIHigh_BTC_Cop : public AIHigh_BasicCop {
    AIHigh_BTC_Perp *perpTarget_;
    int chaseIndex_;
    enum {
        FREEZE_NONE = 0,
        FREEZE_NEWPERP_ROVE = 1,
        FREEZE_NEWPERP_DONE = 2,
        FREEZE_ARREST = 3,
        FREEZE_ARRESTDONE = 4
    } freezeMode_;
    AIHigh_BTC_Cop(Car_tObj *carObj, int copIndex);
    void AssignToPlayer(AIHigh_BTC_Perp *target);
    int GetCheckChasePosition(coorddef *pos);
    int CheckForNewTarget();
    void StartArrest(AIHigh_BTC_Perp *p);
    void FinishArrest(AIHigh_BTC_Perp *p);
    void FalseArrest(AIHigh_BTC_Perp *p);
    virtual void FreezeAndEndChase();
    void HudOff();
    inline AIHigh_BTC_Perp *PerpTarget() LINK_STRIPPED;
#line 471 "C:/nfs4/GAME/COMMON/AIHIGH.H"
};
#line 347 "recon/game/common/aih_btccop_types.h"
inline AIHigh_BTC_Perp *AIHigh_BTC_Cop::PerpTarget() { return perpTarget_; }
typedef struct AIHigh_BTC_HumanCop : public AIHigh_BTC_Cop {
    int currentStage_, stageRepeatCount_, stageTimeMultiplier_, timeLeft_, chaseStartTime_;
    static int lastInputRequestTick_;
    enum {
        WINGMAN_NONE = 0,
        WINGMAN_WINGMAN_REQUEST = 1,
        WINGMAN_BLOCKADER_REQUEST = 2,
        WINGMAN_BLOCKADER_SPIKEBELT_REQUEST = 3,
        WINGMAN_WINGMAN_ACTIVE = 4,
        WINGMAN_BLOCKADER_ACTIVE = 5
    } wingmanStatus_;
    int needPerp_, initialDirection_, initialMovement_, requestedDesiredSpeed_;
    AIHigh_BTC_HumanCop(Car_tObj *carObj, int copIndex);
    int FindRandomBarrierFreeArea(int startSlice, int safetyZone, int randomDistance);
    void ReleaseAndStartChase(AIHigh_BTC_Perp *p);
    void FreezeAndEndChase();
    void CheckConditionWithCop0();
    void NewStage(int copSlice, int direction, int movement);
    void UpdateAndCheckTimeLeft();
    void UpdateFreezeModeAndPullOverMode();
    void RequestWingman();
    void RequestBlockader(int spikeBeltRequest);
    int CheckForWingmanRequest();
    int CheckForBlockaderRequest(int *spikeBeltRequest);
    void UpdateWingmanRole(Wingman_Role currentRole);
    void ClearTrafficToPurgatory();
    void ResetClearTrafficToPurgatory();
    void SetDesiredSpeed();
    void HighExecute();
    void HudOn(AIHigh_BTC_Perp *p, int a, Car_tObj *carObj);
    /* accessors (retail HumanCop pairs); their standalone copies were removed by SLINK /strip (P6 Route C 2026-11-07) */
    inline int CurrentStage() LINK_STRIPPED; inline int InitialDirection() LINK_STRIPPED; inline int InitialMovement() LINK_STRIPPED;
    inline void SetRequestedDesiredSpeed(int speed) LINK_STRIPPED; inline int RequestedDesiredSpeed() LINK_STRIPPED;
    inline void SetInitialDirection(int initialDirection) LINK_STRIPPED; inline void SetInitialMovement(int initialMovement) LINK_STRIPPED;
#line 527 "C:/nfs4/GAME/COMMON/AIHIGH.H"
} AIHigh_BTC_HumanCop;
#line 387 "recon/game/common/aih_btccop_types.h"
inline int AIHigh_BTC_HumanCop::CurrentStage() { return currentStage_; }
inline int AIHigh_BTC_HumanCop::InitialDirection() { return initialDirection_; }
inline int AIHigh_BTC_HumanCop::InitialMovement() { return initialMovement_; }
inline void AIHigh_BTC_HumanCop::SetRequestedDesiredSpeed(int speed) { requestedDesiredSpeed_ = speed; }
inline int AIHigh_BTC_HumanCop::RequestedDesiredSpeed() { return requestedDesiredSpeed_; }
inline void AIHigh_BTC_HumanCop::SetInitialDirection(int initialDirection) { initialDirection_ = initialDirection; }
inline void AIHigh_BTC_HumanCop::SetInitialMovement(int initialMovement) { initialMovement_ = initialMovement; }
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
#line 548 "C:/nfs4/GAME/COMMON/AIHIGH.H"
};
#line 401 "recon/game/common/aih_btccop_types.h"

struct AIHigh_Traffic : public AIHigh_Base {
    int ignoreCops_, forcePurgatory_;
    SceneElem *accidentData_;
    inline void SetForcePurgatory(int force) { forcePurgatory_ = force; }   /* retail pair: this AIHigh_Traffic */
};
#include "shared/BW_tContext.h"
enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
};
#include "shared/SPCHNFSType_POSITION.h"
#include "shared/SPCHNFSType_DISTANCE.h"
#include "shared/SPCHNFSType_COLOUR.h"
#include "shared/SPCHNFSType_ACCIDENT.h"
#include "shared/SPCHNFSType_AMBULANCE.h"
#include "shared/SPCHNFSType_PURS_UPDT.h"
#include "shared/SPCHNFSType_ARREST.h"
#include "shared/SPCHNFSType_vs_RDBLK_SSTRP.h"
#include "shared/SPCHNFSType_PERP_NAME.h"
#include "shared/SPCHNFSType_CONFIRM.h"
#include "shared/SPCHNFSType_SPIKE_BELT_SIDE.h"
#include "shared/SPCHNFSType_REVINTRO.h"

#include "shared/CarBank.h"
#include "shared/LocationBank.h"
#include "shared/CallSignBank.h"

/* Speech's three nested bank aggregates survive even though its outer tag does not. */
struct { CarBank Mobile[9], Dispatch[9]; };
struct { LocationBank Mobile[16], Dispatch[16]; };
struct { CallSignBank Mobile, Dispatch; };

/* Speech, as this surface needs it: the nested polymorphic Speaker and the two static finders */
struct Speech {
    struct Speaker {
        SPCHNFSType_POSITION fPosition;
        SPCHNFSType_DISTANCE fDistance;
        SPCHNFSType_COLOUR fColour;
        SPCHNFSType_ACCIDENT fAccident;
        SPCHNFSType_AMBULANCE fAmbulance;
        SPCHNFSType_vs_RDBLK_SSTRP fBlockade;
        SPCHNFSType_REVINTRO fReverse;
        SPCHNFSType_CONFIRM fConfirm;
        SPCHNFSType_PERP_NAME fPerpName;
        SPCHNFSType_SPIKE_BELT_SIDE fSpikeSide;
        SPCHNFSType_PURS_UPDT fUpdate;
        SPCHNFSType_ARREST fArrest;
        int fCar, fLocation, fFrom, fTo, fWing;
        bool fHavePerp;
        Speaker *fSub;
#include "speech_speaker_virtuals.inc"
    };
    static Speaker *Dispatch();
    static Speaker *Mobile(Car_tObj *carObj);
};
enum AIDataRecord_RecordMethod_t {
    NORMAL_M = 0,
    RECORD_M = 1,
    TEST_M = 2
};

typedef struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    AIDataRecord_RecordMethod_t recordMethod_; /* accessors as in aidatarecord_types.h (retail 9 TPDEFs per includer) */ inline AIDataRecord_RecordMethod_t RecordMethod() { return recordMethod_; } inline char *Name() { return name_; } inline char *DataBuffer() { return dataBuffer_; } inline char *PreAllocatedBuffer() { return preAllocatedBuffer_; } inline int BufferSize() { return bSize_; } inline int NumElements() { return numElements_; } inline void SetDataBuffer(char *buffer) { dataBuffer_ = buffer; }
    virtual ~AIDataRecord_t();   /* aidatarecord.cpp owns the family; slots: dtor, Setup */
    virtual void Setup();
} AIDataRecord_t;
struct AIDataRecord_AccTable_t : public AIDataRecord_t { int scale_; };
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {};
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
#include "shared/Trk_ObjectDef.h"
#include "shared/Trk_CollideBoomInst.h"







#include "shared/Trk_AnimateInst.h"




#include "shared/Trk_SimObject.h"





typedef struct AnimScript {   /* retail: C-style typedef (two TPDEF AnimScript) */
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
} AnimScript;






#include "shared/AnimDef.h"
struct DRender_tView;
struct Draw_DCache;
/* object.cpp's polymorphic root, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */
struct ObjectAnim {
    ObjectAnim() {}
    virtual ~ObjectAnim() {}
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
struct ObjectFinishedMultiAnim : public ObjectAnim { };
struct ObjectFinishedSignAnim : public ObjectAnim {
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
};
/* Canonical foreign aggregates used by this translation unit. */
#include "shared/AITune_BTC_t.h"



#include "shared/Sim_tSimSystemVar.h"



#include "shared/Trk_NewSlice.h"







typedef int CarLogic_tObservations[1][3];
typedef int Input_tDeviceCall();
typedef long (*ReparmFuncPtr)();
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();

#endif

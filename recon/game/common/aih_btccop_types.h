/* aih_btccop.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_AIH_BTCCOP_TYPES_H
#define NFS4_GAME_COMMON_AIH_BTCCOP_TYPES_H

/* newton.obj's complete 87-record graph is a strict semantic subset. */
#include "newton_types.h"

/* GCC 2.8.1 cannot materialize extern arrays of its built-in old-ABI entry. */
typedef struct __nfs4_vtbl_ptr_t {
    short delta, index;
    int (*pfn)(...);
} __nfs4_vtbl_ptr_t;
#define __vtbl_ptr_type __nfs4_vtbl_ptr_t

typedef enum AIDataRecord_RecordMethod_t {
    NORMAL_M = 0,
    RECORD_M = 1,
    TEST_M = 2
} AIDataRecord_RecordMethod_t;

typedef enum copType {
    COP_REGULAR = 0,
    COP_SUPER = 1
} copType;

typedef enum cruiseMode_t {
    CRUISE_ATSETSPEED = 0,
    CRUISE_ATFACTOR = 1,
    CRUISE_ATTRAFFICSPEED = 2
} cruiseMode_t;

typedef enum stateType_t {
    STATE_NONE = 0,
    STATE_PURGATORY = 1,
    STATE_NORMAL = 2,
    STATE_IDLE = 3,
    STATE_CHASE = 4,
    STATE_OFFROAD = 5,
    STATE_ROVING_TRAFFIC = 6,
    STATE_NONACTIVE = 7,
    STATE_DONUTS = 8,
    STATE_GOTOSLICE = 9,
    STATE_CRUISE = 10
} stateType_t;

typedef enum Wingman_Role {
    ROLE_IDLE = 0,
    ROLE_WINGMAN = 1,
    ROLE_BLOCKADER = 2,
    ROLE_BLOCKADER_SPIKEBELT = 3
} Wingman_Role;

typedef enum AIHigh_tAttackMode {
    NO_ATTACK = 0,
    REAR_END = 1,
    SCRIPT_ATTACK = 2,
    PROVOKED_ATTACK = 3
} AIHigh_tAttackMode;

typedef enum blockadeMode_t {
    BLOCKADEMODE_NONE = 0,
    BLOCKADEMODE_SETUP = 1,
    BLOCKADEMODE_WAITING = 2,
    BLOCKADEMODE_CHASE = 3,
    BLOCKADEMODE_SETUP_FOR_OTHER = 4
} blockadeMode_t;

typedef enum AIHigh_tDriveAwayMode {
    DRIVEAWAY_NONE = 0,
    DRIVEAWAY_RESET = 1,
    DRIVEAWAY_NORESET = 2
} AIHigh_tDriveAwayMode;

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

/* This header's original anonymous enum survives in SYM without a typedef. */
enum {
    PERPMODE_CRUISE = 0,
    PERPMODE_FAST = 1,
    PERPMODE_MADECONTACT = 2,
    PERPMODE_TEASE = 3,
    PERPMODE_ESCAPE = 4,
    PERPMODE_CHASEON = 5
};

struct trigger_anyTrigger_t { int type, slice; };
struct trigger_simple_t { int type, slice, dir, side, moving; };
struct trigger_roadblock_t { int type, slice, dir, numCars, spikeBelt; };
struct trigger_offroad_t {
    int type, slice, dir;
    coorddef position;
    matrixtdef orientation;
    int maxSpeed, releaseTime, endSlice;
};
struct trigger_trafficAccident_t {
    int type, slice;
    coorddef position;
    matrixtdef orientation;
};
struct trigger_pathPosition_t {
    coorddef position;
    int targetSpeed, waitTime;
};
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

struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    AIDataRecord_RecordMethod_t recordMethod_;
    __vtbl_ptr_type (*_vf)[3];
};
struct AIDataRecord_AccTable_t : public AIDataRecord_t { int scale_; };
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {};

struct Trk_ObjectDef { short id; u_char vertexCount, quadCount; };
struct Trk_CollideBoomInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad;
    int x, y, z;
    short qx, qy, qz, qw, sx, sy, sz;
    u_char simIndex, boomIndex;
};
struct Trk_AnimateInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad, count, interval;
};
struct Trk_SimObject {
    int point[3];
    short radius, serialNum;
    u_char topCRAP, bottomCRAP, instIndex, type;
};

struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
};
struct SceneElem {
    int type, size, committed, visible;
    coorddef cp;
    int height;
    matrixtdef orient;
    int subType, subTypeIndex, scalar1, scalar2, scalar3, scalar4;
};
struct SceneSortedElem { int slice_; SceneElem *se; };
struct AnimDef { int type, numPieces, objDefIndex, baseAnim, animIndex; };
struct ObjectAnim { __vtbl_ptr_type (*_vf)[3]; };
struct ObjectFinishedMultiAnim { ObjectAnim _base_ObjectAnim; };
struct ObjectFinishedSignAnim {
    ObjectAnim _base_ObjectAnim;
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
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

struct AICop_BasicPerpInfo {
    int copsAssigned_[2];
    crimeType crime_;
};
struct AICop_PerpChaseInfo {
    int engagementTime_;
    copGame_t *copGameInfo_;
    int chaseLevelIndex_, bestChaseLevelIndex_;
    copLevel_t *chaseLevel_;
    int totalEngagementPercent_, blockadeDone_;
    int engagementPercentIncreasePerTick_, copFreeTicks_;
};

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
struct AIState_Idle : public AIState_Base {
    int roadPosition_, idleInPlaceFlag_;
    AIState_Idle() {}
    ~AIState_Idle();
    void Execute();
    void SetIdlePosition(int pos);
};
extern __vtbl_ptr_type AIState_NonActive_vtable[];
struct AIState_NonActive : public AIState_Base {
    AIState_NonActive() {}
    AIState_NonActive(Car_tObj *carObj) : AIState_Base(carObj) {
        _vf = (__vtbl_ptr_type (*)[4])((char *)AIState_NonActive_vtable + 8);
    }
    ~AIState_NonActive();
    void Execute();
};

struct AIHigh_Base {
    Car_tObj *carObj_;
    AIState_Base *state_;
    stateType_t stateType_;
    int schedulingOff_, lastTrafficTriggerCheckSlice_;
    __vtbl_ptr_type (*_vf)[3];
    AIHigh_Base() {}
    AIHigh_Base(Car_tObj *carObj);
    ~AIHigh_Base();
    Car_tObj *GetCarObj() { return carObj_; }
    void StateExecute();
    void SetState(AIState_Base *newState, stateType_t newStateType) {
        AIState_Base *oldState = state_;
        if (oldState != (AIState_Base *)0) {
            (*(*oldState->_vf)[2].pfn)
                ((int)&oldState->carObj_ + (*oldState->_vf)[2].delta, 3);
        }
        state_ = newState;
        stateType_ = newStateType;
    }
};

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
    AIHigh_BasicPerp() {}
    AIHigh_BasicPerp(Car_tObj *carObj);
    void CheckForCrimes();
    int CheckIfCaught();
    void RemoveCloseCops();
    void Clear();
};

struct AIHigh_Player : public AIHigh_BasicPerp {
    int numWarnings_, numBusts_, newTriggerProb_, lastTriggerCheckSlice_;
    AICop_PerpChaseInfo perpChaseInfo_;
    AIHigh_Player() {}
    AIHigh_Player(Car_tObj *carObj);
    void HandleCops();
    int CheckIfABlockadeCanBeSetup();
    void SetupBlockade();
    void CheckForNewLevel(int level);
    void HandleSpeech();
    void MaintainAvailableCops();
    void CleanupBlockaders(int a);
    void HandlePullOver();
};

struct AIHigh_BTC_HumanCop;
struct AIHigh_BTC_Perp : public AIHigh_BasicPerp {
    int caught_, hudActivated_;
    AIHigh_BTC_HumanCop *originalActivationCop_;
    AIHigh_BTC_Perp() {}
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

struct blockade_t {
    blockadeMode_t mode;
    AIHigh_Player *target;
    int flags, chaseLevel, requestSpikeBeltAtSlice, slice, direction;
    int latPos, rotation, reverse, releaseTime, initialPlayerDistanceMetersInt;
    short blockadeSpeechFlags;
};

struct AIHigh_BasicCop : public AIHigh_Base {
    copType type_;
    int copIndex_;
    blockade_t blockade_;
    AIHigh_tDriveAwayMode driveAway_;
    AIHigh_BasicCop() {}
    AIHigh_BasicCop(Car_tObj *carObj, int idx);
    void CheckSpikeBelt();
    void SetupBlockadeElements(blockade_t *blockade);
    void HandleBlockadeSpeech();
    int ShouldIPerformCutOffBlock(int a, Car_tObj *carObj);
};

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
    AIHigh_BTC_Cop() {}
    AIHigh_BTC_Cop(Car_tObj *carObj, int copIndex);
    ~AIHigh_BTC_Cop();
    void AssignToPlayer(AIHigh_BTC_Perp *target);
    int GetCheckChasePosition(coorddef *pos);
    int CheckForNewTarget();
    void StartArrest(AIHigh_BTC_Perp *p);
    void FinishArrest(AIHigh_BTC_Perp *p);
    void FalseArrest(AIHigh_BTC_Perp *p);
    void FreezeAndEndChase();
    void HudOff();
};

struct AIHigh_BTC_HumanCop : public AIHigh_BTC_Cop {
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
    AIHigh_BTC_HumanCop() {}
    AIHigh_BTC_HumanCop(Car_tObj *carObj, int copIndex);
    ~AIHigh_BTC_HumanCop();
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
    void SetTarget(Car_tObj *, coorddef *);
    void SetMurderMode(int, int);
    int FindBarrierEndSlice();
};

struct AIState_GotoSlice : public AIState_Normal {
    int targetSlice_, stopWhenArrivedAtSlice_;
    AIState_GotoSlice() {}
    AIState_GotoSlice(Car_tObj *, int, int);
    int InTargetSliceRange(int);
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
};

struct SPCHNFSType_POSITION { u_long flags; };
struct SPCHNFSType_DISTANCE { u_long flags; };
struct SPCHNFSType_COLOUR { u_long flags; };
struct SPCHNFSType_ACCIDENT { u_long flags; };
struct SPCHNFSType_AMBULANCE { u_long flags; };
struct SPCHNFSType_PURS_UPDT { u_long flags; };
struct SPCHNFSType_ARREST { u_long flags; };
struct SPCHNFSType_vs_RDBLK_SSTRP { u_long flags; };
struct SPCHNFSType_PERP_NAME { u_long flags; };
struct SPCHNFSType_CONFIRM { u_long flags; };
struct SPCHNFSType_SPIKE_BELT_SIDE { u_long flags; };
struct SPCHNFSType_REVINTRO { u_long flags; };

struct CarBank { int fFull, fMake, fModel; };
struct LocationBank { int fStartSlice, fEndSlice, fBankId; char *fName; };
struct CallSignBank { int fAllUnits, fDispatch; int fMobile[15]; };

/* Speech's three nested bank aggregates survive even though its outer tag does not. */
struct { CarBank Mobile[9], Dispatch[9]; };
struct { LocationBank Mobile[16], Dispatch[16]; };
struct { CallSignBank Mobile, Dispatch; };

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
    __vtbl_ptr_type (*_vf)[31];
    void Report(Car_tObj *) asm("Report__Q26Speech7SpeakerP8Car_tObj");
    void Engage(Car_tObj *) asm("Engage__Q26Speech7SpeakerP8Car_tObj");
    inline void Deny()
    {
        (**(int (**)(...))((int)*_vf + 0x1c))
            ((int)&fPosition.flags + (int)*(short *)((int)*_vf + 0x18));
    }
    inline void Grant()
    {
        (**(int (**)(...))((int)*_vf + 0x24))
            ((int)&fPosition.flags + (int)*(short *)((int)*_vf + 0x20));
    }
    inline void Ready(Car_tObj *wing)
    {
        (**(int (**)(...))((int)*_vf + 0x2c))
            ((int)&fPosition.flags + (int)*(short *)((int)*_vf + 0x28), wing);
    }
    inline void Lose()
    {
        (**(int (**)(...))((int)*_vf + 0x3c))
            ((int)&fPosition.flags + (int)*(short *)((int)*_vf + 0x38));
    }
    inline void Catch(int ticket)
    {
        (**(int (**)(...))((int)*_vf + 0x4c))
            ((int)&fPosition.flags + (int)*(short *)((int)*_vf + 0x48), ticket);
    }
    inline void RoadBlock()
    {
        (**(int (**)(...))((int)*_vf + 0x54))
            ((int)&fPosition.flags + (int)*(short *)((int)*_vf + 0x50));
    }
    inline void SpikeBelt()
    {
        (**(int (**)(...))((int)*_vf + 0x5c))
            ((int)&fPosition.flags + (int)*(short *)((int)*_vf + 0x58));
    }
    inline void Backup()
    {
        (**(int (**)(...))((int)*_vf + 0x64))
            ((int)&fPosition.flags + (int)*(short *)((int)*_vf + 0x60));
    }
    inline void Purge()
    {
        (**(int (**)(...))((int)*_vf + 0x84))
            ((int)&fPosition.flags + (int)*(short *)((int)*_vf + 0x80));
    }
};

/* Canonical foreign aggregates used by this translation unit. */
struct AITune_BTC_t {
    int glueMult, speedMult, weightMult, baseChaseTime;
    int wingmanTime, blockaderTime, spikeBeltTime;
};
struct Sim_tSimSystemVar {
    int restartGame, endSimGame, pauseSim, keyRelease, quickPauseSim;
    int goalClockTicks, currentClockTicks;
};
struct Trk_NewSlice {
    int center[3];
    char normal[3], forward[3], right[3];
    u_char acousticType;
    short pavedProfile, leftDrive, rightDrive;
    u_char chunkIndex, laneCount, avgPavedWidthLf, avgPavedWidthRt;
};

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

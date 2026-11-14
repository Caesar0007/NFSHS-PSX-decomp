/* game/common/aihigh.h -- retail AIHIGH.H declarations recovered so far.
 * 2026-10-16: shared AIHigh class definitions recovered here so far.
 * Retail destructor records identify AIHIGH.H. The shared hierarchy includes
 * this header after their bases are complete. Retained method locations below
 * use retail coordinates; a synthesized destructor is located at its class end.
 * This is not a claim that the entire original header has been recovered. */
#if !defined(NFS4_AIHIGH_TYPE_PART) && !defined(_GAME_COMMON_AIHIGH_H_)
#define _GAME_COMMON_AIHIGH_H_

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */
/* P876: native members, static members and destructors are exposed by the
   included C++ classes. Removed encoded non-member declarations that either
   emitted nonexistent double-mangled exports or hid a real static member.
   Native-reference and shared-header regression receipts: scratchpad/p876_ai_bridges. */

void AIHigh_StartUp(void);   /* :58 */
void AIHigh_Restart1(void);   /* :110 */
void AIHigh_Restart2(void);   /* :115 */
void AIHigh_CleanUp(void);   /* :122 */
void AIHigh_Execute(void);   /* :134 */

/* The two emitted None methods identify AIHIGH.H in retail. */
struct AIHigh_None : public AIHigh_Base {
    AIHigh_None(Car_tObj *carObj) : AIHigh_Base(carObj) {}
#line 132 "C:/nfs4/GAME/COMMON/AIHIGH.H"
    void HighExecute() {}

};

/* Retail records both inline destructors in AIHIGH.H, not the private
   reconstruction hierarchy header. Method bodies remain unchanged. */
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
#ifdef NFS4_AIHIGH_PLAYER_PLAIN   /* aih_cop.obj already records AIHigh_Player TPDEF above retail: plain struct there (aih_cop_types.h) */
#define NFS4_AIHIGH_PLAYER_TD
#define NFS4_AIHIGH_PLAYER_NAME
#else   /* C-style typedef form: retail records TPDEF AIHigh_Player twice (one short in the other includers) */
#define NFS4_AIHIGH_PLAYER_TD typedef
#define NFS4_AIHIGH_PLAYER_NAME AIHigh_Player
#endif
#line 164 "C:/nfs4/GAME/COMMON/AIHIGH.H"
    ~AIHigh_BasicPerp() {}
    virtual void CheckForCrimes();
    int CheckIfCaught();
    void RemoveCloseCops();
    void Clear();
};

NFS4_AIHIGH_PLAYER_TD struct AIHigh_Player : public AIHigh_BasicPerp {
    int numWarnings_, numBusts_, newTriggerProb_, lastTriggerCheckSlice_;
    AICop_PerpChaseInfo perpChaseInfo_;
    AIHigh_Player(Car_tObj *carObj);
#line 202 "C:/nfs4/GAME/COMMON/AIHIGH.H"
    ~AIHigh_Player() {}
    void HandleCops();
    int CheckIfABlockadeCanBeSetup();
    void SetupBlockade();
    void CheckForNewLevel(int level);
    void HandleSpeech();
    void MaintainAvailableCops();
    void CleanupBlockaders(int a);
    void HandlePullOver();
    inline copLevel_t *ChaseLevel() { return perpChaseInfo_.chaseLevel_; }   /* retail pairs (this typed AIHigh_Player) */
    inline int LastPullOverTime() { return lastPullOverTime_; } inline int NewTriggerProb() { return newTriggerProb_; }
    int ExchangeLastTriggerCheckSlice(int newSlice); /* inferred exchange name; supplied inline newSlice/temp records */
} NFS4_AIHIGH_PLAYER_NAME;
/* Retail's synthesized Human destructor also identifies AIHIGH.H. */
struct AIHigh_Human : public AIHigh_Player {
    AIHigh_Human(Car_tObj *carObj);
    void HighExecute();
#line 219 "C:/nfs4/GAME/COMMON/AIHIGH.H"
};

#include "shared/AIHigh_tAttackMode.h"
/* Retail's synthesized Opponent destructor identifies AIHIGH.H. Keep the
   actual class here, shared by its implementation and placement-new caller;
   no explicit destructor body is added. */
struct AIHigh_Opponent : public AIHigh_Player {
    AIHigh_tAttackMode attackMode_;
    Car_tObj *lastHumanHitter_;
    int hitCount_, attackTicksLeft_;
    AIHigh_Opponent(Car_tObj *carObj);
    void CheckForWipeOut();
    int DoRearEnder();
    void HighExecute();
    int DoProvokedAttack();
#line 242 "C:/nfs4/GAME/COMMON/AIHIGH.H"
};
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
#line 267 "C:/nfs4/GAME/COMMON/AIHIGH.H"
};

/* Retail's HumanPerp destructor is synthesized: its only nested declarations
   belong to the real base destructors. An empty user body adds a wrong level. */
struct AIHigh_BTC_HumanPerp : public AIHigh_BTC_Perp {
    AIHigh_BTC_HumanPerp(Car_tObj *carObj);
    void NewStage(AIHigh_BTC_HumanCop *cop);
    void HighExecute();
#line 281 "C:/nfs4/GAME/COMMON/AIHIGH.H"
};

#ifdef NFS4_GAME_COMMON_AIH_BTCCOP_TYPES_H   /* AIH_BTCCop.obj (key object of the BTC cop classes) emits standalone copies of their inline members; the retail link removed them */
#define NFS4_AIHIGH_BTCCOP_STRIP LINK_STRIPPED
#else
#define NFS4_AIHIGH_BTCCOP_STRIP
#endif
#ifdef NFS4_GAME_COMMON_AIH_BTCPERP_TYPES_H   /* aih_btcperp.obj: its AIHigh_BTC_AIPerp first */
#include "aih_btcperp_types.h"
#else
#include "shared/blockadeMode_t.h"
#endif
#include "shared/blockade_t.h"
#include "shared/AIHigh_tDriveAwayMode.h"
typedef struct AIHigh_BasicCop : public AIHigh_Base {
    copType type_;
    int copIndex_;
    blockade_t blockade_;
    AIHigh_tDriveAwayMode driveAway_;
    inline void SetDriveAway(AIHigh_tDriveAwayMode mode) { driveAway_ = mode; }   /* retail: inline in every TU (no out-of-line SetDriveAway__15AIHigh_BasicCop in the SYM; 4th BasicCop body) */
    AIHigh_BasicCop(Car_tObj *carObj, int idx);
    void CheckSpikeBelt();
    void SetupBlockadeElements(blockade_t *blockade);
    void HandleBlockadeSpeech();
    int ShouldIPerformCutOffBlock(int a, Car_tObj *carObj);
    inline blockadeMode_t BlockadeMode() { return blockade_.mode; }   /* retail pairs (this typed AIHigh_BasicCop) */
    inline blockade_t *Blockade() { return &blockade_; }
    inline copType Type() { return type_; }
#line 414 "C:/nfs4/GAME/COMMON/AIHIGH.H"
} AIHigh_BasicCop;
#ifdef NFS4_AIHIGH_COP_AFTER_BASICCOP   /* retail AIHIGH.H order BasicCop(414) Cop(448) BTC_Cop(471): owners that record AIHigh_Cop */
#define NFS4_AIHIGH_TYPE_PART 1
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART
#endif
struct AIHigh_BTC_Cop : public AIHigh_BasicCop {   /* retail window "BTC_Cop BTC_Perp BTC_Cop" = plain def + the owner's PerpTarget body (aih_btccop_types.h) */
    AIHigh_BTC_Perp *perpTarget_; inline AIHigh_BTC_Perp *PerpTarget() NFS4_AIHIGH_BTCCOP_STRIP;
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
#line 471 "C:/nfs4/GAME/COMMON/AIHIGH.H"
};
inline AIHigh_BTC_Perp *AIHigh_BTC_Cop::PerpTarget() { return perpTarget_; }

struct AIHigh_BTC_HumanCop : public AIHigh_BTC_Cop {   /* retail: plain struct + 10 in-class accessors = 11 TPDEFs per includer */
    int currentStage_, stageRepeatCount_, stageTimeMultiplier_, timeLeft_, chaseStartTime_;
    enum {
        WINGMAN_NONE = 0,
        WINGMAN_WINGMAN_REQUEST = 1,
        WINGMAN_BLOCKADER_REQUEST = 2,
        WINGMAN_BLOCKADER_SPIKEBELT_REQUEST = 3,
        WINGMAN_WINGMAN_ACTIVE = 4,
        WINGMAN_BLOCKADER_ACTIVE = 5
    } wingmanStatus_;
    int needPerp_, initialDirection_, initialMovement_, requestedDesiredSpeed_;
    inline void SetNeedPerp(int needPerp) NFS4_AIHIGH_BTCCOP_STRIP;   /* flag setter: retail records this in ClearForNewStage */
    inline int CurrentStage() NFS4_AIHIGH_BTCCOP_STRIP;   /* stage getter: retail records this at the stage read */
    inline int InitialDirection() NFS4_AIHIGH_BTCCOP_STRIP; inline void SetInitialDirection(int initialDirection) NFS4_AIHIGH_BTCCOP_STRIP;   /* placement direction pair */
    inline int InitialMovement() NFS4_AIHIGH_BTCCOP_STRIP; inline void SetInitialMovement(int initialMovement) NFS4_AIHIGH_BTCCOP_STRIP;   /* placement movement pair */
    inline bool HasCatchTime() NFS4_AIHIGH_BTCCOP_STRIP;   /* HumanCop receiver, timeLeft_ > 5 in retail */
    inline int NeedsPerp() NFS4_AIHIGH_BTCCOP_STRIP;   /* lead-cop request query */
    inline void SetRequestedDesiredSpeed(int speed) NFS4_AIHIGH_BTCCOP_STRIP; inline int RequestedDesiredSpeed() NFS4_AIHIGH_BTCCOP_STRIP;   /* speed pair */
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
    static int lastInputRequestTick_;   /* retail SYM/MAP: _19AIHigh_BTC_HumanCop.lastInputRequestTick_ (defined in AIH_BTCCOP.CPP) */
#line 527 "C:/nfs4/GAME/COMMON/AIHIGH.H"
};
inline int AIHigh_BTC_HumanCop::CurrentStage() { return currentStage_; }
inline int AIHigh_BTC_HumanCop::InitialDirection() { return initialDirection_; }
inline int AIHigh_BTC_HumanCop::InitialMovement() { return initialMovement_; }
inline void AIHigh_BTC_HumanCop::SetRequestedDesiredSpeed(int speed) { requestedDesiredSpeed_ = speed; }
inline int AIHigh_BTC_HumanCop::RequestedDesiredSpeed() { return requestedDesiredSpeed_; }
inline void AIHigh_BTC_HumanCop::SetInitialDirection(int initialDirection) { initialDirection_ = initialDirection; }
inline void AIHigh_BTC_HumanCop::SetInitialMovement(int initialMovement) { initialMovement_ = initialMovement; } inline bool AIHigh_BTC_HumanCop::HasCatchTime() { return timeLeft_ > 5; } inline void AIHigh_BTC_HumanCop::SetNeedPerp(int needPerp) { needPerp_ = needPerp; } inline int AIHigh_BTC_HumanCop::NeedsPerp() { return copIndex_ == 0 ? needPerp_ : 0; }
struct AIHigh_BTC_Wingman : public AIHigh_BTC_Cop {   /* retail AIHIGH.H:548; members defined in AIH_BTCCOP.CPP */
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
#line 248 "recon/game/common/aihigh.h"
#ifdef NFS4_AIHIGH_TRAFFIC_AFTER_HUMANCOP   /* retail AIHIGH.H: Traffic (584) right after BTC_HumanCop (527): object.obj */
#define NFS4_AIHIGH_TYPE_PART 2
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART
#endif
#elif defined(NFS4_AIHIGH_TYPE_PART)
/* Reconstruction-only part routing preserves the existing owner type sets.  This is not a claim of the original preprocessor/include dependency graph. */
#if defined(NFS4_AIH_COP_OWNER) || defined(NFS4_AIH_TRAF_OWNER)   /* AIH_Cop.obj / AIH_Traf.obj emit standalone copies of the inline members below; SLINK /strip removed them (P6 Route C 2026-11-07) */
#define NFS4_AIHIGH_STRIP LINK_STRIPPED
#else
#define NFS4_AIHIGH_STRIP
#endif
#if NFS4_AIHIGH_TYPE_PART == 1
#ifndef NFS4_AIHIGH_COP_TYPE_DEFINED
#define NFS4_AIHIGH_COP_TYPE_DEFINED
/* Retail AIHigh_Cop is108bytes; field names/types/offsets come from SYM.  Consolidates former private method subsets without a new data member. */
struct AIHigh_Cop : public AIHigh_BasicCop {
    AIHigh_Player *perpTarget_;
    int forcePurgatory_, chaseIndex_, requestSpikeBeltAtSlice_;
    int aggressionLevel_;
    AIHigh_Cop(Car_tObj *carObj, int idx);
    void SetTuningLevers();
    void HighExecute();
    int CheckForNeedyPlayers();
    void CheckForWipeOut();
    int CheckForNewTarget();
    void AssignToPlayer(AIHigh_Player *p);
    int GetCheckChasePosition(coorddef *pt);
    trigger_t *CheckForNewTriggers();
    inline AIHigh_Player *PerpTarget() NFS4_AIHIGH_STRIP;   /* Inferred spelling already used by Traffic's retail inline receiver. */
#line 448 "C:/nfs4/GAME/COMMON/AIHIGH.H"
}; inline AIHigh_Player *AIHigh_Cop::PerpTarget() { return perpTarget_; }
#endif
#elif NFS4_AIHIGH_TYPE_PART == 2
#ifndef NFS4_AIHIGH_TRAFFIC_TYPE_DEFINED
#define NFS4_AIHIGH_TRAFFIC_TYPE_DEFINED
/* Retail AIHigh_Traffic is36bytes. Shared owner-specific inline bodies add neither class storage nor a virtual slot. */
struct AIHigh_Cop;
struct AIHigh_Traffic : public AIHigh_Base {
    int ignoreCops_, forcePurgatory_;
    SceneElem *accidentData_;
    AIHigh_Traffic(Car_tObj *carObj);
    Car_tObj *CheckForCops(int *p);
    AIHigh_Cop *CopCheck(int *p);
    void HighExecute();
    trigger_t *CheckForNewTriggers();
    /* These inline-only spellings remain inferred, not uniquely SYM-named. */
    inline int ForcePurgatory() NFS4_AIHIGH_STRIP;
    inline void SetAccidentData(SceneElem *accidentData) NFS4_AIHIGH_STRIP; inline void SetForcePurgatory(int force) NFS4_AIHIGH_STRIP;   /* SetAccidentData / (Set)ForcePurgatory: called from matched code */
#line 584 "C:/nfs4/GAME/COMMON/AIHIGH.H"
}; inline int AIHigh_Traffic::ForcePurgatory() { return forcePurgatory_; } inline void AIHigh_Traffic::SetAccidentData(SceneElem *accidentData) { accidentData_ = accidentData; } inline void AIHigh_Traffic::SetForcePurgatory(int force) { forcePurgatory_ = force; }
#endif
#else
#error Unknown AIHIGH.H type part
#endif
#endif /* common header or reconstruction-only selected type part */

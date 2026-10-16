/* game/common/aihigh.h -- retail AIHIGH.H declarations recovered so far.
 * 2026-10-16: shared AIHigh class definitions recovered here so far.
 * Retail destructor records identify AIHIGH.H. The shared hierarchy includes
 * this header after their bases are complete; no source-location directives.
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
    void HighExecute() {}
};

/* Retail records both inline destructors in AIHIGH.H, not the private
   reconstruction hierarchy header. Definitions move verbatim, without #line. */
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
    inline copLevel_t *ChaseLevel() { return perpChaseInfo_.chaseLevel_; }   /* retail pairs (this typed AIHigh_Player) */
    inline int LastPullOverTime() { return lastPullOverTime_; }
    int ExchangeLastTriggerCheckSlice(int newSlice); /* inferred exchange name; supplied inline newSlice/temp records */
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
};

/* Retail's HumanPerp destructor is synthesized: its only nested declarations
   belong to the real base destructors. An empty user body adds a wrong level. */
struct AIHigh_BTC_HumanPerp : public AIHigh_BTC_Perp {
    AIHigh_BTC_HumanPerp(Car_tObj *carObj);
    void NewStage(AIHigh_BTC_HumanCop *cop);
    void HighExecute();
};

/* Retail's synthesized Human destructor also identifies AIHIGH.H. */
struct AIHigh_Human : public AIHigh_Player {
    AIHigh_Human(Car_tObj *carObj);
    void HighExecute();
};

/* Retail's synthesized Opponent destructor identifies AIHIGH.H. Keep the
   actual class here, shared by its implementation and placement-new caller;
   no explicit destructor body or source-location directive is required. */
struct AIHigh_Opponent : public AIHigh_Player {
    AIHigh_tAttackMode attackMode_;
    Car_tObj *lastHumanHitter_;
    int hitCount_, attackTicksLeft_;
    AIHigh_Opponent(Car_tObj *carObj);
    void CheckForWipeOut();
    int DoRearEnder();
    void HighExecute();
    int DoProvokedAttack();
};

/* Cop definitions: retail destructor records also identify AIHIGH.H.
   Moved verbatim with their data-type dependency; no source-location overrides. */
#include "shared/blockade_t.h"







struct AIHigh_BasicCop : public AIHigh_Base {
    copType type_;
    int copIndex_;
    blockade_t blockade_;
    AIHigh_tDriveAwayMode driveAway_;
#ifdef NFS4_AIH_BASICPERP_INLINE_SCOPE
    inline void SetDriveAway(AIHigh_tDriveAwayMode mode) { driveAway_ = mode; }
#else
    void SetDriveAway(AIHigh_tDriveAwayMode mode);
#endif
    AIHigh_BasicCop(Car_tObj *carObj, int idx);
    void CheckSpikeBelt();
    void SetupBlockadeElements(blockade_t *blockade);
    void HandleBlockadeSpeech();
    int ShouldIPerformCutOffBlock(int a, Car_tObj *carObj);
    inline blockadeMode_t BlockadeMode() { return blockade_.mode; }   /* retail pairs (this typed AIHigh_BasicCop) */
    inline blockade_t *Blockade() { return &blockade_; }
    inline copType Type() { return type_; }
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
    AIHigh_BTC_Cop(Car_tObj *carObj, int copIndex);
    void AssignToPlayer(AIHigh_BTC_Perp *target);
    int GetCheckChasePosition(coorddef *pos);
    int CheckForNewTarget();
    void StartArrest(AIHigh_BTC_Perp *p);
    void FinishArrest(AIHigh_BTC_Perp *p);
    void FalseArrest(AIHigh_BTC_Perp *p);
    virtual void FreezeAndEndChase();
    void HudOff();
};

struct AIHigh_BTC_HumanCop : public AIHigh_BTC_Cop {
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
    void SetNeedPerp(int); /* inferred flag setter: retail records this in ClearForNewStage */
    int CurrentStage(); /* inferred stage getter: retail records this at the stage read */
    int InitialDirection(); /* inferred getter for the placement direction */
    int InitialMovement(); /* inferred getter for the placement movement */
    bool HasCatchTime(); /* inferred query: HumanCop receiver, timeLeft_ > 5 in retail */
    int NeedsPerp(); /* inferred lead-cop request query: copIndex_ == 0 ? needPerp_ : 0 */
    void SetRequestedDesiredSpeed(int); /* inferred setter at the three speed arms */
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
};

#elif defined(NFS4_AIHIGH_TYPE_PART)
/* Reconstruction-only part routing preserves the existing owner type sets.
   This is not a claim of the original preprocessor/include dependency graph. */
#if NFS4_AIHIGH_TYPE_PART == 1
#ifndef NFS4_AIHIGH_COP_TYPE_DEFINED
#define NFS4_AIHIGH_COP_TYPE_DEFINED
/* Retail AIHigh_Cop is108bytes; field names/types/offsets come from SYM.
   Consolidates former private method subsets without a new data member. */
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
    /* Inferred spelling already used by Traffic's retail inline receiver. */
    inline AIHigh_Player *PerpTarget() { return perpTarget_; }
};
#endif
#elif NFS4_AIHIGH_TYPE_PART == 2
#ifndef NFS4_AIHIGH_TRAFFIC_TYPE_DEFINED
#define NFS4_AIHIGH_TRAFFIC_TYPE_DEFINED
/* Retail AIHigh_Traffic is36bytes. Shared owner-specific inline bodies add
   neither class storage nor a virtual slot. */
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
    inline int ForcePurgatory() { return forcePurgatory_; }
    inline void SetAccidentData(SceneElem *accidentData) { accidentData_ = accidentData; }
};
#endif
#else
#error Unknown AIHIGH.H type part
#endif
#endif /* common header or reconstruction-only selected type part */

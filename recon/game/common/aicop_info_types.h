/* The AI cop-info types (copLevel_t/copGame_t, copType/crimeType, AICop_BasicPerpInfo, AICop_PerpChaseInfo) as one
   unit, moved verbatim from aih_hierarchy_types.h: retail declares them after AIPhysic_BrakeInfo in the AI owners but
   after the AIState classes in sim.obj/object.obj (aih_hierarchy_types.h includes it at both places). */
#ifndef NFS4_GAME_COMMON_AICOP_INFO_TYPES_H
#define NFS4_GAME_COMMON_AICOP_INFO_TYPES_H
#include "shared/copLevel_t.h"
#include "shared/copGame_t.h"
#include "shared/copType.h"
#include "shared/crimeType.h"
struct AICop_BasicPerpInfo {
    int copsAssigned_[2];
    crimeType crime_;
    AICop_BasicPerpInfo(); /* retail BasicPerp constructor records a member-initializer inline tree */
    /* Names inferred from behavior: retail SYM records the inlined scopes,
       not the original inline member identifiers. */
    inline crimeType GetCrime() const { return crime_; }
    inline void SetCrime(crimeType crime) { crime_ = crime; }
    /* retail inlines a member here: AddChaser / RemoveChaser show the scope pair { this { } } (SYM Block records) */
    inline void AddCop(copType type) { copsAssigned_[type]++; }
    inline void RemoveCop(copType type) { copsAssigned_[type]--; }
    inline int CopsAssigned(copType type) { return copsAssigned_[type]; }
    /* Inferred reset/setter spellings; retail ClearForNewStage has an outer
       reset pair containing two nested setter pairs, without extra locals. */
    void SetCopsAssigned(copType type, int count);
    void ClearCopsAssigned();
};
struct AICop_PerpChaseInfo {
    int engagementTime_;
    AICop_PerpChaseInfo(); /* retail player ctor has a pre-body chase-info initializer tree */
    void SetCopGameInfo(copGame_t *copGameInfo); /* candidate initializer boundary from retail copGameInfo receiver records */
    void ResetForCopGame(copGame_t *copGameInfo); /* inferred nested initialization mutator */
    copGame_t *copGameInfo_;
    int chaseLevelIndex_, bestChaseLevelIndex_;
    copLevel_t *chaseLevel_;
    int totalEngagementPercent_, blockadeDone_;
    int engagementPercentIncreasePerTick_, copFreeTicks_;
    inline int GetChaseLevelIndex();
    inline int GetNumLevels();
    int BestChaseLevelIndex(); /* inferred getter for the recorded best-level last-level test */
    copGame_t *GetCopGameInfo(); /* inferred field accessor; no class storage or virtual slot */
    inline copLevel_t *GetChaseLevel();
    inline int GetChaseTime();
    int RemainingEngagementTime(); /* inferred unscaled remaining fixed-point timer; GetChaseTime is the configured duration */
    inline int IsLastChaseLevel();
    inline void SetChaseLevel(int level);
    int ConfiguredEngagementLapTime(); /* inferred timing helpers; caller/receiver structure still under review */
    void InitializeChaseTimer(int lapTime);
    bool BlockadeDone(); /* inferred completed-blockade query from the retail guard inline pair */
    void SetBlockadeDone(); /* inferred setter: retail SetupBlockade records a receiver-less inline pair at each blockadeDone_ = 1 store */
    inline void ResetEngagementTime();
    /* Inferred update spelling; retail retains the receiver/ticks/count inline
       boundary but no standalone linkage name for this operation. */
    void AdvanceEngagement(int ticks, int movingBackwards, int totalCopsEngaged);
};
#endif

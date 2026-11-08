/* AI cop-info types as one unit (moved verbatim from aih_hierarchy_types.h, included at the AI-owner and sim/object positions). */
#ifndef NFS4_GAME_COMMON_AICOP_INFO_TYPES_H
#define NFS4_GAME_COMMON_AICOP_INFO_TYPES_H
#include "shared/copLevel_t.h"
#include "shared/copGame_t.h"
#include "shared/copType.h"
#include "shared/crimeType.h"
struct AICop_BasicPerpInfo {
    int copsAssigned_[2];
    crimeType crime_;
    inline crimeType GetCrime() const { return crime_; }
    inline void SetCrime(crimeType crime) { crime_ = crime; }
    inline void AddCop(copType type) { copsAssigned_[type]++; }
    inline void RemoveCop(copType type) { copsAssigned_[type]--; }
    inline int CopsAssigned(copType type) { return copsAssigned_[type]; }
    void SetCopsAssigned(copType type, int count) { copsAssigned_[type] = count; }
    void ClearCopsAssigned() { SetCopsAssigned((copType)0, 0); SetCopsAssigned((copType)1, 0); }
    AICop_BasicPerpInfo() { ClearCopsAssigned(); crime_ = CRIME_NONE; } /* member-initializer inline tree */
};
#ifndef NFS4_AICOP_GS_ROWS   /* names used by the PCI bodies below (declarations only, no SYM record) */
extern int GameSetup_gData[650];
#define NFS4_AICOP_GS(i) GameSetup_gData[i]
#else   /* aih_btcperp: 52-byte-row view (its own declaration, aih_btcperp_externs.h) */
extern int GameSetup_gData[50][13];
#define NFS4_AICOP_GS(i) GameSetup_gData[0][i]
#endif
extern int AITune_gRoughLapTime; extern "C" int fixedmult(int a, int b); extern copGame_t copGame[]; extern int Cars_gNumAIRaceCars;
/* Retail: PerpChaseInfo 21x per AI object = typedef form (2) + 18 in-class bodies (ctor 2); BasicPerpInfo 10x = plain (1) + 8 bodies; order = callee before caller (a forward in-class call leaves an out-of-line copy). */
typedef struct AICop_PerpChaseInfo {
    int engagementTime_;
    copGame_t *copGameInfo_;
    int chaseLevelIndex_, bestChaseLevelIndex_;
    copLevel_t *chaseLevel_;
    int totalEngagementPercent_, blockadeDone_;
    int engagementPercentIncreasePerTick_, copFreeTicks_;
    void ResetForCopGame(copGame_t *copGameInfo) { copGameInfo_ = copGameInfo; chaseLevelIndex_ = 0; engagementTime_ = 0; bestChaseLevelIndex_ = 0; chaseLevel_ = copGameInfo_->levels + chaseLevelIndex_; blockadeDone_ = 0; copFreeTicks_ = 0; totalEngagementPercent_ = 0; engagementPercentIncreasePerTick_ = 0; }
    copGame_t *GetCopGameInfo() { return copGameInfo_; }
    int GetChaseLevelIndex() { return chaseLevelIndex_; }
    int GetNumLevels() { return copGameInfo_->numLevels; }
    int BestChaseLevelIndex() { return bestChaseLevelIndex_; }
    int IsLastChaseLevel() { return bestChaseLevelIndex_ == copGameInfo_->numLevels - 1; }
    int RemainingEngagementTime() { return engagementTime_ / 0x10000; }
    bool BlockadeDone() { return blockadeDone_ != 0; }
    void SetBlockadeDone() { blockadeDone_ = 1; }
    copLevel_t *GetChaseLevel() { return chaseLevel_; }
    void SetCopGameInfo(copGame_t *copGameInfo) { ResetForCopGame(copGameInfo); }
    AICop_PerpChaseInfo() { copGame_t*copGameInfo; int lapIndex; int gameIndex; lapIndex = (u_int)(NFS4_AICOP_GS(1) /* numLaps */ != 2); if (NFS4_AICOP_GS(3) /* commMode */ == 1) { gameIndex = 2; } else { gameIndex = (u_int)(0 < Cars_gNumAIRaceCars) << 2; } copGameInfo = copGame + (gameIndex + lapIndex); SetCopGameInfo(copGameInfo); }
    int GetChaseTime() { return (GetChaseLevel()->engagementLapFraction * AITune_gRoughLapTime) / 0x10000 * 0x20; }
    int ConfiguredEngagementLapTime() { return (GetChaseLevel()->engagementLapFraction * AITune_gRoughLapTime) / 0x10000; }
    void InitializeChaseTimer(int lapTime) { engagementTime_ = lapTime << 0x15; engagementPercentIncreasePerTick_ = 0x10000 / (lapTime << 5); if (NFS4_AICOP_GS(1) /* numLaps */ == 2) engagementPercentIncreasePerTick_ = fixedmult(engagementPercentIncreasePerTick_,0x13333); else if (NFS4_AICOP_GS(1) /* numLaps */ == 4) engagementPercentIncreasePerTick_ = fixedmult(engagementPercentIncreasePerTick_,0xa8f5); }
    void ResetEngagementTime() { InitializeChaseTimer(ConfiguredEngagementLapTime()); }
    void SetChaseLevel(int level) { chaseLevelIndex_ = level; if (bestChaseLevelIndex_ < level) bestChaseLevelIndex_ = level; chaseLevel_ = copGameInfo_->levels + chaseLevelIndex_; ResetEngagementTime(); blockadeDone_ = 0; }
    void AdvanceEngagement(int ticks, int movingBackwards, int totalCopsEngaged) { if (0 < totalCopsEngaged) { copFreeTicks_ = 0; if (-2 < engagementTime_ / 0x10000) { if (movingBackwards) { engagementTime_ -= ticks << 0xf; } else { engagementTime_ -= ticks << 0x10; } if (RemainingEngagementTime() < ConfiguredEngagementLapTime() * 0x20 - 0x80) { totalEngagementPercent_ += engagementPercentIncreasePerTick_ * ticks; } } } else { copFreeTicks_ += ticks; } }
} AICop_PerpChaseInfo;
#endif

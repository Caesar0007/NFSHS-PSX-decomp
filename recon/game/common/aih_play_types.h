/* aih_play.obj's exact owner delta over the shared AI hierarchy. */
#if !defined(NFS4_GAME_COMMON_AIH_PLAY_TYPES_H)
#define NFS4_GAME_COMMON_AIH_PLAY_TYPES_H
#define NFS4_AIH_HIERARCHY_TRIGGERS_TAIL "aih_play_types.h"   /* retail aih_play.obj: AITrigger_TriggerManager right after trigger_t (second pass below) */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_AIHIGH_PLAYER_PLAIN   /* aihigh.h: AIHigh_Player stays a plain struct here (retail TPDEF count) */
#define NFS4_AIHIGH_COP_AFTER_BASICCOP   /* aihigh.h: AIHigh_Cop right after AIHigh_BasicCop (retail AIHIGH.H order 414/448/471) */
#include "aih_hierarchy_types.h"



#include "shared/BW_tContext.h"
enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
};






#define NFS4_AIHIGH_TYPE_PART 1
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART

#define NFS4_SPEECH_AI_VIEW   /* speech_class.h: Speech + Speaker + banks, no MobileSpeaker/DispatchSpeaker (retail AI-object view) */
#include "speech_class.h"   /* retail: the full Speech class graph (Speaker + CarBank/LocationBank/CallSignBank with their inline bodies) is recorded in this AI object */













































/* Canonical foreign aggregates used by this translation unit. */
/* GameSetup_tData: not in retail aih_play.obj (GameSetup_gData is read through its word view) */















#include "shared/Sim_tSimGlobalVar.h"



#include "shared/Sim_tSimSystemVar.h"



#include "shared/dashhud_info.h"








#include "shared/Trk_NewSlice.h"







enum AICop_RoadBlockState {
    kAICop_RoadBlockState_None = 0,
    kAICop_RoadBlockState_WaitingForPerp = 1,
    kAICop_RoadBlockState_PerpPassed = 2
};
#define RaceType_HotPursuit 1
#define RaceType_Id5 5

typedef int CarLogic_tObservations[1][3];
typedef long (*ReparmFuncPtr)();
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();

#elif !defined(NFS4_AIH_PLAY_TRIG_DONE)   /* second pass: aih_hierarchy_types.h NFS4_AIH_HIERARCHY_TRIGGERS_TAIL */
#define NFS4_AIH_PLAY_TRIG_DONE
#include "shared/Sched_tSchedule.h"
enum triggerType {
    TRIGGER_NONE = 0,
    TRIGGER_COP_SIMPLE = 1,
    TRIGGER_COP_ROADBLOCK = 2,
    TRIGGER_COP_OFFROAD = 3,
    TRIGGER_TRAFFIC_ACCIDENT = 4,
    TRIGGER_TRAFFIC_PATH = 5,
    TRIGGER_NUM_TRIGGER_TYPES = 6
};
typedef struct AITrigger_TriggerManager {
    int numTriggers_, invNumTriggers_;
    int InvNumTriggers(); /* inferred inverse-count getter, retail records the receiver */
    trigger_t *triggers_[100];
    int checkTime_[100];
    int lastTriggerChecked_[9];
    void Init(char *rawTriggers);
    int InsertTrigger(trigger_t *trigger, bool fromFile);
    trigger_t *GetNextTrigger(int car);
    trigger_t *GetPrevTrigger(int car);
    int CheckForTriggerAtSlice(int car, int slice);
    trigger_t *GetTrigger(int trigger, int *used);
    int CheckForClosestTriggerOfType(int slice, triggerType type, int direction);
    void DescribeTrigger(trigger_t *trigger);
    void Sort(); /* INFERRED bodies: retail aih_play.obj TPDEF run (TM TM | trigger_t walk | TM TM trigger_t trigger_t), as aitriger.obj; never called here */ inline trigger_t *GetCheckedTrigger(int triggerNum); inline void SwapTriggers(trigger_t *a, trigger_t *b);
} AITrigger_TriggerManager; inline trigger_t *AITrigger_TriggerManager::GetCheckedTrigger(int triggerNum) { if (triggerNum < numTriggers_) return triggers_[triggerNum]; return (trigger_t *)0; } inline void AITrigger_TriggerManager::SwapTriggers(trigger_t *a, trigger_t *b) { }
#endif

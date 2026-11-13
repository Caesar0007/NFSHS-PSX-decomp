/* aih_play.obj's exact owner delta over the shared AI hierarchy. */
#if !defined(NFS4_GAME_COMMON_AIH_PLAY_TYPES_H)
#define NFS4_GAME_COMMON_AIH_PLAY_TYPES_H
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_AIHIGH_PLAYER_PLAIN   /* aihigh.h: AIHigh_Player stays a plain struct here (retail TPDEF count) */
#define NFS4_AIHIGH_COP_AFTER_BASICCOP   /* aihigh.h: AIHigh_Cop right after AIHigh_BasicCop (retail AIHIGH.H order 414/448/471) */
#define NFS4_GAME_COMMON_AIH_HIERARCHY_TYPES_H   /* this object lists the hierarchy parts itself (retail record order) */
#include "aih_hier_triggers.h"
#include "shared/Sched_tSchedule.h"
#include "shared/triggerType.h"
#include "aitrigger_manager_class.h"   /* retail aih_play.obj: AITrigger_TriggerManager right after trigger_t */
#include "aih_hier_states.h"
#include "shared/Wingman_Role.h"
#include "aih_hier_classes.h"



#include "shared/BW_tContext.h"
enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
};






#define NFS4_AIHIGH_TYPE_PART 1
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART


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

#endif

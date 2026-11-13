/* Exact 108-type source-visible intersection of the ten AI hierarchy owners. */
#ifndef NFS4_GAME_COMMON_AIH_HIERARCHY_TYPES_H
#define NFS4_GAME_COMMON_AIH_HIERARCHY_TYPES_H
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "color_types.h"
#ifdef NFS4_AIH_HIERARCHY_OMIT_SIM_FOREIGN_TYPES   /* sim/object: the scene types ahead of the triggers, the cop info after the AIState classes */
#ifdef NFS4_AIH_HIERARCHY_HOOK_SCENE   /* sim.obj: its forceFocus_t / scene / AudioMus / BW_tContext run here (owner second pass) */
#define NFS4_AIH_IN_SCENE_HOOK
#include NFS4_AIH_HIERARCHY_HOOK_SCENE
#undef NFS4_AIH_IN_SCENE_HOOK
#endif
#include "shared/SceneElem.h"
#include "shared/SceneSortedElem.h"
#endif
/* The common hierarchy header retains this anonymous enum without a typedef.  (GCC 2.8.1 cannot materialize extern arrays of its built-in old-ABI entry.) */
enum {
    PERPMODE_CRUISE = 0,
    PERPMODE_FAST = 1,
    PERPMODE_MADECONTACT = 2,
    PERPMODE_TEASE = 3,
    PERPMODE_ESCAPE = 4,
    PERPMODE_CHASEON = 5
};
#if !defined(NFS4_AIH_HIERARCHY_OMIT_SIM_FOREIGN_TYPES) && !defined(NFS4_AIDEBUG_AI_GRAPH_ONLY)   /* retail: BrakeInfo, the cop info, then ModelConfig (aidebug: AI classes only, retail aidebug.obj has no BrakeInfo/ModelConfig) */
#include "shared/AIPhysic_BrakeInfo.h"   /* one AIPhysic_BrakeInfo definition (header-truth 4m) */
#include "aicop_info_types.h"
#include "shared/AIPhysic_ModelConfig_t.h"
#endif
#ifndef NFS4_AIH_HIERARCHY_TRIGGERS_TAIL   /* aih_play.obj: AITrigger_TriggerManager right after trigger_t (its types header) */
#define NFS4_AIH_HIERARCHY_TRIGGERS_TAIL "shared/Sched_tSchedule.h"
#endif

#include "shared/trigger_anyTrigger_t.h"
#include "shared/trigger_simple_t.h"
#include "shared/trigger_roadblock_t.h"
#include "shared/trigger_offroad_t.h"
#include "shared/trigger_trafficAccident_t.h"
#include "shared/trigger_pathPosition_t.h"
#include "shared/trigger_trafficPath_t.h"
#include "shared/trigger_t.h"

#include NFS4_AIH_HIERARCHY_TRIGGERS_TAIL

#include "shared/AIDelayCar.h"   /* one AIDelayCar definition (header-truth 4o) */










#include "aistate.h"

/* AIState_Idle's empty inline ctor lives HERE, not in aistate.h: aistate.obj (Idle's key-function
   TU) carries no out-of-line copy, which cc1plus 2.8 would emit for any inline member it can see. */
inline AIState_Idle::AIState_Idle(Car_tObj *carObj) : AIState_Base(carObj) {}
inline AIState_Idle::AIState_Idle(Car_tObj *carObj, int idleInPlace) : AIState_Base(carObj) {
    idleInPlaceFlag_ = idleInPlace;
}
#include "aicop_info_types.h"
#include "shared/SceneElem.h"
#include "shared/SceneSortedElem.h"
#include "shared/stateType_t.h"

#ifndef NFS4_AIH_HIERARCHY_WINGMAN   /* aihigh.obj: its AIHigh_CopGameType_t between stateType_t and Wingman_Role (aihigh_types.h) */
#define NFS4_AIH_HIERARCHY_WINGMAN "shared/Wingman_Role.h"
#endif
#include NFS4_AIH_HIERARCHY_WINGMAN












































































































































typedef struct AIHigh_Base {
    Car_tObj *carObj_;

    inline Car_tObj *GetCarObj() { return carObj_; }



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
    inline Car_tObj *CarObj() { return carObj_; } /* ClearSchedulingOff() folded into SetSchedulingOff(0) (same store) */
    /* Inferred inline spelling: retail HighExecute records Base receivers at
       both schedulingOff_ stores; no standalone name survives in SYM. */
    void SetSchedulingOff(int off) { schedulingOff_ = off; }
    bool SchedulingOff() { return schedulingOff_ != 0; } /* inferred query: retail Execute has empty inline receiver scopes */
    int ExchangeTrafficTriggerCheckSlice(int newSlice) { int temp = lastTrafficTriggerCheckSlice_; lastTrafficTriggerCheckSlice_ = newSlice; return temp; } /* inferred exchange */
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

#include "aihigh.h"

/* Shared field-query definitions. Keep them out of class: selected-stock
 * debug emission differs for in-class bodies. The literal original accessor
 * spellings/header arrangement are not uniquely supplied by retail SYM. */




#endif

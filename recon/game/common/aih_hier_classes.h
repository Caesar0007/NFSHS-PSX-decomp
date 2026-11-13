/* AI hierarchy, part 3 of 3: the AIHigh classes (after Wingman_Role) */
#ifndef NFS4_GAME_COMMON_AIH_HIER_CLASSES_H
#define NFS4_GAME_COMMON_AIH_HIER_CLASSES_H
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

/* AI hierarchy, part 2 of 3: AIDelayCar, the AIState classes, cop info, stateType_t */
#ifndef NFS4_GAME_COMMON_AIH_HIER_STATES_H
#define NFS4_GAME_COMMON_AIH_HIER_STATES_H
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
#endif

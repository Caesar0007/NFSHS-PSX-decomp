/* aicop.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AICOP_TYPES_H
#define NFS4_GAME_COMMON_AICOP_TYPES_H

#include "color_types.h"

#include "shared/Sched_tSchedule.h"




#include "shared/copLevel_t.h"









#include "shared/copGame_t.h"




typedef enum crimeType {
    CRIME_NONE = 0,
    CRIME_SPEEDER = 1,
    CRIME_WRONGSIDE = 2,
    CRIME_BUMPCOP = 3,
    CRIME_SMASHCOP = 4
} crimeType;

#include "shared/AICop_spikeBelt_t.h"



typedef enum AICop_RoadBlockState {
    kAICop_RoadBlockState_None = 0,
    kAICop_RoadBlockState_WaitingForPerp = 1,
    kAICop_RoadBlockState_PerpPassed = 2
} AICop_RoadBlockState;

#include "shared/trigger_anyTrigger_t.h"
#include "shared/trigger_simple_t.h"
#include "shared/trigger_roadblock_t.h"

#include "shared/trigger_offroad_t.h"






#include "shared/trigger_trafficAccident_t.h"





#include "shared/trigger_pathPosition_t.h"




#include "shared/trigger_trafficPath_t.h"






#include "shared/trigger_t.h"








typedef int CarLogic_tObservations[1][3];

/* Exact externally owned layout from AITRIGER.SYM; needed here for the
 * original C++ new/delete and member-call expressions. */
struct AITrigger_TriggerManager {
    int numTriggers_, invNumTriggers_;
    trigger_t *triggers_[100];
    int checkTime_[100];
    int lastTriggerChecked_[9];
    void Init(char *rawTriggers);
};

#endif

#ifndef NFS4_GAME_COMMON_AICOP_TYPES_H
#define NFS4_GAME_COMMON_AICOP_TYPES_H   /* aicop.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "color_types.h"

#include "shared/Sched_tSchedule.h"




#include "shared/copLevel_t.h"









#include "shared/copGame_t.h"




enum crimeType {
    CRIME_NONE = 0,
    CRIME_SPEEDER = 1,
    CRIME_WRONGSIDE = 2,
    CRIME_BUMPCOP = 3,
    CRIME_SMASHCOP = 4
};

#include "shared/AICop_spikeBelt_t.h"



#include "shared/AICop_RoadBlockState.h"   /* one AICop_RoadBlockState definition (header-truth 7a) */





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
#include "aitrigger_manager_class.h"   /* triggerType + class AITrigger_TriggerManager: one definition (header-truth 4n) */







#endif

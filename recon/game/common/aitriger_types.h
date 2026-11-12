#ifndef NFS4_GAME_COMMON_AITRIGER_TYPES_H
#define NFS4_GAME_COMMON_AITRIGER_TYPES_H   /* aitriger.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "color_types.h"

#include "shared/Sched_tSchedule.h"




#include "shared/triggerType.h"   /* retail: triggerType at this point of the object's type order */









#include "shared/trigger_anyTrigger_t.h"
#include "shared/trigger_simple_t.h"
#include "shared/trigger_roadblock_t.h"

#include "shared/trigger_offroad_t.h"






#include "shared/trigger_trafficAccident_t.h"





#include "shared/trigger_pathPosition_t.h"




#include "shared/trigger_trafficPath_t.h"






#include "shared/trigger_t.h"








#include "aitrigger_manager_class.h"   /* triggerType + class AITrigger_TriggerManager: one definition (header-truth 4n) */






















typedef int CarLogic_tObservations[1][3];

#endif

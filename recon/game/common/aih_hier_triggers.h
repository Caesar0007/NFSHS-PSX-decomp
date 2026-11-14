/* AI hierarchy, part 1 of 3: the base graph up to the trigger records (through trigger_t) */
#ifndef NFS4_GAME_COMMON_AIH_HIER_TRIGGERS_H
#define NFS4_GAME_COMMON_AIH_HIER_TRIGGERS_H
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "color_types.h"
#ifdef NFS4_AIH_HIERARCHY_OMIT_SIM_FOREIGN_TYPES   /* sim/object: the scene types ahead of the triggers, the cop info after the AIState classes */
#include "shared/SceneElem.h"
#include "shared/SceneSortedElem.h"
#endif
/* The common hierarchy header retains this anonymous enum without a typedef.  (GCC 2.8.1 cannot materialize extern arrays of its built-in old-ABI entry.) */
#include "aih_hier_triggers_d1.h"
#if !defined(NFS4_AIH_HIERARCHY_OMIT_SIM_FOREIGN_TYPES) && !defined(NFS4_AIDEBUG_AI_GRAPH_ONLY)   /* retail: BrakeInfo, the cop info, then ModelConfig (aidebug: AI classes only, retail aidebug.obj has no BrakeInfo/ModelConfig) */
#include "shared/AIPhysic_BrakeInfo.h"   /* one AIPhysic_BrakeInfo definition (header-truth 4m) */
#include "aicop_info_types.h"
#include "shared/AIPhysic_ModelConfig_t.h"
#endif

#include "shared/trigger_anyTrigger_t.h"
#include "shared/trigger_simple_t.h"
#include "shared/trigger_roadblock_t.h"
#include "shared/trigger_offroad_t.h"
#include "shared/trigger_trafficAccident_t.h"
#include "shared/trigger_pathPosition_t.h"
#include "shared/trigger_trafficPath_t.h"
#include "shared/trigger_t.h"
#endif

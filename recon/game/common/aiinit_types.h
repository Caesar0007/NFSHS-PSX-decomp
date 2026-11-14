#if !defined(NFS4_GAME_COMMON_AIINIT_TYPES_H)
#define NFS4_GAME_COMMON_AIINIT_TYPES_H   /* aiinit.obj reconstruction types over the shared color graph. */
#define NFS4_TRANSFORMER_Z_HOOK "../game/common/aiinit_types.h"   /* retail aiinit.obj: Udff types right after Transformer_zOverlay */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_OWNER_DEFINES_UDFF_TYPES
#include "color_types.h"

/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail aiinit.obj (GameSetup_gData is read through its word view) */
















#define RaceType_Id3 3

#include "shared/Sched_tSchedule.h"
#include "shared/AIPhysic_ModelConfig_t.h"   /* retail aiinit: ModelConfig_t, BrakeInfo, then the AIDataRecord family */
#include "shared/AIPhysic_BrakeInfo.h"   /* one AIPhysic_BrakeInfo definition (header-truth 4m) */



#include "aidatarecord_classes.h"   /* the AIDATARECORD.H record-class family: no private copies (header-truth 4i) */



































/* P892: the shared data owner's native type (SYM130b95..130c49,
   EXT1371f7), needed for the real leaderBoard fields. This foreign type
   projection is not claimed present in aiinit.obj's surviving type list. */
#include "shared/AISpeeds_tLeaderBoard.h"











#include "shared/AIPhysic_Config_t.h"





#include "shared/AI_tInfo.h"





#include "shared/accelscale_t.h"



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

#elif defined(NFS4_TRANSFORMER_IN_HOOK) && !defined(NFS4_AIINIT_TZ_DONE)   /* second pass: shared/Transformer_z.h */
#define NFS4_AIINIT_TZ_DONE
#include "shared/Udff_tAccessType.h"



#include "shared/Udff_tInfo.h"




typedef Udff_tInfo *Udff_tHandle;
#endif

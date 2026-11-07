#ifndef NFS4_GAME_COMMON_AILIFE_TYPES_H
#define NFS4_GAME_COMMON_AILIFE_TYPES_H   /* ailife.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#include "color_types.h"

#include "shared/POLY_GT4.h"







#include "shared/Draw_SubdivStruct.h"

#include "shared/Track_tArtresource.h"







#include "shared/Track_tMaterial.h"




#include "shared/Sched_tSchedule.h"




typedef struct AIPhysic_BrakeInfo {
    u_char brakeTable_[128];
    int deceleration_;
} AIPhysic_BrakeInfo;

#include "shared/AIPhysic_ModelConfig_t.h"





#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#include "shared/Skidmark_Segment.h"






#include "shared/Skidmark_Chunk.h"





typedef int CarLogic_tObservations[1][3];

#endif

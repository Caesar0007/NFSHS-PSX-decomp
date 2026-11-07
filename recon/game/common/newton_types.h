#ifndef NFS4_GAME_COMMON_NEWTON_TYPES_H
#define NFS4_GAME_COMMON_NEWTON_TYPES_H   /* newton.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#include "color_types.h"
/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















typedef enum crimeType {
    CRIME_NONE = 0,
    CRIME_SPEEDER = 1,
    CRIME_WRONGSIDE = 2,
    CRIME_BUMPCOP = 3,
    CRIME_SMASHCOP = 4
} crimeType;

#include "shared/Sched_tSchedule.h"




/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"




#include "shared/AICop_spikeBelt_t.h"



typedef struct AIPhysic_BrakeInfo { u_char brakeTable_[128]; int deceleration_; } AIPhysic_BrakeInfo;
#include "shared/AIPhysic_ModelConfig_t.h"




#include "shared/BW_tContext.h"




#include "shared/copLevel_t.h"




#include "shared/copGame_t.h"

#include "shared/POLY_GT4.h"






#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"






#include "shared/Track_tMaterial.h"
#include "shared/Skidmark_Segment.h"





#include "shared/Skidmark_Chunk.h"





#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







typedef int CarLogic_tObservations[1][3];

#endif

#ifndef NFS4_GAME_COMMON_NEWTON_TYPES_H
#define NFS4_GAME_COMMON_NEWTON_TYPES_H   /* newton.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#include "color_types.h"
/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail newton.obj / aih_btccop.obj (word / row views) */


























#ifndef NFS4_NEWTON_AS_AI_BTCCOP   /* retail newton.obj order after Car_tObj (aih_btccop_types.h declares these at its own places) */
#include "shared/AIPhysic_BrakeInfo.h"   /* one AIPhysic_BrakeInfo definition (header-truth 4m) */
#include "shared/copLevel_t.h"
#include "shared/copGame_t.h"
#include "shared/crimeType.h"
#include "shared/AIPhysic_ModelConfig_t.h"
#include "shared/BW_tContext.h"
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
#endif
#include "shared/Sched_tSchedule.h"
/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"
#include "shared/AICop_spikeBelt_t.h"
















#include "shared/POLY_GT4.h"






#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"






#include "shared/Track_tMaterial.h"

























typedef int CarLogic_tObservations[1][3];

#endif

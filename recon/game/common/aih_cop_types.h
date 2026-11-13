#ifndef NFS4_GAME_COMMON_AIH_COP_TYPES_H
#define NFS4_GAME_COMMON_AIH_COP_TYPES_H   /* aih_cop.obj owner types; AIHigh_Cop uses the canonical AIHIGH.H definition. */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_AIHIGH_PLAYER_PLAIN   /* aihigh.h: AIHigh_Player stays a plain struct here (retail TPDEF count) */
#define NFS4_AIHIGH_COP_AFTER_BASICCOP   /* aihigh.h: AIHigh_Cop right after AIHigh_BasicCop (retail AIHIGH.H order 414/448/471) */
#define NFS4_AIH_COP_OWNER   /* aihigh.h: AIHigh_Cop inline copies LINK_STRIPPED */
#include "../../link_stripped.h"
#include "aih_hierarchy_types.h"
#include "shared/BW_tContext.h"




#define NFS4_AIHIGH_TYPE_PART 1
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART

#include "aistate.h"



/* Constructed foreign state classes omitted from this linked owner graph. */


#include "shared/POLY_GT4.h"







#include "shared/Draw_SubdivStruct.h"

#include "shared/Track_tArtresource.h"







#include "shared/Track_tMaterial.h"

#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#include "shared/Skidmark_Segment.h"






#include "shared/Skidmark_Chunk.h"






#include "speech_class.h"   /* retail: the full Speech class graph (Speaker + CarBank/LocationBank/CallSignBank with their inline bodies) is recorded in this AI object */












































/* Canonical foreign aggregates used by this translation unit. */
/* GameSetup_tData: not in retail aih_cop.obj (GameSetup_gData is read through its word view) */















#include "shared/Sim_tSimGlobalVar.h"



#include "shared/AICop_spikeBelt_t.h"


#include "shared/Trk_NewSlice.h"






#include "shared/copTuning_t.h"



#include "shared/triggerType.h"   /* retail: triggerType at this point of the object's type order */









#include "aitrigger_manager_class.h"   /* triggerType + class AITrigger_TriggerManager: one definition (header-truth 4n) */















#include "shared/AICop_RoadBlockState.h"   /* one AICop_RoadBlockState definition (header-truth 7a) */





typedef int CarLogic_tObservations[1][3];
typedef long (*ReparmFuncPtr)();
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();

#endif

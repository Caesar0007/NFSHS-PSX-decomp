/* sim.obj's exact source-visible type surface reconstructed from SYM. */
#if !defined(NFS4_GAME_COMMON_SIM_TYPES_H) && !defined(NFS4_PADS_IN_HOOK)
#define NFS4_GAME_COMMON_SIM_TYPES_H
#define NFS4_COLOR_CAR_STRUCT_ONLY   /* retail: one TPDEF Car_tObj (color_types.h) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_COLOR_SCHED_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_GAME_COMMON_AIH_HIERARCHY_TYPES_H   /* this object lists the hierarchy parts itself (retail record order) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_GAME_COMMON_COLOR_TYPES_H   /* this header lists the parts of the common type graph itself (retail record order) */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#define NFS4_CORE_FULL   /* this object lists the start of the core itself (retail record order) */
#define NFS4_GAME_COMMON_MIN_TYPES_H
#define NFS4_GAME_COMMON_PADS_TYPES_H
#include "game_common_min_core.h"
#include "pads_records.h"
#define NFS4_PADS_IN_HOOK
#include "sim_types.h"   /* this header again: its NFS4_PADS_IN_HOOK branch */
#undef NFS4_PADS_IN_HOOK
#include "pads_tail.h"
#undef NFS4_CORE_FULL
#undef NFS4_CORE_CCOORD16
#include "color_p0_draw.h"
#include "color_p1_pregroup.h"
#include "color_p2_group_trk.h"
#include "color_p3_trkobj.h"
#include "color_p4_save.h"
#include "color_p5_bwsm.h"
#include "color_p6_bo.h"
#include "color_p7_sched.h"
#include "color_p8_car.h"
#include "color_p9_tail.h"
#include "shared/forceFocus_t.h"
#include "shared/SceneElem.h"
#include "shared/SceneSortedElem.h"
#include "shared/AudioMus_tSongEntry.h"
#include "shared/BW_tContext.h"
#define NFS4_AIH_HIERARCHY_OMIT_SIM_FOREIGN_TYPES
#include "aih_hier_triggers.h"
#include "shared/Sched_tSchedule.h"
#include "aih_hier_states.h"
#include "shared/Wingman_Role.h"
#include "aih_hier_classes.h"
#undef NFS4_AIH_HIERARCHY_OMIT_SIM_FOREIGN_TYPES
#define gScratchLastWord (*(int *)0x1F8003FC)






#include "shared/BW_tContext.h"






#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"







#include "shared/Draw_SubdivStruct.h"





#include "shared/POLY_GT4.h"







#include "shared/Sim_tSimGlobalVar.h"




#include "shared/Sim_tSimSystemVar.h"




#include "shared/Skidmark_Segment.h"





#include "shared/Skidmark_Chunk.h"






#include "shared/Track_tArtresource.h"






#include "shared/Track_tMaterial.h"

/* GameSetup_tData: not in retail sim.obj (GameSetup_gData is read through its word view) */















#include "shared/tReplayInterface.h"



#include "shared/Clock_tGameClock.h"

#include "sim_types_d1.h"
#include "sim_types_d2.h"

#define RaceType_HotPursuit 1
#define RaceType_Id5 5

#elif defined(NFS4_PADS_IN_HOOK) && !defined(NFS4_SIM_PADS_DONE)
#define NFS4_SIM_PADS_DONE
#include "sim_types_d3.h"
#include "shared/Sched_tFunctionSchedule.h"
#include "shared/Sched_tSchedule.h"
#define NFS4_COLOR_SCHED_DONE
#include "shared/Sim_tSimGlobalVar.h"
#include "shared/Sim_tSimSystemVar.h"
#endif

#if !defined(NFS4_GAME_COMMON_INPUT_TYPES_H)
#define NFS4_GAME_COMMON_INPUT_TYPES_H   /* input.obj's exact source-visible delta over the shared color graph. */
#define NFS4_PADS_HOOK_AFTER "input_types.h"   /* retail input.obj: Input_tResults, scheduler, GameSetup records right after PAD_COMMON */
#define NFS4_COLOR_SCHED_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_BEFORE_GS   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this object lists the draw leaf itself (retail record order) */
#include "draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "input_after_pads.h"   /* own types at this point */
#include "draw_leaf_b_pixmap.h"
#include "draw_leaf_c_cache.h"
#include "draw_leaf_d_carvertex.h"
#include "color_types.h"
#include "shared/Sched_tSchedule.h"



/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"




/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail input.obj (GameSetup_gData is read through its word view) */
















#include "shared/Input_tDeviceList.h"





#include "shared/Input_tResults.h"




typedef int Input_tDeviceCall(u_long value);

#elif defined(NFS4_PADS_IN_HOOK) && !defined(NFS4_INPUT_PADS_DONE)   /* second pass: game_common_pads_types.h */
#define NFS4_INPUT_PADS_DONE
#include "shared/Input_tResults.h"
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#include "shared/Sched_tSchedule.h"
#define NFS4_COLOR_SCHED_DONE
#include "gamesetup_leaf_types.h"
#endif

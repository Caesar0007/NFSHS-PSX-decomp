/* souffle.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_SOUFFLE_TYPES_H
#define NFS4_GAME_COMMON_SOUFFLE_TYPES_H
#define NFS4_COLOR_GROUP_LATE   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_FIRST   /* retail souffle.obj: scheduler types after RelCoord16, before Group */
#define NFS4_DRAW_LEAF_HOOK_AFTER_CARVERTEX "shared/Souffle_tISouffle.h"   /* retail: right after Draw_CarVertex */
#define NFS4_COLOR_HOOK_BEFORE_GROUP "souffle_before_group.h"   /* retail: TCB/EXEC/DIRENTRY before Group */
#include "color_types.h"
#include "shared/DRender_tView.h"
#include "shared/Souffle_tISouffle.h"







#include "shared/Sched_tSchedule.h"




#include "shared/TCB.h"





#include "shared/EXEC.h"




#include "shared/DIRENTRY.h"







#endif

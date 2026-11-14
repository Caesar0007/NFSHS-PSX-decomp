/* souffle.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_SOUFFLE_TYPES_H
#define NFS4_GAME_COMMON_SOUFFLE_TYPES_H
#define NFS4_COLOR_GROUP_LATE   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_FIRST   /* retail souffle.obj: scheduler types after RelCoord16, before Group */
#define NFS4_DRAW_LEAF_HOOK_AFTER_CARVERTEX "shared/Souffle_tISouffle.h"   /* retail: right after Draw_CarVertex */
#define NFS4_GAME_COMMON_COLOR_TYPES_H   /* this object lists the parts of the common type graph itself (retail record order) */
#include "color_p0_draw.h"
#include "color_p1_pregroup.h"
#include "souffle_before_group.h"   /* own types at this point of the retail record order */
#include "color_p2_group_trk.h"
#include "color_p3_trkobj.h"
#include "color_p4_save.h"
#include "color_p5_bwsm.h"
#include "color_p6_bo.h"
#include "color_p7_sched.h"
#include "color_p8_car.h"
#include "color_p9_tail.h"
#include "shared/DRender_tView.h"
#include "shared/Souffle_tISouffle.h"







#include "shared/Sched_tSchedule.h"




#include "shared/TCB.h"





#include "shared/EXEC.h"




#include "shared/DIRENTRY.h"







#endif

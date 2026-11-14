/* dashHUD.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_DASHHUD_TYPES_H
#define NFS4_GAME_COMMON_DASHHUD_TYPES_H
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this object lists the draw leaf itself (retail record order) */
#include "draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "draw_leaf_b_pixmap.h"
#include "draw_leaf_c_cache.h"
#include "draw_leaf_d_carvertex.h"
#include "shared/dashhud_info.h"   /* own types at this point */
#include "color_types.h"

#define RaceType_Id4 4

#include "shared/Sched_tSchedule.h"




#include "shared/forceFocus_t.h"





#include "shared/dashhud_info.h"








typedef dashhud_info DashHUD_tInfo;

#endif

/* common type graph, part 5 of 10 (cut from color_types.h at its order hooks) */
#ifndef NFS4_GAME_COMMON_COLOR_P5_BWSM_H
#define NFS4_GAME_COMMON_COLOR_P5_BWSM_H
#ifdef NFS4_COLOR_GS_AFTER_SAVE   /* retail: GameSetup right after tSaveSurface (owner first header) */
#include "gamesetup_leaf_types.h"
#endif
#include "shared/BWorldSm_Pos.h"
#ifdef NFS4_COLOR_SCHED_AFTER_BWSM   /* retail hud.obj: scheduler types between BWorldSm_Pos and the BO types */
#include "color_p5_bwsm_d1.h"
#include "shared/Sched_tFunctionSchedule.h"
#ifdef NFS4_COLOR_SCHED_SCHEDULE
#include "shared/Sched_tSchedule.h"
#endif
#endif
#endif

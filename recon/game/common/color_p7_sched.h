/* common type graph, part 7 of 10 (cut from color_types.h at its order hooks) */
#ifndef NFS4_GAME_COMMON_COLOR_P7_SCHED_H
#define NFS4_GAME_COMMON_COLOR_P7_SCHED_H
#ifdef NFS4_COLOR_GS_AFTER_BO   /* retail: GameSetup after the BO types, before the scheduler */
#include "gamesetup_leaf_types.h"
#endif
#if !defined(NFS4_COLOR_SCHED_FIRST) && !defined(NFS4_COLOR_SCHED_AFTER_BWSM) && !defined(NFS4_COLOR_SCHED_DONE)
#include "color_p7_sched_d1.h"
#include "shared/Sched_tFunctionSchedule.h"
#endif
#ifdef NFS4_COLOR_SCHED_SCHEDULE   /* retail: Sched_tSchedule always right after Sched_tFunctionSchedule */
#include "shared/Sched_tSchedule.h"
#endif
#endif

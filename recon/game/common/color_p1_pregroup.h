/* common type graph, part 1 of 10 (cut from color_types.h at its order hooks) */
#ifndef NFS4_GAME_COMMON_COLOR_P1_PREGROUP_H
#define NFS4_GAME_COMMON_COLOR_P1_PREGROUP_H
#ifdef NFS4_COLOR_GROUP_LATE   /* (continued from color_p0_draw.h) */
#include "shared/RelCoord16.h"
#endif
#if defined(NFS4_COLOR_GS_FIRST) && !defined(NFS4_COLOR_SCHED_BEFORE_GS)   /* retail: GameSetup ahead of Group (owner first header) */
#include "gamesetup_leaf_types.h"
#endif
#if defined(NFS4_COLOR_SCHED_FIRST) && !defined(NFS4_COLOR_SCHED_DONE)   /* retail: scheduler types ahead of Group (owner first header; SCHED_DONE = an owner emitted them earlier) */
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#ifdef NFS4_COLOR_SCHED_SCHEDULE
#include "shared/Sched_tSchedule.h"
#endif
#endif
#if defined(NFS4_COLOR_GS_FIRST) && defined(NFS4_COLOR_SCHED_BEFORE_GS)   /* retail input/nfs3: scheduler, then GameSetup */
#include "gamesetup_leaf_types.h"
#endif
#endif

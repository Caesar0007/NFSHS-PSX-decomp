#ifndef NFS4_GAME_COMMON_INPUT_TYPES_H
#define NFS4_GAME_COMMON_INPUT_TYPES_H   /* input.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_SCHED_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_BEFORE_GS   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#include "color_types.h"
#include "shared/Sched_tSchedule.h"




/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"




/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail input.obj (GameSetup_gData is read through its word view) */
















#include "shared/Input_tDeviceList.h"





#include "shared/Input_tResults.h"




typedef int Input_tDeviceCall(u_long value);

#endif

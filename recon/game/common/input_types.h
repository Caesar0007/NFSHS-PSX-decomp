/* input.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_INPUT_TYPES_H
#define NFS4_GAME_COMMON_INPUT_TYPES_H

#include "color_types.h"

#include "shared/Sched_tSchedule.h"




/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"




/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















#include "shared/Input_tDeviceList.h"





#include "shared/Input_tResults.h"




typedef int Input_tDeviceCall(u_long value);

#endif

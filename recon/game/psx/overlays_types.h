/* overlays.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_OVERLAYS_TYPES_H
#define NFS4_GAME_PSX_OVERLAYS_TYPES_H

#include "../common/color_types.h"

#define RaceType_HotPursuit 1

/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















#include "shared/Sched_tSchedule.h"




#include "shared/Sim_tSimGlobalVar.h"




#include "shared/tBTCPerpInfo.h"





#include "shared/kernpair.h"




typedef kernpair KERN;

typedef void (*adjustchar)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef int (*getcode)();

#endif

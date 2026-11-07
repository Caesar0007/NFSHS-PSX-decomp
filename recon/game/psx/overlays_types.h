#ifndef NFS4_GAME_PSX_OVERLAYS_TYPES_H
#define NFS4_GAME_PSX_OVERLAYS_TYPES_H   /* overlays.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "../common/color_types.h"

#define RaceType_HotPursuit 1

/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail overlays.obj (GameSetup_gData is read through its word view) */
















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

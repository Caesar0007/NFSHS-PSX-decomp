#if !defined(NFS4_GAME_PSX_OVERLAYS_TYPES_H)
#define NFS4_GAME_PSX_OVERLAYS_TYPES_H   /* overlays.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_PADS_HOOK_AFTER "../psx/overlays_types.h"   /* retail overlays.obj: GameSetup records, tBTCPerpInfo right after PAD_COMMON */
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

#elif defined(NFS4_PADS_IN_HOOK) && !defined(NFS4_OVERLAYS_PADS_DONE)   /* second pass: game_common_pads_types.h */
#define NFS4_OVERLAYS_PADS_DONE
#include "../common/gamesetup_leaf_types.h"
#include "shared/tBTCPerpInfo.h"
#endif

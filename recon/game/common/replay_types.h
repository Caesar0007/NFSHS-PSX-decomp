#if !defined(NFS4_GAME_COMMON_REPLAY_TYPES_H)
#define NFS4_GAME_COMMON_REPLAY_TYPES_H   /* replay.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_SCHED_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#define NFS4_CORE_FULL   /* this object lists the start of the core itself (retail record order) */
#define NFS4_GAME_COMMON_MIN_TYPES_H
#define NFS4_GAME_COMMON_PADS_TYPES_H
#include "game_common_min_core.h"
#include "pads_records.h"
#define NFS4_PADS_IN_HOOK
#include "replay_types.h"   /* this header again: its NFS4_PADS_IN_HOOK branch */
#undef NFS4_PADS_IN_HOOK
#include "pads_tail.h"
#undef NFS4_CORE_FULL
#undef NFS4_CORE_CCOORD16
#include "color_types.h"

#define RaceType_HotPursuit 1
#define RaceType_Id5 5

#include "shared/Sched_tSchedule.h"






















#include "shared/GameSetup_tData.h"
















typedef struct tControllerData {
    char steering[32];
    u_char gas[32], brake[32], states[32];
} tControllerData;

#include "shared/tReplayInterface.h"
#include "shared/tReplayCameraModes.h"
#include "shared/forceFocus_t.h"




#include "shared/Camera_tCamSlot.h"   /* retail replay: forceFocus_t, Camera_tCamSlot right after tReplayCameraModes */

typedef struct tReplayBuffer {
    GameSetup_tData gameSetup;
    int size;
    char buffer[24576];
} tReplayBuffer;

/* Canonical sim.obj aggregates used by this translation unit. */
#include "shared/Sim_tSimGlobalVar.h"




#include "shared/Sim_tSimSystemVar.h"




/* Canonical input.obj result aggregate used by this translation unit. */
#include "shared/Input_tResults.h"




/* Canonical camera.obj aggregate used by this translation unit. */
#include "shared/camera_info.h"





























typedef int Input_tDeviceCall();

#elif defined(NFS4_PADS_IN_HOOK) && !defined(NFS4_REPLAY_PADS_DONE)   /* second pass: game_common_pads_types.h */
#define NFS4_REPLAY_PADS_DONE
#include "gamesetup_leaf_types.h"
#include "shared/GameSetup_tData.h"
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#include "shared/Sched_tSchedule.h"
#define NFS4_COLOR_SCHED_DONE
#endif

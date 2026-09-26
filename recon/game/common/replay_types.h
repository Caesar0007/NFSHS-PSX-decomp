/* replay.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_REPLAY_TYPES_H
#define NFS4_GAME_COMMON_REPLAY_TYPES_H

#include "color_types.h"

#define RaceType_HotPursuit 1
#define RaceType_Id5 5

#include "shared/Sched_tSchedule.h"




typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

#include "shared/Camera_tCamSlot.h"











#include "shared/GameSetup_tData.h"
















struct tControllerData {
    char steering[32];
    u_char gas[32], brake[32], states[32];
};

#include "shared/tReplayInterface.h"




#include "shared/tReplayCameraModes.h"



struct tReplayBuffer {
    GameSetup_tData gameSetup;
    int size;
    char buffer[24576];
};

/* Canonical sim.obj aggregates used by this translation unit. */
#include "shared/Sim_tSimGlobalVar.h"




#include "shared/Sim_tSimSystemVar.h"




/* Canonical input.obj result aggregate used by this translation unit. */
#include "shared/Input_tResults.h"




/* Canonical camera.obj aggregate used by this translation unit. */
#include "shared/camera_info.h"





























typedef int Input_tDeviceCall();

#endif

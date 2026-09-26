/* dashHUD.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_DASHHUD_TYPES_H
#define NFS4_GAME_COMMON_DASHHUD_TYPES_H

#include "color_types.h"

#define RaceType_Id4 4

#include "shared/Sched_tSchedule.h"




typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

#include "shared/dashhud_info.h"








typedef dashhud_info DashHUD_tInfo;

#endif

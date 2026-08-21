/* clock.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_CLOCK_TYPES_H
#define NFS4_GAME_COMMON_CLOCK_TYPES_H

#include "color_types.h"

struct Clock_tGameClock {
    int time128Hz, time64Hz, time32Hz;
};

typedef int Input_tDeviceCall();

#endif

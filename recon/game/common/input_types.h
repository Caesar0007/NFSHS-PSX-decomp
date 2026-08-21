/* input.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_INPUT_TYPES_H
#define NFS4_GAME_COMMON_INPUT_TYPES_H

#include "color_types.h"

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

struct Input_tResults {
    char steering;
    u_char gas, brake, flags;
};

typedef int Input_tDeviceCall(u_long value);

#endif

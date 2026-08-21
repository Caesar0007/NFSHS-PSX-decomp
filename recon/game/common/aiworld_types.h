/* AIWORLD.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AIWORLD_TYPES_H
#define NFS4_GAME_COMMON_AIWORLD_TYPES_H

#include "color_types.h"

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

typedef int CarLogic_tObservations[1][3];

#endif

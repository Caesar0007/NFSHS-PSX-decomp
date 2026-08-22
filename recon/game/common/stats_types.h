/* stats.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_STATS_TYPES_H
#define NFS4_GAME_COMMON_STATS_TYPES_H

#include "color_types.h"

#define RaceType_HotPursuit 1
#define RaceType_Tournament 2
#define RaceType_Id5 5

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

struct Stats_tPosition {
    int car, slice, sliceTime, isHuman;
};

typedef int Input_tDeviceCall(u_long value);

#endif

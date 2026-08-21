/* schedule.obj's exact source-visible type surface.  Sim_tSimGlobalVar is
 * deliberately only forward-declared here: its body is owned and emitted by
 * sim.obj, while schedule.obj's SYM records only the tagged external object. */
#ifndef NFS4_GAME_COMMON_SCHEDULE_TYPES_H
#define NFS4_GAME_COMMON_SCHEDULE_TYPES_H

#include "game_common_min_types.h"

typedef void (*Sched_tFunctionPt)(void *);

struct Sched_tFunctionSchedule {
    int priority;
    Sched_tFunctionPt function;
    void *var1, *var2;
};

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

#include "gamesetup_leaf_types.h"

struct Sim_tSimGlobalVar;

#endif

/* schedule.obj's exact source-visible type surface. */
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

/* Canonical sim.obj aggregate from the retail SYM type graph. */
struct Sim_tSimGlobalVar {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};

#endif

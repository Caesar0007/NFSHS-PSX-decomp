/* aicop.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AICOP_TYPES_H
#define NFS4_GAME_COMMON_AICOP_TYPES_H

#include "color_types.h"

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

struct copLevel_t {
    int copChasers[2];
    int numBlockaders;
    int copBlockaders[2];
    int spikeBelt;
    int copAggression[2];
    int copsPerLap, engagementLapFraction, warningTicks, beatingTicks;
    int numWarningsAdded;
};

struct copGame_t {
    int numLevels;
    copLevel_t *levels;
};

typedef enum crimeType {
    CRIME_NONE = 0,
    CRIME_SPEEDER = 1,
    CRIME_WRONGSIDE = 2,
    CRIME_BUMPCOP = 3,
    CRIME_SMASHCOP = 4
} crimeType;

struct AICop_spikeBelt_t {
    int active_, slice_, leftLatPos_, rightLatPos_, freshenTime_;
};

typedef enum AICop_RoadBlockState {
    kAICop_RoadBlockState_None = 0,
    kAICop_RoadBlockState_WaitingForPerp = 1,
    kAICop_RoadBlockState_PerpPassed = 2
} AICop_RoadBlockState;

struct trigger_anyTrigger_t { int type, slice; };
struct trigger_simple_t { int type, slice, dir, side, moving; };
struct trigger_roadblock_t { int type, slice, dir, numCars, spikeBelt; };

struct trigger_offroad_t {
    int type, slice, dir;
    coorddef position;
    matrixtdef orientation;
    int maxSpeed, releaseTime, endSlice;
};

struct trigger_trafficAccident_t {
    int type, slice;
    coorddef position;
    matrixtdef orientation;
};

struct trigger_pathPosition_t {
    coorddef position;
    int targetSpeed, waitTime;
};

struct trigger_trafficPath_t {
    int type, slice, dir;
    matrixtdef orientation;
    int maxSpeed, releaseTime, numPoints;
    trigger_pathPosition_t *path;
};

union trigger_t {
    trigger_anyTrigger_t any;
    trigger_simple_t simple;
    trigger_roadblock_t roadblock;
    trigger_offroad_t offroad;
    trigger_trafficAccident_t trafficAccident;
    trigger_trafficPath_t trafficPath;
};

typedef int CarLogic_tObservations[1][3];

/* Exact externally owned layout from AITRIGER.SYM; needed here for the
 * original C++ new/delete and member-call expressions. */
struct AITrigger_TriggerManager {
    int numTriggers_, invNumTriggers_;
    trigger_t *triggers_[100];
    int checkTime_[100];
    int lastTriggerChecked_[9];
    void Init(char *rawTriggers);
};

#endif

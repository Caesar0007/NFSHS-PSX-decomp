/* aitriger.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AITRIGER_TYPES_H
#define NFS4_GAME_COMMON_AITRIGER_TYPES_H

#include "color_types.h"

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

typedef enum triggerType {
    TRIGGER_NONE = 0,
    TRIGGER_COP_SIMPLE = 1,
    TRIGGER_COP_ROADBLOCK = 2,
    TRIGGER_COP_OFFROAD = 3,
    TRIGGER_TRAFFIC_ACCIDENT = 4,
    TRIGGER_TRAFFIC_PATH = 5,
    TRIGGER_NUM_TRIGGER_TYPES = 6
} triggerType;

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

struct AITrigger_TriggerManager {
    int numTriggers_, invNumTriggers_;
    trigger_t *triggers_[100];
    int checkTime_[100];
    int lastTriggerChecked_[9];
    void Init(char *rawTriggers);
    int InsertTrigger(trigger_t *trigger, bool fromFile);
    trigger_t *GetNextTrigger(int car);
    trigger_t *GetPrevTrigger(int car);
    int CheckForTriggerAtSlice(int car, int slice);
    trigger_t *GetTrigger(int trigger, int *used);
    int CheckForClosestTriggerOfType(int slice, triggerType type, int direction);
    void DescribeTrigger(trigger_t *trigger);
    void Sort();
};

typedef int CarLogic_tObservations[1][3];

#endif

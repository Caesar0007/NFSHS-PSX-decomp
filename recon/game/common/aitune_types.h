/* AITUNE.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AITUNE_TYPES_H
#define NFS4_GAME_COMMON_AITUNE_TYPES_H

#include "color_types.h"

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

struct accelscale_t {
    int scale;
};

struct copTuning_t {
    int regularCopAccMultiplier, superCopAccMultiplier;
    int regularCopTopSpeedCap, superCopTopSpeedCap;
};

struct AITune_tTrackInfo {
    int oneWay, driveSide, roughLapTimeSeconds;
};

struct AITune_BTC_t {
    int glueMult, speedMult, weightMult, baseChaseTime;
    int wingmanTime, blockaderTime, spikeBeltTime;
};

typedef int CarLogic_tObservations[1][3];

#endif

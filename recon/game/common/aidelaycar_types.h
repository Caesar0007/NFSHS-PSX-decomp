#ifndef NFS4_GAME_COMMON_AIDELAYCAR_TYPES_H
#define NFS4_GAME_COMMON_AIDELAYCAR_TYPES_H   /* aidelaycar.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "color_types.h"

#include "shared/Sched_tSchedule.h"




typedef int CarLogic_tObservations[1][3];

struct AIDelayCar {
    int delayFactor_;
    Car_tObj *basisCar_, *targetCar_;
    int deltaMeters_, slice_;
    coorddef deltaPosition_, position_;
    int deltaRoadPosition_, roadPosition_, laneIndex_, currentSpeed_;

    AIDelayCar(Car_tObj *basisCar, Car_tObj *targetCar, int delayFactor);
    void SetNewTargetCar(Car_tObj *targetCar);
    void Update();
};

#endif

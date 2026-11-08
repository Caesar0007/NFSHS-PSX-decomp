#ifndef NFS4_GAME_COMMON_AISTATE_TYPES_H
#define NFS4_GAME_COMMON_AISTATE_TYPES_H   /* aistate.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "color_types.h"

#define NFS4_AISTATE_NONE_KEEP   /* key: keep AIState_None bodies (Car_tObj count) */ /* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail aistate.obj (GameSetup_gData is read through its word view) */
















#include "shared/Sched_tSchedule.h"




/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"




struct AIPhysic_BrakeInfo { u_char brakeTable_[128]; int deceleration_; /* the 5 retail AIPhysic_BrakeInfo inline bodies (aiphysic_types.h + aispeeds_types.h); retail 7 TPDEFs per includer */ inline void SetBrakeDistance(int speed, int distance) { int sIndex = speed / 0x10000; if (sIndex < 0) sIndex = -sIndex; if (!(sIndex < 0x80)) sIndex = 0x80; brakeTable_[sIndex] = (u_char)(distance / 0x20000); } AIPhysic_BrakeInfo(int deceleration) { int invDeceleration; deceleration_ = deceleration; invDeceleration = fixeddiv(0x10000, deceleration); for (int brakeTableLoop = 0; brakeTableLoop < 0x80; brakeTableLoop++) { int brakeDistanceMeters = fixedmult(fixedmult(brakeTableLoop << 0x10, invDeceleration), brakeTableLoop << 0x10) / 2; SetBrakeDistance(brakeTableLoop << 0x10, brakeDistanceMeters); } } inline int Deceleration() { return deceleration_; } int GetBrakeDistance(int speed) { int sIndex = speed / 0x10000; if (sIndex < 0) { sIndex = -sIndex; } if (!(sIndex < 0x80)) { sIndex = 0x80; } return (u_int)brakeTable_[sIndex] * 0x20000; } int GetNeededDistance(int futureSpeed,int currentSpeed) { return GetBrakeDistance(currentSpeed) - GetBrakeDistance(futureSpeed); } };






#include "shared/trigger_anyTrigger_t.h"
#include "shared/trigger_simple_t.h"





#include "shared/trigger_roadblock_t.h"
#include "shared/trigger_offroad_t.h"
#include "shared/trigger_trafficAccident_t.h"




#include "shared/trigger_pathPosition_t.h"
#include "shared/trigger_trafficPath_t.h"





#include "shared/trigger_t.h"








typedef struct AIDelayCar {
    int delayFactor_;
    Car_tObj *basisCar_, *targetCar_;
    int deltaMeters_, slice_;
    coorddef deltaPosition_, position_;
    int deltaRoadPosition_, roadPosition_, laneIndex_, currentSpeed_;
    AIDelayCar(Car_tObj *basisCar, Car_tObj *targetCar, int delayFactor);
    void SetNewTargetCar(Car_tObj *targetCar);
    void Update();
    int GetCurrentSpeed() { return currentSpeed_; } /* inferred field getter */ int GetRoadPosition() { return roadPosition_; } /* inferred getter */
    /* GetRoadPosition: defined in-class above (inferred getter for the three lateral-arm inline expansions) */
} AIDelayCar;







#include "aistate.h"
#include "shared/AIPhysic_ModelConfig_t.h"   /* retail aistate.obj: right after AIState_Cruise */

#include "shared/kernpair.h"
typedef kernpair KERN;
typedef int CarLogic_tObservations[1][3];
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

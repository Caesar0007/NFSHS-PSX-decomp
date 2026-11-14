/* common type graph, part 8 of 10 (cut from color_types.h at its order hooks) */
#ifndef NFS4_GAME_COMMON_COLOR_P8_CAR_H
#define NFS4_GAME_COMMON_COLOR_P8_CAR_H
#include "shared/Transformer_z.h"   /* retail order: Transformer_* after the scheduler types, then GameSetup (most frequent retail position) */

#include "gamesetup_leaf_types.h"





#ifndef NFS4_OWNER_DEFINES_UDFF_TYPES
#include "shared/Udff_tAccessType.h"



#ifdef NFS4_COLOR_OMIT_UDFF_HANDLE   /* retail cars.obj: Udff_tInfo complete, C-style typedef (two TPDEF), right after Udff_tAccessType; Udff_tHandle at the tail (cars_types.h) */
#include "shared/Udff_tInfo.h"   /* one Udff_tInfo definition (header-truth 4w) */
#else   /* Opaque in color.obj; the linked SYM resolves its owner-proven size to 12. */
#include "color_p8_car_d1.h"
#endif
#endif
#include "color_p8_car_d2.h"
#include "aiscript_types.h"   /* retail order: AIScript after AIPerson_t */

#include "color_p8_car_d3.h"
#ifdef NFS4_COLOR_CAR_STRUCT_ONLY   /* retail aihigh/aih_hum/aih_opp/aih_traf/aispeeds/object/sim: plain struct (one TPDEF) */
struct Car_tObj {
#else
typedef struct Car_tObj {
#endif
    BO_tNewtonObj N;
    char carName[9], carNameLocalized[9];
    int carIndex, humanIndex, sortIndex, carFlags, lap, unlap, roadSpan;
    int glue, blowout, pullOver, revLimit;
    Car_tObj *swapCar;
    int swapTime;
    GameSetup_tCarData *carInfo;
    Car_tWheel wheel[4];
    Car_tStats stats;
    int crash, wrongway;
    coorddef angularAcc, linearAcc, linearAcc_ch, linearVel_ch;
    coorddef angularVel_ch, linearAcc_rh;
    Car_tControl control;
    char RSGasLevel, RSBrakeLevel;
    int RSSteering, RSControl;
    Car_tSpecs *specs;
    int flywheelRpm, wheelSpin, frontWheelSpin, wheelLock, slide;
    int gTransferFront, gTransferRight, frontSkid, rearSkid, oldSkidState;
    coorddef oldSkidPoint[4];
    int oldAudioSkidState;
    Sched_tFunctionPt funcUpdateRoadInfo, funcReplay, funcControl, funcStats;
    Sched_tFunctionPt funcHandlingPhysics, funcGravityPhysics;
    Sched_tFunctionPt funcQDPhysicsUpdateVel, funcQDPhysicsUpdateRot;
    Sched_tFunctionPt funcTestMeForCollisions, funcDoPostCollisionStuff;
    int personalityIndex;
    AIPerson_t *personality;
    AIScript_t script;
    AISpeechInfo_t speechInfo;
    int carInLane, desiredDirection, direction, desiredLatPos, desiredSpeed;
    int originalDesiredSpeed, currentSpeed, speed, laneSlack, AIFlags;
    int roadPosition;
    Car_tObj *basisCar;
    int aiShiftDuration, aiShiftTimer, redLine, tailgateTimer;
    int physicsModelTimer, trafficSpeedRandomizingFactor, laneChangeSpeed;
    int topSpeeds[7], invTopSpeeds[7];
    short accTable[112];
    AIDataRecord_AccTable_t *accelerationRecord;
    AIDataRecord_CurveSpeedTable_t *curveSpeedTable;
    AIPhysic_BrakeInfo *brakeInfo;
    int speedFactor, barrierThinkHarder, laneIndex, copTopSpeed, copAccMult;
    coorddef desiredVector;
    int aCarWRTDesired;
    coorddef angularAcc_ch;
    int driveDirectionReverseTime, driveDirection, driveDirectionTimer;
    int aCar, aDesired, aCarWRTRoad, lateralVelocity;
    coorddef targetPos;
    int targetLatPos, rampDesiredLatPos, preferredLateralPosition;
    int preferredLateralPositionPower, timeOffRoad, max_clacc, max_aa;
    int aiGlue, drag, slackProb, accNitrous, speedNitrous;
    int wipeOutStartTick, wipeOutEndTick, btcGlueModifier;
    donutMode_t donutMode;
    int AIFishtailEndTick, lookAheadSlice, forceNoSimOptz, gripFactor;
    Car_tObj *fallBehindCar, *nextAIRacer;
    int caravanFollowBehindDistanceMeters, caravanTimer, AISlot, damageMult;
    int topSpeedUpgradeMult, accUpgradeMult, extraWallCollisionAllowance;
    Cars_tCollisionInfo collision;
    int audioDamageScrape, audioCount;
    Cars_tAudio audio[7];
    Cars_tRenderInfo render;
    int async_handle;
#ifdef NFS4_COLOR_CAR_STRUCT_ONLY
};
#else
} Car_tObj;   /* retail: C-style typedef = implicit + explicit TPDEF Car_tObj */
#endif
#endif

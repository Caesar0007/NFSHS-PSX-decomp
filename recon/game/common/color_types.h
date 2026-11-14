#ifndef NFS4_GAME_COMMON_COLOR_TYPES_H   /* color.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_GAME_COMMON_COLOR_TYPES_H
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail place (after COORD16, before the pads) */
#include "draw_leaf_types.h"
#undef NFS4_CORE_CCOORD16
#include "shared/CCOORD16.h"
#ifdef NFS4_COLOR_GROUP_LATE   /* retail: the track quad types and RelCoord16 ahead of Group (owner first header) */
#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"
#ifdef NFS4_COLOR_HOOK_GROUP_LATE_TRK   /* retail object/bworld: Trk_SFX/Trk_SimObject between Trk_NewSimSlice and RelCoord16 */
#include NFS4_COLOR_HOOK_GROUP_LATE_TRK
#endif
#include "shared/RelCoord16.h"
#endif
#if defined(NFS4_COLOR_GS_FIRST) && !defined(NFS4_COLOR_SCHED_BEFORE_GS)   /* retail: GameSetup ahead of Group (owner first header) */
#include "gamesetup_leaf_types.h"
#endif
#if defined(NFS4_COLOR_SCHED_FIRST) && !defined(NFS4_COLOR_SCHED_DONE)   /* retail: scheduler types ahead of Group (owner first header; SCHED_DONE = an owner emitted them earlier) */
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#ifdef NFS4_COLOR_SCHED_SCHEDULE
#include "shared/Sched_tSchedule.h"
#endif
#endif
#if defined(NFS4_COLOR_GS_FIRST) && defined(NFS4_COLOR_SCHED_BEFORE_GS)   /* retail input/nfs3: scheduler, then GameSetup */
#include "gamesetup_leaf_types.h"
#endif
#ifdef NFS4_COLOR_HOOK_BEFORE_GROUP   /* owner types after the GS/scheduler first blocks, right before Group (souffle, hrzsku) */
#include NFS4_COLOR_HOOK_BEFORE_GROUP
#endif
#include "shared/Group.h"   /* one Group definition (header-truth 4n) */










#ifdef NFS4_COLOR_TRK_OBJ   /* retail: track object types right after Group (owner first header) */
#include "shared/Trk_ObjectDef.h"
#ifdef NFS4_COLOR_TRK_SIMPLE
#include "shared/Trk_SimpleInst.h"
#endif
#include "shared/Trk_CollideBoomInst.h"
#endif
#if defined(NFS4_COLOR_TRK_OBJ) || defined(NFS4_COLOR_TRK_ANIM)
#include "shared/Trk_AnimateInst.h"
#endif
#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"
#ifdef NFS4_COLOR_HOOK_AFTER_SIMSLICE   /* an owner's own type right after Trk_NewSimSlice (bworldsm.obj: Trk_NewSlice) */
#include NFS4_COLOR_HOOK_AFTER_SIMSLICE
#endif
#ifdef NFS4_COLOR_TRK_OBJ
#ifdef NFS4_COLOR_TRK_SFX
#include "shared/Trk_SFX.h"
#endif
#ifdef NFS4_COLOR_TRK_LINE   /* retail draww: Trk_Line between Trk_NewSimSlice and Trk_SimObject (moved from draww_types.h) */
typedef struct Trk_Line { u_char firstPoint, slice, type, quadIndex; } Trk_Line;
#endif
#include "shared/Trk_SimObject.h"
#endif
#include "shared/RelCoord16.h"
#ifdef NFS4_COLOR_HOOK_AFTER_RELCOORD   /* retail object/bworld/draww: the owner's Chunk right after RelCoord16/Group (owner pass) */
#define NFS4_COLOR_IN_HOOK5
#include NFS4_COLOR_HOOK_AFTER_RELCOORD
#undef NFS4_COLOR_IN_HOOK5
#endif
#ifdef NFS4_CORE_SUBDIV_TRKART   /* retail: Track_tArtresource/Track_tMaterial after RelCoord16 */
#include "shared/Track_tArtresource.h"
#include "shared/Track_tMaterial.h"
#endif
#include "shared/tSaveSurface.h"
#ifdef NFS4_COLOR_HOOK_AFTER_SAVE   /* retail skidmark.obj: the owner's TCB/EXEC/DIRENTRY/Skidmark block right after tSaveSurface */
#define NFS4_COLOR_IN_HOOK3
#include NFS4_COLOR_HOOK_AFTER_SAVE
#undef NFS4_COLOR_IN_HOOK3
#endif
#ifdef NFS4_COLOR_GS_AFTER_SAVE   /* retail: GameSetup right after tSaveSurface (owner first header) */
#include "gamesetup_leaf_types.h"
#endif
#include "shared/BWorldSm_Pos.h"
#ifdef NFS4_COLOR_SCHED_AFTER_BWSM   /* retail hud.obj: scheduler types between BWorldSm_Pos and the BO types */
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#ifdef NFS4_COLOR_SCHED_SCHEDULE
#include "shared/Sched_tSchedule.h"
#endif
#endif
#ifdef NFS4_COLOR_HOOK_AFTER_BWSM   /* retail audiotrk.obj: the owner's Scene/audio types between BWorldSm_Pos and the BO types */
#define NFS4_COLOR_IN_BWSM
#include NFS4_COLOR_HOOK_AFTER_BWSM
#undef NFS4_COLOR_IN_BWSM
#endif
struct BO_tNewtonObj;
#include "shared/BO_tNewtonCollisionInfo.h"
#include "shared/BO_tNewtonObj.h"
#ifdef NFS4_COLOR_HOOK_AFTER_BO   /* retail object/bworld: the owner's anim/object types right after the BO types (owner second pass) */
#define NFS4_COLOR_IN_HOOK
#include NFS4_COLOR_HOOK_AFTER_BO
#undef NFS4_COLOR_IN_HOOK
#endif
#ifdef NFS4_COLOR_GS_AFTER_BO   /* retail: GameSetup after the BO types, before the scheduler */
#include "gamesetup_leaf_types.h"
#endif
#if !defined(NFS4_COLOR_SCHED_FIRST) && !defined(NFS4_COLOR_SCHED_AFTER_BWSM) && !defined(NFS4_COLOR_SCHED_DONE)
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#endif
#ifdef NFS4_COLOR_SCHED_SCHEDULE   /* retail: Sched_tSchedule always right after Sched_tFunctionSchedule */
#include "shared/Sched_tSchedule.h"
#endif
#ifdef NFS4_COLOR_HOOK_AFTER_SCHED   /* retail bworld: AnimScript between Sched_tSchedule and Transformer_zUV */
#include NFS4_COLOR_HOOK_AFTER_SCHED
#endif
#include "shared/Transformer_z.h"   /* retail order: Transformer_* after the scheduler types, then GameSetup (most frequent retail position) */

#include "gamesetup_leaf_types.h"





#ifndef NFS4_OWNER_DEFINES_UDFF_TYPES
#include "shared/Udff_tAccessType.h"



#ifdef NFS4_COLOR_OMIT_UDFF_HANDLE   /* retail cars.obj: Udff_tInfo complete, C-style typedef (two TPDEF), right after Udff_tAccessType; Udff_tHandle at the tail (cars_types.h) */
#include "shared/Udff_tInfo.h"   /* one Udff_tInfo definition (header-truth 4w) */
#else   /* Opaque in color.obj; the linked SYM resolves its owner-proven size to 12. */
struct Udff_tInfo;
typedef Udff_tInfo *Udff_tHandle;
#endif
#endif
typedef struct AIPerson_t {
    int blockMaxDistance, blockMinDistance, oncomingLookAhead;
    int laneSwerve[4];
    int swerveChangeProb, brakeMultiplier, attackActivationHits, attackTime;
    int fishtailAngle, minimumBetweenWipeoutTicks, randomBetweenWipeoutTicks;
    int gripLossProbPerSecond, gripLossMinFactor, gripLossRecoveryPerTick;
    int bestLineAbility;
    unsigned int rearBumpProbMask, smackProbMask, copCollisionFirmness;
} AIPerson_t;
#include "aiscript_types.h"   /* retail order: AIScript after AIPerson_t */

typedef enum speechModeType {
    SPEECH_MODE_NONE = 0,
    SPEECH_MODE_PURSUIT = 1,
    SPEECH_MODE_PURSUIT_WRONG_SIDE = 2,
    SPEECH_MODE_PURSUIT_BUMP_COP = 3,
    SPEECH_MODE_WARNING = 4,
    SPEECH_MODE_WARNING_WRONG_SIDE = 5,
    SPEECH_MODE_WARNING_BUMP_COP = 6,
    SPEECH_MODE_BUST = 7,
    SPEECH_MODE_APPROACH_ROADBLOCK = 8,
    SPEECH_MODE_ARREST = 9,
    SPEECH_MODE_COP_KILLER = 10,
    SPEECH_MODE_SENTINAL = 11
} speechModeType;

typedef enum speechIntensityType {
    SPEECH_INTENSITY_LOW = 0,
    SPEECH_INTENSITY_MED = 1,
    SPEECH_INTENSITY_HIGH = 2,
    SPEECH_INTENSITY_SENTINAL = 3
} speechIntensityType;

typedef enum speechSourceType {
    SPEECH_SOURCE_REGULAR_COP = 0,
    SPEECH_SOURCE_SUPER_COP = 1,
    SPEECH_SOURCE_ROADBLOCK = 2,
    SPEECH_SOURCE_SENTINAL = 3
} speechSourceType;

typedef struct AISpeechInfo_t {
    speechModeType speechMode;
    speechIntensityType speechIntensity;
    speechSourceType speechSource;
    int playerCarIndex, copCarIndex, warningNumber;
} AISpeechInfo_t;

typedef struct Car_tStats {
    int extractSlice, sliceTotal, sliceTime, slice, lastSlice, lap, lapTime;
    int time[4], topSpeed[4];
    int position, fatalCrashes, finishType, checkpointDifference;
    int checkpointUpdate, checkpointDisplay, numWarnings, numFines, numArrests;
    int carType, carClass, carNameIndex, carFlags, finalDamage;
    int finalNumWarnings, finalNumFines, finalNumArrests, finalFinishType;
    int finalPosition, finalTotalTime;
    int finalLapTime[4];
    int finalBestLap;
} Car_tStats;

typedef struct Car_tControl {
    char desiredGasLevel, desiredBrakeLevel, desiredGear, gasLevel, brakeLevel;
    char lastGear, gear, downShifting, gearShiftTimer, handBrake, horn, lights;
    char lookBehind, abort, event, queuedEvent;
    int desiredSteering, steering, hanno;
} Car_tControl;

typedef struct Car_tWheel {
    coorddef currentPos, roadNormal;
    int actualHeight, wheelAcc, wheelInAir, rebound, impactCompression;
    int roadSurfaceType;
} Car_tWheel;

typedef struct Car_tSpecs {
    int mass, numGears, gearShiftDelay;
    int velToRpmRatio[8], gearEfficiency[8];
    int torqueCurve[41];
    int redline, maxSpeed, frontDriveRatio, maxBrakeAcc, frontBrakeRatio;
    int wheelBase, frontGripBias, maxSteeringAcc, steeringRamp, lateralGripMult;
    int frontAeroDownForce, rearAeroDownForce, gasOffFactor, gTransferFactor;
    int slideMultiplier, spinVelCap, dampingPitchRate, dampingRollRate;
    int suspensionStiffness, pitchAngularVelCap, rollAngularVelCap, damageFactor;
    int bodyPitchFactor, bodyRollFactor, tireRange, rideOffset, dragFactor;
    int redlineInv;
    int gearVelInv[8], velToRpmRatioInv[8], gearAccCoeff[8];
    int dragCoeff, alphaToAccRotInertia, accToAlphaRotInertia;
    int lateralGripMultInv;
} Car_tSpecs;

typedef struct Cars_tCollisionInfo { int resetTimer, smoking; } Cars_tCollisionInfo;
typedef struct Cars_tAudio { int type, channel, surface1, surface2, force, panangle; } Cars_tAudio;

typedef struct Cars_tRenderInfo {
    short colorIndex;
    char currentCountry, newCountry;
    int textureStartIndex, bodyPitch, bodyRoll, currentPitch, currentRoll;
    int currentHeight, pitchFactor, rollFactor, world_otz, sub_otz;
    u_long *sub_ot;
    int sub_otSize, sub_otOffset;
    void *sort_carObj;
    short sort_flag, damageParts;
    int light;
    char *palCopy;
    short palNum;
    short palCopyNum[20];
    char medOnly, upgradeFlags;
    short headLight, brakeLight;
    short signalLight[2];
    short currentCarType, newCarType, inside, detail, VRamX, VRamY;
    short textureOffsetU, textureOffsetV;
    u_char licenseOffsetU[2], licenseOffsetV[2];
    int rideHeight, upgradeHeight;
} Cars_tRenderInfo;
enum donutMode_t {
    DONUTMODE_NONE = 0,
    DONUTMODE_GOCENTER = 1,
    DONUTMODE_DONUT = 2,
    DONUTMODE_BURNOUT = 3
};

struct AIDataRecord_AccTable_t;
struct AIDataRecord_CurveSpeedTable_t;
struct AIPhysic_BrakeInfo;
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
#ifdef NFS4_COLOR_HOOK_AFTER_CAR   /* retail hud: the owner's types right after Car_tObj (owner second pass) */
#define NFS4_COLOR_IN_HOOK2
#include NFS4_COLOR_HOOK_AFTER_CAR
#undef NFS4_COLOR_IN_HOOK2
#endif
typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];
typedef int AIPerson_tGlueTable[21];
typedef short Car_tAccTable[112];

#endif

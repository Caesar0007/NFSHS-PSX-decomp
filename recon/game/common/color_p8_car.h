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
#endif

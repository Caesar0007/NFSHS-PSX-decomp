/* color.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_COLOR_TYPES_H
#define NFS4_GAME_COMMON_COLOR_TYPES_H

#include "draw_leaf_types.h"
#include "gamesetup_leaf_types.h"
#include "aiscript_types.h"

struct CCOORD16 { short x, y, z, light; };

struct Transformer_zUV { u_char u, v; };

struct Transformer_zFacet {
    short flag;
    u_char textureIndex, vertexId0, vertexId1, vertexId2;
    Transformer_zUV uv0, uv1, uv2;
};

struct Transformer_zObj {
    u_short numVertex, numFacet;
    coorddef translation;
    COORD16 *vertex, *Nvertex;
    Transformer_zFacet *facet;
};

struct Transformer_zOverlay { short offset; u_char u, v; };
typedef COORD16 Transformer_zVertex;

struct Group {
    int m_num_elements;
    inline void *GetData() { return this + 1; }
    inline int GetNumElements() { return m_num_elements; }
};

struct Trk_Quad { short material; u_char aPoints[4]; };
struct Trk_NewStrip { u_char topVert, botVert; char quadCount, size; };
struct Trk_NewSimQuad { u_char surface; };
struct Trk_NewSimSlice {
    u_char stripIndex, quadCount, simquadIndex, simquadCount, simquadStartIndex;
};
struct RelCoord16 { short x, z; };
struct tSaveSurface { Trk_NewSimQuad *fSimQuad; u_char fSurface; };

struct BWorldSm_Pos {
    short slice, stripQuadInd, simRotFlag;
    coorddef quadPts[4];
    CCOORD16 quadPts16[4];
    char sliceChanged, quadChanged, offEdge, triangleFlag;
    coorddef normal, forward;
    char quad;
    u_char chunk;
    char lastRezRequested, rez;
    Trk_NewSimQuad *simQuad;
    Trk_NewStrip *strip;
    Trk_NewSimSlice *simSlice;
};

struct BO_tNewtonObj;

struct BO_tNewtonCollisionInfo {
    int collided, impulse;
    BO_tNewtonObj *otherObj;
    int sfxType, disableCollisionTimer;
    coorddef collisionPoint;
    int lastCollision;
    BO_tNewtonObj *lastOtherObj;
    int lastImpulse, lastTime;
};

struct BO_tNewtonObj {
    int objID;
    u_short oldSlice, totalSlice;
    BWorldSm_Pos simRoadInfo;
    int distToPlayer;
    u_char simOptz, active, reOrthoCounter;
    int gravityMult, cumulatedRot, lastUpdated;
    coorddef position, linearVel;
    int mass, massInv, speedXZ, xRelRoadCenter;
    short positionXZ, eIndexEnvMap, eIndexShadow;
    int wheelRot[2];
    int wheelFrontX, wheelFrontZ, wheelBackX, wheelBackZ, wheelWidthF, wheelWidthB;
    matrixtdef orientMat;
    coorddef angularVel;
    int moInertia, moInertiaInv;
    coorddef orientationToGround, dimension;
    int dimensionRadius;
    matrixtdef roadMatrix;
    coorddef roadCenterPoint;
    int roadGravityModifier, roadYaw;
    u_short flightTime, deadTimer;
    int groundElevation, groundVel, objAltitude;
    BO_tNewtonCollisionInfo collision;
    int groundSurfaceType, driveSurfaceType;
    matrixtdef shadowMat;
    coorddef shadowCoord[4];
    int damage[10];
};

typedef void (*Sched_tFunctionPt)(void *);
struct Sched_tFunctionSchedule {
    int priority;
    Sched_tFunctionPt function;
    void *var1, *var2;
};

typedef enum Udff_tAccessType {
    UDFF_FILE = 0,
    UDFF_MEMORY = 1
} Udff_tAccessType;
/* Opaque in color.obj; the linked SYM resolves its owner-proven size to 12. */
struct Udff_tInfo;
typedef Udff_tInfo *Udff_tHandle;

struct AIPerson_t {
    int blockMaxDistance, blockMinDistance, oncomingLookAhead;
    int laneSwerve[4];
    int swerveChangeProb, brakeMultiplier, attackActivationHits, attackTime;
    int fishtailAngle, minimumBetweenWipeoutTicks, randomBetweenWipeoutTicks;
    int gripLossProbPerSecond, gripLossMinFactor, gripLossRecoveryPerTick;
    int bestLineAbility;
    unsigned int rearBumpProbMask, smackProbMask, copCollisionFirmness;
};

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

struct AISpeechInfo_t {
    speechModeType speechMode;
    speechIntensityType speechIntensity;
    speechSourceType speechSource;
    int playerCarIndex, copCarIndex, warningNumber;
};

struct Car_tStats {
    int extractSlice, sliceTotal, sliceTime, slice, lastSlice, lap, lapTime;
    int time[4], topSpeed[4];
    int position, fatalCrashes, finishType, checkpointDifference;
    int checkpointUpdate, checkpointDisplay, numWarnings, numFines, numArrests;
    int carType, carClass, carNameIndex, carFlags, finalDamage;
    int finalNumWarnings, finalNumFines, finalNumArrests, finalFinishType;
    int finalPosition, finalTotalTime;
    int finalLapTime[4];
    int finalBestLap;
};

struct Car_tControl {
    char desiredGasLevel, desiredBrakeLevel, desiredGear, gasLevel, brakeLevel;
    char lastGear, gear, downShifting, gearShiftTimer, handBrake, horn, lights;
    char lookBehind, abort, event, queuedEvent;
    int desiredSteering, steering, hanno;
};

struct Car_tWheel {
    coorddef currentPos, roadNormal;
    int actualHeight, wheelAcc, wheelInAir, rebound, impactCompression;
    int roadSurfaceType;
};

struct Car_tSpecs {
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
};

struct Cars_tCollisionInfo { int resetTimer, smoking; };
struct Cars_tAudio { int type, channel, surface1, surface2, force, panangle; };

struct Cars_tRenderInfo {
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
};

typedef enum donutMode_t {
    DONUTMODE_NONE = 0,
    DONUTMODE_GOCENTER = 1,
    DONUTMODE_DONUT = 2,
    DONUTMODE_BURNOUT = 3
} donutMode_t;

struct AIDataRecord_AccTable_t;
struct AIDataRecord_CurveSpeedTable_t;
struct AIPhysic_BrakeInfo;

struct Car_tObj {
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
};

typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];
typedef int AIPerson_tGlueTable[21];
typedef short Car_tAccTable[112];

#endif

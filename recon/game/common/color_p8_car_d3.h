/* color_p8_car_d3 -- moved verbatim out of color_p8_car.h so that header holds only its include list. */
#ifndef NFS4_COLOR_P8_CAR_D3_H
#define NFS4_COLOR_P8_CAR_D3_H
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
#endif

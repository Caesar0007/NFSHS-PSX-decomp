/* Reconstructed aiperson types and the owner-proven shared GameSetup layout. */
#ifndef NFS4_GAME_COMMON_AIPERSON_TYPES_H
#define NFS4_GAME_COMMON_AIPERSON_TYPES_H

#define NFS4_OWNER_DEFINES_UDFF_TYPES
#include "color_types.h"
#undef NFS4_OWNER_DEFINES_UDFF_TYPES

/* P873: canonical aggregate from native SYM 27dcf0..27e1c7, 2600 bytes.
 * Its body is absent from aiperson.obj's retained debug graph; the original
 * header/debug visibility remains an explicit audit question. The real type
 * and fields replace the false int[19]/Car_tObj angular-velocity view. */
struct GameSetup_tData {
    int raceType, numLaps, skill, commMode, tournamentMultiplier, cops;
    int trafficDensity, localCar, catchupLogic, replayMode, instantReplay;
    int mirrorTrack, reverseTrack, measurement, sgge, track, trackSegment, song;
    int Weather, Fog, Damage, Time, randSeed, easter;
    GameSetup_tControllerData controllerData;
    int pinkSlipsForfeit, checkpointType;
    int checkpointHUD[2];
    int dispatchSpeech, reverseCallSpeech, languageSpeech;
    int SceneNumber, SceneStartLap, SceneEndLap;
    GameSetup_tUserSetting userSetting;
    int numPerps, stageOffset, perpArrests, finalPerpArrests;
    GameSetup_tPerpData perpInfo[10];
    int numCars, numPlayerRaceCars, numOpponentRaceCars, opponentCarType;
    GameSetup_tCarData carInfo[9];
};

#define RaceType_HotPursuit 1
#define RaceType_Tournament 2
#define RaceType_Id5 5

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

typedef enum Udff_tAccessType {
    UDFF_FILE = 0,
    UDFF_MEMORY = 1
} Udff_tAccessType;

struct Udff_tInfo {
    Udff_tAccessType type;
    int handle;
    char *memPtr;
};
typedef struct Udff_tInfo Udff_tInfo;
typedef Udff_tInfo *Udff_tHandle;

typedef int CarLogic_tObservations[1][3];

#endif

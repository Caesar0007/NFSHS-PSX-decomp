/* game/common/aidatarecord_externs.h - reconstructed externs. NOT original. */
#ifndef _GAME_COMMON_AIDATARECORD_EXTERNS_H_
#define _GAME_COMMON_AIDATARECORD_EXTERNS_H_

extern int gNumSlices;

/* paths.obj's path table (@0x80116468; [4] .qcs, [5] .acc/.csp, [10] .qcr, [11] .crv, [12] .qbe, [13] .bes), gmesetup.obj's
   setup record (.track @0x80113228 = the %02d of the file names) + the car list, for the ctor sprintf()s */
extern char     *Paths_Paths[];

/* Canonical gmesetup.obj aggregate (same record aiinit_types.h carries). */
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
extern GameSetup_tData GameSetup_gData;
extern Car_tObj *Cars_gHumanRaceCarList[9];   /* cars.obj; [0]+0x240 = car name */

/* sprintf format strings — named rodata symbols (NOT inline literals, which would
 * land in this object's .rodata; the original references them at these addresses) */

extern "C" void *reservememadr(...);
extern "C" void *loadpackadrz(...);
extern "C" int purgememadr(...);
extern "C" int sprintf(...);
extern "C" int fixedmult(...);

#endif /* _GAME_COMMON_AIDATARECORD_EXTERNS_H_ */

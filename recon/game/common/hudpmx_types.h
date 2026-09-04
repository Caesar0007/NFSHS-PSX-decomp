/* HudPmx.obj's exact source-visible type surface. */
#ifndef NFS4_GAME_COMMON_HUDPMX_TYPES_H
#define NFS4_GAME_COMMON_HUDPMX_TYPES_H

#include "textsys_types.h"
#include "draw_leaf_types.h"

struct HudPmx_tShape {
    Draw_tPixMap pixmap;
    short width, height;
};

struct HudPmx_tUV {
    u_char u0, v0;
    u_short clut;
};

#include "gamesetup_leaf_types.h"

/* Canonical gmesetup.obj aggregate used by this translation unit. */
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

/* Canonical dashHUD.obj aggregate used by this translation unit. */
struct dashhud_info {
    int splitscreen;
    char name[9];
    int conversion, flashtime, flashlap;
    int showhud[2], showmap[2], wrongway[2];
    int laptime, lap, maxlaps, rpm, redline, gear, speed, topspeed;
    int position, opponents, record, tutor;
    int warning[2];
};

#endif

/* GameSetup component records emitted by small game/common users without the
 * 2600-byte GameSetup_tData owner body. */
#ifndef NFS4_GAME_COMMON_GAMESETUP_LEAF_TYPES_H
#define NFS4_GAME_COMMON_GAMESETUP_LEAF_TYPES_H

#include "game_common_min_types.h"

struct GameSetup_tCarData {
    int carType, carClass, Transmission, Colour, ColourSV, ColourChange;
    int RampSteering, RampGas, RampBrake, BrakeBias, GearRatio;
    int SteeringQuickness, Traction, BrakeAssist, TireType, EngineMods;
    int WeightTransfer, GroundEffects, ABS, Bestline, Personality;
    int StartingPos, carNameIndex;
    char driver[8];
    int pad;
    char license[8];
    int HudSpeed, HudSpeedMult, HudTach, HudMap, HudOpponentID, HudTime;
    int HudLapnum, HudPosition, HudMirror, HudColour, HudTachColour;
    int SpeechColour, Country;
    int Camera[4];
};

struct GameSetup_tUserSetting {
    int language, display, bestlap, audioMode, musicLevel, sfxLevel;
    int engineLevel, speechLevel, ambientLevel, interactive;
    int numplaylistsongs;
    int playlist[40];
};

struct GameSetup_tPerpData {
    int CarType, Colour, SpeechColour, HudColour, Personality, TimeLimit;
    int WingmanTime, SpikeBeltTime, BlockadeCopTime, Distance;
    int SpeedFactor, WeightFactor, GlueFactor;
};

struct GameSetup_tControllerData {
    int controllerConfig[2], deadSpot[2], steeringRange[2];
    int IImaxRange[2], ImaxRange[2], J1MIN[2], J1MAX[2];
    int J2MIN[2], J2MAX[2], shockMode[2], shockImpact[2];
};

#endif

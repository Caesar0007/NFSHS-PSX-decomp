/* aih_play.obj's exact owner delta over the shared AI hierarchy. */
#ifndef NFS4_GAME_COMMON_AIH_PLAY_TYPES_H
#define NFS4_GAME_COMMON_AIH_PLAY_TYPES_H

#include "aih_hierarchy_types.h"

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

typedef enum triggerType {
    TRIGGER_NONE = 0,
    TRIGGER_COP_SIMPLE = 1,
    TRIGGER_COP_ROADBLOCK = 2,
    TRIGGER_COP_OFFROAD = 3,
    TRIGGER_TRAFFIC_ACCIDENT = 4,
    TRIGGER_TRAFFIC_PATH = 5,
    TRIGGER_NUM_TRIGGER_TYPES = 6
} triggerType;

struct BW_tContext {
    int client;
    BWorldSm_Pos slicePos;
    int currentChunk, chunkFarZClipSq, polyFarZClipSq, lowDetailDistSq;
    int lineFarZClipSq;
};

struct AIHigh_Cop : public AIHigh_BasicCop {
    AIHigh_Player *perpTarget_;
    int forcePurgatory_, chaseIndex_, requestSpikeBeltAtSlice_;
    int aggressionLevel_;
    AIHigh_Cop(Car_tObj *carObj, int idx);
    void SetTuningLevers();
    void HighExecute();
    int CheckForNeedyPlayers();
    void CheckForWipeOut();
    int CheckForNewTarget();
    void AssignToPlayer(AIHigh_Player *p);
    int GetCheckChasePosition(coorddef *pt);
    trigger_t *CheckForNewTriggers();
};

#include "shared/SPCHNFSType_POSITION.h"
#include "shared/SPCHNFSType_DISTANCE.h"
#include "shared/SPCHNFSType_COLOUR.h"
#include "shared/SPCHNFSType_ACCIDENT.h"
#include "shared/SPCHNFSType_AMBULANCE.h"
#include "shared/SPCHNFSType_PURS_UPDT.h"
#include "shared/SPCHNFSType_ARREST.h"
#include "shared/SPCHNFSType_vs_RDBLK_SSTRP.h"
#include "shared/SPCHNFSType_PERP_NAME.h"
#include "shared/SPCHNFSType_CONFIRM.h"
#include "shared/SPCHNFSType_SPIKE_BELT_SIDE.h"
#include "shared/SPCHNFSType_REVINTRO.h"

#include "shared/CarBank.h"
#include "shared/LocationBank.h"
#include "shared/CallSignBank.h"

/* Speech's nested banks are retained although its outer definition is not. */
struct { CarBank Mobile[9], Dispatch[9]; };
struct { LocationBank Mobile[16], Dispatch[16]; };
struct { CallSignBank Mobile, Dispatch; };

/* Speech, as this surface needs it: the nested polymorphic Speaker and the two static finders */
struct Speech {
    struct Speaker {
        SPCHNFSType_POSITION fPosition;
        SPCHNFSType_DISTANCE fDistance;
        SPCHNFSType_COLOUR fColour;
        SPCHNFSType_ACCIDENT fAccident;
        SPCHNFSType_AMBULANCE fAmbulance;
        SPCHNFSType_vs_RDBLK_SSTRP fBlockade;
        SPCHNFSType_REVINTRO fReverse;
        SPCHNFSType_CONFIRM fConfirm;
        SPCHNFSType_PERP_NAME fPerpName;
        SPCHNFSType_SPIKE_BELT_SIDE fSpikeSide;
        SPCHNFSType_PURS_UPDT fUpdate;
        SPCHNFSType_ARREST fArrest;
        int fCar, fLocation, fFrom, fTo, fWing;
        bool fHavePerp;
        Speaker *fSub;
#include "speech_speaker_virtuals.inc"
    };
    static Speaker *Dispatch();
    static Speaker *Mobile(Car_tObj *carObj);
};

struct AITrigger_TriggerManager {
    int numTriggers_, invNumTriggers_;
    trigger_t *triggers_[100];
    int checkTime_[100];
    int lastTriggerChecked_[9];
    void Init(char *rawTriggers);
    int InsertTrigger(trigger_t *trigger, bool fromFile);
    trigger_t *GetNextTrigger(int car);
    trigger_t *GetPrevTrigger(int car);
    int CheckForTriggerAtSlice(int car, int slice);
    trigger_t *GetTrigger(int trigger, int *used);
    int CheckForClosestTriggerOfType(int slice, triggerType type, int direction);
    void DescribeTrigger(trigger_t *trigger);
    void Sort();
};

/* Canonical foreign aggregates used by this translation unit. */
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
#include "shared/Sim_tSimGlobalVar.h"



struct Sim_tSimSystemVar {
    int restartGame, endSimGame, pauseSim, keyRelease;
    int quickPauseSim, goalClockTicks, currentClockTicks;
};
#include "shared/dashhud_info.h"








#include "shared/Trk_NewSlice.h"







typedef enum AICop_RoadBlockState {
    kAICop_RoadBlockState_None = 0,
    kAICop_RoadBlockState_WaitingForPerp = 1,
    kAICop_RoadBlockState_PerpPassed = 2
} AICop_RoadBlockState;
#define RaceType_HotPursuit 1
#define RaceType_Id5 5

typedef int CarLogic_tObservations[1][3];
typedef long (*ReparmFuncPtr)();
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();

#endif

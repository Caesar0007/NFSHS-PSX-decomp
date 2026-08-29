/* aih_btcperp.obj's exact owner delta over the shared AI hierarchy. */
#ifndef NFS4_GAME_COMMON_AIH_BTCPERP_TYPES_H
#define NFS4_GAME_COMMON_AIH_BTCPERP_TYPES_H

#include "aih_hierarchy_types.h"

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

struct BW_tContext {
    int client;
    BWorldSm_Pos slicePos;
    int currentChunk, chunkFarZClipSq, polyFarZClipSq, lowDetailDistSq;
    int lineFarZClipSq;
};

struct Trk_ObjectDef { short id; u_char vertexCount, quadCount; };
struct Trk_CollideBoomInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad;
    int x, y, z;
    short qx, qy, qz, qw, sx, sy, sz;
    u_char simIndex, boomIndex;
};
struct Trk_AnimateInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad, count, interval;
};
struct Trk_SimObject {
    int point[3];
    short radius, serialNum;
    u_char topCRAP, bottomCRAP, instIndex, type;
};

struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
};
struct AnimDef { int type, numPieces, objDefIndex, baseAnim, animIndex; };
struct ObjectAnim { __vtbl_ptr_type (*_vf)[3]; };
struct ObjectFinishedMultiAnim { ObjectAnim _base_ObjectAnim; };
struct ObjectFinishedSignAnim {
    ObjectAnim _base_ObjectAnim;
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
};

struct AIHigh_BTC_HumanPerp : public AIHigh_BTC_Perp {
    AIHigh_BTC_HumanPerp() {}
    ~AIHigh_BTC_HumanPerp();
    void NewStage(AIHigh_BTC_HumanCop *cop);
    void HighExecute();
};

struct AIHigh_BTC_AIPerp : public AIHigh_BTC_Perp {
    __typeof__(PERPMODE_CRUISE) perpMode_;
    int creationTime_, madeContactTime_, timeUntilContact_, escapeDuration_;
    int originalMass_, originalMassInv_;
    Car_tObj *closestCopCarObj_;
    int closestCopCarDistanceMeters_;
    AIHigh_BTC_AIPerp() {}
    AIHigh_BTC_AIPerp(Car_tObj *carObj);
    ~AIHigh_BTC_AIPerp();
    void AvoidCops();
    void CalculateTimeTillContact();
    void FindClosestCop();
    void HighExecute();
    void NewStage(AIHigh_BTC_HumanCop *cop);
};

struct AIState_Cruise : public AIState_Normal {
    cruiseMode_t cruiseMode_;
    int cruiseSpeed_, cruiseFactor_;
    AIState_Cruise() {}
    AIState_Cruise(Car_tObj *carObj, cruiseMode_t mode, int factor);
    void Execute();
};

struct SPCHNFSType_POSITION { u_long flags; };
struct SPCHNFSType_DISTANCE { u_long flags; };
struct SPCHNFSType_COLOUR { u_long flags; };
struct SPCHNFSType_ACCIDENT { u_long flags; };
struct SPCHNFSType_AMBULANCE { u_long flags; };
struct SPCHNFSType_PURS_UPDT { u_long flags; };
struct SPCHNFSType_ARREST { u_long flags; };
struct SPCHNFSType_vs_RDBLK_SSTRP { u_long flags; };
struct SPCHNFSType_PERP_NAME { u_long flags; };
struct SPCHNFSType_CONFIRM { u_long flags; };
struct SPCHNFSType_SPIKE_BELT_SIDE { u_long flags; };
struct SPCHNFSType_REVINTRO { u_long flags; };

struct CarBank { int fFull, fMake, fModel; };
struct LocationBank { int fStartSlice, fEndSlice, fBankId; char *fName; };
struct CallSignBank { int fAllUnits, fDispatch; int fMobile[15]; };

/* Speech's nested banks are retained although its outer definition is not. */
struct { CarBank Mobile[9], Dispatch[9]; };
struct { LocationBank Mobile[16], Dispatch[16]; };
struct { CallSignBank Mobile, Dispatch; };

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
    __vtbl_ptr_type (*_vf)[31];
};

/* Foreign globals whose completed tags are absent from this retail owner. */
struct AIH_BTCPerp_AITuneBTCCodegenView {
    int glueMult, speedMult, weightMult, baseChaseTime;
    int wingmanTime, blockaderTime, spikeBeltTime;
};
struct AIH_BTCPerp_GameSetupCodegenView {
    int raceType, numLaps, skill, commMode, tournamentMultiplier, cops;
    int trafficDensity, localCar, catchupLogic, replayMode, instantReplay;
    int mirrorTrack, reverseTrack, measurement, sgge, track, trackSegment;
    int song, Weather, Fog, Damage, Time;
    char _pad58[356];
    GameSetup_tPerpData perpInfo[10];
    char _rest[1636];
};
struct AIH_BTCPerp_SimGlobalCodegenView {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};
struct AIH_BTCPerp_CameraCodegenView {
    char _pad00[128];
    int forceFocus;
    signed char focusOnAICar;
    char _rest[139];
};

#define AITune_BTC_t AIH_BTCPerp_AITuneBTCCodegenView
#define GameSetup_tData AIH_BTCPerp_GameSetupCodegenView
#define Sim_tSimGlobalVar AIH_BTCPerp_SimGlobalCodegenView
#define camera_info AIH_BTCPerp_CameraCodegenView
#define AICop_RoadBlockState int
#define kAICop_RoadBlockState_None 0

typedef int CarLogic_tObservations[1][3];
typedef long (*ReparmFuncPtr)();
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();

#endif

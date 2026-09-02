/* aih_cop.obj's exact owner delta over the shared AI hierarchy. */
#ifndef NFS4_GAME_COMMON_AIH_COP_TYPES_H
#define NFS4_GAME_COMMON_AIH_COP_TYPES_H

#include "aih_hierarchy_types.h"

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
    AIHigh_Cop() {}
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

struct AIState_Chase : public AIState_Base {
    AIDelayCar delayCar_;
    int noTurnAroundEndTime_;
    Car_tObj *targetCar_;
    coorddef relPosition_;
    int longTargetRegion_, latTargetRegion_, targetDir_, carDir_;
    int longMetersBetween_, latMetersBetween_, murderMode_, murderEndTime_;
    int inTargetRegion_, nitrousTicks_, nitrousMinForeDistance_;
    int nitrousMinAftDistance_, aggressionLevel_, slowDownEndTime_;
    int barrierTicks32_;
    AIState_Chase() {}
    AIState_Chase(Car_tObj *, Car_tObj *, coorddef *, int, int, int, int, int);
    void SetTarget(Car_tObj *, coorddef *);
    void SetMurderMode(int, int);
    int FindBarrierEndSlice();
};

struct AIState_GotoSlice : public AIState_Normal {
    int targetSlice_, stopWhenArrivedAtSlice_;
    AIState_GotoSlice() {}
    AIState_GotoSlice(Car_tObj *, int, int);
    int InTargetSliceRange(int);
};

/* Constructed foreign state classes omitted from this linked owner graph. */
struct AIState_Purgatory : public AIState_NonActive {
    AIState_Purgatory() {}
    AIState_Purgatory(Car_tObj *carObj);
    int TestForRelease();
    void Execute();
    static void StartUp();
};

struct AIState_Offroad : public AIState_Base {
    int startSlice_;
    coorddef startPosition_;
    matrixtdef startOrientation_;
    coorddef startHeading_;
    int targetSlice_;
    coorddef targetPosition_;
    int longMetersBetween_, letGo_, maxSpeedMPS_, releaseTime_;
    AIState_Offroad() {}
    AIState_Offroad(Car_tObj *, int, coorddef *, matrixtdef *, int, int, int);
    void UnleashIfInRange(Car_tObj *carObj);
    void Execute();
};

struct POLY_GT4 {
    u_long tag;
    u_char r0, g0, b0, code; short x0, y0; u_char u0, v0; u_short clut;
    u_char r1, g1, b1, p1; short x1, y1; u_char u1, v1; u_short tpage;
    u_char r2, g2, b2, p2; short x2, y2; u_char u2, v2; u_short pad2;
    u_char r3, g3, b3, p3; short x3, y3; u_char u3, v3; u_short pad3;
};

struct Draw_SubdivStruct { Draw_SVertex v[15]; };

struct Track_tArtresource {
    int id;
    char *shapeFile;
    int shapeCount;
    Draw_tPixMap *pPmx;
    int pmxCount, basePmxCount;
};

struct Track_tMaterial { char flag, mipmap_offset; short pmxIndex; };

struct TCB { long status, mode; u_long reg[40]; long system[6]; };
struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};
struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

struct Skidmark_Segment {
    SVECTOR svx[2];
    CVECTOR rgb;
    int type;
    Skidmark_Segment *next;
};

struct Skidmark_Chunk {
    coorddef cp;
    short n, slice;
    Skidmark_Segment seg[24];
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
    inline void VirtualEngage(Car_tObj *perp) {
        (*(*_vf)[6].pfn)((int)&fPosition.flags + (int)(*_vf)[6].delta, perp);
    }
    inline void VirtualLose() {
        (*(*_vf)[7].pfn)((int)&fPosition.flags + (int)(*_vf)[7].delta);
    }
    inline void VirtualPurge() {
        (*(*_vf)[16].pfn)((int)&fPosition.flags + (int)(*_vf)[16].delta);
    }
};

/* Foreign globals whose completed tags are absent from this retail owner. */
struct AIH_Cop_GameSetupCodegenView {
    int raceType, numLaps, skill, commMode, tournamentMultiplier, cops;
    int trafficDensity, localCar, catchupLogic, replayMode, instantReplay;
    int mirrorTrack, reverseTrack;
    char _rest[2548];
};
struct AIH_Cop_SimGlobalCodegenView {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};
struct AIH_Cop_SpikeBeltCodegenView {
    int active_, slice_, leftLatPos_, rightLatPos_, freshenTime_;
};
struct AIH_Cop_SliceCodegenView {
    int center[3];
    char normal[3], forward[3], right[3];
    u_char acousticType;
    short pavedProfile, leftDrive, rightDrive;
    u_char chunkIndex, laneCount, avgPavedWidthLf, avgPavedWidthRt;
};
struct AIH_Cop_CopTuningCodegenView {
    int regularCopAccMultiplier, superCopAccMultiplier;
    int regularCopTopSpeedCap, superCopTopSpeedCap;
};
struct AIH_Cop_TriggerManagerCodegenView {
    int numTriggers_, invNumTriggers_;
    trigger_t *triggers_[100];
    int checkTime_[100];
    int lastTriggerChecked_[9];
    void Init(char *rawTriggers);
    int InsertTrigger(trigger_t *trigger, bool fromFile);
    trigger_t *GetNextTrigger(int car);
    trigger_t *GetPrevTrigger(int car);
    int CheckForTriggerAtSlice(int car, int slice)
        asm("CheckForTriggerAtSlice__24AITrigger_TriggerManagerii");
    trigger_t *GetTrigger(int trigger, int *used)
        asm("GetTrigger__24AITrigger_TriggerManageriPi");
    int CheckForClosestTriggerOfType(int slice, int type, int direction);
    void DescribeTrigger(trigger_t *trigger)
        asm("DescribeTrigger__24AITrigger_TriggerManagerP9trigger_t");
    void Sort();
};

#define GameSetup_tData AIH_Cop_GameSetupCodegenView
#define Sim_tSimGlobalVar AIH_Cop_SimGlobalCodegenView
#define AICop_spikeBelt_t AIH_Cop_SpikeBeltCodegenView
#define Trk_NewSlice AIH_Cop_SliceCodegenView
#define copTuning_t AIH_Cop_CopTuningCodegenView
#define AITrigger_TriggerManager AIH_Cop_TriggerManagerCodegenView
#define AICop_RoadBlockState int
#define kAICop_RoadBlockState_None 0
#define kAICop_RoadBlockState_WaitingForPerp 1
#define kAICop_RoadBlockState_PerpPassed 2

typedef int CarLogic_tObservations[1][3];
typedef long (*ReparmFuncPtr)();
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();

#endif

/* game/common/aistate.h -- AIState definitions owned by retail AISTATE.H.
 * Shared by every AI translation unit: retail aihigh/aih_btccop/aih_btcperp/aistate each
 * carry their own LOCAL copies of the all-inline classes' vtables and inline bodies, which
 * cc1plus regenerates from these declarations.  Prototypes below are the two the inline
 * AIState_NonActive constructor needs before the externs headers are seen. */
#ifndef _GAME_COMMON_AISTATE_H_
#define _GAME_COMMON_AISTATE_H_
void AIState_StartUp(void);
void AIState_Restart(void);
void AIState_CleanUp(void);
#include "link_stripped.h"   /* SLINK /strip removed the standalone copies of the inlines below (no #pragma) */
/* Real polymorphic classes (retail = cc1plus 2.8 vtables): every vtable is
 * {null}{Execute}{dtor}{TestForRelease}; AIState_Base's Execute is pure, its dtor and
 * TestForRelease are INLINE (so every TU that constructs a state gets a local copy of both
 * bodies and of the vtable -- retail aihigh/aih_btccop/aih_btcperp/aistate each carry
 * TestForRelease__12AIState_Base / _._12AIState_Base copies).  Declaration order below is
 * retail's: aistate.obj emits the tables in REVERSE of it (Cruise first ... Base last). */
struct AIState_Base {
    Car_tObj *carObj_;
    AIState_Base(Car_tObj *carObj);
    void StateExecute();
    virtual void Execute() = 0;
#if defined(NFS4_AIHIGH_OWNER) || defined(NFS4_AISTATE_NONE_KEEP)   /* owner key: AIState_None's inline bodies (retail: only aihigh.obj records AIState_None; _KEEP = TUs not yet converted, see GSDATA_state.md) */
#define NFS4_AISTATE_NONE_BODY(b) b
#else
#define NFS4_AISTATE_NONE_BODY(b) ;
#endif
#line 24 "C:/nfs4/GAME/COMMON/AISTATE.H"
    virtual ~AIState_Base() {}
#line 25 "C:/nfs4/GAME/COMMON/AISTATE.H"
    virtual int TestForRelease() { return 0; }
};

/* Retail places None's inline definitions before Normal and Idle. */
struct AIState_None : public AIState_Base {
    AIState_None(Car_tObj *carObj) NFS4_AISTATE_NONE_BODY(: AIState_Base(carObj) {})
#line 34 "C:/nfs4/GAME/COMMON/AISTATE.H"
    ~AIState_None() NFS4_AISTATE_NONE_BODY({})
#line 35 "C:/nfs4/GAME/COMMON/AISTATE.H"
    void Execute() NFS4_AISTATE_NONE_BODY({})
};

struct AIState_Normal : public AIState_Base {
    AIState_Normal(Car_tObj *carObj);
#line 45 "C:/nfs4/GAME/COMMON/AISTATE.H"
    ~AIState_Normal() {}
    void Execute();
};

struct AIState_Idle : public AIState_Base {
    int roadPosition_, idleInPlaceFlag_;
    AIState_Idle(Car_tObj *carObj) LINK_STRIPPED;   /* inline, defined in aih_hierarchy_types.h; aistate.obj (key TU) copy link-stripped (retail MAP has none) */
    AIState_Idle(Car_tObj *carObj, int idleInPlace);   /* inline, likewise (aih_btccop_types.h) */
#line 58 "C:/nfs4/GAME/COMMON/AISTATE.H"
    ~AIState_Idle() { carObj_->carFlags = carObj_->carFlags & 0xfffffbff; }   /* inline: retail emits it in the deferred batch after ~AIState_NonActive */
    void Execute();
    void SetIdlePosition(int pos);
};

struct AIState_Chase : public AIState_Base {
    AIDelayCar delayCar_;
    int noTurnAroundEndTime_;
    Car_tObj *targetCar_;
    coorddef relPosition_;
    int longTargetRegion_, latTargetRegion_, targetDir_, carDir_;
    int longMetersBetween_, latMetersBetween_, murderMode_, murderEndTime_;
    int inTargetRegion_, nitrousTicks_, nitrousMinForeDistance_, nitrousMinAftDistance_;
    int aggressionLevel_, slowDownEndTime_, barrierTicks32_;
    AIState_Chase(Car_tObj *, Car_tObj *, coorddef *, int, int, int, int, int);
    ~AIState_Chase();
    void SetTarget(Car_tObj *, coorddef *);
    void SetMurderMode(int, int);
    void SetUp();
    void DoSlowNitrous();
    void DoNitrous(int);
    void Execute();
    int IsSlowingDown() LINK_STRIPPED; /* inferred predicate: current tick precedes slowDownEndTime_ */
    void FarTargeting();
    int CalculateCloseTargettingAheadSlowDownFactor();
    void CloseTargeting();
    void ApproachTargeting(int);
    void CheckForBarriersAndTargetAroundThem();
    int FindBarrierEndSlice();
    int BarrierTicks32() LINK_STRIPPED;       /* inline, defined in the AI-high type headers; aistate.obj (key TU) copy link-stripped */
    int InMurderRange(int minTimeInZone, int minLatMetersDistance, int minLongMetersDistance) LINK_STRIPPED;   /* inline, likewise */ void SetNitrousTicks(int nitrousTicks) LINK_STRIPPED; void SetSlowDownEndTime(int slowDownEndTime) LINK_STRIPPED; int MurderMode() LINK_STRIPPED;   /* inferred inline accessors (retail AIH_Cop.obj HighExecute this records) */
};

struct AIState_Offroad : public AIState_Base {
    int startSlice_;
    coorddef startPosition_;
    matrixtdef startOrientation_;
    coorddef startHeading_;
    int targetSlice_;
    coorddef targetPosition_;
    int longMetersBetween_, letGo_, maxSpeedMPS_, releaseTime_;
    AIState_Offroad(Car_tObj *, int, coorddef *, matrixtdef *, int, int, int);
    ~AIState_Offroad();
    void UnleashIfInRange(Car_tObj *);
    void MarkLetGo() LINK_STRIPPED; /* inferred inline setter: retail records this at the letGo_ store */
    void Execute();
};

extern "C" void *memset(...);
void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *, int, coorddef *, int);
struct AIState_NonActive : public AIState_Base {
    /* retail's inline body (aistate/aih_btccop/aih_btcperp all expand it): park the car */
    /* retail records trafficOffset two blocks below the inline body block (every expansion, e.g. the Purgatory
       ctor and the AI-high SetState sites); the extra braces reproduce that nesting and emit no code */
    AIState_NonActive(Car_tObj *carObj) : AIState_Base(carObj) {
        {
            {
                coorddef trafficOffset;
                memset((u_char *)&trafficOffset, '\0', 0xc);
                trafficOffset.y = carObj->carIndex * 0xa0000;
                Newton_SetInitialSlicePositionOrientationEtc(&carObj_->N, 0, &trafficOffset, 1);
                carObj_->N.active = '\0';
            }
        }
    }
#line 169 "C:/nfs4/GAME/COMMON/AISTATE.H"
    ~AIState_NonActive()
    {

        (carObj_->N).active = '\x01'; }   /* declared before Execute: the deferred batch is emitted in reverse member order (retail: Execute 0x80072750, dtor 0x80072758) */

#line 174 "C:/nfs4/GAME/COMMON/AISTATE.H"
    void Execute() {}
};

struct AIState_Purgatory : public AIState_NonActive {
    AIState_Purgatory(Car_tObj *);
    ~AIState_Purgatory();
    int TestForRelease();
    void Execute();
    static void StartUp();
};

struct AIState_RovingTraffic : public AIState_Base {
    trigger_pathPosition_t *path_;
    int numPathPoints_, pathIndex_;
    long waitTick_;
    AIState_RovingTraffic(Car_tObj *, trigger_t *);
    ~AIState_RovingTraffic();
    void CheckIfCarIsNearbyAndStop(Car_tObj *, int &); AIState_RovingTraffic(Car_tObj *carObj, trigger_pathPosition_t *path) LINK_STRIPPED;   /* inferred second ctor (aistate.cpp), link-stripped */
    void Execute();
    int TestForRelease();
};

struct AIState_Donuts : public AIState_Base {
    int donutLookForward_;
    donutMode_t donutMode_;
    ~AIState_Donuts(); AIState_Donuts(Car_tObj *carObj) LINK_STRIPPED;   /* inferred ctor (aistate.cpp), link-stripped */
    void Execute();
};

struct AIState_GotoSlice : public AIState_Normal {
    int targetSlice_, stopWhenArrivedAtSlice_;
    AIState_GotoSlice(Car_tObj *, int, int);
    ~AIState_GotoSlice();
    void Execute();
    int InTargetSliceRange(int);
};
#include "shared/cruiseMode_t.h"
struct AIState_Cruise : public AIState_Normal {
    cruiseMode_t cruiseMode_;
    int cruiseSpeed_, cruiseFactor_;
    AIState_Cruise(Car_tObj *, cruiseMode_t, int);
    ~AIState_Cruise();
    void Execute();
};

/* Retail callers have nested inline Chase receiver records for the timer
   operations. These member spellings are inferred. GCC 2.8's interface form
   keeps their inline scopes without emitting non-retail standalone copies. */
/* (no #pragma: user ruling 2026-11-07) */
inline void AIState_Offroad::MarkLetGo() { letGo_ = 1; }

/* Only the state owner surface supplies Sim_tSimGlobalVar. Keep the real
 * timer predicate with the header's other interface-only inline definitions,
 * without importing foreign type records into other AI owners. The predicate
 * name/signature and this reconstruction include boundary are inferred. */
#ifdef NFS4_GAME_COMMON_AISTATE_TYPES_H
extern Sim_tSimGlobalVar simGlobal;
inline int AIState_Chase::IsSlowingDown() { return simGlobal.gameTicks < slowDownEndTime_; } inline AIState_Idle::AIState_Idle(Car_tObj *carObj) : AIState_Base(carObj) {}   /* INFERRED body: retail aistate.obj Idle run "Idle Car_tObj Idle" (key TU: link-stripped copy) */ inline AIState_RovingTraffic::~AIState_RovingTraffic() { (this->carObj_)->targetPos.x = (this->carObj_)->targetPos.y = (this->carObj_)->targetPos.z = 0; this->carObj_->targetLatPos = 0; this->carObj_->carFlags &= 0xfffff7ff; return; } inline int AIState_RovingTraffic::TestForRelease() { return this->pathIndex_ < this->numPathPoints_ ^ 1; } inline AIState_GotoSlice::~AIState_GotoSlice() { return; } inline AIState_Cruise::~AIState_Cruise() { return; }   /* retail AISTATE.H 200/206/234/258 inline bodies: NO_SLD deferred copies in the key TU (emitted in reverse definition order) */
#endif

/* AIState_Chase inline members, visible to every includer (retail AIH_Cop.obj HighExecute and AIH_BTCCop.obj inline them: this REG records) */
inline int AIState_Chase::BarrierTicks32() { return barrierTicks32_; }
inline int AIState_Chase::InMurderRange(int minTimeInZone, int minLatMetersDistance, int minLongMetersDistance) {
    return minTimeInZone < inTargetRegion_ && __builtin_abs(latMetersBetween_) < minLatMetersDistance &&
           __builtin_abs(longMetersBetween_) < minLongMetersDistance;
}
inline void AIState_Chase::SetNitrousTicks(int nitrousTicks) { nitrousTicks_ = nitrousTicks; }
inline void AIState_Chase::SetSlowDownEndTime(int slowDownEndTime) { slowDownEndTime_ = slowDownEndTime; }
inline int AIState_Chase::MurderMode() { return murderMode_; }


#endif

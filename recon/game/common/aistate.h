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
    virtual ~AIState_Base() {}
    virtual int TestForRelease() { return 0; }
};

/* Retail places None's inline definitions before Normal and Idle. */
struct AIState_None : public AIState_Base {
    AIState_None(Car_tObj *carObj) : AIState_Base(carObj) {}
    ~AIState_None() {}
    void Execute() {}
};

struct AIState_Normal : public AIState_Base {
    AIState_Normal(Car_tObj *carObj);
    ~AIState_Normal() {}
    void Execute();
};

struct AIState_Idle : public AIState_Base {
    int roadPosition_, idleInPlaceFlag_;
    AIState_Idle(Car_tObj *carObj);   /* inline, defined in aih_hierarchy_types.h: retail aistate.obj (the key TU, Execute) has NO copy */
    AIState_Idle(Car_tObj *carObj, int idleInPlace);   /* inline, likewise (aih_btccop_types.h) */
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
    int IsSlowingDown(); /* inferred predicate: current tick precedes slowDownEndTime_ */
    void FarTargeting();
    int CalculateCloseTargettingAheadSlowDownFactor();
    void CloseTargeting();
    void ApproachTargeting(int);
    void CheckForBarriersAndTargetAroundThem();
    int FindBarrierEndSlice();
    int BarrierTicks32();       /* inline, defined in the AI-high type headers (no copy in aistate.obj) */
    int InMurderRange(int minTimeInZone, int minLatMetersDistance, int minLongMetersDistance);   /* inline, likewise */
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
    void MarkLetGo(); /* inferred inline setter: retail records this at the letGo_ store */
    void Execute();
};

extern "C" void *memset(void *, int, unsigned int);
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
    ~AIState_NonActive() { (carObj_->N).active = '\x01'; }   /* declared before Execute: the deferred batch is emitted in reverse member order (retail: Execute 0x80072750, dtor 0x80072758) */
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
    void CheckIfCarIsNearbyAndStop(Car_tObj *, int &);
    void Execute();
    int TestForRelease();
};

struct AIState_Donuts : public AIState_Base {
    int donutLookForward_;
    donutMode_t donutMode_;
    ~AIState_Donuts();
    void Execute();
};

struct AIState_GotoSlice : public AIState_Normal {
    int targetSlice_, stopWhenArrivedAtSlice_;
    AIState_GotoSlice(Car_tObj *, int, int);
    ~AIState_GotoSlice();
    void Execute();
    int InTargetSliceRange(int);
};

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
#pragma interface
inline void AIState_Offroad::MarkLetGo() { letGo_ = 1; }

/* Only the state owner surface supplies Sim_tSimGlobalVar. Keep the real
 * timer predicate with the header's other interface-only inline definitions,
 * without importing foreign type records into other AI owners. The predicate
 * name/signature and this reconstruction include boundary are inferred. */
#ifdef NFS4_GAME_COMMON_AISTATE_TYPES_H
extern Sim_tSimGlobalVar simGlobal;
inline int AIState_Chase::IsSlowingDown() { return simGlobal.gameTicks < slowDownEndTime_; }
#endif

#endif

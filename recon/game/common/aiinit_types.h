/* aiinit.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AIINIT_TYPES_H
#define NFS4_GAME_COMMON_AIINIT_TYPES_H

#define NFS4_OWNER_DEFINES_UDFF_TYPES
#include "color_types.h"

#define RaceType_Id3 3

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
typedef Udff_tInfo *Udff_tHandle;

typedef struct __nfs4_vtbl_ptr_t {
    short delta, index;
    int (*pfn)(...);
} __nfs4_vtbl_ptr_t;
#define __vtbl_ptr_type __nfs4_vtbl_ptr_t

typedef enum AIDataRecord_RecordMethod_t {
    NORMAL_M = 0,
    RECORD_M = 1,
    TEST_M = 2
} AIDataRecord_RecordMethod_t;

struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    AIDataRecord_RecordMethod_t recordMethod_;

    virtual ~AIDataRecord_t();
    virtual void Setup();

    static void StartUp1();
    static void StartUp2();
    static void CleanUp1();
    static void CleanUp2();
};

struct AIDataRecord_AccTable_t : public AIDataRecord_t {
    int scale_;
    AIDataRecord_AccTable_t(char *name, int n, int which)
      asm("__23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t");
    ~AIDataRecord_AccTable_t();
    void Setup();
};

struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {
    AIDataRecord_CurveSpeedTable_t(char *name, int which)
      asm("__30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t");
    ~AIDataRecord_CurveSpeedTable_t();
    void Upgrade(int i);
};

struct AIPhysic_BrakeInfo { u_char brakeTable_[128]; int deceleration_; };

struct AIPhysic_ModelConfig_t {
    int dlpos_to_dlvel, max_dlvel, dlvel_to_clacc, max_clacc;
    int dangle_to_dav, max_dav, dav_to_aa, max_aa;
    int vel_limit_range, lat_vel_limit_factor, ang_vel_limit_factor;
};

struct trigger_anyTrigger_t { int type, slice; };
struct trigger_simple_t { int type, slice, dir, side, moving; };
struct trigger_roadblock_t { int type, slice, dir, numCars, spikeBelt; };
struct trigger_offroad_t {
    int type, slice, dir;
    coorddef position;
    matrixtdef orientation;
    int maxSpeed, releaseTime, endSlice;
};
struct trigger_trafficAccident_t {
    int type, slice;
    coorddef position;
    matrixtdef orientation;
};
struct trigger_pathPosition_t { coorddef position; int targetSpeed, waitTime; };
struct trigger_trafficPath_t {
    int type, slice, dir;
    matrixtdef orientation;
    int maxSpeed, releaseTime, numPoints;
    trigger_pathPosition_t *path;
};
union trigger_t {
    trigger_anyTrigger_t any;
    trigger_simple_t simple;
    trigger_roadblock_t roadblock;
    trigger_offroad_t offroad;
    trigger_trafficAccident_t trafficAccident;
    trigger_trafficPath_t trafficPath;
};

struct AITrigger_TriggerManager;

typedef int CarLogic_tObservations[1][3];

#endif

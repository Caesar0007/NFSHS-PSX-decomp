/* aispeeds.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AISPEEDS_TYPES_H
#define NFS4_GAME_COMMON_AISPEEDS_TYPES_H

#define NFS4_OWNER_DEFINES_UDFF_TYPES
#include "color_types.h"

#define RaceType_SingleRace 0
#define RaceType_HotPursuit 1
#define RaceType_Id3 3
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
    __vtbl_ptr_type (*_vf)[3];
};

struct AIDataRecord_AccTable_t : public AIDataRecord_t { int scale_; };
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t { int Get(int i); };

struct AIPhysic_BrakeInfo {
    u_char brakeTable_[128];
    int deceleration_;

    /* SYM-INFERRED-INLINE-NAMES: PsyQ preserves the nested this/speed/sIndex
     * and currentSpeed/futureSpeed scopes, but not either unlinked method name.
     * These semantic names and both bodies are therefore codegen-proven
     * reconstructions rather than name claims from the SYM. */
    int GetBrakeDistance(int speed)
    {
        int sIndex = speed / 0x10000;
        if (sIndex < 0) {
            sIndex = -sIndex;
        }
        if (!(sIndex < 0x80)) {
            sIndex = 0x80;
        }
        return (u_int)brakeTable_[sIndex] * 0x20000;
    }

    int GetNeededDistance(int currentSpeed,int futureSpeed)
    {
        return GetBrakeDistance(currentSpeed) - GetBrakeDistance(futureSpeed);
    }
};

struct AISpeeds_tLeaderBoard {
    Car_tObj *leadRacer, *leadHumanRacer, *leadAIRacer, *lastAIRacer;
};

struct AIPhysic_ModelConfig_t {
    int dlpos_to_dlvel, max_dlvel, dlvel_to_clacc, max_clacc;
    int dangle_to_dav, max_dav, dav_to_aa, max_aa;
    int vel_limit_range, lat_vel_limit_factor, ang_vel_limit_factor;
};

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef kernpair KERN;

struct AISpeeds_Upgrade_t { int accMult, brakeMult, handlingMult, topSpeedMult; };
struct AISpeeds_tSlotInfo {
    int distanceMaintainTime32, minDistanceMeters, maxDistanceMeters;
    unsigned int fallBackRandomTime_TickPercent;
};
struct speedData_t { u_short endSlice, speedMPS; };

struct AIDataRecord_TrackCurve_t;

/* Canonical sim.obj aggregate from the retail SYM type graph. */
struct Sim_tSimGlobalVar {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};

typedef int CarLogic_tObservations[1][3];
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

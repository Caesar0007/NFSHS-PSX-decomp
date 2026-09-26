/* aiphysic.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AIPHYSIC_TYPES_H
#define NFS4_GAME_COMMON_AIPHYSIC_TYPES_H

#include "color_types.h"

/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















#define RaceType_HotPursuit 1
#define RaceType_Id5 5

#include "shared/Sched_tSchedule.h"




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
    virtual ~AIDataRecord_t();   /* aidatarecord.cpp owns the family; slots: dtor, Setup */
    virtual void Setup();
};
struct AIDataRecord_AccTable_t : public AIDataRecord_t {
    int scale_;
    int Get(int i);
};
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t { int Get(int i); };

extern "C" int fixeddiv(...);
extern "C" int fixedmult(...);

struct AIPhysic_BrakeInfo {
    u_char brakeTable_[128];
    int deceleration_;

    AIPhysic_BrakeInfo(int deceleration)
    {
        int invDeceleration;
        int brakeTableLoop;

        deceleration_ = deceleration;
        invDeceleration = fixeddiv(0x10000, deceleration);
        brakeTableLoop = 0;
        while (brakeTableLoop < 0x80) {
            int distance = brakeTableLoop << 0x10;
            int brakeDistanceMeters =
                fixedmult(fixedmult(distance, invDeceleration), distance) / 2;
            int sIndex = distance / 0x10000;
            if (sIndex < 0)
                sIndex = -sIndex;
            if (!(sIndex < 0x80))
                sIndex = 0x80;
            brakeTable_[sIndex] = (u_char)(brakeDistanceMeters / 0x20000);
            brakeTableLoop = brakeTableLoop + 1;
        }
    }
};

typedef enum Gear_t {
    GEAR_REVERSE = 0,
    GEAR_NEUTRAL = 1,
    GEAR_FIRST = 2,
    GEAR_SECOND = 3,
    GEAR_THIRD = 4,
    GEAR_FOURTH = 5,
    GEAR_FIFTH = 6,
    GEAR_SIXTH = 7,
    GEAR_SEVENTH = 8
} Gear_t;

typedef enum eRampType {
    kRampType_Interpolate = 0,
    kRampType_NoInterpolate = 1
} eRampType;

#include "shared/AIPhysic_ModelConfig_t.h"




#include "shared/AIPhysic_Config_t.h"





#include "shared/kernpair.h"




typedef kernpair KERN;

struct AIDataRecord_TrackCurve_t;

typedef int CarLogic_tObservations[1][3];
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

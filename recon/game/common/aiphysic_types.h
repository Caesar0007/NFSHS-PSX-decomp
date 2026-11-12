/* aiphysic.obj source-visible types over the shared color graph.
 * Sim_tSimGlobalVar's canonical body is retained by other retail TUs; this
 * TU's original debug visibility is still unproved, not an exact-tagset claim. */
#ifndef NFS4_GAME_COMMON_AIPHYSIC_TYPES_H
#define NFS4_GAME_COMMON_AIPHYSIC_TYPES_H
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "color_types.h"
/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail aiphysic.obj (GameSetup_gData is read through its word view) */
















#define RaceType_HotPursuit 1
#define RaceType_Id5 5

#include "shared/Sched_tSchedule.h"
#include "shared/Sim_tSimGlobalVar.h"





/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_math.h"
}

struct AIPhysic_BrakeInfo {
    u_char brakeTable_[128];
    int deceleration_;

    /* Inferred setter spelling: retail records this/distance in an inline
       parameter region, then sIndex in its body. The computed speed argument
       has no named retail row; the braking-distance argument does. */
    inline void SetBrakeDistance(int speed, int distance) {
        int sIndex = speed / 0x10000;
        if (sIndex < 0)
            sIndex = -sIndex;
        if (!(sIndex < 0x80))
            sIndex = 0x80;
        brakeTable_[sIndex] = (u_char)(distance / 0x20000);
    }

    AIPhysic_BrakeInfo(int deceleration)
    {
        int invDeceleration;

        deceleration_ = deceleration;
        invDeceleration = fixeddiv(0x10000, deceleration);
        for (int brakeTableLoop = 0; brakeTableLoop < 0x80; brakeTableLoop++) {
            int brakeDistanceMeters =
                fixedmult(fixedmult(brakeTableLoop << 0x10, invDeceleration), brakeTableLoop << 0x10) / 2;
            SetBrakeDistance(brakeTableLoop << 0x10, brakeDistanceMeters);
        }
    }
    inline int Deceleration() { return deceleration_; }   /* retail pair (this typed AIPhysic_BrakeInfo) */ /* + the 2 aispeeds_types.h bodies (retail 7 TPDEFs) */ int GetBrakeDistance(int speed) { int sIndex = speed / 0x10000; if (sIndex < 0) { sIndex = -sIndex; } if (!(sIndex < 0x80)) { sIndex = 0x80; } return (u_int)brakeTable_[sIndex] * 0x20000; } int GetNeededDistance(int futureSpeed,int currentSpeed) { return GetBrakeDistance(currentSpeed) - GetBrakeDistance(futureSpeed); }
};

#include "shared/AIPhysic_ModelConfig_t.h"   /* retail aiphysic.obj: ModelConfig, Config before Gear_t */
#include "shared/AIPhysic_Config_t.h"
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

enum eRampType {
    kRampType_Interpolate = 0,
    kRampType_NoInterpolate = 1
};
#include "aidatarecord_classes.h"   /* the AIDATARECORD.H record-class family: no private copies (header-truth 4i) */




























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

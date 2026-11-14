#if !defined(NFS4_GAME_COMMON_AISPEEDS_TYPES_H)
#define NFS4_GAME_COMMON_AISPEEDS_TYPES_H   /* aispeeds.obj's exact source-visible delta over the shared color graph. */
#define NFS4_TRANSFORMER_Z_HOOK "../game/common/aispeeds_types.h"   /* retail aispeeds.obj: Udff types right after Transformer_zOverlay */
#define NFS4_COLOR_CAR_STRUCT_ONLY   /* retail: one TPDEF Car_tObj (color_types.h) */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_OWNER_DEFINES_UDFF_TYPES
#include "color_types.h"
/* The canonical 2600-byte SYM-owned GameSetup aggregate, also used by AIPERSON.
 * Replace the import's false int[] type; original per-TU header/debug visibility
 * remains a separate audit question, not an excuse to misdeclare the object. */
/* GameSetup_tData: not in retail aispeeds.obj (GameSetup_gData is read through its word view) */

#define RaceType_SingleRace 0
#define RaceType_HotPursuit 1
#define RaceType_Id3 3
#define RaceType_Id5 5

#include "shared/Sched_tSchedule.h"





#include "shared/AIPhysic_BrakeInfo.h"   /* one AIPhysic_BrakeInfo definition (header-truth 4m) */


























#include "aidatarecord_classes.h"   /* the AIDATARECORD.H record-class family: no private copies (header-truth 4i) */

















#include "shared/AISpeeds_tLeaderBoard.h"



#include "shared/AIPhysic_ModelConfig_t.h"





#include "shared/kernpair.h"




typedef kernpair KERN;

typedef struct AISpeeds_Upgrade_t { int accMult, brakeMult, handlingMult, topSpeedMult; } AISpeeds_Upgrade_t;
typedef struct AISpeeds_tSlotInfo {
    int distanceMaintainTime32, minDistanceMeters, maxDistanceMeters;
    unsigned int fallBackRandomTime_TickPercent;
} AISpeeds_tSlotInfo;
typedef struct speedData_t { u_short endSlice, speedMPS; } speedData_t;

struct AIDataRecord_TrackCurve_t;

/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"




typedef int CarLogic_tObservations[1][3];
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#elif defined(NFS4_TRANSFORMER_IN_HOOK) && !defined(NFS4_AISPEEDS_TZ_DONE)   /* second pass: shared/Transformer_z.h */
#define NFS4_AISPEEDS_TZ_DONE
#include "shared/Udff_tAccessType.h"



#include "shared/Udff_tInfo.h"




typedef Udff_tInfo *Udff_tHandle;
#endif

#if !defined(NFS4_GAME_COMMON_PHYSICS_TYPES_H)
#define NFS4_GAME_COMMON_PHYSICS_TYPES_H   /* physics.obj's exact source-visible delta over the shared color graph. */
#define NFS4_TRANSFORMER_Z_HOOK "../game/common/physics_types.h"   /* retail physics.obj: Udff (+AIDataRecord base) right after Transformer_zOverlay */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_OWNER_DEFINES_UDFF_TYPES
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#define NFS4_CORE_FULL   /* this object lists the start of the core itself (retail record order) */
#define NFS4_GAME_COMMON_MIN_TYPES_H
#define NFS4_GAME_COMMON_PADS_TYPES_H
#include "game_common_min_core.h"
#include "pads_records.h"
#include "gamesetup_leaf_types.h"   /* own types at this point */
#include "pads_tail.h"
#undef NFS4_CORE_FULL
#undef NFS4_CORE_CCOORD16
#include "color_types.h"
#undef NFS4_OWNER_DEFINES_UDFF_TYPES

#define RaceType_HotPursuit 1
#define RaceType_Id5 5

#include "shared/Sched_tSchedule.h"





struct Trk_NewSlice;
typedef struct Trk_NewSlice Trk_NewSlice;

/* Retail's completed typedef emits its own record;no local pointer alias is needed to manufacture that copy. */
typedef struct Physics_tWheelAccStruct {
    int acc, roadGrip, steeringAcc, steeringAngle;
    coorddef velCap, finalAcc;
    int frontTire, skid;
} Physics_tWheelAccStruct;

typedef int Input_tDeviceCall();

#elif defined(NFS4_TRANSFORMER_IN_HOOK) && !defined(NFS4_PHYSICS_TZ_DONE)   /* second pass: shared/Transformer_z.h */
#define NFS4_PHYSICS_TZ_DONE
#include "shared/Udff_tAccessType.h"




#include "shared/Udff_tInfo.h"




typedef struct Udff_tInfo Udff_tInfo;
typedef Udff_tInfo *Udff_tHandle;
#endif

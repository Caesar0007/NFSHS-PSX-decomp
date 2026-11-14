/* simqueue.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_SIMQUEUE_TYPES_H
#define NFS4_GAME_COMMON_SIMQUEUE_TYPES_H
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_HOOK_AFTER_PADS "shared/Input_tResults.h"   /* retail simqueue.obj: Input_tResults ahead of MATRIX (nfs4_types.h) */
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

#include "shared/Input_tResults.h"




enum VALIDITY {
    kINVALID = 0,
    kVALID = 1,
    kPREDICTED = 2,
    kRESIM = 3
};

struct sim_queue {
    Input_tResults Buffer[2][32];
    VALIDITY Validity[2][32];
    int HeadTime;
    int TailTime[2];
};

typedef int Input_tDeviceCall(u_long value);
typedef sim_queue SIM_QUEUE;

#endif

#if !defined(NFS4_GAME_COMMON_AIPERSON_TYPES_H)
#define NFS4_GAME_COMMON_AIPERSON_TYPES_H   /* Reconstructed aiperson types and the owner-proven shared GameSetup layout. */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_OWNER_DEFINES_UDFF_TYPES
#define NFS4_GAME_COMMON_COLOR_TYPES_H   /* this object lists the parts of the common type graph itself (retail record order) */
#include "color_p0_draw.h"
#include "color_p1_pregroup.h"
#include "color_p2_group_trk.h"
#include "color_p3_trkobj.h"
#include "color_p4_save.h"
#include "color_p5_bwsm.h"
#include "color_p6_bo.h"
#include "color_p7_sched.h"
#include "shared/Transformer_z.h"
#define NFS4_TRANSFORMER_IN_HOOK   /* own types right after Transformer_zOverlay */
#include "aiperson_types.h"   /* this header again: its NFS4_TRANSFORMER_IN_HOOK branch */
#undef NFS4_TRANSFORMER_IN_HOOK
#include "color_p8_car.h"
#include "color_p9_tail.h"
#undef NFS4_OWNER_DEFINES_UDFF_TYPES

/* P873: canonical aggregate from native SYM 27dcf0..27e1c7, 2600 bytes.
 * Its body is absent from aiperson.obj's retained debug graph; the original
 * header/debug visibility remains an explicit audit question. The real type
 * and fields replace the false int[19]/Car_tObj angular-velocity view. */
#include "shared/GameSetup_tData.h"
















#define RaceType_HotPursuit 1
#define RaceType_Tournament 2
#define RaceType_Id5 5

#include "shared/Sched_tSchedule.h"





typedef int CarLogic_tObservations[1][3];

#elif defined(NFS4_TRANSFORMER_IN_HOOK) && !defined(NFS4_AIPERSON_TZ_DONE)   /* second pass: shared/Transformer_z.h */
#define NFS4_AIPERSON_TZ_DONE
#include "shared/Udff_tAccessType.h"




#include "shared/Udff_tInfo.h"




typedef struct Udff_tInfo Udff_tInfo;
typedef Udff_tInfo *Udff_tHandle;
#endif

#if !defined(NFS4_GAME_COMMON_AIPERSON_TYPES_H)
#define NFS4_GAME_COMMON_AIPERSON_TYPES_H   /* Reconstructed aiperson types and the owner-proven shared GameSetup layout. */
#define NFS4_TRANSFORMER_Z_HOOK "../game/common/aiperson_types.h"   /* retail aiperson.obj: Udff types right after Transformer_zOverlay */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_OWNER_DEFINES_UDFF_TYPES
#include "color_types.h"
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

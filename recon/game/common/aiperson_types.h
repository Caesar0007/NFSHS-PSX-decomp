/* Reconstructed aiperson types and the owner-proven shared GameSetup layout. */
#ifndef NFS4_GAME_COMMON_AIPERSON_TYPES_H
#define NFS4_GAME_COMMON_AIPERSON_TYPES_H

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




typedef enum Udff_tAccessType {
    UDFF_FILE = 0,
    UDFF_MEMORY = 1
} Udff_tAccessType;

#include "shared/Udff_tInfo.h"




typedef struct Udff_tInfo Udff_tInfo;
typedef Udff_tInfo *Udff_tHandle;

typedef int CarLogic_tObservations[1][3];

#endif

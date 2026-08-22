/* aiperson.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AIPERSON_TYPES_H
#define NFS4_GAME_COMMON_AIPERSON_TYPES_H

#define NFS4_OWNER_DEFINES_UDFF_TYPES
#include "color_types.h"
#undef NFS4_OWNER_DEFINES_UDFF_TYPES

#define RaceType_HotPursuit 1
#define RaceType_Tournament 2
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
typedef struct Udff_tInfo Udff_tInfo;
typedef Udff_tInfo *Udff_tHandle;

typedef int CarLogic_tObservations[1][3];

#endif

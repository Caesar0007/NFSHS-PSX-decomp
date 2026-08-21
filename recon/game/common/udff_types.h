/* udff.obj's exact source-visible type surface. */
#ifndef NFS4_GAME_COMMON_UDFF_TYPES_H
#define NFS4_GAME_COMMON_UDFF_TYPES_H

#include "game_common_min_types.h"

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

#endif

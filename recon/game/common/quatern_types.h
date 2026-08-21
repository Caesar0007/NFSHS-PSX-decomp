/* quatern.obj's exact source-visible type surface. */
#ifndef NFS4_GAME_COMMON_QUATERN_TYPES_H
#define NFS4_GAME_COMMON_QUATERN_TYPES_H

#include "mathnfs_types.h"

struct tQuat {
    short x, y, z, w;
};
typedef struct tQuat Quatern_quat;

#endif

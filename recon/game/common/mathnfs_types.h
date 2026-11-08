/* MathNfs.obj's exact source-visible type surface. */
#ifndef NFS4_GAME_COMMON_MATHNFS_TYPES_H
#define NFS4_GAME_COMMON_MATHNFS_TYPES_H
#define NFS4_CORE_MATRIXT   /* retail: matrixtdef + MATRIX3DT right after coorddef/LIBCOORD (nfs4_types.h) */
#include "game_common_min_types.h"

#include "shared/matrixtdef.h"

#ifndef NFS4_HAVE_MATRIX3DT
typedef struct matrixtdef MATRIX3DT;
#endif
#endif

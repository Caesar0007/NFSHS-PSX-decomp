/* Owner-specific type surface for felines.obj, reconstructed from the retail
 * SYM graph.  Keeping this TU off the monolithic nfs4_types.h prevents
 * unrelated completed tags and typedefs from leaking into its debug graph. */
#ifndef NFS4_FRONTEND_COMMON_FELINES_TYPES_H
#define NFS4_FRONTEND_COMMON_FELINES_TYPES_H

#include "../../game/common/draw_leaf_types.h"
#include "shared/tTexture_ShapeInfo.h"
#ifndef NFS4_FELINES_KERNPAIR_LATE   /* else the owner includes felines_kern.h later (retail screenmain group: kernpair after tScreen) */

#include "felines_kern.h"
#endif

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

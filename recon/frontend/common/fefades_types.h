/* Owner-specific type surface for fefades.obj, reconstructed from the retail
 * SYM graph.  Keeping this TU off the monolithic nfs4_types.h prevents hundreds
 * of unrelated completed tags and typedefs from leaking into its debug graph. */
#ifndef NFS4_FRONTEND_COMMON_FEFADES_TYPES_H
#define NFS4_FRONTEND_COMMON_FEFADES_TYPES_H

#include "../../game/common/draw_leaf_types.h"

/* The retail owner uses byte only as a source spelling and emits no typedef
 * record for it, so retain the spelling as a macro in this visibility surface. */
#define byte unsigned char

#include "shared/tTexture_ShapeInfo.h"
#include "shared/kernpair.h"

typedef struct kernpair KERN;

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#include "shared/tMenuTextType.h"   /* one tMenuTextType definition (header-truth 4-C.1) */


















#endif

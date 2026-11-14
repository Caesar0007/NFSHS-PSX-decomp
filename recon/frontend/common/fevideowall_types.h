/* Owner-specific type surface for fevideowall.obj, reconstructed from the
 * retail SYM graph. */
#ifndef NFS4_FRONTEND_COMMON_FEVIDEOWALL_TYPES_H
#define NFS4_FRONTEND_COMMON_FEVIDEOWALL_TYPES_H

#include "../../game/common/draw_leaf_types.h"
#include "shared/tTexture_ShapeInfo.h"


#include "shared/tTVState.h"






#include "shared/tTVConfig.h"

#include "shared/tVideoWall.h"   /* one tVideoWall definition (header-truth 4t) */





























#include "shared/kernpair.h"

typedef struct kernpair KERN;

#include "shared/tDrawShapeExtended.h"

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

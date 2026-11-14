/* Owner-specific type surface for fetv.obj, reconstructed from the retail SYM
 * graph and the PsyQ 4.3 GPU packet declarations. */
#ifndef NFS4_FRONTEND_COMMON_FETV_TYPES_H
#define NFS4_FRONTEND_COMMON_FETV_TYPES_H
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#include "../../game/common/draw_leaf_types.h"

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

#include "shared/POLY_F4.h"
#include "shared/POLY_FT4.h"
#include "shared/POLY_GT4.h"
#include "shared/tTexture_ShapeInfo.h"

#include "shared/tTVState.h"






#include "shared/tTVConfig.h"
#include "shared/kernpair.h"

typedef struct kernpair KERN;

#include "shared/tActiveLine.h"

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

struct tDrawShapeExtended;

#endif

/* Owner-specific type surface for fetv.obj, reconstructed from the retail SYM
 * graph and the PsyQ 4.3 GPU packet declarations. */
#ifndef NFS4_FRONTEND_COMMON_FETV_TYPES_H
#define NFS4_FRONTEND_COMMON_FETV_TYPES_H

#include "../../game/common/draw_leaf_types.h"

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

#include "shared/POLY_F4.h"





#include "shared/POLY_FT4.h"
















#include "shared/POLY_GT4.h"



















struct tTexture_ShapeInfo {
    shapetbl *shpptr;
    long clutID;
    char depth;
    u_long type : 8;
    long next : 24;
    signed short width, height;
    short centerx, centery, shapex, shapey;
    u_short tpage, clut;
};

enum tTVState {
    tv_StateOff = 0,
    tv_StateOn = 1,
    tv_TransitionOn = 2,
    tv_TransitionOff = 3
};

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

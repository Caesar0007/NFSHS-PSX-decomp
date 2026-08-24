/* Owner-specific type surface for felines.obj, reconstructed from the retail
 * SYM graph.  Keeping this TU off the monolithic nfs4_types.h prevents
 * unrelated completed tags and typedefs from leaking into its debug graph. */
#ifndef NFS4_FRONTEND_COMMON_FELINES_TYPES_H
#define NFS4_FRONTEND_COMMON_FELINES_TYPES_H

#include "../../game/common/draw_leaf_types.h"

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

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef struct kernpair KERN;

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

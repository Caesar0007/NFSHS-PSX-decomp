/* Owner-specific type surface for fetv.obj, reconstructed from the retail SYM
 * graph and the PsyQ 4.3 GPU packet declarations. */
#ifndef NFS4_FRONTEND_COMMON_FETV_TYPES_H
#define NFS4_FRONTEND_COMMON_FETV_TYPES_H

#include "../../game/common/draw_leaf_types.h"

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

struct POLY_F4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0, x1, y1, x2, y2, x3, y3;
};

struct POLY_FT4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    short x1, y1;
    u_char u1, v1;
    u_short tpage;
    short x2, y2;
    u_char u2, v2;
    u_short pad1;
    short x3, y3;
    u_char u3, v3;
    u_short pad2;
};

struct POLY_GT4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    u_char r1, g1, b1, p1;
    short x1, y1;
    u_char u1, v1;
    u_short tpage;
    u_char r2, g2, b2, p2;
    short x2, y2;
    u_char u2, v2;
    u_short pad2;
    u_char r3, g3, b3, p3;
    short x3, y3;
    u_char u3, v3;
    u_short pad3;
};

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

struct tTVConfig {
    tTVState state;
    short transition;
    u_short destBrightness, flags;
    short fxWide, fxThin;
    int tint;
    short x, y, w, h;
    u_char u, v, uw, vh, shapeType;
    u_short clut, tpage, shapex, shapey, clutID, flip_axis;
};

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef struct kernpair KERN;

struct tActiveLine {
    short startTick, endTick, x1, y1;
    char type;
    short data;
};

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

struct tDrawShapeExtended;

#endif

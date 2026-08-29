/* drawshp.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_FRONTEND_PSX_DRAWSHP_TYPES_H
#define NFS4_FRONTEND_PSX_DRAWSHP_TYPES_H

#include "../../game/common/color_types.h"

/* Scratchpad render cursors are fixed-address lvalues, not owned globals. */
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

struct LINE_F2 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0, x1, y1;
};

struct POLY_G4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char r1, g1, b1, pad1;
    short x1, y1;
    u_char r2, g2, b2, pad2;
    short x2, y2;
    u_char r3, g3, b3, pad3;
    short x3, y3;
};

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};

struct tActiveLine {
    short startTick, endTick, x1, y1;
    char type;
    short data;
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

struct tDrawShapeExtended {
    short flip_axis;
    int tint[4];
    tTexture_ShapeInfo *custom_shapes;
};

/* The call ABI needs these enum identities only in the external symbol name;
 * drawshp.obj does not retain either completed enum definition. */
#define tMenuTextState int
#define tMenuTextType int
#define textState_Selected 1
#define textType_FramedInfo 3

typedef kernpair KERN;
typedef int (*getcode)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

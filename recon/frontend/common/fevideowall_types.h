/* Owner-specific type surface for fevideowall.obj, reconstructed from the
 * retail SYM graph. */
#ifndef NFS4_FRONTEND_COMMON_FEVIDEOWALL_TYPES_H
#define NFS4_FRONTEND_COMMON_FEVIDEOWALL_TYPES_H

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

struct tVideoWall {
    tTVConfig *fTVs;
    short fFirstTVShape, fNumTVs;
    tTexture_ShapeInfo *fTVShapes;
    short *tvOrder;
    u_long fTVTicks;
    short fTransitionDirection, fFlipAxis, fOffsetX, fOffsetY;
    short fAvailableTextID, fAvailable, fAvailableBright, fValid;
    short fAvailableX, fAvailableY;
    tTexture_ShapeInfo *fIconShapes;
    short fIcon, fIconFrames, fIconX, fIconY;
    bool fUpdated;

    void Initialize(tTVConfig *tvs, tTexture_ShapeInfo *shapes,
                    short firstTV, short numTVs, short *tvOrdering,
                    short flip_axis);
    void UpdateImages();
    void SetAvailableText(short textID, short x, short y);
    void SetAvailableIcon(short icon, short numFrames, short x, short y,
                          tTexture_ShapeInfo *iconImages);
    void SetOffset(short x, short y);
    void SetAvailable(short avail);
    void SetValid(short valid);
    void UpdateTransition();
    void Draw();
    void TurnOff();
    void TurnOffInstant();
    void TurnOn();
};

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef struct kernpair KERN;

struct tDrawShapeExtended {
    short flip_axis;
    int tint[4];
    tTexture_ShapeInfo *custom_shapes;
};

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

/* HudPmx.obj's exact source-visible type surface. */
#ifndef NFS4_GAME_COMMON_HUDPMX_TYPES_H
#define NFS4_GAME_COMMON_HUDPMX_TYPES_H

#include "textsys_types.h"
#include "draw_leaf_types.h"

struct HudPmx_tShape {
    Draw_tPixMap pixmap;
    short width, height;
};

struct HudPmx_tUV {
    u_char u0, v0;
    u_short clut;
};

#include "gamesetup_leaf_types.h"

#endif

/* genericpmx.obj's exact source-visible type surface. */
#ifndef NFS4_GAME_COMMON_GENERICPMX_TYPES_H
#define NFS4_GAME_COMMON_GENERICPMX_TYPES_H

#include "draw_leaf_types.h"
#include "gamesetup_leaf_types.h"

struct CHorizonSpec {
    int mirror, angle, yoffset, height;
    CVECTOR frontColor[2], backColor[2];
    char ringPMX[16];
};

struct CSkySpec {
    int type, flags;
    CVECTOR frontcolors[5], backcolors[5], clearcolor;
    int sunAngleInSky, sunHeightInSky, moonAngleInSky, moonHeightInSky;
    int numStars, starAngleLow, starAngleHigh, starBrightMin, starBrightMax;
    CVECTOR starBaseColor;
    int starRandomSeed;
    CVECTOR sunBeamColor, sunHaloColor;
    int yoffset;
    char cloudIndices[5][4];
    int ringAngles[5];
};

struct CNightSpec { CVECTOR nightcolor; };
struct CWeatherSpec { int type, intensity_limit; };

struct CFogSpec {
    int contrast;
    CVECTOR color;
    int start, dist2base;
};

struct CDepthCueSpec {
    CVECTOR color;
    int distance;
};

struct CWorldColor {
    int contrast;
    CVECTOR contrast_color;
    short worldR, worldG, worldB, type;
};

struct CTrackSpec;

#endif

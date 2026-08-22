/* trackspec.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_TRACKSPEC_TYPES_H
#define NFS4_GAME_PSX_TRACKSPEC_TYPES_H

#include "../common/gamesetup_leaf_types.h"

struct CHorizonSpec {
    int mirror, angle, yoffset, height;
    CVECTOR frontColor[2], backColor[2];
    char ringPMX[16];
};

struct CSkySpec {
    int type, flags;
    CVECTOR frontcolors[5], backcolors[5];
    CVECTOR clearcolor;
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

struct CTrackSpecHeader { int version, num_spec; };

struct CTrackSpec {
    short fogstate, weatherstate, horizonstate, skystate;
    short nightstate, depthcuestate, worldcolorstate, pad0;
    CFogSpec fogspec;
    CWeatherSpec weatherspec;
    CHorizonSpec horizonspec;
    CSkySpec skyspec;
    CNightSpec nightspec;
    CDepthCueSpec depthcuespec;
    CWorldColor worldcolorspec;
};

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

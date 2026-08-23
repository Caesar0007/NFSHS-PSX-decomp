/* TextureProcess.obj's exact source-visible type surface reconstructed from
 * the retail SYM.  The completed GameSetup_tData and CTrackSpec records belong
 * to other objects; textureprocess only emits their component/header types. */
#ifndef NFS4_GAME_PSX_TEXTUREPROCESS_TYPES_H
#define NFS4_GAME_PSX_TEXTUREPROCESS_TYPES_H

#include "../common/color_types.h"

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

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
struct CFogSpec { int contrast; CVECTOR color; int start, dist2base; };
struct CDepthCueSpec { CVECTOR color; int distance; };
struct CWorldColor {
    int contrast;
    CVECTOR contrast_color;
    short worldR, worldG, worldB, type;
};

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef kernpair KERN;
typedef int (*getcode)();
typedef void (*adjustchar)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();

struct CSVECTOR { int r, g, b; };
struct TP_ZPaletteSystem { int numdepthclut; };
typedef TP_ZPaletteSystem TP_tZPaletteSystem;
struct FogKey {
    short distance, slice;
    FogKey *next, *prev;
};

#endif

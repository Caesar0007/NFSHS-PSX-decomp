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

#include "shared/CHorizonSpec.h"





#include "shared/CSkySpec.h"












#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"





#include "shared/kernpair.h"




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

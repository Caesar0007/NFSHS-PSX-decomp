/* render.obj's exact source-visible extension of the shared night graph. */
#ifndef NFS4_GAME_COMMON_RENDER_TYPES_H
#define NFS4_GAME_COMMON_RENDER_TYPES_H

#define NFS4_NIGHT_OMIT_PRIVATE_TYPES
#include "../psx/night_types.h"
#undef NFS4_NIGHT_OMIT_PRIVATE_TYPES

#define gScratchLastWord (*(int *)0x1F8003FC)

#include "shared/BW_tContext.h"






#include "shared/SceneElem.h"







#include "shared/SceneSortedElem.h"

#include "shared/FLARE_PIECE_DEF.h"

#include "shared/kernpair.h"





#include "shared/AudioMus_tSongEntry.h"





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

#include "shared/POLY_F4.h"





#include "shared/POLY_FT4.h"
















struct DR_STP { u_long tag; u_long code[2]; };

#include "shared/dflip.h"

#include "shared/FLARE_DEF.h"







typedef int Input_tDeviceCall();
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif

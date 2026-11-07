/* render.obj's exact source-visible extension of the shared night graph. */
#ifndef NFS4_GAME_COMMON_RENDER_TYPES_H
#define NFS4_GAME_COMMON_RENDER_TYPES_H
#define NFS4_PRIM_POLY_F4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_FT4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_DR_STP   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
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





#include "shared/tTexture_ShapeInfo.h"










#include "shared/POLY_F4.h"





#include "shared/POLY_FT4.h"
















/* DR_STP: declared by nfs4_types.h right after DISPENV (NFS4_PRIM_DR_STP, retail libgpu.h order) */

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

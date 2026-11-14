/* render.obj's exact source-visible extension of the shared night graph. */
#if !defined(NFS4_GAME_COMMON_RENDER_TYPES_H) && !defined(NFS4_COLOR_IN_HOOK)
#define NFS4_GAME_COMMON_RENDER_TYPES_H
#define NFS4_PRIM_POLY_F4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_FT4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_DR_STP   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
/* retail render.obj: forceFocus_t, BW_tContext, FLARE_PIECE_DEF right after BO_tNewtonObj (second pass through
 * color_types.h NFS4_COLOR_HOOK_AFTER_BO); SceneElem/SceneSortedElem/AudioMus_tSongEntry after the Skidmark types,
 * then the C*Spec block (night_types.h NFS4_NIGHT_RENDER_LATE skips its own copies). */
#define NFS4_NIGHT_RENDER_LATE
#define NFS4_NIGHT_OMIT_PRIVATE_TYPES
#include "../psx/night_types.h"
#undef NFS4_NIGHT_OMIT_PRIVATE_TYPES

#define gScratchLastWord (*(int *)0x1F8003FC)

#include "shared/SceneElem.h"
#include "shared/SceneSortedElem.h"
#include "shared/AudioMus_tSongEntry.h"
#include "shared/CHorizonSpec.h"
#include "shared/CSkySpec.h"
#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"
#include "shared/kernpair.h"
#include "shared/tTexture_ShapeInfo.h"
/* POLY_F4, POLY_FT4, DR_STP: declared by nfs4_types.h right after DISPENV (NFS4_PRIM_*, retail libgpu.h order) */

#include "shared/dflip.h"

#include "shared/FLARE_DEF.h"

typedef int Input_tDeviceCall();
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#elif defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_RENDER_HOOK_DONE)
#define NFS4_RENDER_HOOK_DONE
#include "shared/forceFocus_t.h"


#include "shared/BW_tContext.h"
#include "shared/FLARE_PIECE_DEF.h"
#endif

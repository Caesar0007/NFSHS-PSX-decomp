/* Sfx.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_SFX_TYPES_H
#define NFS4_GAME_PSX_SFX_TYPES_H
#define NFS4_PRIM_POLY_FT4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_KERNEL_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#include "../common/draw_leaf_types.h"
/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail sfx.obj (GameSetup_gData is read through its word view) */















#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#include "shared/POLY_FT4.h"
















#include "shared/DRender_tView.h"




#include "shared/Souffle_tISouffle.h"







typedef struct sfxsouffle {
    Draw_tPixMap pmx;
    SVECTOR v0, v1, v2, v3;
} sfxsouffle;

typedef struct Sfx_tCache {
    Draw_tCacheHeader head;
    int otz;
} Sfx_tCache;

#include "shared/RelCoord16.h"
#include "../common/gamesetup_leaf_types.h"   /* retail sfx.obj: GameSetup records right after RelCoord16 */
typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;

#endif

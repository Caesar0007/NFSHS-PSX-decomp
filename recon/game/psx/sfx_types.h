/* Sfx.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_SFX_TYPES_H
#define NFS4_GAME_PSX_SFX_TYPES_H

#include "../common/gamesetup_leaf_types.h"
#include "../common/draw_leaf_types.h"

/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

#include "shared/TCB.h"
#include "shared/EXEC.h"



struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

#include "shared/POLY_FT4.h"
















#include "shared/DRender_tView.h"




#include "shared/Souffle_tISouffle.h"







struct sfxsouffle {
    Draw_tPixMap pmx;
    SVECTOR v0, v1, v2, v3;
};

struct Sfx_tCache {
    Draw_tCacheHeader head;
    int otz;
};

#include "shared/RelCoord16.h"
typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;

#endif

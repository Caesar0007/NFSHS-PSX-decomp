/* texture.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_TEXTURE_TYPES_H
#define NFS4_GAME_PSX_TEXTURE_TYPES_H

#include "../common/draw_leaf_types.h"
#include "../common/gamesetup_leaf_types.h"

typedef struct Texture_pal8bit {
    int x, y;
    short pal[256];
} Texture_pal8bit;

#endif

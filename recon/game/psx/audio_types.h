/* audio.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_AUDIO_TYPES_H
#define NFS4_GAME_PSX_AUDIO_TYPES_H
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "../common/draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this object lists the draw leaf itself (retail record order) */
#include "../common/draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "../psx/audio_snd_early.h"   /* own types at this point */
#include "../common/draw_leaf_b_pixmap.h"
#include "../common/draw_leaf_c_cache.h"
#include "../common/draw_leaf_d_carvertex.h"
#include "../common/color_types.h"
#include "shared/SndBnk_t.h"

/* sndpsxz owns the canonical system-option structs and prototypes. */
extern "C" {
#include "eaclib/psx/sndpsxz/ssysinit.h"
}

#include "shared/SNDSAMPLEFORMAT.h"
#include "shared/AudioMus_tSongEntry.h"

struct SpuVolume {
    short left, right;
};

struct SpuExtAttr {
    SpuVolume volume;
    long reverb, mix;
};

struct SpuStVoiceAttr {
    char status, pad1, pad2, pad3;
    long last_size;
    u_long buf_addr, data_addr;
};

typedef void (*SpuIRQCallbackProc)();
typedef void (*SpuTransferCallbackProc)();
typedef void (*SpuStCallbackProc)();

#endif

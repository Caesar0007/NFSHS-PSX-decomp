/* draw.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_DRAW_TYPES_H
#define NFS4_GAME_PSX_DRAW_TYPES_H
#define NFS4_CORE_KERNEL_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#define NFS4_CORE_FULL   /* this object lists the start of the core itself (retail record order) */
#define NFS4_GAME_COMMON_MIN_TYPES_H
#define NFS4_GAME_COMMON_PADS_TYPES_H
#include "../common/game_common_min_core.h"
#include "shared/dflip.h"   /* own types at this point */
#include "../common/pads_records.h"
#include "../common/pads_tail.h"
#undef NFS4_CORE_FULL
#include "../common/draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this object lists the draw leaf itself (retail record order) */
#include "../common/draw_leaf_a_pads.h"
#include "../common/draw_leaf_b_pixmap.h"
#include "../common/draw_leaf_c_cache.h"
#include "shared/Draw_DCache.h"   /* own types at this point */
#include "../common/draw_leaf_d_carvertex.h"
#include "shared/Draw_tView.h"   /* own types at this point */
#include "../common/draw_leaf_types.h"
#include "../common/gamesetup_leaf_types.h"
/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















/* Scratchpad render cursors; these are address constants, not object-owned
 * globals or additional debug-visible record types. */
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#include "shared/dflip.h"




#include "shared/Draw_DCache.h"







#include "shared/Draw_tView.h"





#endif

/* draw.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_DRAW_TYPES_H
#define NFS4_GAME_PSX_DRAW_TYPES_H
#define NFS4_DRAW_LEAF_HOOK_AFTER_CACHEHEADER "shared/Draw_DCache.h"   /* retail: Draw_DCache right after Draw_tCacheHeader (draw_leaf_types.h) */
#define NFS4_CORE_KERNEL_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#define NFS4_PADS_HOOK_BEFORE "shared/dflip.h"   /* retail draw.obj: dflip right after COORD16 (game_common_pads_types.h) */
#define NFS4_DRAW_LEAF_HOOK_AFTER_CARVERTEX "shared/Draw_tView.h"   /* retail: Draw_tView right after Draw_CarVertex */
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

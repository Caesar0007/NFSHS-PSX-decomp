/* draw.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_DRAW_TYPES_H
#define NFS4_GAME_PSX_DRAW_TYPES_H

#include "../common/gamesetup_leaf_types.h"
#include "../common/draw_leaf_types.h"

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

#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: full tMenu/tMenuItem inline-member sets */
#define NFS4_FE_CORE_GS_EARLY   /* retail: GameSetup before tMenuCommandType (fe_core_types.h) */
#define NFS4_FE_LIST_NO_INDEXED   /* retail fetools object: tListIterator + Range only */
#define NFS4_CORE_PADS_KERNEL_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#define NFS4_FE_CORE_CARS_LATE   /* retail FETools.obj: car tail after tShapeInformation (fetools_types.h end) */
#define NFS4_FE_CORE_TMENUCOMMAND_EARLY   /* retail: tMenu forward copy right after tMenuCommandType (fe_core_types.h) */
#define NFS4_FE_CORE_TMENU_AFTER_ITEMS   /* retail: tMenu (+ tScreen forward copy) after tMenuItemGoToMenuButton */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "../../game/common/draw_leaf_core.h"
#if !defined(NFS4_DRAW_LEAF_CORE_ONLY) && !defined(NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H)   /* this object lists the draw leaf itself (retail record order) */
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H
#include "../../game/common/draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "../../game/common/draw_leaf_b_pixmap.h"
#include "../../game/common/draw_leaf_c_cache.h"
#include "../../game/common/draw_leaf_d_carvertex.h"
#include "../../frontend/common/fetools_after_carvertex.h"   /* own types at this point */
#endif
#include "fetools_types.h"
#include "fetools_externs.h"

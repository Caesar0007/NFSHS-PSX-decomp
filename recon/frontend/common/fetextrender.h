#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: full tMenu/tMenuItem inline-member sets */
#define NFS4_FE_LIST_NO_INDEXED   /* retail fetextrender object: tListIterator + Range only */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* retail FETextRender.obj: core, kernpair, pads, PCOORD16/COORD16/CCOORD16, then the draw leaf */
#define NFS4_FE_CORE_TMENUCOMMAND_EARLY   /* retail: tMenu forward copy right after tMenuCommandType (fe_core_types.h) */
#include "../../game/common/draw_leaf_types.h"
#undef NFS4_DRAW_LEAF_CORE_ONLY
#include "shared/kernpair.h"
#include "../../game/common/game_common_pads_types.h"
#include "shared/PCOORD16.h"
#include "shared/COORD16.h"
#include "shared/CCOORD16.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this object lists the draw leaf itself (retail record order) */
#include "../../game/common/draw_leaf_a_pads.h"
#include "../../game/common/draw_leaf_b_pixmap.h"
#include "../../game/common/draw_leaf_c_cache.h"
#include "../../game/common/draw_leaf_d_carvertex.h"
#include "shared/tTexture_ShapeInfo.h"   /* own types at this point */
#include "fetextrender_types.h"
#include "fetextrender_externs.h"

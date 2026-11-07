#define NFS4_FE_LIST_NO_INDEXED   /* retail fetextrender object: tListIterator + Range only */
#define NFS4_DRAW_LEAF_HOOK_AFTER_CARVERTEX "shared/tTexture_ShapeInfo.h"   /* retail: right after Draw_CarVertex */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* retail FETextRender.obj: core, kernpair, pads, PCOORD16/COORD16/CCOORD16, then the draw leaf */
#include "../../game/common/draw_leaf_types.h"
#undef NFS4_DRAW_LEAF_CORE_ONLY
#include "shared/kernpair.h"
#include "../../game/common/game_common_pads_types.h"
#include "shared/PCOORD16.h"
#include "shared/COORD16.h"
#include "shared/CCOORD16.h"
#include "fetextrender_types.h"
#include "fetextrender_externs.h"

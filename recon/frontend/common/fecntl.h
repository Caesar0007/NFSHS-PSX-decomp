#define NFS4_FE_LIST_NO_INDEXED   /* retail fecntl object: tListIterator + Range only */
#define NFS4_CORE_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail core place (color_types.h does the same) */
#define NFS4_DRAW_LEAF_HOOK_AFTER_PADS "../../frontend/common/fecntl_after_pads.h"   /* retail: old-menu records + kernpair after the pads */
#include "../../game/common/draw_leaf_types.h"
#include "fecntl_types.h"
#include "../../game/common/color_types.h"

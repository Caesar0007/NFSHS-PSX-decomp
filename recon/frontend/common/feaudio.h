#define NFS4_FE_CORE_GS_EARLY   /* retail: GameSetup before tMenuCommandType (fe_core_types.h) */
#define NFS4_FE_LIST_NO_RANGE_INDEXED   /* retail feaudio object: tListIterator, Indexed, Range */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* retail Feaudio.obj: full core (MATRIX/DR_MODE/matrixtdef) first; draw leaf after the sound records */
#include "../../game/common/draw_leaf_types.h"
#undef NFS4_DRAW_LEAF_CORE_ONLY
#include "shared/PCOORD16.h"
#include "shared/COORD16.h"
#include "shared/CCOORD16.h"
#include "../../game/common/game_common_pads_types.h"
#include "feaudio_types.h"
#include "feaudio_externs.h"

/* game/common/color.h — reconstructed from game/common/color.cpp (2 fns) */
#ifndef _GAME_COMMON_COLOR_H_
#define _GAME_COMMON_COLOR_H_
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "draw_leaf_core.h"
#if !defined(NFS4_DRAW_LEAF_CORE_ONLY) && !defined(NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H)   /* this object lists the draw leaf itself (retail record order) */
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H
#include "draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "draw_leaf_b_pixmap.h"
#include "draw_leaf_c_cache.h"
#include "draw_leaf_d_carvertex.h"
#include "shared/Transformer_z.h"   /* own types at this point */
#endif
#include "color_types.h"

char IsNumChar(char c);   /* :454 */
int Risk_ReadNextValue(char **aScript);   /* :462 */

#endif /* _GAME_COMMON_COLOR_H_ */

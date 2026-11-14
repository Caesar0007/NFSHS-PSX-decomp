/* Shared draw/platform records emitted by the compact PMX loader objects. */
#ifndef NFS4_GAME_COMMON_DRAW_LEAF_TYPES_H
#define NFS4_GAME_COMMON_DRAW_LEAF_TYPES_H
#include "draw_leaf_core.h"
#endif

/* Phase 2 (separate guard): a frontend surface that defines NFS4_DRAW_LEAF_CORE_ONLY gets only the core above here
 * and re-includes this header after its screen graph (retail: PCOORD16 .. Draw_* after tScreen). */
#if !defined(NFS4_DRAW_LEAF_CORE_ONLY) && !defined(NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H)
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H
#include "draw_leaf_a_pads.h"
#include "draw_leaf_b_pixmap.h"
#include "draw_leaf_c_cache.h"
#include "draw_leaf_d_carvertex.h"
#endif

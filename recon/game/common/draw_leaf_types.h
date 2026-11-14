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
#ifdef NFS4_DRAW_LEAF_HOOK_AFTER_PADS   /* owner types between the pads and the draw leaf (audio.obj: SND system structs) */
#include NFS4_DRAW_LEAF_HOOK_AFTER_PADS
#endif
#include "draw_leaf_b_pixmap.h"
#ifdef NFS4_DRAW_LEAF_HOOK_AFTER_PIXMAP   /* owner types right after Draw_tPixMap (r3dcar: Draw_tVertex) */
#include NFS4_DRAW_LEAF_HOOK_AFTER_PIXMAP
#endif
#include "draw_leaf_c_cache.h"
#ifdef NFS4_DRAW_LEAF_HOOK_AFTER_CACHEHEADER   /* owner types right after Draw_tCacheHeader (flare: Draw_FlareCache) */
#include NFS4_DRAW_LEAF_HOOK_AFTER_CACHEHEADER
#endif
#include "draw_leaf_d_carvertex.h"
#ifdef NFS4_DRAW_LEAF_HOOK_AFTER_CARVERTEX   /* owner types right after Draw_CarVertex (fetools/drawdbg: kernpair, tTexture_ShapeInfo...) */
#include NFS4_DRAW_LEAF_HOOK_AFTER_CARVERTEX
#endif
#endif

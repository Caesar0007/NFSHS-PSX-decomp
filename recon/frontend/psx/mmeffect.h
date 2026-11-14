/* frontend/psx/mmeffect.h - reconstructed declarations for MMEFFECT.CPP (C++ TU) */
#ifndef _FRONTEND_PSX_MMEFFECT_H_
#define _FRONTEND_PSX_MMEFFECT_H_
#define NFS4_CORE_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "../../game/common/draw_leaf_core.h"
#if !defined(NFS4_DRAW_LEAF_CORE_ONLY) && !defined(NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H)   /* this object lists the draw leaf itself (retail record order) */
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H
#include "../../game/common/draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "../../game/common/draw_leaf_b_pixmap.h"
#include "../../game/common/draw_leaf_c_cache.h"
#include "../../game/common/draw_leaf_d_carvertex.h"
#include "../../frontend/psx/mmeffect_after_carvertex.h"   /* own types at this point */
#endif
#include "mmeffect_types.h"

/* MMEFFECT.CPP is C++ (cfront-mangled in SYM: FeDraw_SetABRMode__Fi) -> normal C++ linkage. */
void FeDraw_SetABRMode(int abr);   /* mmeffect.cpp:233 */

#endif /* _FRONTEND_PSX_MMEFFECT_H_ */

/* frontend/psx/drawshp.h - reconstructed declarations for DRAWSHP.CPP (C++ TU) */
#ifndef _FRONTEND_PSX_DRAWSHP_H_
#define _FRONTEND_PSX_DRAWSHP_H_
#define NFS4_CORE_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail core place (color_types.h does the same) */
#define NFS4_PRIM_POLY_G4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_CORE_HOOK_AFTER_DRMODE "frontend/psx/drawshp_linef2.h"   /* retail: LINE_F2 in the core next to DR_MODE */
#include "../../game/common/draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this object lists the draw leaf itself (retail record order) */
#include "../../game/common/draw_leaf_a_pads.h"
#include "../../game/common/draw_leaf_b_pixmap.h"
#include "../../game/common/draw_leaf_c_cache.h"
#include "../../game/common/draw_leaf_d_carvertex.h"
#include "../../frontend/psx/drawshp_after_carvertex.h"   /* own types at this point */
#include "../../game/common/draw_leaf_types.h"
#include "drawshp_types.h"
#include "../../game/common/color_types.h"
#include "shared/tActiveLine.h"   /* retail: tActiveLine is the last type record */
#include "drawshp_externs.h"

/* DRAWSHP.CPP is C++ (cfront-mangled in SYM) -> normal C++ linkage. */
void DrawShape_SubtractNFS4RectEdges(RECT &rect);
void DrawShape_NFS4RoundRectangle(int textID,RECT &position,short selected);
void DrawShape_NFS4Rectangle(RECT &position);
void DrawShape_NFS4TransRectangle(RECT &r,short opacity);

extern int kNoColor;   /* 0x800529d0 (EXT, defined in drawshp.cpp) */

#endif
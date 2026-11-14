/* common type graph, part 0 of 10 (cut from color_types.h at its order hooks) */
#ifndef NFS4_GAME_COMMON_COLOR_P0_DRAW_H
#define NFS4_GAME_COMMON_COLOR_P0_DRAW_H
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail place (after COORD16, before the pads) */
#include "draw_leaf_types.h"
#undef NFS4_CORE_CCOORD16
#include "shared/CCOORD16.h"
#ifdef NFS4_COLOR_GROUP_LATE   /* retail: the track quad types and RelCoord16 ahead of Group (owner first header) */
#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"
#endif
#endif

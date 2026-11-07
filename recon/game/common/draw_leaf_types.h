/* Shared draw/platform records emitted by the compact PMX loader objects. */
#ifndef NFS4_GAME_COMMON_DRAW_LEAF_TYPES_H
#define NFS4_GAME_COMMON_DRAW_LEAF_TYPES_H

#define NFS4_CORE_FULL
#include "game_common_min_types.h"
#undef NFS4_CORE_FULL

#include "shared/MATRIX.h"
#include "shared/DR_MODE.h"

#include "shared/matrixtdef.h"
#ifndef NFS4_HAVE_MATRIX3DT
typedef struct matrixtdef MATRIX3DT;
#endif
#endif

/* Phase 2 (separate guard): a frontend surface that defines NFS4_DRAW_LEAF_CORE_ONLY gets only the core above here
 * and re-includes this header after its screen graph (retail: PCOORD16 .. Draw_* after tScreen). */
#if !defined(NFS4_DRAW_LEAF_CORE_ONLY) && !defined(NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H)
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H
#include "shared/PCOORD16.h"
#include "shared/COORD16.h"
#ifdef NFS4_CORE_CCOORD16
#include "shared/CCOORD16.h"
#endif
#include "game_common_pads_types.h"

#include "shared/Draw_tPixMap.h"










#include "shared/DRender_tCalcView.h"
#ifdef NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (every includer) */
#include "shared/DRender_tView.h"
#endif



#include "shared/Draw_SVertex.h"
#ifdef NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct right after Draw_SVertex (every includer) */
#include "shared/Draw_SubdivStruct.h"
#endif



#include "shared/Draw_PrimStruct.h"




#include "shared/Draw_tCacheHeader.h"





#include "shared/Draw_CarVertex.h"




#endif
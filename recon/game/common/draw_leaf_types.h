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

#include "shared/PCOORD16.h"
#include "shared/COORD16.h"

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

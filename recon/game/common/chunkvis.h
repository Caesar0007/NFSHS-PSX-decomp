/* game/common/chunkvis.h - type environment for the metadata-only chunkvis.obj owner. */
#ifndef _GAME_COMMON_CHUNKVIS_H_
#define _GAME_COMMON_CHUNKVIS_H_
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail place (after COORD16, before the pads) */
#include "draw_leaf_types.h"
#undef NFS4_CORE_CCOORD16



#include "shared/CCOORD16.h"
#include "shared/Group.h"   /* one Group definition (header-truth 4n) */





#include "shared/Trk_Quad.h"

#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"
#include "shared/RelCoord16.h"
#include "shared/tSaveSurface.h"
typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];
#endif /* _GAME_COMMON_CHUNKVIS_H_ */

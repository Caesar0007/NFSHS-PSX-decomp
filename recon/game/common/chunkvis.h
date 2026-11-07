/* game/common/chunkvis.h - type environment for the metadata-only chunkvis.obj owner. */
#ifndef _GAME_COMMON_CHUNKVIS_H_
#define _GAME_COMMON_CHUNKVIS_H_
#include "draw_leaf_types.h"
typedef struct PCOORD16 PCOORD16;
typedef struct COORD16 COORD16;
typedef struct Draw_tCacheHeader Draw_tCacheHeader;
#include "shared/CCOORD16.h"
struct Group {
    int m_num_elements;

    inline void *GetData() { return this + 1; }
    inline int GetNumElements() { return m_num_elements; }
};
#include "shared/Trk_Quad.h"
typedef struct Trk_Quad Trk_Quad;
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"
#include "shared/RelCoord16.h"
#include "shared/tSaveSurface.h"
typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];
#endif /* _GAME_COMMON_CHUNKVIS_H_ */

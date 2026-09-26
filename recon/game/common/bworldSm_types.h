/* bworldSm.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_BWORLDSM_TYPES_H
#define NFS4_GAME_COMMON_BWORLDSM_TYPES_H

/* bworldSm.obj contains color.obj's complete 71-record game/platform graph. */
#include "color_types.h"

#include "shared/Trk_NewSlice.h"







struct Chunk {
    RelCoord16 boundPts[4], chunkboundPts[4];
    u_char quadCounts[6];
    u_char pad[2];
    Trk_Quad *renderQuads[4];
    Group *stripBuf, *lorezstripBuf, *objInstanceBuf, *objSpecialInstanceBuf;
    Group *simSliceBuf, *simQuadBuf, *simObjBuf, *sfxBuf, *lineBuf;
    Group *objVertexBuf, *objQuadBuf, *objQuadInstanceBuf;
    short firstSimSliceInd, chunkInd;
    Group *vertexBuf;
};

#include "shared/BW_tContext.h"









struct tNormalCacheEntry {
    short sliceInd;
    u_char triangleFlag;
    signed char quadInd;
    coorddef normal, forward;
    u_long accessTime;
};

#endif

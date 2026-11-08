/* bworldSm.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_BWORLDSM_TYPES_H
#define NFS4_GAME_COMMON_BWORLDSM_TYPES_H

/* bworldSm.obj contains color.obj's complete 71-record game/platform graph. */
#define NFS4_COLOR_HOOK_AFTER_BWSM "gamesetup_leaf_types.h"   /* retail bworldsm.obj: GameSetup records right after BWorldSm_Pos */
#define NFS4_COLOR_HOOK_AFTER_SIMSLICE "shared/Trk_NewSlice.h"   /* retail bworldsm.obj: Trk_NewSlice right after Trk_NewSimSlice */
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









/* tNormalCacheEntry: defined in bworldSm.cpp before NormalCache_AddEntry (INV-A3: retail type-record position) */







#endif

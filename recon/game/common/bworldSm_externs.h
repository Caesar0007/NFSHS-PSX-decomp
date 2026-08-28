/* game/common/bworldSm_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_BWORLDSM_EXTERNS_H_
#define _GAME_COMMON_BWORLDSM_EXTERNS_H_
#include "bworldSm_types.h"

/* Track_chunkList is owned by chunk.obj.  bworldSm.obj's retail debug graph
 * deliberately omits Chunk, but its exact instructions retain these five
 * member offsets.  Keep this private codegen view byte-for-byte locked to the
 * 112-byte owner layout; the canonical type audit filters only this complete
 * owner/name/layout pair.  Pre-change backup: Git commit 5163e832. */
struct BWorldSm_ChunkCodegenView {
    char _beforeStripBuf[56];
    Group *stripBuf;
    char _beforeSimSliceBuf[12];
    Group *simSliceBuf;
    Group *simQuadBuf;
    char _beforeFirstSimSliceInd[24];
    short firstSimSliceInd;
    char _beforeVertexBuf[2];
    Group *vertexBuf;
};

extern CVECTOR * Chunk_lightTable;
extern BWorldSm_ChunkCodegenView *Track_chunkList;
extern coorddef * Chunk_chunkCenters;
extern int  xzsquaredist32(coorddef *, coorddef *);
extern int BWorld_gChunkBuildList[];
int  Math_DistXZ(coorddef *a, coorddef *b);
void Math_NormalizeVector(coorddef *v);
extern "C" void crossproduct(coorddef *a, coorddef *b, coorddef *out);
extern "C" int fixedmult(int a, int b);

#endif /* _GAME_COMMON_BWORLDSM_EXTERNS_H_ */

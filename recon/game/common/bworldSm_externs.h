/* game/common/bworldSm_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_BWORLDSM_EXTERNS_H_
#define _GAME_COMMON_BWORLDSM_EXTERNS_H_
#include "bworldSm_types.h"

extern CVECTOR * Chunk_lightTable;
extern Chunk *Track_chunkList;
extern coorddef * Chunk_chunkCenters;
extern int  xzsquaredist32(coorddef *, coorddef *);
extern int BWorld_gChunkBuildList[];
int  Math_DistXZ(coorddef *a, coorddef *b);
void Math_NormalizeVector(coorddef *v);
extern "C" void crossproduct(coorddef *a, coorddef *b, coorddef *out);
extern "C" int fixedmult(int a, int b);

#endif /* _GAME_COMMON_BWORLDSM_EXTERNS_H_ */
